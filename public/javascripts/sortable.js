
$().ready(function() {
	$("ul[id^='sortable']").sortable({
		cancel: '.ui-state-disabled',
		connectWith: 'ul',
		cursor: 'move',
		receive: function (event, ui) {
			var fields = new Array() ;
			$("ul[id^='sortable']").each(function(value, elem) {
				$(this).children().each(function(ii,mnu){
					var menu = { id: 'mnu_'+$(this).attr("id"), day: value }
					fields.push(menu);
				})
			});
			$.post('/choixmenu/addAll', {fields : JSON.stringify(fields), empty: true});
		}	
	}).disableSelection();	
	
	
	$( "#dialog-form" ).dialog({
		autoOpen: false,
		resizable: false,
		modal: true,
		buttons: {
			"Valider": function() {
				/* serialize fields */
				//"_method=put&authenticity_token=vuoTEvhvjt65JHIccab8ZC%2Fhf%2BWDFf0dp18bjW2UgqQ%3D&planning%5Bname%5D=TESTBB2&planning%5Bpublic%5D=0&planning%5Bpublic%5D=1"
				
				var fields = '';
				$("ul[id^='sortable']").each(function(i, elem) {
					$(this).children().each(function(ii,mnu){
						fields += '&fields%5Bjour_'+(i+1)+'%5D%5B'+ii+'%5D='+mnu.id
					})
				});
				
				var form = $("#dialog-form form") ;
				if (form.attr('action') != null) {
					$.post(form.attr('action'), form.serialize()+fields, function(data) {
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
