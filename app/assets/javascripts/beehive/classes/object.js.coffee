class beehive.BeehiveObject extends beehive.Module
  @mixin beehive.URLTemplates
  constructor: (@_data) ->
    for key of @_data
      @[key] = @_data[key]
