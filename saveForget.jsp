<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Random" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%
	Connection conn = null;
	conn=dbConn.getConnection();
	
	PreparedStatement psProfile=null;
	ResultSet rsProfile=null;
	
	Random rNumber = new Random();
	
	long getRdm = 	Math.abs(rNumber.nextLong());
	
	String sEmailID=nullconv(request.getParameter("emailID"));  
	PreparedStatement psForgetPassword=null;
	PreparedStatement psGenerateForgetPassword=null;
	
	try{
	    String sqlProfile="SELECT sUserID FROM registration r where sRegEmail=? and sStatus='A'";
		psProfile=conn.prepareStatement(sqlProfile);
		psProfile.setString(1,sEmailID);
		rsProfile=psProfile.executeQuery();
		
		if((rsProfile.next()))
		{
			String sqlForgetPassword="insert into forget_password (sEmailID,sRandPwd, sStatus) values('"+sEmailID+"','"+getRdm+"','P')";
			psForgetPassword=conn.prepareStatement(sqlForgetPassword);
			psForgetPassword.executeUpdate();
			
			String sqlGenerateForgetPassword="update registration set sForgetPassword=password(?) where sRegEmail='"+sEmailID+"'";
			psGenerateForgetPassword=conn.prepareStatement(sqlGenerateForgetPassword);
			psGenerateForgetPassword.setLong(1,getRdm);
			psGenerateForgetPassword.executeUpdate();
		}
		else
		{
		  response.sendRedirect("forget.jsp?error=No Email Found");
		  return;
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
		response.sendRedirect("forget.jsp");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Forget Password</title>
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
        <td width="75%" valign="top"><h2>Wait New Password will send on you Email ID </h2></td>
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
		 if(psForgetPassword!=null){
			 psForgetPassword.close();
		 }
		 if(psGenerateForgetPassword!=null){
			 psGenerateForgetPassword.close();
		 }
		 if(psProfile!=null){
			 psProfile.close();
		 }
		 
		 if(rsProfile!=null){
			 rsProfile.close();
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