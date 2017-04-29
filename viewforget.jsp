<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	PreparedStatement psForgetPassword=null;
	ResultSet rsForgetPassword=null;
	
	try{
		String sqlForgetPassword="SELECT f.iForgetID, r.sUserID, r.sRegEmail, r.sFirstName, r.sLastName," 
								  +"r.iUserType,  f.sRandPwd, r.sStatus "
								  +" FROM forget_password f"  
								  +"  left join registration r on r.sRegEmail=f.sEmailID"
								  +"   order by iForgetID desc";
		psForgetPassword=conn.prepareStatement(sqlForgetPassword);
		System.out.println("sqlForgetPassword :"+sqlForgetPassword);
		rsForgetPassword=psForgetPassword.executeQuery();
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>View Forget Password Request</title>
<script>
function goRecord(obID) 
{
   window.open("pwdStringSendEmail.jsp?i="+obID,"_self")
}
</script>
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
        <td width="75%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="3"><h3>View Forget </h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="br">
  <tr>
    <td width="39%" class="hspry">Email ID</td>
    <td width="22%" class="hspry">User ID</td>
    <td width="28%" class="hspry">password</td>
    <td width="11%" class="hspry">Status</td>
  </tr>
     <%
	 boolean bCntRows=false;
     while (rsForgetPassword.next())
     {
	  bCntRows=true;
      %>
  <tr>
    <td onclick="goRecord('<%=rsForgetPassword.getInt("iForgetID") %>')" class="pd"><%=nullconv(rsForgetPassword.getString("sRegEmail"))%>&nbsp;</td>
    <td onclick="goRecord('<%=rsForgetPassword.getInt("iForgetID") %>')" class="pd"><%=nullconv(rsForgetPassword.getString("sUserID"))%>&nbsp;</td>
    <td onclick="goRecord('<%=rsForgetPassword.getInt("iForgetID") %>')" class="pd"><%=nullconv(rsForgetPassword.getString("sRandPwd"))%>&nbsp; </td>
    <td onclick="goRecord('<%=rsForgetPassword.getInt("iForgetID") %>')" class="pd"><%=nullconv(rsForgetPassword.getString("sStatus"))%>&nbsp;</td>
  </tr>
    <%
	}
	if(bCntRows==false)
	{
	  %>
	<tr>
   		<td colspan="4" align="center">No Records Found</td>
    </tr>
	  <%
	}
	%>
</table></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table></td>
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
		 if(rsForgetPassword!=null){
			 rsForgetPassword.close();
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