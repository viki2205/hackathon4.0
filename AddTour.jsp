	<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>

<%
  try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost/tourism","root","iambatman");
    Statement st=con.createStatement();
    st.executeUpdate("insert into tours values('"+request.getParameter("dest")+"','SOURCE',0)");
    String str[];
    str=request.getParameterValues("spots");
    int i=0;
    Statement st2=con.createStatement();
    ResultSet rs;
    while(i<str.length)
    {
    	rs=st2.executeQuery("select * from spots where placeid="+str[i]+";");
    	rs.beforeFirst();
    	rs.next();
    	st.executeUpdate("insert into tours values('"+rs.getString("Place")+"','WAYP',"+str[i]+")");
    	i++;
    }
    response.sendRedirect("http://localhost:8080/Tourism/RouteTour.jsp");
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>
