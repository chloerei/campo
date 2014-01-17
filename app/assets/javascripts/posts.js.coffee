campo.Posts =
  init: ->
    @bindPostVoteAction()

  updateVotes: (postVotes) ->
    for post_vote in postVotes
      $("[data-post-id=#{post_vote.post_id}]").attr('data-post-voted', post_vote.type)

  bindPostVoteAction: ->
    $(document).on 'click', '[data-behavior~=post-votable] [data-post-vote-action]', ->
      if not campo.currentUser?
        # TODO show login modal
        Turbolinks.visit "/login?return_to=#{encodeURIComponent window.location.pathname}"
        return

      action = $(this)
      post = action.closest('[data-post-id]')
      id = post.data('post-id')
      action_type = action.data('post-vote-action')
      type = if post.attr('data-post-voted') is action_type then 'cancel' else action_type

      $.ajax
        url: "/posts/#{id}/vote"
        data: { type: type }
        method: 'PATCH'
        datatype: 'json'
        success: (data) ->
          if type == 'cancel'
            post.attr('data-post-voted', null)
          else
            post.attr('data-post-voted', type)

          score = post.find('.score')
          switch
            when data.score > 0
              score.text(data.score).removeClass('down').addClass('up')
            when data.score < 0
              score.text(data.score).removeClass('up').addClass('down')
            else
              score.text('').removeClass('up down')
        error: (xhr) ->
          try
            json = $.parseJSON(xhr.responseText)
            alert(json.message)
          catch
            alert('something error')

@campo.Posts.init()
