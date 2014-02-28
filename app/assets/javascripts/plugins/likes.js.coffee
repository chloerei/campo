campo.Likes =
  updateLike: (likeable, id, liked = true) ->
    if liked
      $("#like-for-#{likeable}-#{id}").addClass('liked').data('method', 'delete')
    else
      $("#like-for-#{likeable}-#{id}").removeClass('liked').data('method', 'post')

  updateLikes: (likeable, ids, liked = true) ->
    for id in ids
      @updateLike(likeable, id, liked)
