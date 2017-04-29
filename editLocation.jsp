<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		String iLocationID=request.getParameter("iLocationID");
		String sLocationName="";
		String iCityID="";
		
		PreparedStatement psCity=null;
		ResultSet rsCity=null;
		
		PreparedStatement psLocation=null;
		ResultSet rsLocation=null;
		
		
		String sqlCity="SELECT * FROM citymaster c ";
		psCity=conn.prepareStatement(sqlCity);
		rsCity=psCity.executeQuery();
		
		String sqlLocation="SELECT iLocationName,iCityID FROM locationmaster c where iLocationID="+nullIntconv(iLocationID)+" ";
		psLocation=conn.prepareStatement(sqlLocation);
		rsLocation=psLocation.executeQuery();
		if(rsLocation.next())
		{
		  sLocationName=rsLocation.getString("iLocationName");
		  iCityID=nullconv(rsLocation.getString("iCityID"));
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Edit Location</title>
<script>
	function validate()
	{
		var chge="Are you sure to Edit Record!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
		if(document.frm.sLocationName.value=="")
		{
			alert("Please fill city name");
			document.frm.sCityName.focus();
			return false;
		}
		if(document.frm.sCityName.value=="")
		{
			alert("Please fill city name");
			document.frm.sCityName.focus();
			return false;
		}
	} 
	function cancalit()
	{
		window.open("viewLocation.jsp","_self")
	}
	
	function deleteRecord()
	{
	 var chge="Are you sure to Delete Record!";
	 if(confirm(chge)==true)
	 {  
	 document.frm.action="deleteLocation.jsp"
	 document.frm.submit();
	 }
	}
</script> 
</head>

<body>
<form name="frm" action="saveELocation.jsp" onSubmit="return validate()">
<input type="hidden" name="iLocationID" value="<%=iLocationID%>">
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
    <td width="22%">&nbsp;</td>
    <td width="78%"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2"><h3>Edit Location</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Location Name</td>
    <td><input type="text" name="sLocationName" value="<%=sLocationName%>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>City Under</td>
    <td><select name="iCityID" class="smalltextbox">
        <option value="" >-- Select City --</option>
         <%
		 while (rsCity.next())
		 {
		  if(rsCity.getInt("iCityID")==nullIntconv(iCityID))
		  {
		  %>
			<option value="<%=rsCity.getInt("iCityID") %>" selected="selected"><%=rsCity.getString("iCityName")%></option>
			<%
		  }
		  else
		  {
		  %>
			<option value="<%=rsCity.getInt("iCityID") %>"><%=rsCity.getString("iCityName")%></option>
		  <%
		  }
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
             if(psCity!=null){
                 psCity.close();
             }
			 if(psLocation!=null){
                 psLocation.close();
             }
             if(rsCity!=null){
                 rsCity.close();
             }
			 if(rsLocation!=null){
                 rsLocation.close();
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