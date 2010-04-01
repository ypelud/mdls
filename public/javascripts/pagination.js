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