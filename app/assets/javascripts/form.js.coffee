$.extend $.fn.form.settings.rules,
  username: (value) ->
    /\w+/.test value

  check_email: (email) ->
    data = $.ajax(
      url: '/users/check_email'
      data:
        email: email
      cache: false
      dataType: 'json'
      async: false
    ).responseJSON.uniqueness

  check_username: (username) ->
    data = $.ajax(
      url: '/users/check_username'
      data:
        username: username
      cache: false
      dataType: 'json'
      async: false
    ).responseJSON.uniqueness
