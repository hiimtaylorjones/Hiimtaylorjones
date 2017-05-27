// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function() {
 var navbar = document.getElementsByClassName("navbar navbar-inverse");
 var color = ["#4CAF50", "#03A9F4", "#f34d4d", "#f765b8","#ffab7f", "#35c390"];
 var ind = Math.floor(Math.random() * color.length);
 navbar[0].style['background-color'] = color[ind];

 $.each($('.code'), function(i, block) {
   hljs.highlightBlock(block);
 });
});
