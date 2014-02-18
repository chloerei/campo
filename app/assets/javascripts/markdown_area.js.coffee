$(document).on 'focus', '.markdown-area textarea', ->
  $(this).closest('.markdown-area').addClass('focus')

$(document).on 'blur', '.markdown-area textarea', ->
  $(this).closest('.markdown-area').removeClass('focus')

$(document).on 'click', '.markdown-area a[data-behaviors~="preview"]', (e) ->
  area = $(this).closest('.markdown-area')
  preview = area.find('.preview')
  textarea = area.find('textarea')
  preview.html('')
  preview.css height: textarea.css('height')

  $.ajax
    url: '/markdown/preview'
    data: { body: textarea.val() }
    type: 'POST'
    success: (data) ->
      preview.html(data)
      preview.css height: 'auto'
