# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Requires jQuery



$(document).ready ->
  $('#login-window').dialog
  	autoOpen: false
  	fluid: true
  	modal: true
  	maxWidth: '450'
  	maxheight: '500'
  	draggable: true
  	title: 'Sign In'

  $('#signup-window').dialog
  	autoOpen: false
  	title: 'Sign Up'

  $('#login-nav').click ->
    $('#login-window').dialog('open')
    false
  $('#signup-nav').click ->
  	$('#signup-window').dialog('open')
  return

