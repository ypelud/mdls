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
				$.get(urlDrop + '/' + ui.draggable.parents("div[id^=mnuMidi]").attr("id"), function(data) {
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
	
	
	$.fn.addAllMenu = function(settings) {
		var elem = $(this) ;
		$(this).click(function() {
		
			var fields = new Array() ;
			var cpte = 0;
			$(':checked', settings.selectBoxes).each(function(ii, val) {
				var menu = { id: $(this).attr("id")}
				fields.push(menu);
				$(this).attr("checked", false);
				cpte++;							
			});
			$.post(settings.url, {fields : JSON.stringify(fields)}, function(data) {
					$(settings.dropSelector).html(data);
					$("#flash").notifyFlash(cpte+' repas ajouté(s)')
			      }
			);
		});
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
			className   :'dropDown ui-state-hover'
			}); //.css("top", container.offset().top + container.outerHeight()  ).css("left",offset.left);
			
		var selectBox = selectBoxContainer.find('.selectBox');
		
		dropDown.append($('<li>',{html:   '<span class="all">'+settings.tous+'</span>' }) );
			//.__selectAll($(settings.selectBoxes), $(checkbox),  true) );
		dropDown.append($('<li>',{html:   '<span class="none">'+settings.aucun+'</span>'}) );
			//.__selectAll($(settings.selectBoxes), $(checkbox),  false) );
		
		selectBoxContainer.append(dropDown.hide());
		select.after(selectBoxContainer);
		
		// Binding custom show and hide events on the dropDown:

		$('.dropDown').bind('show',function(){
        
			if($(this).is(':animated')){
				return false;
			}
        
			$(this).addClass('expanded');
			$(this).slideDown();
        
		}).bind('hide',function(){
        
			if($(this).is(':animated')){
				return false;
			}
        
			$(this).removeClass('expanded');
			$(this).slideUp();
        
		}).bind('toggle',function(){
			if($(this).hasClass('expanded')) 
				$(this).trigger('hide');
			else 
				$(this).trigger('show');
		}).delegate(".all", "click", function() {
			$(settings.selectBoxes).attr("checked", true);
			$(checkbox).attr("checked", true);
		}).delegate(".none", "click", function() {
			$(settings.selectBoxes).attr("checked", false);
			$(checkbox).attr("checked", false);
		});
		
		
		checkbox.click(function() {
			var chk = $(this).attr("checked");
			$(settings.selectBoxes).attr("checked", chk);
			checkbox.attr("checked", chk);
		});
		
		$(settings.selectBoxes).live('click', function() {
			if ($(this).attr("checked")) {
				checkbox.attr("checked", true);
			}			
		});
		
		select.click(function(){
			var ddnow = $(this).next('.tzSelect').find(".dropDown:first");
			top = $(this).parent().innerHeight();
			//left = $(this).parent().offset().left;
			ddnow.css("top", top).css("left", 0);
			ddnow.trigger('toggle');
			return false;
		});
        
		// If we click anywhere on the page, while the
		// dropdown is shown, it is going to be hidden:
        
		$(document).click(function(){
			$('.dropDown').trigger('hide');
		});
		
	}
	
	
	$.fn.add2Planning = function(options) {
		var settings = $.extend({ },
			options) ;
		
		var select = $(this);
		
	}
	
	
	
	
	$.fn.notifyFlash = function(flash_message, error) { 
		var flash_div = $(this) 
		flash_div.hide() ;
		
		if (!flash_message) {
			flash_message = flash_div.html().trim(); 			
		}

		if (flash_message) {
			flash_div.html(flash_message); 
			flash_div.addClass(error?"ui-state-error":"ui-state-highlight");
			flash_div.fadeIn(400); 
			// use Javascript timeout function to delay calling 
			// our jQuery fadeOut, and hide 
			setTimeout(function(){ 
				flash_div.fadeOut(500, function(){ 
					flash_div.html(""); 
					flash_div.hide()
				})
			}, 3000);
		}
	} 
	
	
	$.fn.replaceCK = function() {
		CKEDITOR.replace($(this).get(0));
	}
	
	$.fn.afficheComments = function() {
		$(this).dialog({ 
			width: 600, 
			buttons: { 
				"Ok": function() {
					$(this).dialog("close"); 
				}
			}
		});
	}
	
	
})(jQuery);