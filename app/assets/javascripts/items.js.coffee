# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready(() ->
	$('#files').bind("click" , () ->
		console.log($('#file'))
		$('#file').click()
	)
	
	$('#file').bind('change', () ->
		str = $(this).val()
		console.log(this)
		console.log(str)
		aux = str.split("\\")
		console.log(aux)
		str = aux[aux.length - 1]
		$("#filename").text(str)
	).change()
	
);
