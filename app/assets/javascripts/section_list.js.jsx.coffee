{div, p, h2, a, img} = React.DOM

LEFT_BUTTON = 0
DRAG_THRESHOLD = 3 # pixels

document.addEventListener 'DOMContentLoaded', ->
  if document.getElementById('section_list')
    React.render Sections(), document.getElementById('section_list')


Sections = React.createClass(
  getInitialState: ->
    currentDragItem: null

  loadSectionsFromServer: ->
    $.ajax
      url: "sections.json"
      dataType: "json"
      success: ((data) ->
        @setState data: data.sections
        return
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
        return
      ).bind(this)

    return

  getInitialState: ->
    data: []

  onDragStart: (details) ->
    console.log(details)
    @setState currentDragItem: details

  onDragStop: ->
    @setState currentDragItem: null

  onDrop: (target) ->
    @setState lastDrop:
      source: @state.currentDragItem
      target: target
    window.location.replace("/sections/new")

  componentDidMount: ->
    @loadSectionsFromServer()
    setInterval @loadSectionsFromServer(), 8000
    return

  sectionClick: ->
    return

  render: ->
    (div { className: 'sections row'}, [
      (h2 {key: "title"}, "Sections"),
      (div { className: 'col-md-9'}, (
        SectionList { key: 'list', data: @state.data, onSectionClick: @sectionClick, currentDragItem: @state.currentDragItem, onDrop: @onDrop})
      ),
      (div { className: 'col-md-3'},
        (AddItemBox {key: 'add-item', onDragStart: @onDragStart, onDragStop: @onDragStop})
      )
    ])
)


AddItemBox = React.createClass(
  getInitialState: ->
    mouseDown: false
    dragging: false
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
      @props.onDragStart("item")

    if @state.dragging
      @setState
        left: deltaX + document.body.scrollLeft
        top: deltaY + document.body.scrollTop

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
    console.log("drag #{'dragging' if @state.dragging}")
    (div { className: "drag #{'dragging' if @state.dragging}", onMouseDown: @onMouseDown, style: @style() }, "Add Item")

)

Item = React.createClass(
  render: ->
    (div {}, (img { src: @props.item.links.tiled_image.uri width: "100" }))
)

ItemList = React.createClass(
  render: ->
    onClickFunction = @props.onItemClick
    itemNodes = @props.data.map((item, index) ->
      Item { item: item, key: item.id, onItemClick: onClickFunction }
      return
    )
    return
)

SectionList = React.createClass(
  sectionRows: ->
    rows = []
    i = 0
    while i < @props.data.length
      section = @props.data[i]
      rows.push (Section {section: section, key: section.id, onSectionClick: @props.onSectionClick })
      rows.push (SectionSpacer {key: "spacer-#{section.id}", currentDragItem: @props.currentDragItem, onDrop: @props.onDrop } )
      i++
    rows

  render: ->
    (div {}, @sectionRows())
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
      @props.onDrop(@props.currentDragItem)

  render: ->
    (div {className: @classes(), onMouseEnter: @onMouseEnter, onMouseLeave: @onMouseLeave, onMouseUp: @onDrop  },
      (div {}, "Create New Section HERE!!")

    )
)
