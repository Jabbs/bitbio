# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('fieldset:nth-child(3)').hide()
  $('.edit_user').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    $('.new_attch').show()
    event.preventDefault()
    
  if $('#showSignupModal').length
    $('#signupModal').removeClass('fade');
    $('#signupModal').modal('show');
  if $('#showLoginModal').length
    $('#loginModal').modal('show');
  # if $('#loginModal').length
  #   $('#forgot_pass').hide();
  
  $('.loginlink').mousedown ->
    $('#forgot_pass').hide();
    $('#login').show();
  $('#show_forgot_pass').mousedown ->
    $('#login').hide();
    $('#forgot_pass').show();
  