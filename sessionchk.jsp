<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%  
	if((nullconv((String)session.getAttribute("sUserID")).equals("")))
	{
	  response.sendRedirect("login.jsp");
	  return;
	 }
%>