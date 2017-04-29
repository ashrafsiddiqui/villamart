<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		String iStateID=request.getParameter("iStateID");
		String sStateName="";
		String iCountryID="";
		
		PreparedStatement psCountry=null;
		ResultSet rsCountry=null;
		
		PreparedStatement psState=null;
		ResultSet rsState=null;
		
		
		String sqlCountry="SELECT * FROM countrymaster c ";
		psCountry=conn.prepareStatement(sqlCountry);
		rsCountry=psCountry.executeQuery();
		
		String sqlState="SELECT sStateName,iCountryID FROM statemaster c where iStateID="+nullIntconv(iStateID)+" ";
		psState=conn.prepareStatement(sqlState);
		rsState=psState.executeQuery();
		if(rsState.next())
		{
		  sStateName=rsState.getString("sStateName");
		  iCountryID=nullconv(rsState.getString("iCountryID"));
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Edit State</title>
<script>
	function validate()
	{
		var chge="Are you sure to Edit Record!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
		if(document.frm.sStateName.value=="")
		{
			alert("Please fill Country name");
			document.frm.sStateName.focus();
			return false;
		}
		if(document.frm.iCountryID.value=="")
		{
			alert("Please fill Country name");
			document.frm.iCountryID.focus();
			return false;
		}
	} 
	function cancalit()
	{
		window.open("viewState.jsp","_self")
	}
	
	function deleteRecord()
	{
	 var chge="Are you sure to Delete Record!";
	 if(confirm(chge)==true)
	 {  
	   document.frm.action="deleteState.jsp"
	   document.frm.submit();
	 }
	}
</script>  
</head>

<body>
<form name="frm" action="saveEState.jsp" onSubmit="return validate()">
<input type="hidden" name="iStateID" value="<%=iStateID%>">
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
    <td width="16%">&nbsp;</td>
    <td width="84%"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2"><h3>Edit State</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>State Name</td>
    <td><input type="text" name="sStateName" value="<%=sStateName%>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Country Under</td>
    <td><select name="iCountryID" class="smalltextbox">
          <option value="" >-- Select Country --</option>
     <%
     while (rsCountry.next())
     {
	  if(rsCountry.getInt("iCountryID")==nullIntconv(iCountryID))
	  {
	  %>
      <option value="<%=rsCountry.getInt("iCountryID") %>" selected="selected"><%=rsCountry.getString("sCountryName")%></option>
      <%
	  }
	  else
	  {
	  %>
      <option value="<%=rsCountry.getInt("iCountryID") %>"><%=rsCountry.getString("sCountryName")%></option>
      <%
	  }
      %>
      
      <%
      }
      %>
    </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="11%"><input type="submit" name="Submit" value="Edit" /></td>
    <td width="31%"><input type="button" name="cancel" value="Cancel" onclick="cancalit()"/></td>
    <td width="50%"><input type="button" name="delete" value="Delete" onclick="deleteRecord()"/></td>
    <td width="8%">&nbsp;</td>
  </tr>
</table></td>
  </tr>
  <tr>
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
</form>
</body>
</html>
<%
	try{
		 if(psCountry!=null){
			 psCountry.close();
		 }
		 if(psState!=null){
			 psState.close();
		 }
		 if(rsCountry!=null){
			 rsCountry.close();
		 }
		 if(rsState!=null){
			 rsState.close();
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