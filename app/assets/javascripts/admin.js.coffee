# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->  
  $('#myTab a').click (e) ->
    e.preventDefault()
    $(this).tab('show')
    
  url = document.URL

  if url.indexOf("user_order") != -1
    $('#myTab a#user_tab').tab('show')
  if url.indexOf("project_order") != -1
    $('#myTab a#project_tab').tab('show')
  if url.indexOf("blog_order") != -1
    $('#myTab a#blog_tab').tab('show')
  if url.indexOf("event_order") != -1
    $('#myTab a#event_tab').tab('show')
  if url.indexOf("facility_order") != -1
    $('#myTab a#facility_tab').tab('show')
  if url.indexOf("contact_order") != -1
    $('#myTab a#contact_tab').tab('show')
      