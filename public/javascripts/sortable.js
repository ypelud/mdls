(function($) {

	$.fn.GetPlannings = function() {
		var fields = new Array() ;
		$("ul[id^='sortable']").each(function(value, elem) {
			$(this).children().each(function(ii,mnu){
				var menu = { id: 'mnu_'+$(this).attr("id"), day: value }
				fields.push(menu);
			})
		});
		return fields;
	}

})(jQuery);

$().ready(function() {
	
	$("ul[id^='sortable']").sortable({
		cancel: '.ui-state-disabled',
		connectWith: 'ul',
		cursor: 'move',
		receive: function (event, ui) {			
			$.post('/choixmenu/addAll', {fields : JSON.stringify($(this).GetPlannings()), empty: true});
		}	
	}).disableSelection();	
	
	
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		buttons: {
			"Valider": function() {
				var form = $("#dialog-form form") ;
				if (form.attr('action') != null) {					
					var array = form.serializeArray() ;
					array.push({ name: "fields", value: JSON.stringify($(this).GetPlannings())})					
					$.post(form.attr('action'), array, function(data) {
						location.reload(true);
					});
				}
				$( this ).dialog( "close" );
				return false;
			},
			Cancel: function() {
				$( this ).dialog( "close" );
			}
		}
	});
	
	$( "#dialog-form" ).submit(function() {
		return false;
	});
	
	$('.delete_mnu').live('click', function() {
		$(this).parent().remove();
		return false;
	});
	

	$( "#create-planning" ).button().click(function() {
			$( "#dialog-form" ).dialog( "open" );
	});
	
	$( "#update-planning" ).button().click(function() {
			$( "#dialog-form" ).dialog( "open" );
	});
	
	$(".organise").addClass("ui-state-active");
});
