# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Requires jQuery


deselect = (e) ->
  $(".pop").slideFadeToggle ->
    e.removeClass "selected"
    return

  return
$ ->
  $("#sign-up-nav").on "click", ->
    if $(@).hasClass("selected")
      deselect $(@)
    else
      $(@).addClass "selected"
      $(".signup-pop").slideFadeToggle()
    false

  $(".close").on "click", ->
    deselect $("#sign-up-nav")
    false

  return

$ ->
  $("#log-in-nav").on "click", ->
    if $(@).hasClass("selected")
      deselect $(@)
    else
      $(@).addClass "selected"
      $(".login-pop").slideFadeToggle()
    false

  $(".close").on "click", ->
    deselect $("#log-in-nav")
    false

  return

$.fn.slideFadeToggle = (easing, callback) ->
  @animate
    opacity: "toggle"
    height: "toggle"
  , "fast", easing, callback