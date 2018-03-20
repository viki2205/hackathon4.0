	<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>

<%
  try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    st.executeUpdate("delete from spots where placeid="+request.getParameter("place")+";");
    response.sendRedirect("http://localhost:8080/Tourism/PlacesList.jsp");
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
