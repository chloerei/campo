@campo = {}

$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

$(document).popover
  selector: '[data-behaviors~=pagination-popover]'
  content: ->
    $(this).siblings('.popover').find('.popover-content').html()
  html: true
