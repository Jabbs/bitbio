// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-ui
//= require bootstrap
//= require_tree .

$(function() {
  $('.main-nav-set li').hide()
  $('.main-nav-set li:first-child').show()
  
  $("#project_start_date").datepicker({
		dateFormat: "yy-mm-dd"
	});
	$("#start_date").datepicker({
		dateFormat: "yy-mm-dd"
	});
	$("#end_date").datepicker({
		dateFormat: "yy-mm-dd"
	});
	
  $('.typeahead').typeahead()
	
	$('#url-text').click(function() {
    $('#url-text').select();
  });
  
  jQuery(".tm-input").tagsManager({
    prefilled: $('#project-prefilled-tags').data('tags'),
    typeahead: true,
    typeaheadSource: $('#project-tags').data('tags'),
    blinkBGColor_1: '#FFFF9C',
    blinkBGColor_2: '#CDE69C',
    maxTags: 6,
    tagClass: "tm-tag-success"
  });
  
});

