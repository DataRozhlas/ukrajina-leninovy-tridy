mapElement = document.createElement \div
  ..className = 'map'
ig.containers.base.appendChild mapElement
map = L.map do
  * mapElement
  * minZoom: 6,
    maxZoom: 14,
    zoom: 6,
    center: [51.26191485308454, 32.2119140625]
    maxBounds: [[44.0560,21.6210], [52.7495,41.0449]]

tiles = L.tileLayer do
  'http://{s}.tile.osm.org/{z}/{x}/{y}.png'
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'

tiles.addTo map
{lenin} = ig.data
geojson = topojson.feature lenin, lenin.objects."data"

streets = L.geoJson do
  geojson
  style: ->
    color: \red
  onEachFeature: (feature, layer) ->
    layer.bindPopup feature.properties.name

streets.addTo map
