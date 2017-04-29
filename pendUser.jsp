<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psPendingUser=null;
		ResultSet rsPendingUser=null;
		
		String sPendingUser="";
		
		try{
			String sqlPendingUser="SELECT sUserID,  sFirstName, sLastName, iUserType, iUserLevel,dCreatedDate,sStatus FROM registration r order by dCreatedDate desc";
			psPendingUser=conn.prepareStatement(sqlPendingUser);
			rsPendingUser=psPendingUser.executeQuery();
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
<title>List User</title>
<script>
function goRecord(sUserID)
{
  window.open("editPUser.jsp?sUserIDform="+sUserID,"_self")
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
   <td colspan="3"><h3>Pending User Permission</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><%=nullconv((String)request.getAttribute("error"))%></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="br">
  <tr>
    <td width="35%" class="hspry">User Name</td>
    <td width="24%" class="hspry">User type</td>
    <td width="24%" class="hspry">User ID</td>
    <td width="41%" class="hspry">Created Date</td>
    </tr>
     <%
     while (rsPendingUser.next())
     {
	  sPendingUser="";
	  if(rsPendingUser.getString("sStatus").equalsIgnoreCase("P"))
	  {
	    sPendingUser=" class='bgRw'";
	  }
      %>
   <tr>
    <td onclick="goRecord('<%=rsPendingUser.getString("sUserID") %>')" style="padding-left:5px; cursor:pointer" <%=sPendingUser%>><%=nullconv(rsPendingUser.getString("sFirstName"))+" "+nullconv(rsPendingUser.getString("sLastName"))%></td>
    <td onclick="goRecord('<%=rsPendingUser.getString("sUserID") %>')" style="padding-left:5px; cursor:pointer" <%=sPendingUser%>><%if(nullconv(rsPendingUser.getString("iUserType")).equalsIgnoreCase("1")){out.print("Admin Level");} else if(nullconv(rsPendingUser.getString("iUserType")).equalsIgnoreCase("2")){out.print("Power user");} else{out.print("End user");}%></td>
    <td onclick="goRecord('<%=rsPendingUser.getString("sUserID") %>')" style="padding-left:5px; cursor:pointer" <%=sPendingUser%>><%=nullconv(rsPendingUser.getString("sUserID"))%></td>
    <td onclick="goRecord('<%=rsPendingUser.getString("sUserID") %>')" style="padding-left:5px; cursor:pointer" <%=sPendingUser%>><%=getDateFormat(rsPendingUser.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%></td>
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
		 if(psPendingUser!=null){
			 psPendingUser.close();
		 }
		 if(rsPendingUser!=null){
			 rsPendingUser.close();
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