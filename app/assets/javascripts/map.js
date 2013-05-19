function addMap(url, selector){
  function update_map(url, selector) {
    $.ajax({
      dataType: "json",
      url: url,
      success: function(data){
        var center = new google.maps.LatLng(-26.2041028, 28.0473051);
        var options = {
          'zoom': 2,
          'center': center,
          'mapTypeId': google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map($(selector)[0], options);

        var markers = [];
        for (var i = 0; i < data.length; i++) {
          var latLng = new google.maps.LatLng(data[i].location[0], data[i].location[1]);
          var marker = new google.maps.Marker({position: latLng, title: data[i].first_name + " " + data[i].last_name});
          marker.name = data[i].first_name + " " + data[i].last_name;
          google.maps.event.addListener(marker, 'click', function() {
            var infowindow = new google.maps.InfoWindow(
              { content: this.name,
                size: new google.maps.Size(50,50)
              });
            infowindow.open(map,this);
          });
          markers.push(marker);
        }
        var markerCluster = new MarkerClusterer(map, markers, {maxZoom: 13});
      }
    });
  };
  google.maps.event.addDomListener(window, 'load', update_map(url, selector));
};