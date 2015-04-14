mapElement = document.createElement \div
  ..className = 'map'
ig.containers.base.appendChild mapElement
map = L.map do
  * mapElement
  * minZoom: 5,
    maxZoom: 14,
    zoom: 5,
    center: [51.26191485308454, 32.2119140625]
    maxBounds: [[44.0560,21.6210], [52.7495,41.0449]]

tiles = L.tileLayer do
  'http://{s}.tile.osm.org/{z}/{x}/{y}.png'
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'

tiles.addTo map
{lenin, ukraine} = ig.data
geojson = topojson.feature lenin, lenin.objects."data"

i = 0
borders = L.geoJson do
  topojson.feature ukraine, ukraine.objects."data"
  style: (feature) ->
    i++
    if i == 1 # ukrajina
      color: \#005BBB
      weight: 1
      clickable: no
      fillOpacity: 0.1
    else # krym
      color: \#005BBB
      dashArray: "5,5"
      weight: 1
      clickable: no
      fillOpacity: 0.05

borders.addTo map

streets = L.geoJson do
  geojson
  style: ->
    color: \red
  onEachFeature: (feature, layer) ->
    layer.bindPopup "#{feature.properties.name}<br>#{ig.transliterate feature.properties.name}"

streets.addTo map
