<%@ page import="java.sql.*"%>
<head>
<link rel="stylesheet" type="text/css" href="frontend.css">
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

<div id="signupblock">
<%
  try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select * from spots;");
    rs.beforeFirst();
    %>
  

    <%
    while(rs.next())
    {
    	String s[]=rs.getString("Place").split(",");
    	%>
    	<form action="http://localhost:8080/Tourism/RemovePlace.jsp">
    <%out.print(s[0]); %><input type="hidden" name="place" value="<%out.print(rs.getString("placeid"));%>">
    <input type="submit" value="Remove" style="width:50%;">
  </form>

    	
    	<%
    }
    %>
    </div>
    </body>
    <%
    
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>





