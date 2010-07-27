$(function() {
		
	$(".pagination a").live("click", function() {
		$(".pagination").html("Page en cours de chargement...")
		$.setFragment({ "page" : $.queryString(this.href).page })
		/*$.getScript(this.href);*/
		return false;
	});

	$.fragmentChange(true);
	$(document).bind("fragmentChange.page", function() {
		$.getScript($.queryString(document.location.href, { "page" : $.fragment().page }));
	});

	if ($.fragment().page) {
		$(document).trigger("fragmentChange.page");
	}
});




$(document).ready(function() {
	
	alert("TEST") ;
	$("tr[id^='mnuMidi']").live("mouseover", function(event) {
		$(this).draggable({ 
			handle: '.menu_cart',
		  	revert: true, 
		  	helper: 'clone'
		 });
	}) ;
	//$("tr[id^='mnuMidi']").live("click", function() {
		// alert(this.id)
		// 	
	
	$("#cart").droppable({
		activeClass: 'ui-state-hover',
		hoverClass: 'ui-state-active',
		accept: "tr[id^='mnuMidi']",
		drop: function(event, ui) {
			var theId =  $(ui.draggable[0]).attr("id").split("_")[1] ;
			$.get("/choixmenu/add/" + theId, function(data) {
			  $('#cart').html(data);
			});
		}
	});
});