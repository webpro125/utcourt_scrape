# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require datapicker/bootstrap-datepicker
#= require clockpicker/clockpicker
$ ->
  $('.input-group.date').datepicker({
    todayBtn: "linked",
    format: 'yyyy-mm-dd',
    keyboardNavigation: false,
    forceParse: false,
    calendarWeeks: true,
    autoclose: true
  });
  $('.clockpicker').clockpicker();