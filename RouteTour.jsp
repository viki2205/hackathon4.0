<%@ page import="java.sql.*" %>
<html>
  <head>
  <link rel="shortcut icon" type="image/x-icon" href="57157524-design-of-rajasthani-man-with-turban-and-moustache-in-indian-art-style.jpg" />
	<link rel="stylesheet" type="text/css" href="frontend.css"/>
    
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Tourism</title>
    <style>
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        float: left;
        width: 63%;
      }
      #right-panel {
        float: right;
        width: 34%;
        height: 100%;
        overflow-y:auto;
      }
      .panel {
        height: 100%;
        overflow: auto;
      }
      #map a{
	border:none;
	background-color:rgba(0,0,0,0);
	}
    </style>
  </head>
  <body>
  <div id="navbar-div">
		<div id="logo-div">
				<img id="logo" src="57157524-design-of-rajasthani-man-with-turban-and-moustache-in-indian-art-style.jpg" width="50px"/>
		</div>
		<div class="element-div">
			<h2>PlanMyTour</h2>
		</div>
  </div>
<div id="signupblock" style="width:90%;">
    <div id="map"></div>
    <div id="right-panel">
      <p>Your Travel Plan. Total distance covered in the entire tour: <span id="total"></span></p>
    </div>
    </div>
   
    <script>
    <%
    try {
      java.sql.Connection con;
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
      Statement st=con.createStatement();
      ResultSet rs=st.executeQuery("select * from tours where Type='SOURCE';");
      rs.beforeFirst();
      rs.next();
  %>
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: {lat: -24.345, lng: 134.46}  // Australia.
        });

        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer({
          draggable: false,
          map: map,
          panel: document.getElementById('right-panel')
        });

        directionsDisplay.addListener('directions_changed', function() {
          computeTotalDistance(directionsDisplay.getDirections());
        });

        displayRoute('<%out.print(rs.getString("Place"));%>', '<%out.print(rs.getString("Place"));%>', directionsService,
            directionsDisplay);
      }
<% rs=st.executeQuery("select * from tours where Type='WAYP';");
rs.beforeFirst();
%>
      function displayRoute(origin, destination, service, display) {
        service.route({
          origin: origin,
          destination: destination,
          waypoints: [<%while(rs.next()){
        	  Statement st1=con.createStatement();
        	  ResultSet rs1=st1.executeQuery("select * from spots where placeid="+rs.getString("placeid"));
          rs1.beforeFirst();
          rs1.next();
          %>{location: '<%out.print(rs1.getString("lattitude")+","+rs1.getString("longitude"));%>'},  <%}%>],
          optimizeWaypoints:true,
          travelMode: 'DRIVING',
          avoidTolls: true
        }, function(response, status) {
          if (status === 'OK') {
            display.setDirections(response);
            
          } else {
            alert('Could not display directions due to: ' + status);
          }
        });
      }

      function computeTotalDistance(result) {
        var total = 0;
        var myroute = result.routes[0];
        for (var i = 0; i < myroute.legs.length; i++) {
          total += myroute.legs[i].distance.value;
          //document.getElementById('total').innerHTML+=myroute.legs[i].end_address;
        }
        total = total / 1000;
        document.getElementById('total').innerHTML += total + ' km';
      }
      <%
      st.executeUpdate("delete from tours;");
      }
    catch(SQLException e) {
      out.println("SQLException caught: " +e.getMessage());
    }
  %>
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBLP2mkhJz21qggbaJ_GEMCrlqH3ITapX4&callback=initMap">
    </script>
  </body>
</html>