$(document).on 'show.bs.tab', 'a[data-behaviors~="preview"]', (e) ->
  editor = $(this).closest('.campo-editor')
  preview = editor.find('.preview')
  textarea = editor.find('textarea')
  preview.html('')
  preview.css height: textarea.css('height')

  $.ajax
    url: '/comments/preview'
    data: { content: textarea.val() }
    type: 'POST'
    success: (data) ->
      console.log preview
      preview.html(data)
      preview.css height: 'auto'
