beehive.moduleKeywords = ['extended', 'included', 'mixin']

class beehive.Module
  @extend: (obj) ->
    for key, value of obj when key not in beehive.moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in beehive.moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    obj.included?.apply(@)
    this

  @mixin: (obj) ->
    @extend obj.classProperties
    @include obj.instanceProperties
