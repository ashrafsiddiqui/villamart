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
		
		 String iPageID=nullconv(request.getParameter("iPageID"));  
		 String reDirectPage="/searchRes.jsp";
		 if(iPageID.equalsIgnoreCase("My"))
		 {
		  reDirectPage="/myList.jsp"; 
		 }
		 else if(iPageID.equalsIgnoreCase("app"))
		 {
		  reDirectPage="/approveList.jsp"; 
		 }
	
	chbx=request.getParameterValues("iListID");
	try{
		String sqlProperty="DELETE FROM list_requirement where iListID in("+arrayToString(chbx,",")+")";
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
		request.setAttribute("error","<span class='sSuccess'>&nbsp; Data is deleted successfully&nbsp; </span>");
		RequestDispatcher dispatch = request.getRequestDispatcher(reDirectPage);
		dispatch.forward(request, response);
	}
	catch(Exception e)
	{
	  e.printStackTrace();
	  request.setAttribute("error","<span class='sSError'>&nbsp; Error: Data is not deleted successfully&nbsp; </span>");
	  RequestDispatcher dispatch = request.getRequestDispatcher(reDirectPage);
	  dispatch.forward(request, response);
	}

%>

