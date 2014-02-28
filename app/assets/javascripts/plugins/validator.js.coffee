$.validator.setDefaults
  highlight: (element) ->
    $(element).closest(".form-group").addClass "has-error"

  unhighlight: (element) ->
    $(element).closest(".form-group").removeClass "has-error"

  errorElement: "span"
  errorClass: "help-block"
  errorPlacement: (error, element) ->
    if element.closest('.markdown-area').length
      error.insertAfter(element.closest('.markdown-area'))
    else if element.parent('.input-group').length
      error.insertAfter(element.parent())
    else
      error.insertAfter(element)

jQuery.validator.addMethod "format", ((value, element, param) ->
  @optional(element) or param.test(value)
), "Please fix this field."
