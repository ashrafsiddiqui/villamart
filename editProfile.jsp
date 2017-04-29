<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn = null;
	conn=dbConn.getConnection();
	
	PreparedStatement psEditProfile=null;
	
	String sFirstName=request.getParameter("sFirstName");
	String sLastName=request.getParameter("sLastName");
	String iCityID=request.getParameter("iCityID");
	String iLocation=request.getParameter("iLocation");
	String sRegEmail=request.getParameter("sRegEmail");
	String dd=request.getParameter("dd");
	String mm=request.getParameter("mm");
	String yyyy=request.getParameter("yyyy");
	String iDateBirth=yyyy+"-"+mm+"-"+dd;
	String sRegGender=request.getParameter("sRegGender");
	String iUserContact=request.getParameter("iUserContact");
	String sUserID=request.getParameter("sUserID");
	String sPassword=request.getParameter("sPassword");
	String sCPassword=request.getParameter("sCPassword");
	String sStatus=request.getParameter("sStatus");
	
	String sModifiedBy=nullconv((String)session.getAttribute("sUserID"));
	
	String sqlEditProfile=null;
	
	try{
		sqlEditProfile="update registration set sRegEmail=?, sFirstName=?, sLastName=?, iDateBirth=?, sRegGender=?, iCityID=?, iLocation=?, iUserContact=?, sModifiedBy=?, sModifiedDate=sysdate() where sUserID=?";
		psEditProfile=conn.prepareStatement(sqlEditProfile);
		psEditProfile.setString(1,sRegEmail);
		psEditProfile.setString(2,sFirstName);
		psEditProfile.setString(3,sLastName);
		psEditProfile.setString(4,iDateBirth);
		psEditProfile.setString(5,sRegGender);
		psEditProfile.setString(6,iCityID);
		psEditProfile.setString(7,iLocation);
		psEditProfile.setString(8,iUserContact);
		psEditProfile.setString(9,sModifiedBy);
		psEditProfile.setString(10,sModifiedBy);
		psEditProfile.executeUpdate();
	}
	catch(Exception e)
	{
	   e.printStackTrace();
	   response.sendRedirect("myProfile.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Edit Profile Successful</title>
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
        <td width="75%" valign="top"><h2>Profile is Updated successfully!</h2></td>
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
		 if(psEditProfile!=null){
			 psEditProfile.close();
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