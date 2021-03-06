
expand = (text)->
  text
    .replace /&/g, '&amp;'
    .replace /</g, '&lt;'
    .replace />/g, '&gt;'
    .replace /\*(.+?)\*/g, '<i>$1</i>'

beam = (url) ->
  $.getJSON url, (page) ->
    resultPage = wiki.newPage(page)
    wiki.showResult resultPage

emit = ($item, item) ->
  $item.append """
    <p style="background-color:#eee;padding:15px;">
      #{expand item.text}<br>
    </p>
  """

bind = ($item, item) ->
  $item.dblclick -> wiki.textEditor $item, item
  $item.find('button').click ->
    beam item.text
  $item.on 'drop', (e) ->
    e.preventDefault()
    e.stopPropagation()

    htmlDtoppedElem = e.originalEvent.dataTransfer.getData('text/html')
    link = $(htmlDtoppedElem).attr "href"

    $.getJSON item.text, { drop: link }, (page) ->
      resultPage = wiki.newPage(page)
      wiki.showResult resultPage


window.plugins.transport = {emit, bind} if window?
module.exports = {expand} if module?
