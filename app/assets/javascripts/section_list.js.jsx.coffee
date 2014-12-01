{div, p, h1, h2, a, img} = React.DOM

LEFT_BUTTON = 0
DRAG_THRESHOLD = 3 # pixels

window.Sections = React.createClass(
  getInitialState: ->
    currentDragItem: null
    sections: []

  loadSectionsFromServer: ->
    $.ajax
      url: "sections.json"
      dataType: "json"
      success: ((data) ->
        @setState sections: data.sections
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)

    return

  handleItemDrop: (item, index) ->
    section = {
      title: item.title
      image: item.links.tiled_image.uri
      item_id: item.id
      order: index
    }

    sections = @state.sections
    sections.splice(index, 0, section)
    #optimistically add the data to the list of sections
    @setState
      sections: sections
    , ->

      $.ajax
        url: "sections.json"
        dataType: "json"
        type: "POST"
        data:
          section: section

        success: ((data) ->
          # this is called because the optimist listing above does not include the id of the item.
          @loadSectionsFromServer()
          return
        ).bind(this)
        error: ((xhr, status, err) ->
          console.error @props.url, status, err.toString()
          return
        ).bind(this)

      return

  onDragStart: (details) ->
    @setState currentDragItem: details

  onDragStop: ->
    @setState currentDragItem: null

  onDrop: (target, index) ->
    @handleItemDrop(target, index)
    @setState lastDrop:
      source: @state.currentDragItem
      target: target

  componentDidMount: ->
    @loadSectionsFromServer()
    setInterval @loadSectionsFromServer(), 8000
    return

  sectionClick: (section) ->
    window.location.replace("/sections/#{section.id}/edit")
    return

  render: ->
    divclassname = "sections"
    if @state.currentDragItem
      divclassname = "sections #{dragging}"

    `<div className={this.divclassname}>
      <h1>Sections</h1>
      <div className="sections-content">
        <SectionList sections={this.state.sections} onSectionClick={this.sectionClick} currentDragItem={this.state.currentDragItem} onDrop={this.onDrop} />
      </div>
      <div className="add-items-content">
        <AddItemBox onDragStart={this.onDragStart} onDragStop={this.onDragStop} />
      </div>
    </div>`
)


AddItemBox = React.createClass(
  getInitialState: ->
    items: []

  loadItemsFromServer: ->
    $.ajax
      url: "http://localhost:3017/collections/1/items.json?include=tiled_images"
      dataType: "json"
      success: ((data) ->
        @setState items: data.items
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)

    return

  componentDidMount: ->
    @loadItemsFromServer()
    setInterval @loadItemsFromServer(), 8000
    return

  render: ->
    `<ItemList onDragStart={this.props.onDragStart} onDragStop={this.props.onDragStop} items={this.state.items} />`
)

Item = React.createClass(
  getInitialState: ->
    mouseDown: false
    dragging: false

  style: ->
    if @state.dragging
      position: 'absolute'
      left: @state.left
      top: @state.top
    else
      {}

  onMouseDown: (event) ->
    if event.button == LEFT_BUTTON
      event.stopPropagation()
      event.preventDefault()
      @addEvents()
      pageOffset = @getDOMNode().getBoundingClientRect()
      @setState
        mouseDown: true
        originX: event.pageX
        originY: event.pageY
        elementX: pageOffset.left
        elementY: pageOffset.top

  onMouseMove: (event) ->
    deltaX = event.pageX - @state.originX
    deltaY = event.pageY - @state.originY
    distance = Math.abs(deltaX) + Math.abs(deltaY)

    if !@state.dragging and distance > DRAG_THRESHOLD
      @setState dragging: true
      @props.onDragStart(@props.item)

    if @state.dragging
      @setState
        left: @state.elementX + deltaX + document.body.scrollLeft
        top: @state.elementY + deltaY + document.body.scrollTop

  onMouseUp: ->
    @removeEvents()
    if @state.dragging
      @props.onDragStop()
      @setState dragging: false

  addEvents: ->
    document.addEventListener 'mousemove', @onMouseMove
    document.addEventListener 'mouseup', @onMouseUp

  removeEvents: ->
    document.removeEventListener 'mousemove', @onMouseMove
    document.removeEventListener 'mouseup', @onMouseUp

  render: ->
    dragclass = "drag "
    if @state.dragging
      dragclass = "#{dragclass} dragging"

    `<div className={dragclass} onMouseDown={this.onMouseDown} style={this.style()}>
      <img src={this.props.item.links.tiled_image.uri} />
    </div>`
)

ItemList = React.createClass(
  render: ->
    onDragStart = @props.onDragStart
    onDragStop = @props.onDragStop
    itemNodes = @props.items.map((item, index) ->
      Item { item: item, key: item.id, onDragStart: onDragStart, onDragStop: onDragStop }
    )

    `<div className="add-items-content-inner">
      <div className="add-items-title">
        <h2>Add Items</h2>
        <p>Click to Drag items into the exhibit</p>
      </div>
      {itemNodes}
    </div>`
)


