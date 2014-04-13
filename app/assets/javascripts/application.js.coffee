#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require jquery.autosize
#= require jquery.validate
#= require jquery.timeago
#= require campo
#= require_tree ./plugins

$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

  $("time[data-behaviors~=timeago]").timeago()
