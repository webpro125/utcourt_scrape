# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require plugins/jquery-ui.min
$ ->
  loadingGif = $('img.loading-gif').clone()
  loadingGif.removeClass('hide');
  $('input#user_first_name').parent().append(loadingGif)
  log = (message) ->
    $('<div>').text(message).prependTo '#log'
    $('#log').scrollTop 0
    return

  $('#user_first_name').autocomplete
    search: (event, ui) ->
      loadingGif.show()
      return
    source: (request, response) ->
      $.ajax
        url: '/user_autocomplete'
        dataType: 'json'
        data: q: request.term
        success: (data) ->
          loadingGif.hide()
          response data
          return
      return
    minLength: 2
    select: (event, ui) ->
      event.preventDefault()
      $('input#user_first_name').val(ui.item.first_name)
      $('input#user_last_name').val(ui.item.last_name)
      return
    open: ->
      $(this).removeClass('ui-corner-all').addClass 'ui-corner-top'
      return
    close: ->
      $(this).removeClass('ui-corner-top').addClass 'ui-corner-all'
      return
  .autocomplete( "widget" ).addClass( "typeahead dropdown-menu" )
  return