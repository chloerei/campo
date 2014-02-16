$.validator.setDefaults
  highlight: (element) ->
    $(element).closest(".form-group").addClass "has-error"

  unhighlight: (element) ->
    $(element).closest(".form-group").removeClass "has-error"

  errorElement: "span"
  errorClass: "help-block"
  errorPlacement: (error, element) ->
    error.appendTo(element.closest('.form-group'))

jQuery.validator.addMethod "format", ((value, element, param) ->
  @optional(element) or param.test(value)
), "Please fix this field."
