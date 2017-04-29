<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	Statement stDoPosting=null;
	ResultSet rsDoPosting=null;
	
	stDoPosting = conn.createStatement();

	String iTransactionType=request.getParameter("tranType");
	String iPropertyID=request.getParameter("propertyType");
	String iCityID=request.getParameter("iCityID");
	String iLocalityID=request.getParameter("iLocation");
	String iArea=request.getParameter("iArea");
	String iBudgetID=request.getParameter("iBudgetID");
	String iBedroom=request.getParameter("bedroom");
	String iNFloor=request.getParameter("floornumber");
	
	String sqlInsertpost_requirement=null;
	
	String sSessionUserID=(String)session.getAttribute("sUserID");
	
	PreparedStatement psPostApprovalOption=null;
	ResultSet rsPostApprovalOption=null;
	
	String appYes="A";
	
	try{
		String sqlPostApprovalOption="SELECT cIsApprovalNeed FROM post_approval";
		psPostApprovalOption=conn.prepareStatement(sqlPostApprovalOption);
		rsPostApprovalOption=psPostApprovalOption.executeQuery();
		
		if(rsPostApprovalOption.next())
		{
		  appYes=rsPostApprovalOption.getString("cIsApprovalNeed");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	try{
	
	sqlInsertpost_requirement="insert into post_requirement(sUserID, iTransactionType, iPropertyID, iCityID, iLocalityID, iArea, iBudgetID, iBedroom, cStatus, sCreatedBy, dCreatedDate)"
								+"values('"+sSessionUserID+"', '"+iTransactionType+"', '"+iPropertyID+"','"+iCityID+"', '"+iLocalityID+"', '"+iArea+"', '"+iBudgetID+"','"+iBedroom+"','"+appYes+"', 'Admin', sysdate())";
	
    stDoPosting.executeUpdate(sqlInsertpost_requirement);
	}
	catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("create-posting.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Saved Post</title>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="90%"><div class="header"><%@ include file="comman/header.jsp"%></div></td>
    <td width="5%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><%@ include file="comman/logo.jsp"%></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><%@include file="/comman/menu.jsp"%></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="20%" valign="top"><div id="leftbar"><%@include file="menu.jsp" %></div></td>
        <td width="5%" valign="top">&nbsp;</td>
        <td width="75%" valign="top"><h3>Post Requirement is saved successfully!</h3></td>
      </tr>
    </table></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div class="footer"><%@ include file="comman/footer.jsp"%></div></td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
	try{
		 if(stDoPosting!=null){
			 stDoPosting.close();
		 }
		 
		 if(psPostApprovalOption!=null){
			 psPostApprovalOption.close();
		 }
		 
		 if(rsPostApprovalOption!=null){
			 rsPostApprovalOption.close();
		 }
		 
		 if(conn!=null){
		  conn.close();
		 }
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>