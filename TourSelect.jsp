<%@ page import="java.sql.*" %>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="57157524-design-of-rajasthani-man-with-turban-and-moustache-in-indian-art-style.jpg" />
	<link rel="stylesheet" type="text/css" href="frontend.css"/>
    <title>PlanMyTour</title>
    <style type="text/css">
    	#mapholder a{
	border:none;
	background-color:rgba(0,0,0,0);
	}
    </style>
	
  </head>
<body onload="getLocation()" background="background.jpg">
<div id="navbar-div">
		<div id="logo-div">
				<img id="logo" src="57157524-design-of-rajasthani-man-with-turban-and-moustache-in-indian-art-style.jpg" width="50px"/>
		</div>
		<div class="element-div">
			<h2>PlanMyTour</h2>
		</div>
		
		
	
	</div>
	<br><br><br><br><br><br>
<div id="signupblock">
<p id="demo"></p>

<div id="mapholder"></div>
<form name="fi" action="http://localhost:8080/Tourism/AddTour.jsp">
<div id="or-div">
		     <img src="or.PNG" >
			 
		  </div>
		  <input type="hidden" name="dlat">
			 <input type="hidden" name="dlon">
Enter Your Starting Point:
        <input type="text" id="txtDestination" name="dest" placeholder="Andheri, Mumbai, India" style="width: 75%;" onfocusout="GetRoute()" required/>
<br>
Choose The places you want to visit:
<% try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    ResultSet rs;
    rs=st.executeQuery("select * from spots");
    rs.beforeFirst();
    while(rs.next())
    {
    	String str[]=rs.getString("Place").split(",");
    %>
<br>
<input type="checkbox" name="spots" style="width:10%" value="<%out.print(rs.getString("placeid")); %>"><%out.print(str[0]); %>

<% } %>
<br>
<input type="submit" value="Plan Your Tour" style="width:45%;">
<% }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
</form>
</div>
<script src="https://maps.google.com/maps/api/js?key=AIzaSyBLP2mkhJz21qggbaJ_GEMCrlqH3ITapX4&sensor=false&libraries=places"></script>
<script>
var x = document.getElementById("demo");
var lat,lon;

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    lat = position.coords.latitude;
    lon = position.coords.longitude;
    var latlon = new google.maps.LatLng(lat, lon);
    var mapholder = document.getElementById('mapholder');
    mapholder.style.height = '200px';
    mapholder.style.width = '100%';

    var myOptions = {
    center:latlon,zoom:17,
    mapTypeId:google.maps.MapTypeId.ROADMAP,
    mapTypeControl:false,
    navigationControlOptions:{style:google.maps.NavigationControlStyle.SMALL}
    }
    var map = new google.maps.Map(document.getElementById("mapholder"), myOptions);
    var marker = new google.maps.Marker({position:latlon,map:map,title:"You are here!"});
    var latlng = {lat: lat, lng: lon};
	var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'location': latlng }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
               fi.txtDestination.value=results[0].formatted_address;
            }
        }
    });
    
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
        case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
        case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
        case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
    }
}
google.maps.event.addDomListener(window, 'load', function () {
    
    new google.maps.places.SearchBox(document.getElementById('txtDestination'));
    });

function GetRoute() {
    var destination = document.getElementById("txtDestination").value;
    var myLat;
    var myLong;
 
    
    var geocoder = new google.maps.Geocoder();

    geocoder.geocode({address: destination}, function(results, status) {

      if (status == google.maps.GeocoderStatus.OK) {

        var myResult = results[0].geometry.location; // reference LatLng value
  	  var myLat=myResult.lat();
  	  var myLong=myResult.lng();
        fi.dlat.value=myLat;
        fi.dlon.value=myLong;
        var mumbai = new google.maps.LatLng(myLat, myLong);
        var mapholder = document.getElementById('mapholder');
        
        var mapOptions = {
            zoom: 17,
            center: mumbai
        };
        var map = new google.maps.Map(document.getElementById('mapholder'), mapOptions);
        var marker = new google.maps.Marker({position:mumbai,map:map,title:"You are here!"});

        

      }
    });
     }
 	

</script>

</body>
</html>
