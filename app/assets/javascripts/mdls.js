$(document).ready(function() {
	$('#alert').hide();
	$('#alert').show('highlight', {} , 1000, function() { 
			setTimeout(function() {
				$('#alert').removeAttr( "style" ).fadeOut();
			}, 1000)});
	
})