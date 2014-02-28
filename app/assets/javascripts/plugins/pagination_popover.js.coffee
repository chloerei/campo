$(document).popover
  selector: '[data-behaviors~=pagination-popover]'
  content: ->
    $(this).siblings('.popover').find('.popover-content').html()
  html: true
