# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.registerClick = (messagesIds) ->
	for id in messagesIds
		$("a#responder-" + id).click(() ->
			_id = (this.id.split('-')[1])
			url = $(this).attr('href')
			window.removeForm()
			$.get(url, ((data) -> window.appendContent(data, _id)), 'html')
			return false
		)
		
		$('a#cancelar').live('click', () ->
			window.removeForm()
			return false
		)


window.appendContent = (content, id) ->
	$('#form-content-' + id).append(content)
	$('#reply_text').focus()

window.removeForm = () ->
	if $('.reply-form').length
		$('.reply-form').remove();