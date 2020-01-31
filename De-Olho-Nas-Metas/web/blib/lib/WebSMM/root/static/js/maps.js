var $maps = function () {
	if (!google.maps.Polygon.prototype.getBounds) {

        google.maps.Polygon.prototype.getBounds = function(latLng) {

                var bounds = new google.maps.LatLngBounds();
                var paths = this.getPaths();
                var path;
                
                for (var p = 0; p < paths.getLength(); p++) {
                        path = paths.getAt(p);
                        for (var i = 0; i < path.getLength(); i++) {
                                bounds.extend(path.getAt(i));
                        }
                }

                return bounds;
        }

	}
    var map,
    	infoBubble,
    	addr,
    	geocoder,
		mc,
		marker_array = [];

	function setAllMap(dado){
		for (var i = 0; i < marker_array.length; i++){
			marker_array[i].setMap(null);
		}
	}
	function clearMarkers(){
		setAllMap(null);
	}
	function deleteMarkers(){
		clearMarkers();
		marker_array = [];
// 		mc.clearMarkers();
		clearMarkers();
	}

    function initialize() {
		var mapOptions = {
			center: new google.maps.LatLng(-23.549035, -46.634438),
			zoom: 10,
		};
		geocoder = new google.maps.Geocoder();

   	    map = new google.maps.Map(document.getElementById("map"),mapOptions);
    }

	function loadgeocoder(){
		geocoder = new google.maps.Geocoder();
	}
	function loadproject(){
		var ib;
		
		$.getJSON('/project_map',function(data,status){
			var json = data;
			$.each(json, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				var bubble_color = "rgb(140,198,63)";
				var icone = "/static/images/icone_verde.png";

				if (pj.percentage < 50){
					bubble_color = "rgb(198,93,93)";
					icone = "/static/images/icone_vermelho.png";
				}

				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
	                url: "/project/"+pj.id,
	                icon: icone
        	    });
				marker_array.push(marker);
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '" target="_blank" >';
				if (pj.goal){
					content += pj.name + '( Meta - '+pj.goal.id+')</a></div>';
				}else{
					content += pj.name + '</a></div>';
				}
				content += '<div class="description"></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'click', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: bubble_color,
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 100
				        });
				        ib.open(map, this);
					}else{
						ib.setBackgroundColor(bubble_color);
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
        			//window.location.href = url;
    			});
				google.maps.event.addListener(marker, 'dblclick', function(event) {
					map.setCenter(event.latLng);
				});
			});
// 			mc = new MarkerClusterer(map, marker_array);
			map.setZoom(12);
		});

map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(
  document.getElementById('legend'));	
	}

	function markprojectdetail( project_id ){
		var ib;
		var myLatlng;
		$.getJSON('/project_map_single', { id : project_id } ,function(data,status){
			var json = data;
			marker = "";
			var geojson = eval('(' + json.geom_json + ')');
            var polygon = new GeoJSON(geojson, 
			{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 

			});
			
			latlong = polygon.getBounds().getCenter();

			myLatlng = new google.maps.LatLng(json.latitude,json.longitude);	
			polygon.setMap(map);	
			marker = new google.maps.Marker({
	                position: myLatlng,
		            map: map,
		            icon: "/static/images/marker_donm.png"
	        });

			var url = marker.url;

			google.maps.event.addListener(polygon, "click", function(event) {

				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += json.region.name + '</a></div>';
				content += '</div>';

				if (!ib){
		              ib = new InfoBubble({
			          map: map,
			          content: content,
	        	      shadowStyle: 0,
		        	  padding: 0,
			          backgroundColor: 'rgb(222,164,2)',
			          borderRadius: 0,
			          arrowSize: 15,
			          borderWidth: 0,
			          borderColor: '#dea402',
			          disableAutoPan: true,
			          hideCloseButton: false,
		    	      arrowPosition: 50,
	   	      	      arrowStyle: 0,
	   			      MaxWidth: 340,
	   	      		  MinHeight: 60
	   	    	  });
	       		  ib.open(map);
	       		  ib.setPosition(event.latLng);
				}else{
					ib.setContent(content);
					ib.setPosition(event.latLng);
					ib.open(map);
				}
			});


			if (myLatlng){
				map.setCenter(myLatlng);
		    	map.setZoom(12);
			}
		});
	
	}
	function showregions( ){
		var ib;
		var myLatlng;
		myLatlng = new google.maps.LatLng(-23.554070, -46.634438);	
		$.getJSON('/getregions', function(data,status){
			var json = data;
			//var infowindow = new google.maps.InfoWindow();
			$.each(json.geoms, function(i, pj){
				marker = "";
		    	var geojson = eval('(' + pj.geom_json + ')');
	            var polygon = new GeoJSON(geojson, 
					{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 });

				marker = new google.maps.Marker({
		            map: map,
					url : "/region/"+pj.id,
	            });
				var url = marker.url;
				google.maps.event.addListener(polygon, "mouseover", function(event) {

					var content = '<div class="project-bubble" style="width: 300px;"><div class="name">';
					content += 'Distrito: <a href="' + url + '">';
					content += pj.name + '</a></div>';
					content += '<div class="name">';
					content += 'Subprefeitura: <a href="' + '/subprefecture/' +pj.subprefecture_id+ '">'+pj.subprefecture.name+'</a></div>';
					content += '</div>';

					if (!ib){
  		              ib = new InfoBubble({
				          map: map,
				          content: content,
		        	      shadowStyle: 0,
			        	  padding: 0,
				          backgroundColor: 'rgb(222,164,2)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#dea402',
				          disableAutoPan: true,
				          hideCloseButton: false,
			    	      arrowPosition: 50,
		   	      	      arrowStyle: 0,
		   			      MaxWidth: 340,
		   	      		  MinHeight: 120
		   	    	  });
		       		  ib.open(map);
		       		  ib.setPosition(event.latLng);
					}else{
						ib.setContent(content);
						ib.setPosition(event.latLng);
						ib.open(map);
					}

					/*infowindow.setContent(content);
					infowindow.setPosition(event.latLng);
					infowindow.open(map);*/
				});

				map.data.addListener('click', function(event) {
					    event.feature.setProperty('isColorful', true);
				});	
				polygon.getBounds().getCenter();
				polygon.setMap(map);	
				
			});
	    	map.setCenter(myLatlng);
	    	map.setZoom(10);
      });	
	}

	function markregiondetail( region_id ){
		var ib;
		$.getJSON('/region_project', { id : region_id } ,function(data,status){
			console.log(data);
			var json = data;
			var myLatlng;
			var geojson = eval('(' + json.geom_json + ')');
	        var polygon = new GeoJSON(geojson, 
			{
			  "strokeColor": "#FF7800",
			  "strokeOpacity": 1,
			  "strokeWeight": 2,
			  "fillColor": "#46461F",
			  "fillOpacity": 0.25 
			});

			polygon.setMap(map);	

			$.each(json.projects, function(i, pj){
				marker = "";
				myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
				marker = new google.maps.Marker({
	                position: myLatlng,
		            map: map,
					url : "/project/"+pj.id,
		            icon: "/static/images/marker_donm.png"
	            });
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += pj.name + '</a></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
	        		//window.location.href = url;
	    		});
			});
			var latlong = polygon.getBounds().getCenter();
			console.log(latlong);
			myLatlng = new google.maps.LatLng(latlong.H,latlong.L);	
			
			if (myLatlng){
				map.setCenter(myLatlng);

		    	map.setZoom(12);
			}
      });	
	}

	function markorgdetail( org_id ){
		$.getJSON('/subpref_org',{ id : org_id },function(data,status){
			var json = data;
			var myLatlng;
			var ib;
			var myLatlng = new google.maps.LatLng(data.subprefecture.latitude,data.subprefecture.longitude);	
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
	                url: "/subprefecture/"+data.subprefecture.id,
	                icon: "/static/images/marker_donm.png"
        	    });
				var url = marker.url;
				var content = '<div class="project-bubble" ><div class="name">';
				content += '<a href="/subprefecture/'+data.subprefecture.id+'">' + data.subprefecture.name + '</a></div>';
				content += '</div>';

				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						ib.open(map, this);
					}
    			});

	   		map.setCenter(myLatlng);
		  	map.setZoom(12);	
        });	

	}

	function marksubprefdetail( subpref_id ){
		var ib;
		$.getJSON('/subpref_region', { id : subpref_id } ,function(data,status){
			var json = data;
			var myLatlng;
			$.each(json.regions, function(i, pj){
				marker = "";
		    	var geojson = eval('(' + pj.geom_json + ')');
	            var polygon = new GeoJSON(geojson, 
					{
					  "strokeColor": "#FF7800",
				      "strokeOpacity": 1,
				      "strokeWeight": 2,
				      "fillColor": "#46461F",
				      "fillOpacity": 0.25 });

				marker = new google.maps.Marker({
		            map: map,
					url : "/region/"+pj.id,
	            });
				var url = marker.url;

				google.maps.event.addListener(polygon, "mouseover", function(event) {

					var content = '<div class="project-bubble"><div class="name">';
					content += '<a href="' + url + '">';
					content += pj.name + '</a></div>';
					content += '</div>';
					if (!ib){
  		              ib = new InfoBubble({
				          map: map,
				          content: content,
		        	      shadowStyle: 0,
			        	  padding: 0,
				          backgroundColor: 'rgb(222,164,2)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#dea402',
				          disableAutoPan: true,
				          hideCloseButton: false,
			    	      arrowPosition: 50,
		   	      	      arrowStyle: 0,
		   			      MaxWidth: 340,
		   	      		  MinHeight: 60
		   	    	  });
		       		  ib.open(map);
		       		  ib.setPosition(event.latLng);
					}else{
						ib.setContent(content);
						ib.setPosition(event.latLng);
						ib.open(map);
					}
				});

				map.data.addListener('click', function(event) {
				    event.feature.setProperty('isColorful', true);
			    });	
				polygon.getBounds().getCenter();
				polygon.setMap(map);	
			
			});
			myLatlng = new google.maps.LatLng(json.latitude,json.longitude);	
			marker = new google.maps.Marker({
	            position: myLatlng,
                map: map,
                url: "/subprefecture/"+json.id,
                icon: "/static/images/marker_donm.png"
    	    });

	    	map.setCenter(myLatlng);
	    	map.setZoom(12);	

      });	
	}


	function markgoaldetail( goal_id ){
		var ib;
		var markers = [];
		$.getJSON('/project_map_list', { id : goal_id } ,function(data,status){
			$.each(data.project, function(i, pj){
				marker = "";
				var myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);
				marker = new google.maps.Marker({
    	            position: myLatlng,
	                map: map,
					url : "/project/"+pj.id,
	                icon: "/static/images/marker_donm.png"
        	    });
				if ( pj.latitude != 0 && pj.longitude != 0){
					markers.push(marker);
				}
				var url = marker.url;
				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '">';
				content += pj.name + '</a></div>';
				content += '</div>';
				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
				          map: map,
				          content: content,
				          shadowStyle: 0,
				          padding: 0,
				          backgroundColor: 'rgb(140,198,63)',
				          borderRadius: 0,
				          arrowSize: 15,
				          borderWidth: 0,
				          borderColor: '#8cc63f',
				          disableAutoPan: true,
				          hideCloseButton: false,
				          arrowPosition: 50,
				          arrowStyle: 0,
				          MaxWidth: 340,
				          MinHeight: 60
				        });
				        ib.open(map, this);
					}else{
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
	        		//window.location.href = url;
	    		});
			});

			if (markers.length == 0){
				$('#map').hide();
			}

		    	map.setZoom(8);
		});
	
	}
	function codeAddress(data){
		geocoder.geocode({ 'address': data + ', Brasil', 'region': 'BR' }, function (results, status) {
                 return results;
		});
	}
	
	function setlocal(location){
		map.setCenter(location);
	    map.setZoom(16);
	}
	function render_goal(){
		var ib;
		var myLatlng;
		$.post( "/goal/search_by_types", { type_id: $('#type_goal option:selected').val(), region_id: $('#goalregion option:selected').val() }, function( data ) {
			data.plural = (data.goals.length > 1);
			var template = $('#row_template').html();
			var html = Mustache.to_html(template, data);
			$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
			$('#result').html(html);
		},"json");
	}
	function render_goal_latlng(){
		var myLatlng;
		var ib;

		geocoder = new google.maps.Geocoder();

		geocoder.geocode({ 'address': $('#txtaddress').val() + ', Brasil', 'region': 'BR' }, function (results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					var latitude = results[0].geometry.location.lat();
					var longitude = results[0].geometry.location.lng();
					$('#txtEndereco').val(results[0].formatted_address);
					$.post("/goal/search_by_types",{ latitude: latitude, longitude: longitude, type_id: $('#type option:selected').val() },function(data){
						var template = $('#row_template').html();
	   					var html = Mustache.to_html(template, data);
		   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
						$('#result').html(html);
					},"json");
				}
			}
		});
	}

	function render_projects(){
		var ib;
		var myLatlng;
		$.post( "/project/search_by_types", { type_id: $('#type option:selected').val(), region_id: $('#homeregion option:selected').val() }, function( data ) {
			$("#map").addClass("search");

			data.plural = (data.projects.length > 1);
			var template = $('#row_template').html();
			var html = Mustache.to_html(template, data);
			$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
			$('#result').html(html);
			$maps.deleteMarkers();
			if (data.projects.length > 0){
				$("#map").fadeIn();
			}else{
				$("#map").fadeOut();
			}
			$.each(data.projects, function(i, pj){
				console.log(pj);	
				if (pj.latitude == 0 && pj.longitude == 0) return;
				marker = "";	
				myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);
				var icone = "/static/images/icone_verde.png";

				if (pj.percentage < 50){
					bubble_color = "rgb(198,93,93)";
					icone = "/static/images/icone_vermelho.png";
				}

				marker = new google.maps.Marker({
					position: myLatlng,
					map: map,
					url: "/project/"+pj.id,
					icon: icone
				});

				marker_array.push(marker);
				var url = marker.url;

				var content = '<div class="project-bubble"><div class="name">';
				content += '<a href="' + url + '" target="_blank" >';
				if (pj.goal){
					content += pj.name + '( Meta - '+pj.goal.id+')</a></div>';
				}else{
					content += pj.name + '</a></div>';
				}

				google.maps.event.addListener(marker, 'mouseover', function() {
					if (!ib){
						ib = new InfoBubble({
							map: map,
							content: content,
							shadowStyle: 0,
							padding: 0,
							backgroundColor: bubble_color,
							borderRadius: 0,
							arrowSize: 15,
							borderWidth: 0,
							borderColor: '#8cc63f',
							disableAutoPan: true,
							hideCloseButton: false,
							arrowPosition: 50,
							arrowStyle: 0,
							MaxWidth: 340,
							MinHeight: 60
						});
						ib.open(map, this);
					}else{
						ib.setBackgroundColor(bubble_color);
						ib.setContent(content);
						//ib.setPosition(myLatlng);
						ib.open(map, this);
					}
					//window.location.href = url;
				});
			})
// 					mc = new MarkerClusterer(map, marker_array);
			map.setCenter(myLatlng);
		},"json");
	}
	
	function render_project_latlng(){
		var myLatlng;
		var ib;
		geocoder.geocode({ 'address': $('#txtaddress').val() + ', Brasil', 'region': 'BR' }, function (results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					var latitude = results[0].geometry.location.lat();
					var longitude = results[0].geometry.location.lng();
					$('#txtEndereco').val(results[0].formatted_address);
					$.post("/project/search_by_types",{ latitude: latitude, longitude: longitude, type_id: $('#type option:selected').val() },function(data){
						var template = $('#row_template').html();
	   					var html = Mustache.to_html(template, data);
		   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
						$('#result').html(html);
						$.each(data.projects, function(i, pj){
							marker = "";	
							myLatlng = new google.maps.LatLng(pj.latitude,pj.longitude);	
							marker = new google.maps.Marker({
	    	    	        	position: myLatlng,
			        	        map: map,
		    	        	    url: "/project/"+pj.id,
			       		        icon: "/static/images/marker_donm.png"
    	    	   		 	});
							var url = marker.url;
							var content = '<div class="project-bubble"><div class="name">';
							content += '<a href="' + url + '" target="_blank">';
							content += pj.name + '</a></div>';
							content += '</div>';
							google.maps.event.addListener(marker, 'mouseover', function() {
								if (!ib){
			  		              ib = new InfoBubble({
							          map: map,
							          content: content,
					        	      shadowStyle: 0,
						        	  padding: 0,
							          backgroundColor: 'rgb(140,198,63)',
							          borderRadius: 0,
							          arrowSize: 15,
							          borderWidth: 0,
							          borderColor: '#8cc63f',
							          disableAutoPan: true,
							          hideCloseButton: false,
						    	      arrowPosition: 50,
					   	      	      arrowStyle: 0,
					   			      MaxWidth: 340,
					   	      		  MinHeight: 100
					   	    	  });
					       		  ib.open(map, this);
								}else{
									ib.setContent(content);
									//ib.setPosition(myLatlng);
									ib.open(map, this);
								}
        				//window.location.href = url;
						})
					  })
					map.setCenter(myLatlng);
					},"json");
					var location = new google.maps.LatLng(latitude, longitude);
					setlocal(location);
				}
			}
		});
	}
	return {
		initialize	             : initialize,
		loadproject              : loadproject,
		loadgeocoder             : loadgeocoder,
		codeAddress              : codeAddress,
		setlocal                 : setlocal,
		markprojectdetail        : markprojectdetail,
		markgoaldetail     	     : markgoaldetail,
		markregiondetail         : markregiondetail,
	   	markorgdetail            : markorgdetail,
		marksubprefdetail        : marksubprefdetail,
		showregions              : showregions,
		deleteMarkers 			 : deleteMarkers,
		render_projects			 : render_projects,
		render_project_latlng	 : render_project_latlng,
		render_goal	 			 : render_goal,
		render_goal_latlng	 	 : render_goal_latlng
	};
}();

var openSelect = function(selector){
	var $target = $(selector);
	var $clone = $target.clone();
	$clone.addClass("select-stylized clone");
	$clone.val($target.val()).css({
		position: 'absolute',
		'z-index': 999,
		left: $target.offset().left,
		width: $target.width() + "px",
		top: $target.offset().top + $target.height()
	}).attr('size', $clone.find('option').length).change(function() {
		$target.val($clone.val());
	}).on('click blur',function() {
		$(this).remove();
	});
	$('body').append($clone);
	$clone.focus();
}

$(document).ready(function () {

	$(".metas-filtro .select-stylized select").unbind();
	$(".metas-filtro .select-stylized select").bind("click",function(e){
		e.stopPropagation();
	})
	$(".metas-filtro .select-stylized").unbind();
	$(".metas-filtro .select-stylized").bind("click",function(e){
		e.stopPropagation();
		e.preventDefault();
		openSelect($(this).find("select"));
	})
	
	if ($("#pagetype").val() != 'homegoal' && $("#pagetype").val() != 'campaign_user' && $("#pagetype").val() != 'campaigndetail' && $("#pagetype").val() != 'campaignhome') {	
		$maps.initialize();
	}
	if ($("#pagetype").val() == 'home'){	
		$maps.loadproject();
	}		
	if ($("#pagetype").val() == 'projectdetail'){	
		$maps.markprojectdetail($("#projectid").val());
	}		
	if ($("#pagetype").val() == 'goaldetail'){
		$maps.markgoaldetail($("#goalid").val());
	}	
	if ($("#pagetype").val() == 'campaign_user'){
		$maps.loadgeocoder();
	}		
	if ($("#pagetype").val() == 'campaignhome'){
		$maps.loadgeocoder();
	}		
	if ($("#pagetype").val() == 'campaigndetail'){
		$maps.loadgeocoder();
	}		
	if ($("#pagetype").val() == 'regiondetail'){
		$maps.markregiondetail($("#regionid").val());
	}		
	if ($("#pagetype").val() == 'homeregion'){
		$maps.showregions();
	}		
	if ($("#pagetype").val() == 'subprefdetail'){
		$maps.marksubprefdetail($("#subprefid").val());
	}		
	if ($("#pagetype").val() == 'orgdetail'){
		$maps.markorgdetail($("#orgid").val());
	}


//	$("#type_goal").change(function(){
//		var id = $( "#type_goal option:selected" ).val();
//		$("section.map .map-overlay").fadeIn();
//    	$.get("/goal/type",{type_id: id}).done( function(data){
//			$("section.map .map-overlay").fadeOut();
//			document.getElementById("result").innerHTML=data
//      	});
//	});

//	$("#goalregion").change(function(){
//		var id = $( "#goalregion option:selected" ).val();
//    	$.get("/goal/region",{region_id: id}).done( function(data){
//			document.getElementById("result").innerHTML=data
//      	});
//	});
	$('#search').on('click', function () {
		var ib;
		var id = $(this).data("id");
		if ($('#txtaddress').val() && $('type option:selected').val() != 'Distrito'){
				$maps.render_project_latlng()	
			} else {
				$maps.render_projects()
			}

	})
	$('#searchgoal').on('click', function () {
		var ib;
		var id = $(this).data("id");
		if ($('#txtaddress').val() && $('type option:selected').val() != 'Distrito'){
				$maps.render_goal_latlng()	
			} else {
				$maps.render_goal()
			}

	})
 $('.objective_type_goal').on('click', function ( e) {
 		$.post( "/goal/search_by_types", { type_id: $('#objective_type_goal_id').val() }, function( data ) {
							data.plural = (data.goals.length > 1);
							var template = $('#row_template').html();
							var html = Mustache.to_html(template, data);
							$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
							$('#result').html(html);
		 },"json"); 
   e.preventDefault();
 }) 
 $('.objective_type_project').on('click', function ( e) {
 		$.post( "/project/search_by_types", { type_id: $('#objective_type_project_id').val() }, function( data ) {
			$("#map").addClass("search");

			data.plural = (data.projects.length > 1);
			var template = $('#row_template').html();
			var html = Mustache.to_html(template, data);
			$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
			$('#result').html(html);
		 },"json"); 
   e.preventDefault();
 }) 
 $("#project_name").autocomplete({
	source: function (request, response) {
  	$.post( "/project/project_autocomplete", { project_name : $('#project_name').val() }, function( data ) {
							console.log(data);
       response($.map(data, function (item) {
          return {
             id: item.id,
             value: item.value
          }
       })); 
		 },"json");  
		},
		select: function (event, ui) {
					$('#project_id').val(ui.item.id);
		}
	});
	$("#txtaddress").autocomplete({
	source: function (request, response) {
	   geocoder = new google.maps.Geocoder();
// 	   console.log('address' request.term + ', São Paulo - SP' , 'language': 'pt-br','region': 'br');
       geocoder.geocode({
			address: request.term,
			region: 'BR',
 			componentRestrictions: { 
				country: 'BR',
				administrativeArea: 'SP'
			}
	}, function (results, status) {
          response($.map(results, function (item) {
                return {
                    label: item.formatted_address,
                    value: item.formatted_address,
                    latitude: item.geometry.location.lat(),
                    longitude: item.geometry.location.lng()
                }
          }));
       })
    },
    select: function (event, ui) {
        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
		if ($("#pagetype").val() == 'home'){		
			$("section.map .map-overlay").fadeIn();
 			$.get("/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				$("section.map .map-overlay").fadeOut();
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
        	$maps.setlocal(location);
		}
 		if ($("#pagetype").val() == 'campaign_user'){
				
				$('#latlng').val(location);
		} 
		if ($("#pagetype").val() == 'projectdetail'){		
 			$.get("/project/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}
		
		if ($("#pagetype").val() == 'homegoal'){		
 			$.get("/goal/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}
 		if ($("#pagetype").val() == 'campaignhome'){		
 			$.get("/campaign/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		} 
		if ($("#pagetype").val() == 'campaigndetail'){		
 			$.get("/campaign/region_by_cep",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
				document.getElementById("result").innerHTML=data
        	});
		}

		if ($("#pagetype").val() == 'homeregion'){		
			$.getJSON('/region/id',{latitude: ui.item.latitude, longitude: ui.item.longitude},function(data,status){
				if (data.message){
   				$(".project-detail").removeClass(".metas-detail").addClass("metas-result");
					document.getElementById("result").innerHTML="<h2 class=\"section-tittle\">"+data.message+"</h2>"
				}else{
					window.location.href="/region/"+data.id;
				}
        	});

			  $("select#homeregion")[0].selectedIndex = 0;
		}
		if ($("#pagetype").val() == 'regiondetail'){			
 			$.get("/region/id",{latitude: ui.item.latitude, longitude: ui.item.longitude}).done( function(data){
				window.location.href="/region/"+data.id;
        	});
		}
			
       	$(".metas-filtro .form .region .select-stylized").addClass("disabled");
       	$(".metas-filtro .form .cep button").removeClass("disabled");
    }
    });
});
