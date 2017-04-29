<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%
		Connection conn = null;
		conn=dbConn.getConnection();
		
		PreparedStatement psInsert=null;
		
		String sFirstName=request.getParameter("sFirstName");
		String sLastName=request.getParameter("sLastName");
		String iCountryID=request.getParameter("iCountryID");
		String iCityID=request.getParameter("iCityID");
		String iLocation=request.getParameter("iLocation");
		String sRegEmail=request.getParameter("sRegEmail");
		String dd=request.getParameter("dd");
		String mm=request.getParameter("mm");
		String yyyy=request.getParameter("yyyy");
		String iDateBirth=yyyy+"-"+mm+"-"+dd;
		String sRegGender=request.getParameter("sRegGender");
		String iUserLevel=request.getParameter("iUserLevel");
		String iUserContact=request.getParameter("iUserContact");
		String iUserType=request.getParameter("iUserType");
		String sUserID=request.getParameter("sUserID");
		String sPassword=request.getParameter("sPassword");
		String sCPassword=request.getParameter("sCPassword");
		
		String sqlInsertregistration=null;
		
		try{
			sqlInsertregistration="insert into registration (sUserID, sRegEmail, sFirstName, sLastName, iDateBirth, sRegGender,iCountryID, iCityID, iLocation, iUserType, iUserLevel, sPassword, iUserContact,dCreatedDate, sStatus)"
												+"values(?, ?, ?, ?, ?, ?, ?, ?, ?, 3, ?, password('"+sPassword+"'), ?, sysdate(),'P')";
			psInsert=conn.prepareStatement(sqlInsertregistration);
			psInsert.setString(1,sUserID);
			psInsert.setString(2,sRegEmail);
			psInsert.setString(3,sFirstName);
			psInsert.setString(4,sLastName);
			psInsert.setString(5,iDateBirth);
			psInsert.setString(6,sRegGender);
			psInsert.setString(7,iCountryID);
			psInsert.setString(8,iCityID);
			psInsert.setString(9,iLocation);
			psInsert.setString(10,iUserLevel);
			psInsert.setString(11,iUserContact);
			
			psInsert.executeUpdate();
		}
		catch(Exception e)
		{
		   e.printStackTrace();
		   request.setAttribute("error","<span class='sSError'>&nbsp; Registration is not successful, May be User ID already Exists &nbsp; </span>");
		   RequestDispatcher dispatch = request.getRequestDispatcher("/register.jsp");
		   dispatch.forward(request, response);
		}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>User Registration</title>
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
        <td width="7%" valign="top">&nbsp;</td>
        <td width="93%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><h2>Registration Successfully!</h2></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Your registration is under activation process. Your profile will be reviewed for activation. It usually takes approximately 24 - 48 hours.</td>
  </tr>
</table>
</td>
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
		 if(psInsert!=null){
			 psInsert.close();
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