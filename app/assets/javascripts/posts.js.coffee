$(document).on 'click', '.post [data-vote]', ->
  button = $(this)
  post = button.closest('.post')
  id = post.data('id')
  type = if button.attr('data-voted')? then 'cancel' else button.data('vote')

  $.ajax
    url: "/posts/#{id}/vote"
    data: { type: type }
    method: 'PATCH'
    datatype: 'json'
    success: (data) ->
      button.siblings('[data-voted]').attr('data-voted', null)
      if type is 'cancel'
        button.attr('data-voted', null)
      else
        button.attr('data-voted', true)

      if data.votes is 0
        post.find('.votes').text('')
      else
        post.find('.votes').text(data.votes)
