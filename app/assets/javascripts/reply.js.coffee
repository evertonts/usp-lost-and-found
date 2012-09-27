# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Window.registerClick = (messagesIds) ->
	for id in messagesIds
		console.log($("a#responder-" + id))
		$("a#responder-" + id).click(() ->
			_id = (this.id.split('-')[1])
			url = $(this).attr('href')
			Window.removeForm()
			$.get(url, ((data) -> Window.appendContent(data, _id)), 'html')
			return false
		)
		
		$('a#cancelar').live('click', () ->
			Window.removeForm()
			return false
		)


Window.appendContent = (content, id) ->
	console.log($('#form-content-' + id))
	$('#form-content-' + id).append(content)
	console.log($('#reply_text'))
	$('#reply_text').focus()

Window.removeForm = () ->
	console.log($('.reply-form'))
	if $('.reply-form').length
		$('.reply-form').remove();