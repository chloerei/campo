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

$(document).on 'change', '.markdown-area .file-upload input', (event) ->
  textarea = $(this).closest('.markdown-area').find('textarea')

  $.each event.target.files, ->
    formData = new FormData()
    formData.append 'attachment[file]', this
    fileName = this.name
    imageText = "![#{fileName}]()"
    imageText = "\n\n" + imageText if textarea.val() != ''
    textarea.val(textarea.val() + imageText).trigger('autosize.resize')

    $.ajax
      url: '/attachments'
      type: 'POST'
      dataType: 'json'
      processData: false
      contentType: false
      data: formData
      success: (data) ->
        textarea.val(textarea.val().replace("![#{fileName}]()", "![#{fileName}](#{data.url})")).trigger('autosize.resize')
