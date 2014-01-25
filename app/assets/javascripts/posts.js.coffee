campo.Posts =
  init: ->
    $(document).on 'click', '[data-post-reply-to]', @replyTo

  replyTo: ->
    $textarea = $('#new_post').find('textarea')
    $textarea.focus()
    $textarea.val($textarea.val() + $(this).data('post-reply-to') + ' ')

campo.Posts.init()
