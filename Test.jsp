<%@ page import="java.sql.*" %>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="Cab.png" />
	<link rel="stylesheet" type="text/css" href="frontend.css"/>
    <title>Tourism</title>
    <style type="text/css">
    #signupblock{
    transition:width 2s;
    }
    #signupblock:hover{
    width:90%;
    }
    #mapholder a{
	border:none;
	background-color:rgba(0,0,0,0);
	}
		
    </style>
	
  </head>
<body background="background.jpg">
<%
try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from spots;");
    rs.beforeFirst();
    rs.next();
    %>
<div id="navbar-div">
		<div id="logo-div">
				<img id="logo" src="Cab.png" width="50px"/>
		</div>
		<div class="element-div">
			<h2>Tourism</h2>
		</div>
		
		<div id="help" >
			<a href="login.html">Sign Out</a>
		</div>
		
		<div id="login">
			<a href="http://localhost:8080/youyou/TravelHis.jsp">Travel History</a>
		</div>
	
	</div>
	<br><br><br><br><br><br>
<div id="signupblock">
<p id="demo"></p>

<div id="mapholder"></div>
<form name="fi" action="http://localhost:8080/Tourism/AddSpot.jsp">
<input type="hidden" name="dlat">
<input type="hidden" name="dlon">
Destination:
        <input type="text" id="txtDestination" name="dest" placeholder="Andheri, Mumbai, India" style="width: 75%;" onfocusout="initMap()" required/>
<input type="submit" value="Add" style="width:45%;">


</form>
</div>
<script src="https://maps.google.com/maps/api/js?key=AIzaSyBLP2mkhJz21qggbaJ_GEMCrlqH3ITapX4&sensor=false&libraries=places"></script>
<script>

var map;
var infowindow;

function initMap() {
  var pyrmont = {lat: <%out.print(rs.getString("lattitude")); %>, lng: <% out.print(rs.getString("longitude"));%>};
<%
}
catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
  map = new google.maps.Map(document.getElementById('mapholder'), {
    center: pyrmont,
    zoom: 15
  });

  infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);
  service.nearbySearch({
    location: pyrmont,
    radius: 500,
    type: ['store']
  }, callback);
}

function callback(results, status) {
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);
    }
  }
}

function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}
</script>

</body>
</html>
