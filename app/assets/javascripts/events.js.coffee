# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#event_scheduled").datetimepicker
    language: "en"
    pick12HourFormat: true
  $(document).mouseup (e) ->
    container = $(".bootstrap-datetimepicker-widget")
    container.hide()  if container.has(e.target).length is 0
  $('#event_scheduled').click (e) ->
    $(".bootstrap-datetimepicker-widget").css({'top':e.pageY,'left':e.pageX}).show()
