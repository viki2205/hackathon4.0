<%@ page import="java.sql.*"%>
<html>
<head>
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="57157524-design-of-rajasthani-man-with-turban-and-moustache-in-indian-art-style.jpg" />
	<link rel="stylesheet" type="text/css" href="frontend.css"/>
    <title>PlanMyTour</title>
	
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
	<br><br><br><br><br><br>
	<div id="signupblock">
<%
  try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    st.executeUpdate("insert into spots(Place,Lattitude,Longitude) values('"+request.getParameter("dest")+"',"+request.getParameter("dlat")+","+request.getParameter("dlon")+");");
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
<%="Your Spot Has been added" %>
<br>
<br>
<a href="http://localhost:8080/Tourism/PlacesList.jsp"><span id="ridersignup">View &rang;</span></a>
</div>
</body>
</html>



