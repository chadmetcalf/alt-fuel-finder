  function initMap() {
    var directionsService = new google.maps.DirectionsService;
    var directionsDisplay = new google.maps.DirectionsRenderer;
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 6,
      center: {lat: 39.73, lng: -104.99}
    });

    directionsDisplay.setMap(map);

    document.getElementById('submit').addEventListener('click', function() {
      calculateAndDisplayRoute(directionsService, directionsDisplay);
    });
  }

  function calculateAndDisplayRoute(directionsService, directionsDisplay) {
    directionsService.route({
      origin: document.getElementById('start').value,
      destination: document.getElementById('end').value,
      optimizeWaypoints: true,
      travelMode: 'DRIVING'
    }, function(response, status) {
      if (status === 'OK') {
        directionsDisplay.setDirections(response);
        var route = response.routes[0];
        var summaryPanel = document.getElementById('directions-panel');
        summaryPanel.innerHTML = '';
      } else {
        window.alert('Directions request failed due to ' + status);
      }

      var allLegs = directionsDisplay.directions.routes[0].overview_path;
      coordinates = computeInterimCoordinates(allLegs);
      fetchAllStations(coordinates, directionsService, directionsDisplay);
    });
  }

  function computeInterimCoordinates(allLegs){
    var interval = document.getElementById('interval').value*1609.34;
    var legDistance = 0;
    var coordinates = [];

    for (var i = 0; i < allLegs.length - 1; i++) {
      var distance = google.maps.geometry.spherical.computeDistanceBetween(allLegs[i], allLegs[i+1]);
      legDistance += distance
      if (legDistance >= interval) {
        coordinates.push(allLegs[i+1]);
        legDistance = 0;
      }
    };

    return coordinates;
  };

  function buildMapWithWaypts(stations, directionsService, directionsDisplay) {

    formattedStations = formatStations(stations);

    directionsService.route({
      origin: document.getElementById('start').value,
      destination: document.getElementById('end').value,
      waypoints: formattedStations,
      optimizeWaypoints: true,
      travelMode: 'DRIVING'
    }, function(response, status) {
      if (status === 'OK') {
        directionsDisplay.setDirections(response);
        var route = response.routes[0];
        var summaryPanel = document.getElementById('directions-panel');
        summaryPanel.innerHTML = '';
        for (var i = 0; i < route.legs.length; i++) {
          var routeSegment = i + 1;
          summaryPanel.innerHTML += '<b>Route Segment: ' + routeSegment +
          '</b><br>';
          summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
          summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
          summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
        }
      } else {
        window.alert('Directions request failed due to ' + status);
      }
    });
  };

  function formatStations(stations) {
    var formattedStations = [];

    for (var i = 0; i < stations.length; i++) {
      formattedStations.push(
        {location: { lat: stations[i].latitude, lng: stations[i].longitude },
        stopover: true}
      );
    }

    return formattedStations;
  };

  function fetchStations(params, directionsService, directionsDisplay) {
    $.ajax({
      url: '/api/v1/fuel_stations?' + params,
      method: 'GET',
    }).done(function(data){
      buildMapWithWaypts(data, directionsService, directionsDisplay);
    }).fail(function(error){
      console.error(err);
    });
  };

  function fetchAllStations(coordinates, directionsService, directionsDisplay){
    var allStations = "";
    var fuel = document.getElementById('fuel-type').value;

    for (var i = 0; i < coordinates.length; i++) {

      var lat = coordinates[i].lat();
      var lng = coordinates[i].lng();
      var latLng = "latLng" + i;
      allStations = allStations.concat(latLng + "=" + lat + "," + lng + "&");
    }

    var params = allStations + "fuel_type=" + fuel;
    fetchStations(params, directionsService, directionsDisplay);
  };
