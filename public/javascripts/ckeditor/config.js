/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.language = 'fr';
	config.uiColor = '#F4ECCA';
	config.toolbar = 'Basic';
	config.removePlugins = 'elementspath'
	
	config.toolbar_Basic = 
	[
		['Bold','Italic','Underline', 'JustifyLeft', 'JustifyCenter',
		 'JustifyRight', 'Smiley', 'Font', 'FontSize', 'TextColor', 'BGColor' ]
	];
//	config.removePlugins = 'elementPath';
};
