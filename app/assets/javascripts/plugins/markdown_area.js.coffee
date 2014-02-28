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

$(document).on 'change', '.markdown-area .file-upload input[type=file]', (event) ->
  textarea = $(this).closest('.markdown-area').find('textarea')

  $.each event.target.files, ->
    formData = new FormData()
    formData.append 'attachment[file]', this
    fileName = this.name
    imageTag = "![#{fileName}]()"

    pos = textarea[0].selectionStart
    before = textarea.val().slice(0, pos)
    after = textarea.val().slice(pos, -1)
    before = before + "\n" if before != ''
    after = "\n" + after if after != ''
    textarea.val(before + imageTag + after).trigger('autosize.resize')
    textarea[0].selectionStart = (before + imageTag).length

    $.ajax
      url: '/attachments'
      type: 'POST'
      dataType: 'json'
      processData: false
      contentType: false
      data: formData
      success: (data) ->
        pos = textarea[0].selectionStart
        imagePos = textarea.val().indexOf(imageTag)
        textarea.val(textarea.val().replace(imageTag, "![#{fileName}](#{data.url})")).trigger('autosize.resize')
        if imagePos < pos
          textarea[0].selectionStart = textarea[0].selectionEnd = pos + data.url.length
        else
          textarea[0].selectionStart = textarea[0].selectionEnd = pos

  # Clear input, or ujs submit will be abort.
  $(this).replaceWith($(this).val('').clone())
