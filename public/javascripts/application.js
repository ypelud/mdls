// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults




$(document).ready(function() {
	$("#flash").notifyFlash();
		
	//   	$(".login").click(function() {
	// 	$.getScript(this.href)
	// 	return false;
	// });	
	
	$('.buttonz').button();
	$('.sousmenu').addClass('ui-button ui-widget ui-state-default ui-button-text-only');
	$('.sousmenu a:first-child').addClass('ui-button-text');
	//$('.button').addClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only ui-state-hover ui-state-active');
		
}) ;
