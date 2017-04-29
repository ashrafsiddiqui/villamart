<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	String iCountryID=request.getParameter("iCountryID");
	
	PreparedStatement psCountry=null;
	ResultSet rsCountry=null;
	
	String sCountryName="";
	
	try{
		String sqlCountry="SELECT sCountryName FROM countrymaster c where iCountryID="+nullIntconv(iCountryID)+"";
		psCountry=conn.prepareStatement(sqlCountry);
		rsCountry=psCountry.executeQuery();
		if(rsCountry.next())
		{
		  sCountryName=rsCountry.getString("sCountryName");
		}
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
<title>Edit Country</title>
<script>
	function validate()
	{
		var chge="Are you sure to Edit Record!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
		if(document.frm.sCountryName.value=="")
		{
			alert("Please fill Country name");
			document.frm.sCountryName.focus();
			return false;
		}
	} 
	function cancalit()
	{
	 window.open("viewCountry.jsp","_self")
	}
	
	function deleteRecord()
	{
	 var chge="Are you sure to Delete Record!";
	 if(confirm(chge)==true)
	 {  
	 document.frm.action="deleteCountry.jsp"
	 document.frm.submit();
	 }
	}
</script>  
</head>

<body>
<form name="frm" action="saveECountry.jsp" onSubmit="return validate()">
<input type="hidden" name="iCountryID" value="<%=iCountryID%>">
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
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><h3>Edit Country</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Country Name</td>
    <td><input type="text" name="sCountryName" value="<%=sCountryName%>"/></td>
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
</table>
      </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
		 if(rsCountry!=null){
			 rsCountry.close();
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