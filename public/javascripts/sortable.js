(function($) {

	$.fn.GetPlannings = function() {
		var fields = new Array() ;
		$(".sortable").each(function(value, elem) {
			$(this).find("tr").each(function(ii,mnu){
				var menu = { id: 'mnu_'+$(this).attr("id"), day: value }
				fields.push(menu);
			})
		});
		return fields;
	}

})(jQuery);

$().ready(function() {
	
/*	$(".sortable").sortable({
		cancel: '.ui-state-disabled',
		connectWith: '.sortable tbody',
		cursor: 'move',
		receive: function (event, ui) {			
			$.post('/choixmenu/addAll', {fields : JSON.stringify($(this).GetPlannings()), empty: true});
		}	
	}).disableSelection();*/
	
	
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		width: 500,
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
			"Annuler": function() {
				$( this ).dialog( "close" );
			}
		}
	});
	
	$( "#dialog-form" ).submit(function() {
		return false;
	});
	
	$(document).delegate(".delete_mnu", "click", function() {
		$(this).parent().remove();
		return false;
	});
	
	$(document).delegate(".up_mnu", "click", function() {
		$(this).parent("tr").appendTo($(this).parents(".organise").prev().find("tbody"));
	});

	$(document).delegate(".down_mnu", "click", function() {
		$(this).parent("tr").appendTo($(this).parents(".organise").next().find("tbody"));
	});
	
	$( "#create-planning,#update-planning" ).click(function() {
			$("#dialog-form" ).dialog( "open" );
	});
	
});
