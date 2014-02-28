$(document).on 'submit', 'form[method=get]:not([data-remote])', (event) ->
  event.preventDefault()
  symbol = if @.action.indexOf('?') == -1 then '?' else '&'
  Turbolinks.visit @.action + symbol + $(@).serialize()
