jQuery ->
  $('#long-tag-list').hide()
  $('.expand-tags').click ->
    $('#long-tag-list').toggle()
    $('#short-tag-list').toggle()
