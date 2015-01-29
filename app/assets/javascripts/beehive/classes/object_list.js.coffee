class beehive.BeehiveObjectList extends beehive.Module
  @mixin beehive.URLTemplates

  constructor: () ->
    @initialize()

  initialize: () ->
    @data = {}
    @objects = []
    @objectsByID = {}
    @loaded = false

  load: () ->
    _this = @
    if !@loading
      @deferred = new jQuery.Deferred()
      @loading = true
      $.getJSON(@loadURL())
        .done (data) ->
          _this.loadSuccess(data)
          _this.deferred.resolve(_this)
        .fail (xhr, status, err) ->
          console.error(xhr, status, err.toString());
          _this.deferred.reject(xhr, status, err)
        .always ->
          _this.loading = false
    @deferred.promise()

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

