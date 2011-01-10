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
					
		addDropDown : function(settings) {
			var elem = $(this) ;
			var map = { Lundi: 1, Mardi: 2, Mercredi: 3, Jeudi:4, Vendredi:5, Samedi:6, Dimanche:7, 'Je ne sais pas': 0} ;
			 
			$.each(map, function(index, value){
				var li = $('<li>',{
						html:   '<span>'+index+'</span>'
					}).click(function() {
						
						var fields = new Array() ;
						var cpte = 0;
						$(':checked', settings.selectBoxes).each(function(ii, val) {
							var menu = { id: $(this).attr("id"), day: value }
							fields.push(menu);
							$(this).attr("checked", false);
							cpte++;							
						});
						$.post(settings.url, {fields : JSON.stringify(fields)}, function(data) {
								$(settings.dropSelector).html(data);
								$("#flash").notifyFlash(cpte+' repas ajouté(s)')
						      }
						);
					}) ;
				elem.append(li);
			});
		}
	};
	
	$.fn.__selectAll = function(allBoxes, checkBoxe, val) {

		$(this).click(function() {
			allBoxes.attr("checked", val);
			checkBoxe.attr("checked", val);
		});
		return $(this);
	};
	
	$.fn.selectAll = function(options) {
		
		var settings = {
			tous: 'tous',
			aucun: 'aucun',
			selectBoxes: '#menus .checkbox input',
			method: 'selectDropDown',
			size: 100
		};
	
	 	$.extend(settings, options) ;
		
		// The select element to be replaced:
		var container = $(this);
		var select = $(this).find('.arrow');
        var checkbox = $(this).find('.chk_all');		
		var offset = container.offset() ;
		
		var selectBoxContainer = $('<div>',{
				className	: 'tzSelect',
				html		: '<div class="selectBox"></div>'				
			});
			
		var dropDown = $('<ul>',{
			width		: settings.size,
			className   :'dropDown'
			}).css("top", container.offset().top + container.outerHeight()  ).css("left",offset.left);
			
		var selectBox = selectBoxContainer.find('.selectBox');
		
		dropDown.append($('<li>',{html:   '<span>'+settings.tous+'</span>' })
			.__selectAll($(settings.selectBoxes), $(checkbox),  true) );
		dropDown.append($('<li>',{html:   '<span>'+settings.aucun+'</span>'})
			.__selectAll($(settings.selectBoxes), $(checkbox),  false) );
		
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
		
		checkbox.click(function() {
			var chk = $(this).attr("checked");
			$(settings.selectBoxes).attr("checked", chk)
		});
		
		$(settings.selectBoxes).live('click', function() {
			if ($(this).attr("checked")) {
				checkbox.attr("checked", true);
			}
			
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
	
	
	
	
	$.fn.notifyFlash = function(flash_message) { 
		var flash_div = $(this) 
		flash_div.hide() ;
		
		if (!flash_message) {
			flash_message = flash_div.html().trim(); 			
		}

		if (flash_message) {
			flash_div.html(flash_message); 
			flash_div.fadeIn(400); 
			// use Javascript timeout function to delay calling 
			// our jQuery fadeOut, and hide 
			setTimeout(function(){ 
				flash_div.fadeOut(500, function(){ 
					flash_div.html(""); 
					flash_div.hide()
				})
			}, 1400); 
		}
	} 
	
	
})(jQuery);