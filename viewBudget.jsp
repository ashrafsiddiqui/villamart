<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psBudget=null;
		ResultSet rsBudget=null;
		
		try{
			String sqlBudget="SELECT * FROM budgetmaster b";
			psBudget=conn.prepareStatement(sqlBudget);
			rsBudget=psBudget.executeQuery();
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
<title>View Budget</title>
<script>
	function goRecord(iBudgetID)
	{
	  window.open("editBudget.jsp?iBudgetID="+iBudgetID,"_self")
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
    <td colspan="3"><h3>View Budget</h3></td>
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
          <td class="hspry">Budget Name</td>
		  <td class="hspry">Minimum Budget</td>
		  <td class="hspry">Maximum Budget</td>
        </tr>
        <%
     while (rsBudget.next())
     {
      %>
        <tr>
          <td onclick="goRecord('<%=rsBudget.getInt("iBudgetID") %>')" style="padding-left:5px; cursor:pointer"><%=rsBudget.getString("sBudgetName")%></td>
          <td onclick="goRecord('<%=rsBudget.getInt("iBudgetID") %>')" style="padding-left:5px; cursor:pointer"><%=rsBudget.getString("iMinBudget")%></td>
          <td onclick="goRecord('<%=rsBudget.getInt("iBudgetID") %>')" style="padding-left:5px; cursor:pointer"><%=rsBudget.getString("iMaxBudget")%></td>
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
		 if(psBudget!=null){
			 psBudget.close();
		 }
		 if(rsBudget!=null){
			 rsBudget.close();
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