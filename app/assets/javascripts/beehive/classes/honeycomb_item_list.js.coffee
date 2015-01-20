class beehive.HoneycombItemList extends beehive.ObjectList
  constructor: (@exhibit_id) ->
    super()

  initialize: ->
    super()
    @items = @objects

  loadURL: ->
    @getURL 'load',
      exhibit_id: @exhibit_id

  dataList: (data) ->
    data.items

  buildObject: (objectData) ->
    new beehive.HoneycombItem(objectData)
