<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	Statement stList=null;
	stList = conn.createStatement();

	String iTransactionType=request.getParameter("tranType");
	String iPropertyID=request.getParameter("propertyType");
	String sPropertyAddress=request.getParameter("sPropertyAddress");
	String iCityID=request.getParameter("iCityID");
	String iLocalityID=request.getParameter("iLocation");
	String iArea=request.getParameter("iArea");
	String iTotalPrice=request.getParameter("iTotalPrice");
	String cPriceNegotiable=request.getParameter("cPriceNegotiable");
	String iBedroom=request.getParameter("bedroom");
	String iNFloor=request.getParameter("floornumber");
	
	String sqlInsertlist_requirement=null;
	
	String sSessionUserID=(String)session.getAttribute("sUserID");
	
	PreparedStatement psListApprovalOption=null;
	ResultSet rsListApprovalOption=null;
	
	String appYes="A";
	
	try{
		String sqlListApprovalOption="SELECT cIsApprovalNeed FROM list_approval";
		psListApprovalOption=conn.prepareStatement(sqlListApprovalOption);
		rsListApprovalOption=psListApprovalOption.executeQuery();
		
		if(rsListApprovalOption.next())
		{
		  appYes=rsListApprovalOption.getString("cIsApprovalNeed");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
	
	try{
		sqlInsertlist_requirement="insert into list_requirement(sUserID, iTransactionType, iPropertyID, sPropertyAddress, iCityID, iLocalityID, iArea, iTotalPrice, iBedRoom, iNFloor, cPriceNegotiable, cStatus, sCreatedBy, dCreatedDate)"
									+"values('"+sSessionUserID+"', '"+iTransactionType+"', '"+iPropertyID+"', '"+sPropertyAddress+"', '"+iCityID+"', '"+iLocalityID+"', '"+iArea+"', '"+iTotalPrice+"', '"+iBedroom+"', '"+iNFloor+"', '"+cPriceNegotiable+"','"+appYes+"', '"+sSessionUserID+"', sysdate())";
		
		stList.executeUpdate(sqlInsertlist_requirement);
	}
	catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("create-listing.jsp");
	}
%>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>list</title>
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
        <td width="75%" valign="top"><h2>Property Listing is saved successfully!</h2></td>
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
		 if(stList!=null){
			 stList.close();
		 }
		 if(psListApprovalOption!=null){
			 psListApprovalOption.close();
		 }
		 
		 if(rsListApprovalOption!=null){
			 rsListApprovalOption.close();
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