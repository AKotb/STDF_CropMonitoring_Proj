var prev, next;
var images;
var imagenumber;
var currentimage;
var player;
var playchecker;
var prev_db2, next_db2;
var images_db2;
var imagenumber_db2;
var currentimage_db2;
var player_db2;
var playchecker_db2;
$(document).ready(function() {
	playchecker=false;
	playchecker_db2=false;
	images = $('#cf7').children('img').get();
	images_db2 = $('#cf7_db2').children('img').get();
	imagesnumber = images.length;
	imagesnumber_db2 = images_db2.length;
	currentimage = 0;
	currentimage_db2 = 0;
	$("#prev").on('click', function() {
		if (currentimage == 0){
			$("#cf7 img").removeClass("opaque");
		    $("#cf7 img").eq(imagesnumber-1).addClass("opaque");
		    $("#cf7_controls span").removeClass("selected");
		    $("#cf7_controls span").eq(imagesnumber-1).addClass("selected");
		    currentimage = imagesnumber-1;
		} 		
		else{
			$("#cf7 img").removeClass("opaque");
		    $("#cf7 img").eq(currentimage-1).addClass("opaque");
		    $("#cf7_controls span").removeClass("selected");
		    $("#cf7_controls span").eq(currentimage-1).addClass("selected");
		    currentimage = currentimage-1;
		}
	});
	$("#prev_db2").on('click', function() {
		if (currentimage_db2 == 0){
			$("#cf7_db2 img").removeClass("opaque");
		    $("#cf7_db2 img").eq(imagesnumber_db2-1).addClass("opaque");
		    $("#cf7_controls_db2 span").removeClass("selected");
		    $("#cf7_controls_db2 span").eq(imagesnumber_db2-1).addClass("selected");
		    currentimage_db2 = imagesnumber_db2-1;
		} 		
		else{
			$("#cf7_db2 img").removeClass("opaque");
		    $("#cf7_db2 img").eq(currentimage_db2-1).addClass("opaque");
		    $("#cf7_controls_db2 span").removeClass("selected");
		    $("#cf7_controls_db2 span").eq(currentimage_db2-1).addClass("selected");
		    currentimage_db2 = currentimage_db2-1;
		}
	});
	
	$("#next").on('click', function() {
		if (currentimage == imagesnumber - 1){
			$("#cf7 img").removeClass("opaque");
		    $("#cf7 img").eq(0).addClass("opaque");
		    $("#cf7_controls span").removeClass("selected");
		    $("#cf7_controls span").eq(0).addClass("selected");
		    currentimage = 0;
		}		
		else{
			$("#cf7 img").removeClass("opaque");
		    $("#cf7 img").eq(currentimage+1).addClass("opaque");
		    $("#cf7_controls span").removeClass("selected");
		    $("#cf7_controls span").eq(currentimage+1).addClass("selected");
		    currentimage = currentimage+1;
		}
	});
	$("#next_db2").on('click', function() {
		if (currentimage_db2 == imagesnumber_db2 - 1){
			$("#cf7_db2 img").removeClass("opaque");
		    $("#cf7_db2 img").eq(0).addClass("opaque");
		    $("#cf7_controls_db2 span").removeClass("selected");
		    $("#cf7_controls_db2 span").eq(0).addClass("selected");
		    currentimage_db2 = 0;
		}		
		else{
			$("#cf7_db2 img").removeClass("opaque");
		    $("#cf7_db2 img").eq(currentimage_db2+1).addClass("opaque");
		    $("#cf7_controls_db2 span").removeClass("selected");
		    $("#cf7_controls_db2 span").eq(currentimage_db2+1).addClass("selected");
		    currentimage_db2 = currentimage_db2+1;
		}
	});
	
	$("#play").on('click', function() {
		if(playchecker == true){
			playchecker = false;
			document.getElementById('play').style.backgroundImage = "url('resources/images/ts_play.png')";
			clearInterval(player);  
		}else{
			playchecker = true;
			document.getElementById('play').style.backgroundImage = "url('resources/images/ts_pause.png')";
			player = setInterval(function(){ 
				if (currentimage == imagesnumber - 1){
					$("#cf7 img").removeClass("opaque");
				    $("#cf7 img").eq(0).addClass("opaque");
				    $("#cf7_controls span").removeClass("selected");
				    $("#cf7_controls span").eq(0).addClass("selected");
				    currentimage = 0;
				}		
				else{
					$("#cf7 img").removeClass("opaque");
				    $("#cf7 img").eq(currentimage+1).addClass("opaque");
				    $("#cf7_controls span").removeClass("selected");
				    $("#cf7_controls span").eq(currentimage+1).addClass("selected");
				    currentimage = currentimage+1;
				}
		 }, 1000); 
		}
	});
	$("#play_db2").on('click', function() {
		if(playchecker_db2 == true){
			playchecker_db2 = false;
			document.getElementById('play_db2').style.backgroundImage = "url('resources/images/ts_play.png')";
			clearInterval(player_db2);  
		}else{
			playchecker_db2 = true;
			document.getElementById('play_db2').style.backgroundImage = "url('resources/images/ts_pause.png')";
			player_db2 = setInterval(function(){ 
				if (currentimage_db2 == imagesnumber_db2 - 1){
					$("#cf7_db2 img").removeClass("opaque");
				    $("#cf7_db2 img").eq(0).addClass("opaque");
				    $("#cf7_controls_db2 span").removeClass("selected");
				    $("#cf7_controls_db2 span").eq(0).addClass("selected");
				    currentimage_db2 = 0;
				}		
				else{
					$("#cf7_db2 img").removeClass("opaque");
				    $("#cf7_db2 img").eq(currentimage_db2+1).addClass("opaque");
				    $("#cf7_controls_db2 span").removeClass("selected");
				    $("#cf7_controls_db2 span").eq(currentimage_db2+1).addClass("selected");
				    currentimage_db2 = currentimage_db2+1;
				}
		 }, 1000); 
		}
	});
	
	$("#pause").on('click', function() {
		clearInterval(player);
	});
	$("#pause_db2").on('click', function() {
		clearInterval(player_db2);
	});
	
  $("#cf7_controls").on('click', 'span', function() {
    $("#cf7 img").removeClass("opaque");
    var newImage = $(this).index();
    $("#cf7 img").eq(newImage).addClass("opaque");
    $("#cf7_controls span").removeClass("selected");
    $(this).addClass("selected");
    currentimage = newImage;
  });
  $("#cf7_controls_db2").on('click', 'span', function() {
	    $("#cf7_db2 img").removeClass("opaque");
	    var newImage_db2 = $(this).index();
	    $("#cf7_db2 img").eq(newImage_db2).addClass("opaque");
	    $("#cf7_controls_db2 span").removeClass("selected");
	    $(this).addClass("selected");
	    currentimage_db2 = newImage_db2;
	  });
  
});