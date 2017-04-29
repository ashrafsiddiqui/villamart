<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn = null;
	conn=dbConn.getConnection();

	PreparedStatement psInsertPwd=null;
	
	String sPassword=request.getParameter("sPassword");
	String sOldPwd=request.getParameter("sOldPwd");
	String sModifiedBy=nullconv((String)session.getAttribute("sUserID"));
	
	String sqlUpdateRegistration=null;
	
	PreparedStatement psProfile=null;
	ResultSet rsProfile=null;
	
	try{
		String sqlProfile="SELECT sUserID FROM registration r where sUserID='"+sModifiedBy+"' and sPassword=password('"+sOldPwd+"')";
		psProfile=conn.prepareStatement(sqlProfile);
		rsProfile=psProfile.executeQuery();
		
		if(rsProfile.next())
		{
		 sqlUpdateRegistration="update registration set sPassword=password('"+sPassword+"'), sModifiedBy='"+sModifiedBy+"', sModifiedDate=sysdate() where sUserID='"+sModifiedBy+"'";
		 psInsertPwd=conn.prepareStatement(sqlUpdateRegistration);
		 psInsertPwd.executeUpdate();
		}
		else{
		 int c=1/0;
		}
	}
	catch(Exception e)
	{
	   e.printStackTrace();
	   response.sendRedirect("chgPwd.jsp");
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