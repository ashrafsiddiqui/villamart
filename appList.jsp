<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%@ include file="function.jsp"%>
<%!
String[] chbx;
	
 public String arrayToString(String[] a, String separator) {
	    StringBuffer result = new StringBuffer();
	    if (a.length > 0) {
	        result.append(a[0]);
	        for (int i=1; i<a.length; i++) {
	              result.append(separator);
	              result.append(a[i]);
	        }
	    }
	    return result.toString();
	}
%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	PreparedStatement psProperty=null;
	
	chbx=request.getParameterValues("iListID");
	
	String reDirectPage="approveList.jsp";
	
	try{
		String sqlProperty="update list_requirement set cStatus='A' where iListID in("+arrayToString(chbx,",")+")";
		psProperty=conn.prepareStatement(sqlProperty);
		psProperty.executeUpdate();
		
		try{
		 if(psProperty!=null){
			 psProperty.close();
		 }
		 		 
		 if(conn!=null){
		  conn.close();
		 }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		request.setAttribute("error","<span class='sSuccess'>&nbsp; List is Approved Successfully&nbsp; </span>");
		RequestDispatcher dispatch = request.getRequestDispatcher(reDirectPage);
		dispatch.forward(request, response);
	}
	catch(Exception e)
	{
	  e.printStackTrace();
	  request.setAttribute("error","<span class='sSError'>&nbsp; Error: List is not Approved Successfully&nbsp; </span>");
	  RequestDispatcher dispatch = request.getRequestDispatcher(reDirectPage);
	  dispatch.forward(request, response);
	}

%>

