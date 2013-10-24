# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.reply').click ->
    comment_number = $(this).data("commentnumber")
    $('#rf-' + comment_number).slideDown(200)
    event.preventDefault()
  
  $('.cancelreply').click ->
    comment_number = $(this).data("commentnumber")
    $('#rf-' + comment_number).slideUp(200)
    event.preventDefault()