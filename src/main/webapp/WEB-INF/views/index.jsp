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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<!--<link rel="stylesheet" href="resources/css/leaflet.draw.css"/>
	<script src="resources/js/leaflet.draw.js"></script>-->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.12/leaflet.draw.css" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/0.4.12/leaflet.draw.js"></script>
    
<style>  
    #header {
    	width: 100%; 
    	height: 15%; 
    	background-color: #227db2;
    }
    
    #leftLogo {
	    float: left;
	    width: 20%;
	    background-color: #227db2;
    }
    
       
    .header_title {
    	width: 100%;
	    background-color: #227db2;
	    text-align: center;
	    padding-top: 7;
	}
    
    .header_title_decorated {
	    width: 100%;
	    height: 100%;
	    color: #EEEEFF;
	    font-size: 35px;
	    font-weight: bold;
	    line-height: 1;
	}
    
	#viewPan{
		width: 100%;
		height: 80%;
	}
	
	#panel {
		width: 24.4%;
		height: 99%;
		//float: left;
		//border: 2px solid #d73;
		background-color: #6FB8E3;
		overflow: auto;
	}
	
	#drawArea {
		width: 100%;
		/*width: 75%;*/
		height: 99%;
		//float: right;
		//border: 2px solid #d73;
		//background-color: #6FB8E3;
	}
	
    #map {
        width: 100%;
        height: 66%;
    }
	
	#timeSeires {
        width: 100%;
        height: 34%;
		background-color: #6FB8E3;
		min-height: 0;
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
	
	.chart-container {
	  width: 100%;
	  height: 86%;
	  position: relative;
	  background-color: white;
	}
	
	#basemaps-wrapper {
	top: 5px;
    right: 10px;
    padding: 10px;
	height: 5%;
  }
  
  .collapsSTDF {
	  //background-color: #777;
	  color: white;
	  cursor: pointer;
	  //padding: 18px;
	  //float: right;
	  border: none;
	  //text-align: left;
	  outline: none;
	  font-size: 15px;
	}

	.active, .collapsSTDF:hover {
	  background-color: #afa;
	}

	.collapsSTDF:after {
	  content: '\25B2';
	  color: white;
	  font-weight: bold;
	  float: right;
	  margin-left: 5px;
	}

	.active:after {
	  content: "\25BC";
	}
  
  #index {
    margin-bottom: 5px;
  }
  
   #link {
    visibility: hidden;
  }
  
  table, th, td {
	  border: 1px solid #227db2;
	  text-align: center;
  }
  
</style>
</head>

<!-- <body style="background-color: #79C255">-->
<body onload="loadGraph()">
<div id="container" style="width: 100%; height: 100%; padding: 0; margin: 0;">
	<div id="header">
		<div id="leftLogo">
			<div style="border-radius: 50%; filter: contrast(1.3); width: 75px; height: 75px; margin-left: 5px; margin-top: 5px; float: left;">
				<img style="border-radius: 50%;" src="resources/images/narss_logo_normal.jpg" alt="NARSS" width="75px">
			</div>
			<div style="width: 100px; margin-left: 20px; margin-top: 10px; float: left;">
				<img src="resources/images/stdf_logo.png" alt="STDF">
			</div>
        </div>
        <div class="header_title">
			<span class="header_title_decorated">Use of Big Data Analysis to Develop a Crop Information System based on Remote Sensing Technology (BigCrops)</span>
		</div>
        <!--  <div id="rightLogo">
			<img src="resources/images/site_logo.png" style="margin-right: 5; margin-top: 5;" alt="NARSS">
        </div> -->
	</div>
	<div id="viewPan">
		<div id="drawArea">
			<div id="map"></div>
			<div id="timeSeires">
				<div id="basemaps-wrapper" class="leaflet-bar">
				  <strong>Calculate:</strong> <select id="index">
					<option value="" selected></option>
					<option value="NDVI">NDVI</option>
					<option value="NDWI">NDWI</option>
					<option value="LST">LST</option>
				  </select>
				  <span class="collapsSTDF"></span>
				  </div>
				<div class="chart-container">
					<canvas id="line-chart"></canvas>
				</div>
			</div>
		</div>
		<!--<div id="panel">
			
				<a id="link" href="/STDF_CropMonitoring_Proj/ndvi">Calculate NDVI</a>
			
			<h2>${line}</h2>
		</div>-->
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
	var tempArray = null;
	var chart = null;
	var polygonCoordinates = "";
	var temp = "";
	var url = 'resources/data/Salhyia_LC_Winter2020.json';  // my GeoJSON data source, in same folder as my html page.
	var sliderControl = null;
	var map = L.map('map').setView([30.45,32.0], 11); 

	var osm=new L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png',{ 
				attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);
	//-----------------Draw Polygons Tool-------------------
	var drawnItems = new L.FeatureGroup();
     map.addLayer(drawnItems);
	 var drawControl = new L.Control.Draw({
		 draw: {
              polygon: {
			  allowIntersection: false, // Restricts shapes to simple polygons
			  drawError: {
				color: '#e1e100', // Color the shape will turn when intersects
				message: '<strong>Polygon draw does not allow intersections!<strong> (allowIntersection: false)' // Message that will show when intersect
			  },
			  shapeOptions: {
				color: '#97009c'
			  }
			},
			circle: false, // Turns off this drawing tool
			polyline: false,
			circlemarker: true,
			marker: false,
			rectangle: false/*{
			  shapeOptions: {
				color: '#FF0000',
				clickable: false
			  }
			}*/
         },
         edit: {
             featureGroup: drawnItems,
			 remove: true
         }
     });
	 
     map.addControl(drawControl);
	 	 
	 map.on(L.Draw.Event.CREATED, function(e) {
	  var type = e.layerType,
		layer = e.layer;
		var tempArray = layer._latlngs[0];
	  if (type === 'polygon') {
		polygonCoordinates +="["
		for(var i=0; i<tempArray.length; i++)
		{
			temp += "[" + tempArray[i].lat+","+tempArray[i].lng + "]";
			if(i === tempArray.length - 1)
				break;
			else
				temp +=",";
		}
		polygonCoordinates +=temp + "]";
		console.log(polygonCoordinates);
		console.log(tempArray);
		var popupContent = '<a href="/STDF_CropMonitoring_Proj/ndvi?polygonCoordinates='+polygonCoordinates+'">Calculate NDVI</a>';
		layer.bindPopup(popupContent).openPopup();
	  }
	  drawnItems.addLayer(layer);
	});
	
	map.on(L.Draw.Event.EDITED, function (e) {
            var layers = e.layers;
            var countOfEditedLayers = 0;
            layers.eachLayer(function(layer) {
                countOfEditedLayers++;
            });
            console.log("Edited " + countOfEditedLayers + " layers");
        });
		
	map.on('draw:deleted', function(e){
		
		tempArray = null;
		temp = "";
		polygonCoordinates = "";
		console.log(tempArray);
		console.log(polygonCoordinates);
	});
	//------------------------------------------------------
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
                "</br>W2020: "+ feature.properties.W2020 + '</p>' + 
                '<a href="/STDF_CropMonitoring_Proj/ndvi?id='+feature.id+'">Calculate NDVI</a>'

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

	//vectorLayer.addTo(map);

//------------------------------------------------------------
var url2 = 'resources/data/11.json';  // my GeoJSON data source, in same folder as my html page.

function style2(feature) {
    return {
        radius: 5,
		fillColor: "#ff7800",
		color: "#000",
		weight: 1,
		opacity: 1,
		fillOpacity: 0.8
    };
}


	var highlight2 = {
			'fillColor': 'yellow',
			'weight': 2,
			'opacity': 1
		};
		
	function forEachFeature2(feature, layer) {
		
		var popupContent = "<table><caption><strong>Feature Properties</strong></caption>" + "		<tr><th>Property</th><th>Value</th></tr><tr><td>ID</td><td>"+ feature.id +
            "</td></tr><tr><td>Sample</td><td>"+ feature.properties.Sample + 
			"</td></tr><tr><td>EC</td><td>"+ feature.properties.EC + 
			"</td></tr><tr><td>pH</td><td>"+ feature.properties.pH +
			"</td></tr><tr><td>OM</td><td>"+ feature.properties.OM + 
			"</td></tr><tr><td>Sand</td><td>"+ feature.properties.Sand + 
			"</td></tr><tr><td>Silt</td><td>"+ feature.properties.Silt +
			"</td></tr><tr><td>Clay</td><td>"+ feature.properties.Clay +
			"</td></tr><tr><td>Porosity</td><td>"+ feature.properties.Porosity +
			"</td></tr></table>"; /*+ 
            '<a href="/STDF_CropMonitoring_Proj/ndvi?id='+feature.id+'">Calculate NDVI</a>'*/

        layer.bindPopup(popupContent);

        layer.on("click", function (e) { 
        	vectorLayer2.setStyle(style2); //resets layer colors
            layer.setStyle(highlight2);  //highlights selected.
        }); 
	}

//Null variable that will hold layer
var vectorLayer2 = L.geoJson(null, {pointToLayer: function (feature, latlng) {
        return L.circleMarker(latlng, null);
    }, onEachFeature: forEachFeature2, style: style2});

$.getJSON(url2, function(data) {
	vectorLayer2.addData(data);
});

//vectorLayer2.addTo(map);
//------------------------------------------------------------
 var imageUrl = 'resources/data/NDVI605_png.png'
 var imageBounds = [[29.2239788, 30.7082307], [31.3682549, 33.1368597]];
 L.imageOverlay(imageUrl, imageBounds).setOpacity(0.4);
 
 var rasterLayer = L.imageOverlay(imageUrl, imageBounds).setOpacity(0.4);
 //rasterLayer.addTo(map);
 
// for Layer Control	
var baseMaps = {
    "Open Street Map": osm  	
};

var overlayMaps = {
	"Salhyia Soil Map (Shapfile)":vectorLayer2,
    "Salhyia (Shapfile)":vectorLayer,
    "Salhyia (NDVI)":rasterLayer,
	"Drawn Layers":drawnItems
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
var chartType = null;
document
    .querySelector('#index')
    .addEventListener('change', function (e) {
      chartType = e.target.value;
	  addDataSet(chartType);
    });

</script>
<script>
var coll = document.getElementsByClassName("collapsSTDF");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = document.getElementById("timeSeires");
	var mapContent = document.getElementById("map");
	
	if (content.style.minHeight){
      content.style.minHeight = null;
	  content.style.height = "34%";
	  mapContent.style.height = "66%";
	} else {
      content.style.minHeight = "0%";
	  content.style.height = "100%";
	  mapContent.style.height = "0%";
	} 
  });
}
</script>
<script>
function addDataSet(chartType) {
    const csv_ndvi = `Date,NDVI
	1/1/2019,0.1901
	15/1/2019,0.6951
	1/2/2019,0.4134
	15/2/2019,0.8371
	1/3/2019,0.4253
	15/3/2019,0.4622
	1/4/2019,0.7685
	15/4/2019,0.4715
	1/5/2019,0.4651
	15/5/2019,0.4614
	1/6/2019,0.6068
	15/6/2019,0.1438
	1/7/2019,0.7301
	15/7/2019,0.1315
	1/8/2019,0.3241
	15/8/2019,0.5852
	1/9/2019,0.5947
	15/9/2019,0.1265
	1/10/2019,0.463
	15/10/2019,0.4237
	1/11/2019,0.0738
	15/11/2019,0.1279
	1/12/2019,0.841
	15/12/2019,0.3963`;

	const csv_ndwi = `Date,NDWI
	1/1/2019,0.4303
	15/1/2019,0.1422
	1/2/2019,0.3767
	15/2/2019,0.3426
	1/3/2019,0.1343
	15/3/2019,0.3759
	1/4/2019,0.3374
	15/4/2019,0.6408
	1/5/2019,0.5255
	15/5/2019,0.4762
	1/6/2019,0.7346
	15/6/2019,0.9465
	1/7/2019,0.4853
	15/7/2019,0.7511
	1/8/2019,0.4098
	15/8/2019,0.5898
	1/9/2019,0.152
	15/9/2019,0.5373
	1/10/2019,0.5822
	15/10/2019,0.4466
	1/11/2019,0.1402
	15/11/2019,0.1704
	1/12/2019,0.045
	15/12/2019,0.6008`;
	
	const csv_lst = `Date,LST
	1/1/2019,0.7062
	15/1/2019,0.6445
	1/2/2019,0.9603
	15/2/2019,0.6602
	1/3/2019,0.6761
	15/3/2019,0.5212
	1/4/2019,0.797
	15/4/2019,0.1299
	1/5/2019,0.5767
	15/5/2019,0.4256
	1/6/2019,0.3374
	15/6/2019,0.698
	1/7/2019,0.4432
	15/7/2019,0.8036
	1/8/2019,0.3301
	15/8/2019,0.5691
	1/9/2019,0.5435
	15/9/2019,0.6906
	1/10/2019,0.385
	15/10/2019,0.4792
	1/11/2019,0.3317
	15/11/2019,0.6299
	1/12/2019,0.6549
	15/12/2019,0.3802` ;

	const csvToNDVIChartData = csv_ndvi => {
	  const lines = csv_ndvi.trim().split('\n');
	  lines.shift(); // remove titles (first line)
	  return lines.map(line => {
		const [date, ndvi] = line.split(',');
		return {
		  x: date,
		  y: ndvi
		}
	  });
	};
	
	const csvToNDWIChartData = csv_ndwi => {
	  const lines = csv_ndwi.trim().split('\n');
	  lines.shift(); // remove titles (first line)
	  return lines.map(line => {
		const [date, ndwi] = line.split(',');
		return {
		  x: date,
		  y: ndwi
		}
	  });
	};
	
	const csvToLSTChartData = csv_lst => {
	  const lines = csv_lst.trim().split('\n');
	  lines.shift(); // remove titles (first line)
	  return lines.map(line => {
		const [date, lst] = line.split(',');
		return {
		  x: date,
		  y: lst
		}
	  });
	};
	
	var dsColor;
	var chartData;
	
	if(chartType === 'NDVI')
	{
      dsColor = "#FF0000";
	  chartData = csvToNDVIChartData(csv_ndvi);
	}
	else if(chartType === 'NDWI')
	{
		dsColor = "#00FF00";
		chartData = csvToNDWIChartData(csv_ndwi);
	}
	else if(chartType === 'LST')
	{
		dsColor = "#0000FF";
		chartData = csvToLSTChartData(csv_lst);
	}
	
      const newDataset = {
        label: chartType,
        borderColor: dsColor,
        data: chartData
      };
	  if(chartType !== "" || chart.data.datasets.length !== 3)
	  {
		chart.data.datasets.push(newDataset);
		chart.update();
	  }
}

function loadGraph()
{
	const ctx = document.querySelector("#line-chart").getContext('2d');
	const plugin = {
	  id: 'custom_canvas_background_color',
	  beforeDraw: (chart) => {
		const ctx = chart.canvas.getContext('2d');
		ctx.save();
		ctx.globalCompositeOperation = 'destination-over';
		ctx.fillStyle = 'white';
		ctx.fillRect(0, 0, chart.width, chart.height);
		ctx.restore();
	  }      
	};
	
	const config = {
		  type: 'line',
		  options: {
			maintainAspectRatio: false,
			scales: {
			  xAxes: [{
				type: 'time',
				distribution: 'linear',
			  }],
			  title: {
				display: false,
			  }
			}
		  },
		  plugins: [plugin]
		};
		
		chart = new Chart(ctx, config);
}
</script>