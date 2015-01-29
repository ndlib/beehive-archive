window.RedactorPlugins = {}  unless window.RedactorPlugins
window.RedactorPlugins.bufferbuttons = ->
  init: ->
    undo = @button.addFirst("undo", "Undo")
    redo = @button.addAfter("undo", "redo", "Redo")
    @button.addCallback undo, @buffer.undo
    @button.addCallback redo, @buffer.redo
    return


jQuery ->
  $('.redactor-field').each ->
    element = $(this)
    element.redactor(
      buttonSource: true
      plugins: ['bufferbuttons']
      placeholder: element.attr('placeholder')
      minHeight: 300
    )
