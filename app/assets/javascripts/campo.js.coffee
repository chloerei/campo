@campo = {}

$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

$(document).popover
  selector: '[data-behaviors~=pagination-popover]'
  content: ->
    $(this).siblings('.popover').find('.popover-content').html()
  html: true

$.validator.setDefaults
  highlight: (element) ->
    $(element).closest(".form-group").addClass "has-error"

  unhighlight: (element) ->
    $(element).closest(".form-group").removeClass "has-error"

  errorElement: "span"
  errorClass: "help-block"
  errorPlacement: (error, element) ->
    if element.parent(".input-group").length
      error.insertAfter element.parent()
    else
      error.insertAfter element
