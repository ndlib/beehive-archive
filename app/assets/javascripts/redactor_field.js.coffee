window.RedactorPlugins = {}  unless window.RedactorPlugins
window.RedactorPlugins.bufferbuttons = ->
  init: ->
    undo = @button.addFirst("undo", "Undo")
    redo = @button.addAfter("undo", "redo", "Redo")
    @button.addCallback undo, @buffer.undo
    @button.addCallback redo, @buffer.redo
    return


jQuery ->

  $('#section_description').redactor(
      buttonSource: true
      plugins: ['bufferbuttons']
      placeholder: 'Add Text Describing the image'
      minHeight: 300
    )
