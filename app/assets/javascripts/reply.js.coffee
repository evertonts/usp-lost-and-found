# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(() ->
	$("a#responder").click(() ->
  	removeForm() 
  	url = $(this).attr('href')
  	$.get(url, ((data) -> appendContent(data)), 'html')
  	return false
	)
	
	$('a#cancelar').live('click', () ->
		removeForm()
		return false
  )
)

appendContent = (content) ->
  $('#form-content').append(content)

removeForm = () ->
	if $('.reply-form').length
		$('.reply-form').remove();