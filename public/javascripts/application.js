// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function MDLSUtil() { }

MDLSUtil.replaceTitre = function(name) {
  var chaine = name;
  Element.replace('title', '<h1>'+name+'</h1>') ;
};
