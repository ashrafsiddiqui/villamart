<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%
	Connection conn = null;
	conn=dbConn.getConnection();

	PreparedStatement psInsertPwd=null;
	PreparedStatement psDeletePwd=null;
	
	String sEmail=request.getParameter("sEmail");
	String sRandPwd=request.getParameter("sRandPwd");
	
	String sPassword=request.getParameter("sPwd");
	String sOldPwd=request.getParameter("sCPwd");
	
	String sqlUpdateRegistration=null;
	String sqlDeleteForgetPassword=null;
	
	PreparedStatement psProfile=null;
	ResultSet rsProfile=null;
	conn.setAutoCommit(false);
	try{
		String sqlProfile="SELECT sUserID FROM registration r where sRegEmail=? and sForgetPassword=password(?) and sStatus='A'";
		psProfile=conn.prepareStatement(sqlProfile);
		psProfile.setString(1,sEmail);
		psProfile.setString(2,sRandPwd);
		rsProfile=psProfile.executeQuery();
		
		if(rsProfile.next())
		{
		 sqlUpdateRegistration="update registration set sPassword=password('"+sPassword+"'), sForgetPassword='', sModifiedBy='self', sModifiedDate=sysdate() where sRegEmail='"+sEmail+"'";
		 psInsertPwd=conn.prepareStatement(sqlUpdateRegistration);
		 psInsertPwd.executeUpdate();
		 
		 sqlDeleteForgetPassword="delete from forget_password where sEmailID=? and sRandPwd=?";
		 psDeletePwd=conn.prepareStatement(sqlDeleteForgetPassword);
		 psDeletePwd.setString(1,sEmail);
		 psDeletePwd.setString(2,sRandPwd);
		 psDeletePwd.executeUpdate();
		 
		 conn.commit();
		}
		else{
		 int c=1/0;
		}
	}
	catch(Exception e)
	{
	   e.printStackTrace();
	   response.sendRedirect("resetPassword.jsp?e="+sEmail+"&p="+sRandPwd);
	}
	finally
	{
	  conn.setAutoCommit(true);
	}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Change Password</title>
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
        <td width="75%" valign="top"><h2>Password is changed successfully!</h2></td>
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
		 if(psInsertPwd!=null){
			 psInsertPwd.close();
		 }
		 if(psProfile!=null){
			 psProfile.close();
		 }
		 if(psProfile!=null){
			 psProfile.close();
		 }
		 
		 if(psDeletePwd!=null){
			 psDeletePwd.close();
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