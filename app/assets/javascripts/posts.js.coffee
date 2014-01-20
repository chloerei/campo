campo.Posts =
  init: ->
    $(document).on 'click', '[data-post-reply-to]', @replyTo

  replyTo: ->
    $textarea = $('#new_post').find('textarea')
    $textarea.focus()
    $textarea.val($textarea.val() + $(this).data('post-reply-to') + ' ')

  updateVotes: (postVotes) ->
    for post_vote in postVotes
      post = $("#post_#{post_vote.post_id}")
      console.log post
      switch post_vote.type
        when 'up'
          post.find('.post-vote-up').addClass('active').attr('data-method', 'delete')
        when 'down'
          post.find('.post-vote-down').addClass('active').attr('data-method', 'delete')

campo.Posts.init()
