// Side Bar Toggle
$('.hide-sidebar').click(function() {
	$('#sidebar').hide('fast', function() {
		$('#content').removeClass('span9');
		$('#content').addClass('span12');
		$('.hide-sidebar').hide();
		$('.show-sidebar').show();
	});
});

$('.show-sidebar').click(function() {
	$('#content').removeClass('span12');
	$('#content').addClass('span9');
	$('.show-sidebar').hide();
	$('.hide-sidebar').show();
	$('#sidebar').show('fast');
});

//You can calculate directions (using a variety of methods of transportation) by using the DirectionsService object.

var directionsService = new google.maps.DirectionsService();

//Define a variable with all map points.

var _mapPoints = new Array();

//Define a variable with all map stop points.

var _stopPoints = new Array();

//Define a DirectionsRenderer variable.
var _directionsRenderer = '';

//This will give you the map zoom value.
var zoom_option = 10;

//LegPoints is your route points between two locations.
var LegPoints = new Array();

//Google map object
var map;

//Google map object for getting locations
var geocoder;

//Google map infomation popup window
var infoWindow = "";

//Setting map center coordinates
var center = "";

//InitializeMap() function is used to initialize google map on page load.
function InitializeMap() {
        geocoder = new google.maps.Geocoder();
        
        if (_mapPoints.length > 0) {
           center = _mapPoints[_mapPoints.length-1]; 
        }else {
           center = new google.maps.LatLng(21.7679, 78.8718); 
           zoom_option = 6;
        }

	//Set the your own options for map.
	var myOptions = {
		zoom : zoom_option,
		zoomControl : true,
		center : center,
		mapTypeId : google.maps.MapTypeId.ROADMAP
	};

	//Define the map.
	map = new google.maps.Map(document.getElementById("dvMap"), myOptions);
        
        infoWindow = new google.maps.InfoWindow();
        var latlngbounds = new google.maps.LatLngBounds();
        var movingIcon = "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.3|0|FF8844|12|_|"
        var startIcon = "https://chart.googleapis.com/chart?chst=d_map_spin&chld=.6|0|00FF00|12|_|A"
        var endIcon = "https://chart.googleapis.com/chart?chst=d_map_spin&chld=.6|0|00FF00|12|_|B"
        var stopIcon = "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.4|180|FF0000|12|_|"
        
        for (i = 0; i < _stopPoints.length; i++) {
            createInfoWindow(new google.maps.Marker({position: _stopPoints[i], map: map, icon: stopIcon, title: 'Bus Stop'}), i);
        }
        
	for (i = 0; i < _mapPoints.length; i++) {
            var mapIcon = "";
            var title = "";
            var data = "";
            if (i == 0) {
                mapIcon = startIcon;
                title = "Starting Point";
            } else if (i == (_mapPoints.length - 1)) {
                mapIcon = endIcon;
                title = "Current Position/Destination";
            }else {
                mapIcon = movingIcon;
                title = "Route";
            }
            data = i + ") " + _mapPoints[i].lat() + "|" + _mapPoints[i].lng() +", "
//            latlngbounds.extend(marker.position);
            if (mapIcon != "") {
                createInfoWindow(new google.maps.Marker({position: _mapPoints[i], map: map, icon: mapIcon, title: title}), data);
            }
        }
        
        
//        map.setCenter(latlngbounds.getCenter());
//        map.fitBounds(latlngbounds);
        
               //***********ROUTING****************//
 
        //Intialize the Path Array
        var path = new google.maps.MVCArray();
 
        //Intialize the Direction Service
        var service = new google.maps.DirectionsService();
 
        //Set the Path Stroke Color
        var poly = new google.maps.Polyline({ map: map, strokeColor: '#4986E7' });
 
        //Loop and Draw Path Route between the Points on MAP
        for (var i = 0; i < _mapPoints.length; i++) {
            if ((i + 1) < _mapPoints.length) {
                var src = _mapPoints[i];
                var des = _mapPoints[i + 1];
                path.push(src);
                poly.setPath(path);
//                service.route({
//                    origin: src,
//                    destination: des,
//                    travelMode: google.maps.DirectionsTravelMode.DRIVING
//                }, function (result, status) {
//                    if (status == google.maps.DirectionsStatus.OK) {
//                        for (var i = 0, len = result.routes[0].overview_path.length; i < len; i++) {
//                            path.push(result.routes[0].overview_path[i]);
//                        }
//                    }
//                });
            }
        }
        
}

function createInfoWindow(marker, data){
    (function (marker) {
        google.maps.event.addListener(marker, "click", function (e) {
            geocoder.geocode({'latLng': marker.position}, function(results, status) {
//                        var address = results[0].address_components[1].long_name+' '+results[0].address_components[0].long_name+', '+results[0].address_components[3].long_name
              if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    infoWindow.setContent(data + "" +results[0].formatted_address);
                }
              } else {
                infoWindow.setContent("Unavailable");
              }
            });
            infoWindow.open(map, marker);

        });
    })(marker, data);
}




