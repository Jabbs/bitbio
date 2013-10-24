$ ->
  $('#message').click -> 
    $('#message-form').slideDown(200)
    data_rec = $('#message').data('blah')
    $('#message_receiver_id').val(data_rec)
    # to_content = "TO:" + " " + $('#message').data('namee')
    # $('#to_field').text(to_content)
    event.preventDefault()
  $('.cancel').click -> 
    $('#message-form').slideUp(200)
    $('#message').show()
    event.preventDefault()