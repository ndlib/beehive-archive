beehive.URLTemplates =
  classProperties:
    urlTemplates: {}
    setURLTemplates: (data) ->
        @urlTemplates = data
    urlFromTemplate: (url, data) ->
      for key of data
        val = data[key]
        replacement = "{#{key}}"
        url = url.replace(replacement, val)
      url
    getURL: (key, replacementData) ->
      @urlFromTemplate(@urlTemplates[key], replacementData)
  instanceProperties:
    getURL: (key, replacementData) ->
      @constructor.getURL(key, replacementData)

