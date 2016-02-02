###
extentiont OPTIONS
###

###wrap dom utility with selector engine ###
bonzo.setQueryEngine(qwery)
cgt = (selector) -> bonzo(qwery(selector))
get = (selector) -> qwery(selector)

getPrefix = () -> "cgt_"
setOption = (key, value) -> localStorage[getPrefix()+key] = value
getOption = (key, value) -> localStorage[getPrefix()+key]
updateStatus = (message) -> cgt('#message_box').html('<p>'+message+'</p>')


hasGetUserMedia = () -> (navigator.getUserMedia or navigator.webkitGetUserMedia or navigator.mozGetUserMedia or navigator.msGetUserMedia)

onFailSoHard  = (e) -> console.log 'Reeeejected!', e

page_saveOptions = (evt) ->
	console.log 'page_saveOptions'
	cgt('input, textarea, select').each( (e,i) ->
		console.log cgt(e).attr('id'), cgt(e).val()
		setOption cgt(e).attr('id'), cgt(e).val()
	)
	updateStatus 'Options successfully saved'

popupUserMediaSuccess = (localMediaStream) ->
	 video = document.querySelector('video');
	 video.src = window.URL.createObjectURL(localMediaStream);
	 video.onloadedmetadata = (e) -> console.log '// Ready to go. Do some stuff.'

popupInit = (evt) ->
	
	vendorUserMedia = hasGetUserMedia()
	console.log "popupInit. media?=", vendorUserMedia

	if vendorUserMedia
		navigator.webkitGetUserMedia({video:true, audio:false}, popupUserMediaSuccess, onFailSoHard);
		true


###DOMContentLoaded###
domReady(popupInit)