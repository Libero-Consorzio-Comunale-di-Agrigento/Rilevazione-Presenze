var map,
  infoWindow,
  rilCircle,
  geocoder,
  marker,
  raggioValidita,
  cardRicercaPosizione,
  cardImpostazioni;

var retVal = new Object();
retVal.center = {
  lat: 44.55,
  lng: 7.39
};
retVal.radius = 60;
retVal.address = "";

var confirmPosition = function() {
  var ret = "&lat=" + retVal.center.lat() + "&lng=" + retVal.center.lng() + "&radius=" + retVal.radius + "&address=" + retVal.address;
  executeAjaxEvent(ret,null,"OnConfermaPosizioneRilevatore",false,null,false);
}

var radiusInputHandler = function(e) {
  try {
    retVal.radius = parseInt(this.value);
  } catch (err) {
    retVal.radius = 0;
  }
  // riposiziona la mappa e visualizza il cerchio
  rilCircle.setCenter(retVal.center);
  rilCircle.setRadius(retVal.radius);
};

function initMap() {
  console.log('initMap()');
  // inizializza valore di ritorno
  retVal.center = new google.maps.LatLng(0, 0);
  retVal.radius = 0;
  retVal.address = "";

  // geocoder
  geocoder = new google.maps.Geocoder();

  // mappa
  map = new google.maps.Map(document.getElementById("map"), {
    center: retVal.center,
    fullscreenControl: false,
    zoom: 16,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    mapTypeControl: false,
    streetViewControl: false
  });

  // marker di posizione
  marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  // area circolare di validita timbratura
  rilCircle = new google.maps.Circle({
    clickable: false,
    strokeColor: "#0000FF",
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: "#0000FF",
    fillOpacity: 0.15,
    map: map,
    center: null,
    radius: retVal.radius
  });

  // finestra informativa
  infowindow = new google.maps.InfoWindow();

  cardRicercaPosizione = document.getElementById('cardRicercaPosizione');
  var input = document.getElementById('inputLocalita');
  var types = document.getElementById('type-selector');

  cardImpostazioni = document.getElementById('cardImpostazioni');
  raggioValidita = document.getElementById('raggioValidita');
  
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(cardRicercaPosizione);
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(cardImpostazioni);

  var autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.bindTo('bounds', map);

  var infowindowContent = document.getElementById('infowindow-content');
  infowindow.setContent(infowindowContent);

  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("Nessun dettaglio disponibile per: '" + place.name + "'");
      return;
    }

    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);
    }
    retVal.center = place.geometry.location;
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);
    rilCircle.setCenter(retVal.center);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindowContent.children['place-icon'].src = place.icon;
    infowindowContent.children['place-name'].textContent = place.name;
    infowindowContent.children['place-address'].textContent = address;
    infowindow.open(map, marker);
  });

  function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    radioButton.addEventListener('click', function() {
      autocomplete.setTypes(types);
    });
  }
  setupClickListener('changetype-all', []);
  setupClickListener('changetype-address', ['address']);
  setupClickListener('changetype-establishment', ['establishment']);
}

// posizionamento del marker e del circle
function moveMarker(coords) {
  if ((marker) && (rilCircle)) {
    marker.setVisible(false);
    marker.setPosition(coords);
    marker.setVisible(true);
    rilCircle.setCenter(coords);
    geocoder.geocode({
      "location": coords
    }, function(results, status) {
      if (status === "OK") {
        if (results[0]) {
          retVal.address = results[0].formatted_address;
          infowindow.setContent(results[0].formatted_address);
          infowindow.open(map, marker);
        } else {
          // nessun risultato
        }
      } else {
        // errore durante ricerca indirizzo -> cfr. status
      }
    });
  }
}
// posizionamento su indirizzo
function gotoAddress(address) {
  if (geocoder) {
    geocoder.geocode({
      address: address
    }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        retVal.address = address;
        retVal.center = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng());
        moveMarker(retVal.center);
      } else {
        window.alert("Errore durante la ricerca della localita: " + status);
      }
    });
  }
}
// posizionamento su coordinate specifiche
function gotoCoords(lat, lng, bMoveMarker) {
  retVal.center = new google.maps.LatLng(lat, lng);
  map.setCenter(retVal.center);
  if (bMoveMarker) {
    moveMarker(retVal.center);
  }
  google.maps.event.trigger(map, 'resize');
}
// inizializzazione mappa
function setInitialData(rilevatore, editEnabled, lat, lng, radius) {
  console.log('setInitialData("' + rilevatore + '", ' + editEnabled + ', ' + lat + ', ' + lng + ', ' + radius + ')');
  document.getElementById("rilevatoreTitle").textContent = "Rilevatore: " + rilevatore;
  if (editEnabled) {
    map.addListener("click", function(event) {
      infowindow.close();
      var pos = event.latLng;
      if (pos) {
        retVal.center = pos;
        moveMarker(retVal.center);
      }
    });
    raggioValidita.oninput = radiusInputHandler;
    raggioValidita.onpropertychange = raggioValidita.oninput; // IE8
  } else {
    cardRicercaPosizione.style.display = "none";
    raggioValidita.readOnly = true;
  }
  raggioValidita.value = radius;
  try {
    retVal.radius = parseInt(radius);
  } catch (err) {
    retVal.radius = 0;
  }
  rilCircle.setRadius(retVal.radius);

  // geolocalizzazione
  if ((lat === 0) && (lng === 0)) {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        gotoCoords(position.coords.latitude, position.coords.longitude, false);
      }, function() {
        handleLocationError(true, infowindow, map.getCenter());
      });
    } else {
      handleLocationError(false, infowindow, map.getCenter());
    }
  } else {
    gotoCoords(lat, lng, true);
  }
  
  // prepara dialog modale
  var maxW = $(window).width() - 45; 
  var maxH = $(window).height() - 45; 
  var dialW = 1300; 
  var dialH = 800; 
  if (dialW > maxW) {dialW = maxW;} 
  if (dialH > maxH) {dialH = maxH;} 
  
  var dlgOptions = {   
    autoOpen: false, 
    width: dialW, 
    height: dialH,  
    minHeight: 60,  
    modal: true,  
    hide: "fade",  
    title: "Posizione rilevatore",
    closeOnEscape: false,
    resizable: true,  
    dialogClass: ''
  }
  
  if (editEnabled) {
    var buttons = [{
      text: "OK",
      class: "pulsante",
      click: function() {
        confirmPosition();
        $(this).dialog("close");
      }
    },{
      text: "Annulla",
      class: "pulsante",
      click: function() {
        $(this).dialog("close");
      }
    }];
    dlgOptions.buttons = buttons;
  }                 
  
  $("#WA050_modalRicercaPosizione").dialog(dlgOptions);  
  $("#WA050_modalRicercaPosizione").dialog("open");
  google.maps.event.trigger(map, 'resize');
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infowindow.setPosition(pos);
  infowindow.setContent(browserHasGeolocation ?
    'Error: The Geolocation service failed.' :
    'Error: Your browser doesn\'t support geolocation.');
  infowindow.open(map);
}
