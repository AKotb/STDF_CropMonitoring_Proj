<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
	<title>STDF</title>
	<link rel="stylesheet" href="resources/css/leaflet.css" type="text/css"/> 
	<link rel="stylesheet" href="resources/css/jquery-ui.css" type="text/css">
	<link rel="stylesheet" href="resources/css/image-slider3.css" type="text/css">
	<script src="resources/js/leaflet.js" type="text/javascript"></script>
    <script src="resources/js/jquery.min.js" type="text/javascript"></script>
    <script src="resources/js/jquery-1.9.1.min.js"></script>
    <script src="resources/js/jquery-ui.js"></script>
    <script src="resources/js/jquery.ui.touch-punch.min.js"></script>
    <script src="resources/js/SliderControl.js"></script>
    <script src="resources/js/image-slider3.js" type="text/javascript"></script>
    <script src="resources/js/esri-leaflet.js" type="text/javascript"></script>
    
<style>  
    #header {
    	width: 100%; 
    	height: 20%; 
    	background-color: #227db2;
    }
    
    #leftLogo {
	    float: left;
	    width: 25%;
	    background-color: #227db2;
    }
    
       
    .header_title {
    	width: 80%;
	    background-color: #227db2;
	    text-align: center;
	    padding-top: 7;
	}
    
    .header_title_decorated {
	    width: 100%;
	    height: 100%;
	    color: #FFFFFF;
	    font-size: 35px;
	    font-weight: bold;
	    line-height: 1;
	}
    
	#viewPan{
		width: 100%;
		height: 75%;
	}
	
    #map {
        width: 75%;
        height: 99%;
		float: right;
		border: 2px solid #d73;
    }
    
    #panel {
		width: 24.4%;
		height: 99%;
		float: left;
		border: 2px solid #d73;
		background-color: #6FB8E3;
		overflow: auto;
	}
          
    #footer {
    	width: 100%; 
    	height: 5%; 
		background-color: #227db2;
    	font-size: 15px;
	    text-align: center;
    }
    
    #footerInfo {
	    line-height: 30px;
	    margin-right: 20px;
	    color: #FFFFFF;
	    font-weight: bold;
	}
</style>
</head>

<!-- <body style="background-color: #79C255">-->
<body>
<div id="container" style="width: 100%; height: 100%;">
	<div id="header">
		<div id="leftLogo">
			<div style="border-radius: 50%; filter: contrast(1.3); width: 90px; height: 90px; margin-left: 5px; margin-top: 5px; float: left;">
				<img style="border-radius: 50%;" src="resources/images/narss_logo_normal.jpg" alt="NARSS" width="110px">
			</div>
			<div style="width: 150px; margin-left: 25px; margin-top: 25px; float: left;">
				<img src="resources/images/stdf_logo.png" alt="STDF">
			</div>
        </div>
        <div class="header_title">
			<span class="header_title_decorated">Use of Big Data Analysis to Develop<br/>a Crop Information System based on Remote<br/>Sensing Technology (BigCrops)</span>
		</div>
        <!--  <div id="rightLogo">
			<img src="resources/images/site_logo.png" style="margin-right: 5; margin-top: 5;" alt="NARSS">
        </div> -->
	</div>
	<div id="viewPan">
		<div id="map"></div>
		<div id="panel">
			<ul>
				<li><a href="/STDF_CropMonitoring_Proj/ndvi">Calculate NDVI</a></li>
			</ul>
			<h2>${line}</h2>
		</div>
	</div>
	<div id="footer">
		<span id="footerInfo"> 
			Copyright © 2021 STDF. All Rights Reserved
		</span>
	</div>
</div>


</body>
<!-- ---------------- -->
<script>
	var url = 'resources/data/Salhyia_LC_Winter2020.json';  // my GeoJSON data source, in same folder as my html page.
	var sliderControl = null;
	var map = L.map('map').setView([30.4677028,31.9959757], 11); 

	var osm=new L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',{ 
				attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);
		
	
// Set style function that sets fill color property
function style(feature) {
    return {
        fillColor: 'green', 
        fillOpacity: 0.5,  
        weight: 2,
        opacity: 1,
        color: '#ffffff',
        dashArray: '3'
    };
}
	var highlight = {
		'fillColor': 'yellow',
		'weight': 2,
		'opacity': 1
	};
	
		function forEachFeature(feature, layer) {

            var popupContent = "<p><b>Name: </b>"+ feature.properties.Name +
                "</br>W2020: "+ feature.properties.W2020 + '</p>'
                /* "</br>POP2010: "+ feature.properties.POP2010.toLocaleString() +
                "</br>Pop 2010 per SQMI: "+ feature.properties.POP10_SQMI.toLocaleString() +
                "</br>Males: "+ feature.properties.MALES.toLocaleString() +
                "</br>Females: "+ feature.properties.FEMALES.toLocaleString() +
                "</br>SQ Miles: "+ feature.properties.SQMI.toLocaleString() +'</p>'; */

            layer.bindPopup(popupContent);

            layer.on("click", function (e) { 
            	vectorLayer.setStyle(style); //resets layer colors
                layer.setStyle(highlight);  //highlights selected.
            }); 
		}
	
// Null variable that will hold layer
var vectorLayer = L.geoJson(null, {onEachFeature: forEachFeature, style: style});

	$.getJSON(url, function(data) {
		vectorLayer.addData(data);
    });

	vectorLayer.addTo(map);
 
 var imageUrl = 'resources/data/NDVI605_png.png'
 var imageBounds = [[29.2239788, 30.7082307], [31.3682549, 33.1368597]];
 L.imageOverlay(imageUrl, imageBounds).setOpacity(0.4);
 
 var rasterLayer = L.imageOverlay(imageUrl, imageBounds).setOpacity(0.4);
 rasterLayer.addTo(map);
 
// for Layer Control	
var baseMaps = {
    "Open Street Map": osm  	
};

var overlayMaps = {
    "Salhyia (Shapfile)":vectorLayer,
    "Salhyia (NDVI)":rasterLayer
};	
	
//Add layer control
L.control.layers(baseMaps, overlayMaps).addTo(map);


var testlayer = null;
//Fetch some data from a GeoJSON file
$.getJSON("resources/data/Salhyia_LC_Winter2020.json", function(json) {
    testlayer = L.geoJson(json, {onEachFeature: forEachFeatureSlider, style: style}),
        
    //For a Range-Slider use the range property:
    sliderControl = L.control.sliderControl({
        position: "topright",
        layer: testlayer,
        range: true
    });

    //Make sure to add the slider to the map ;-)
    //map.addControl(sliderControl);
    //And initialize the slider
    //sliderControl.startSlider();
});

function forEachFeatureSlider(feature, rasterLayer) {

    var popupContentSlider = "<p><b>Name: </b>"+ feature.properties.Name +
    "</br>W2020: "+ feature.properties.W2020 + '</p>';

    rasterLayer.bindPopup(popupContentSlider); 
}

var timeInput = document.getElementById('timeInput');
var imageOverlays = L.layerGroup();
  
function myFunction() {
	L.imageOverlay(timeInput.options[timeInput.selectedIndex].value, imageBounds).setOpacity(0.75).addTo(imageOverlays);
	imageOverlays.addTo(map);	
}
</script>