campo.VisibleTo =
  # data-visible-to="options"
  #
  # options:
  #   - user: Visible to logined user
  #     Check if campo.currentUser exists.
  #
  #   - creator: Visible to creator
  #     Find closest element witch has data-creator-id,
  #     and compare with campo.currentUser.id.
  #
  #   - no-creator: Visible to anyone except creator
  check: ->
    $('[data-visible-to]').each ->
      $element = $(this)
      rules = $element.data('visible-to').split(/\s/)

      if 'user' in rules
        if !campo.currentUser?
          return $element.remove()

      if 'creator' in rules
        creator_id = $element.closest('[data-creator-id]').data('creator-id')
        if (!campo.currentUser?) or (campo.currentUser.id != creator_id)
          return $element.remove()

      if 'no-creator' in rules
        creator_id = $element.closest('[data-creator-id]').data('creator-id')
        if campo.currentUser? and (campo.currentUser.id == creator_id)
          return $element.remove()

$(document).on 'page:update', ->
  campo.VisibleTo.check()
