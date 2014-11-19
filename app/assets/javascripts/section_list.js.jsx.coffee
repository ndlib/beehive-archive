{div, p, h2, a, img} = React.DOM

LEFT_BUTTON = 0
DRAG_THRESHOLD = 3 # pixels

document.addEventListener 'DOMContentLoaded', ->
  if document.getElementById('section_list')
    React.render Sections(), document.getElementById('section_list')


Sections = React.createClass(
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
    }
    console.log(@state.sections)
    sections = @state.sections
    sections.splice(index, 0, section)
    console.log(sections)
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
          console.log("success")
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

  sectionClick: ->
    return

  render: ->
    (div { className: 'sections'}, [
      (h2 {key: "title"}, "Sections"),
      (div { key: 'list-div', className: "sections-content"}, (
        SectionList { key: 'list', data: @state.sections, onSectionClick: @sectionClick, currentDragItem: @state.currentDragItem, onDrop: @onDrop})
      ),
      (div { key: 'add-item-div', className: "add-items-content"},
        (AddItemBox {key: 'add-item', onDragStart: @onDragStart, onDragStop: @onDragStop})
      )
    ])
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
    (ItemList { onDragStart: @props.onDragStart, onDragStop: @props.onDragStop, items: @state.items } )

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
    (div { src: @props.item.links.tiled_image.uri, className: "drag #{'dragging' if @state.dragging}", onMouseDown: @onMouseDown, style: @style() }, @props.item.title)
)

ItemList = React.createClass(
  render: ->
    onDragStart = @props.onDragStart
    onDragStop = @props.onDragStop
    itemNodes = @props.items.map((item, index) ->
      Item { item: item, key: item.id, onDragStart: onDragStart, onDragStop: onDragStop }
    )

    (div { className: 'add-items-content-inner'}, [
      (div { className: 'add-items-title', key: 'add-items-title' }, [
        (h2 {key: 'add-items-title-h2'}, "Add Items")
        (p {key: 'add-items-title-p'}, "Click to Drag items into the exhibit")
      ])
      itemNodes
    ])
)

SectionList = React.createClass(
  sectionRows: ->
    rows = []
    i = 0
    while i < @props.data.length
      section = @props.data[i]
      rows.push (Section {section: section, key: section.id, onSectionClick: @props.onSectionClick })
      rows.push (SectionSpacer {key: "spacer-#{section.id}", currentDragItem: @props.currentDragItem, onDrop: @props.onDrop, new_index: (i + 1) } )
      i++
    rows

  render: ->
    (div { className: "sections-content-inner"}, @sectionRows())
)


Section = React.createClass(
  handleClick: (e) ->
    e.preventDefault()
    @props.onSectionClick @props.section
    return

  render: ->
    (div {className: "section"}, [
      (a { key: "a-#{@props.section.id}", onClick: @handleClick }, [
        (img { key: "img-#{@props.section.id}", src: @props.section.image } )
      ])
    ])
)


SectionSpacer = React.createClass(
  getInitialState: ->
    hover: false

  classes: ->
    [
      'section_spacer'
      'active' if @active()
      'hover' if @state.hover
    ].join ' '

  onMouseEnter: ->
    @setState hover: true

  onMouseLeave: ->
    @setState hover: false

  active: ->
    @props.currentDragItem

  onDrop: ->
    if @active()
      @props.onDrop(@props.currentDragItem, @props.new_index)

  render: ->
    (div {className: @classes(), onMouseEnter: @onMouseEnter, onMouseLeave: @onMouseLeave, onMouseUp: @onDrop  },
      (div {}, "Create New Section HERE!!")

    )
)
