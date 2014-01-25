campo.Posts =
  init: ->
    $(document).on 'click', '[data-post-reply-to]', @replyTo

  updateLikes: (ids) ->
    for id in ids
      console.log $("#post_#{id} .post-like")
      $("#post_#{id} .post-like").addClass('active').attr('data-method', 'delete')

  replyTo: ->
    $textarea = $('#new_post').find('textarea')
    $textarea.focus()
    $textarea.val($textarea.val() + $(this).data('post-reply-to') + ' ')

campo.Posts.init()
