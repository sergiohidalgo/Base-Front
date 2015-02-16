

app.gmap =

	init: ->
		app.gmap.insert()

	insert: ->

		if $(".map").length

			$(".map").each ->

				m = $(this)

				markers = new Array()
				infowindow = false

				map_zoom = parseInt(m.attr("data-zoom"))

				map_lat = m.attr("data-lat")
				map_lng = m.attr("data-lng")

				blackandwhite_simple = [
					featureType: "all"
					elementType: "all"
					stylers: [
						saturation: -100
					]
				]

				blackandwhite = [
				    {
				        "featureType": "landscape",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "lightness": 65
				            },
				            {
				                "visibility": "on"
				            }
				        ]
				    },
				    {
				        "featureType": "poi",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "lightness": 51
				            },
				            {
				                "visibility": "simplified"
				            }
				        ]
				    },
				    {
				        "featureType": "road.highway",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "visibility": "simplified"
				            }
				        ]
				    },
				    {
				        "featureType": "road.arterial",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "lightness": 30
				            },
				            {
				                "visibility": "on"
				            }
				        ]
				    },
				    {
				        "featureType": "road.local",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "lightness": 40
				            },
				            {
				                "visibility": "on"
				            }
				        ]
				    },
				    {
				        "featureType": "transit",
				        "stylers": [
				            {
				                "saturation": -100
				            },
				            {
				                "visibility": "simplified"
				            }
				        ]
				    },
				    {
				        "featureType": "administrative.province",
				        "stylers": [
				            {
				                "visibility": "off"
				            }
				        ]
				    },
				    {
				        "featureType": "water",
				        "elementType": "labels",
				        "stylers": [
				            {
				                "visibility": "on"
				            },
				            {
				                "lightness": -25
				            },
				            {
				                "saturation": -100
				            }
				        ]
				    },
				    {
				        "featureType": "water",
				        "elementType": "geometry",
				        "stylers": [
				            {
				                "hue": "#ffff00"
				            },
				            {
				                "lightness": -25
				            },
				            {
				                "saturation": -97
				            }
				        ]
				    }
				]


				mapOptions =
					zoom: map_zoom
					center: new google.maps.LatLng(map_lat,map_lng)
					mapTypeId: google.maps.MapTypeId.ROADMAP
					disableDefaultUI: true
					scrollwheel: false
					streetViewControl: false
					styles: blackandwhite
					backgroundColor: "#FFFFFF"

				if !m.find(".map-gmap").length
					m.append '<div class="map-gmap"></div>'


				map = new google.maps.Map(m.find(".map-gmap")[0], mapOptions)


				m.append ''+
		            '<div class="map-zoom">'+
		                '<button class="map-zoom-button map-zoom-in  button button-small button-dark"><i class="fa fa-plus"></i></button>'+
		                '<button class="map-zoom-button map-zoom-out button button-small button-dark"><i class="fa fa-minus"></i></button>'+
		            '</div>'

				m.find(".map-zoom-in").click ->
					map.setZoom map.getZoom() + 1
					false

				m.find(".map-zoom-out").click ->
					map.setZoom map.getZoom() - 1
					false



				# Cargar coordenadas

				m.find(".map-marker").each ->

					marker = new google.maps.Marker(
						position: new google.maps.LatLng($(this).attr("data-lat"), $(this).attr("data-lng"))
						animation: google.maps.Animation.DROP
						#icon: "img/marker.png"
						map: map
					)
				
					content =
						"<div class='map-infowindow'>"+
							$(this).html()+
						"</div>"


					marker['content'] = content
					marker['value'] = $(this).val()

					if !infowindow
						infowindow = new google.maps.InfoWindow(content:"x")

					google.maps.event.addListener map, 'click', ->
						infowindow.close()

					if $(this).html().length
						google.maps.event.addListener marker, "click", ->
							infowindow.close()
							infowindow.setContent content
							infowindow.open map, this
							#map.setCenter(marker.getPosition())

					markers.push(marker)





