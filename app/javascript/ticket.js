document.addEventListener('DOMContentLoaded', function() {
  var wkt = document.getElementById("well_known_text").value;
  var polygonCoords = wkt.slice(10, -2).split(',').map(function(point) {
  var latLng = point.trim().split(' ').map(parseFloat);
  return [latLng[1], latLng[0]];
  });

  var map = L.map('map').setView([polygonCoords[0][0], polygonCoords[0][1]], 15);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
  L.polygon(polygonCoords).addTo(map);
  map.fitBounds(polygonCoords);
});
