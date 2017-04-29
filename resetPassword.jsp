<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%
    Connection conn = null;
	conn=dbConn.getConnection();
	
	String sEmail=request.getParameter("e");
	String sRandPwd=request.getParameter("p");
	
	PreparedStatement psProfile=null;
	ResultSet rsProfile=null;
	
	try{
		String sqlProfile="SELECT sUserID FROM registration r where sRegEmail=? and sForgetPassword=password(?) and sStatus='A'";
		psProfile=conn.prepareStatement(sqlProfile);
		psProfile.setString(1,sEmail);
		psProfile.setString(2,sRandPwd);
		rsProfile=psProfile.executeQuery();
		
		if(!(rsProfile.next()))
		{
		 int c=1/0;
		}
	}
	catch(Exception e)
	{
	   e.printStackTrace();
	   response.sendRedirect("errorReset.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Change password</title>
<script>
function trim(s) 
{
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}

function validateReset()
{
	if(trim(document.frm.sPwd.value)==""){
	  alert("Password cannot be left blank");
	  document.frm.sPwd.focus();
	  return false;
	}
	else if(trim(document.frm.sCPwd.value)==""){
	  alert("Confirm Password cannot be left blank");
	  document.frm.sCPwd.focus();
	  return false;
	}
	else if(trim(document.frm.sPwd.value)!=trim(document.frm.sCPwd.value)){
	  alert("Password and Confirm Password are not matched");
	  document.frm.sPwd.focus();
	  return false;
	}
	
	if((document.frm.sPwd.value.length<5)){
	  alert("Password length must be more than 6 characters");
	  document.frm.sPwd.focus();
	  return false;
	}
}	
</script>
</head>

<body>
<form name="frm" action="saveResetPassword.jsp" method="post" onSubmit="return validateReset();">
<input type="hidden" name="sEmail" value="<%=sEmail%>" />
<input type="hidden" name="sRandPwd" value="<%=sRandPwd%>" />
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
    <td width="23%">&nbsp;</td>
    <td width="77%"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2"><h2>Change Password</h2></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>New Password </td>
    <td><input type="password" name="sPwd"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Confirm Password </td>
    <td><input type="password" name="sCPwd"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Change Password" /></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
</form>
</body>
</html>

<%
	try{
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
