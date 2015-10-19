# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
   navbar = document.getElementsByClassName("navbar navbar-inverse")
   color = ["black", "#607D8B", "#4CAF50", "#03A9F4", "#9C27B0"]
   ind = Math.floor(Math.random() * color.length)
   navbar[0].style['background-color'] = color[ind]

   $('pre code').each (i, block) ->
     hljs.highlightBlock block
     return
   return
