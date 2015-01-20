class beehive.BeehiveObjectList extends beehive.Module
  @mixin beehive.URLTemplates

  constructor: () ->
    @initialize()

  initialize: () ->
    @data = {}
    @objects = []
    @objectsByID = {}
    @loaded = false

  load: (callback) ->
    _this = @
    $.getJSON(@loadURL())
      .success (data) ->
        _this.loadSuccess(data)
        callback()

  loadSuccess: (data) ->
    @loadData(data)

  loadData: (data) ->
    @initialize()
    @data = data
    @processData(data)

  dataList: (data) ->
    data.objects

  processData: (data) ->
    $.each(@dataList(data), @loadDataEach.bind(@))

  loadDataEach: (index, objectData) ->
    @loadObject(objectData)

  addObject: (object) ->
    @objects.push(object)
    @objectsByID[object.id] = object


  loadObject: (objectData) ->
    @addObject(@buildObject(objectData))

  buildObject: (objectData) ->
    new beehive.BeehiveObject(objectData)

  find: (id) ->
    @objectsByID[id]

