# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Requires jQuery

$(document).ready ->
  $(".login-window").hide()
  $("#login-nav").click -> 
    $(".login-window").dialog( 
      show: "slide"
      hide: "toggle"
      width: 400
      height: 500
      modal: true
      title: ""
      buttons: 
        Close: ->
          $(".login-window").dialog "close"
          $(".login-window").css("display", "none")
          return
    )
    false
  return
