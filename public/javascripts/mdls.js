(function($) {
	
	$.fn.dragDropMenus = function(dropSelector, urlDrop) {
		var elem = $(this) ;
		
		elem.live("mouseover", function(event) {
			$(this).draggable({ 
				handle: '.dragicon',
			  	revert: true, 
			  	helper: 'clone'
			 });
		}) ;

		$(dropSelector).droppable({
			activeClass: 'ui-state-hover',
			hoverClass: 'ui-state-active',
			accept: $(this).selector,
			drop: function(event, ui) {
				$.get(urlDrop + '/' + $(ui.draggable).attr("id"), function(data) {
				  $(dropSelector).html(data);
				});
			}
		});
		
		return $(this);
	} ;
	
	
	$.fn.pagination = function() {
		$(".pagination a").live("click", function() {
			$(".pagination").html("Page en cours de chargement...")
			$.setFragment({ "page" : $.queryString(this.href).page })
			return false;
		});

		$.fragmentChange(true);
		$(document).bind("fragmentChange.page", function() {
			$.getScript($.queryString(document.location.href, { "page" : $.fragment().page }));
		});

		if ($.fragment().page) {
			$(document).trigger("fragmentChange.page");
		}	
	};
	
	
	var methods = {
	
	   	selectDropDown : function(settings) {
			var li = $('<li>',{
					html:   '<span>'+settings.tous+'</span>'
				}).click(function() {
					$(settings.selectBoxes).attr("checked", true)
				}) ;
			$(this).append(li);
			var li2 = $('<li>',{
					html:   '<span>'+settings.aucun+'</span>'
				}).click(function() {
					$(settings.selectBoxes).attr("checked", false)
				}) ;
			$(this).append(li2);
		},
				
		addDropDown : function(settings) {
			var elem = $(this) ;
			var map = { Lundi: 1, Mardi: 2, Mercredi: 3, Jeudi:4, Vendredi:5, Samedi:6, Dimanche:7, 'Je ne sais pas': 0} ;
			 
			$.each(map, function(index, value){
				var li = $('<li>',{
						html:   '<span>'+index+'</span>'
					}).click(function() {
						
						var fields = new Array() ;
						$(':checked', settings.selectBoxes).each(function(ii, val) {
							var menu = { id: $(this).attr("id"), day: value }
							fields.push(menu);
						});
						$.post(settings.url, {fields : JSON.stringify(fields)}, function(data) {
								$(settings.dropSelector).html(data);
						      }
						);
					}) ;
				elem.append(li);
			});
		}
	};
	
	var settings = {
		tous: 'tous',
		aucun: 'aucun',
		selectBoxes: '#menus .checkbox input',
		method: 'selectDropDown',
		size: 100
	};
	
	$.fn.selectAll = function(options) {
		
		$.extend(settings, options) ;
		
		// The select element to be replaced:
		var select = $(this);
		
		var offset = select.offset() ;
		
		var selectBoxContainer = $('<div>',{
				className	: 'tzSelect',
				html		: '<div class="selectBox"></div>'				
			});
			
		var dropDown = $('<ul>',{
			width		: settings.size,
			className   :'dropDown'
			}).css("top", select.offset().top + select.outerHeight() - 2 ).css("left",offset.left);
			
		var selectBox = selectBoxContainer.find('.selectBox');
		
		if ( methods[settings.method] ) {
			methods[settings.method].apply( dropDown , arguments );
		}
		
		selectBoxContainer.append(dropDown.hide());
		select.after(selectBoxContainer);
		
		// Binding custom show and hide events on the dropDown:

		dropDown.bind('show',function(){
        
			if(dropDown.is(':animated')){
				return false;
			}
        
			select.addClass('expanded');
			dropDown.slideDown();
        
		}).bind('hide',function(){
        
			if(dropDown.is(':animated')){
				return false;
			}
        
			select.removeClass('expanded');
			dropDown.slideUp();
        
		}).bind('toggle',function(){
			if(select.hasClass('expanded')){
				dropDown.trigger('hide');
			}
			else dropDown.trigger('show');
		});
        
		select.click(function(){
			dropDown.trigger('toggle');
			return false;
		});
        
		// If we click anywhere on the page, while the
		// dropdown is shown, it is going to be hidden:
        
		$(document).click(function(){
			dropDown.trigger('hide');
		});
		
	}
	
	
	$.fn.add2Planning = function(options) {
		var settings = $.extend({ },
			options) ;
		
		var select = $(this);
		
	}
	
	
})(jQuery);