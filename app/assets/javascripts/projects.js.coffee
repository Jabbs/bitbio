jQuery ->
  # $('.main-nav-set li').hide()
  # $('.main-nav-set li:first-child').show()
  $('.main-nav-set li:first-child').mouseenter ->
    $(this).parent().children().show()
  $('.main-nav-set').mouseleave ->
    $(this).children().hide()
    $('.main-nav-set li:first-child').show()
    
  $(".main-nav-set li").click ->
    url = $(this).find("a").attr('href')
    if url
      window.location = url
    
  $('#any').mousedown ->
    if $(this).prop('checked') == false
      $('.ctry').prop('checked', false)
  $('#eur').mousedown ->
    $('#any').prop('checked', false)
  $('#na').mousedown ->
    $('#any').prop('checked', false)
  $('#asia').mousedown ->
    $('#any').prop('checked', false)
  $('#aus').mousedown ->
    $('#any').prop('checked', false)
    
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()
    
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    

    # if (!$(this).is(':checked')) {
    #       this.checked = confirm("Are you sure?");
    #       $(this).trigger("change");
    #   }

  