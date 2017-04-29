<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%@ include file="function.jsp"%>
<%
	Connection conn = null;
	conn=dbConn.getConnection();
	
	PreparedStatement psInsertMessage=null;
	
	String iListID=nullconv(request.getParameter("iListID"));           
	String sMessage=nullconv(request.getParameter("sMessage"));
	String sSubject=nullconv(request.getParameter("sSubject"));
	String iType=nullconv(request.getParameter("iType"));
	String sSessionUserID=(String)session.getAttribute("sUserID");
	String paraValue="";
	
	if(iType.equalsIgnoreCase("L")) 
	{
	  paraValue=" iListID ";
	}  
	else if(iType.equalsIgnoreCase("P")) 
	{
	 paraValue=" iPostID ";
	}
		
	String sqlInsertMessage=null;
	try{
	
	sqlInsertMessage="insert into response (sUserID, "+paraValue+", sSubject, tMessage, sStatus, sRead, sCreatedBy, sCreatedDate)"
										+"values('"+sSessionUserID+"','"+iListID+"','"+sSubject+"','"+sMessage+"','A','N','"+sSessionUserID+"',sysdate())";
	
	psInsertMessage=conn.prepareStatement(sqlInsertMessage);
	psInsertMessage.executeUpdate();
	
	if(psInsertMessage!=null){
	   psInsertMessage.close();
	}
		 
	if(conn!=null){
	  conn.close();
	}
		 
	response.sendRedirect("success.jsp");
	}
	catch(Exception e)
	{
	   e.printStackTrace();
	   response.sendRedirect("response.jsp");
	}
%>
