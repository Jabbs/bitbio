# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if $('#showSignupModal').length
    $('#signupModal').removeClass('fade');
    $('#signupModal').modal('show');
  if $('#showLoginModal').length
    $('#loginModal').modal('show');
  if $('#loginModal').length
    $('#forgot_pass').hide();
  
  $('#show_forgot_pass').mousedown ->
    $('#login').hide();
    $('#forgot_pass').show();
  