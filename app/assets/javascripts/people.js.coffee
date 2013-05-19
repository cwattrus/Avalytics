# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("button.multiselect-clear").click (e) ->
    e.preventDefault()
    $($(this).data("to-clear")).find("option:selected").removeAttr("selected")