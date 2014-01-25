$(document).on 'show.bs.tab', 'a[data-behavior~="preview"]', (e) ->
  editor = $(this).closest('.campo-editor')
  preview = editor.find('.tab-pane.preview')
  textarea = editor.find('textarea')
  preview.html('')
  preview.css height: textarea.css('height')

  $.ajax
    url: '/posts/preview'
    data: { content: textarea.val() }
    type: 'POST'
    success: (data) ->
      preview.html(data)
      preview.css height: 'auto'
