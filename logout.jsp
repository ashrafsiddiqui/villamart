<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.text.*"  errorPage="" %>
<%@include file="function.jsp"%>

<%
	if(!(nullconv((String)session.getAttribute("sUserID")).equals("")))
	{
	  session.invalidate();
	  response.sendRedirect("index.jsp");
	}
	else{
	  response.sendRedirect("index.jsp");
	}
%>
