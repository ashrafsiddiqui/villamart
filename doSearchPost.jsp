<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();

	ResultSet rsBudget=null;
	PreparedStatement psBudget=null;
	
	PreparedStatement psCity=null;
	ResultSet rsCity=null;
	
	PreparedStatement psLocation=null;
	ResultSet rsLocation=null;
	
	PreparedStatement psProperty=null;
	ResultSet rsProperty=null;
	
	try{
		String sqlBudget="SELECT * FROM budgetmaster u ";
		psBudget=conn.prepareStatement(sqlBudget);
		rsBudget=psBudget.executeQuery();
		
		String sqlCity="SELECT * FROM citymaster c ";
		psCity=conn.prepareStatement(sqlCity);
		rsCity=psCity.executeQuery();
		
		String sqlLocation="SELECT * FROM locationmaster c ";
		psLocation=conn.prepareStatement(sqlLocation);
		rsLocation=psLocation.executeQuery();
		
		String sqlProperty="SELECT * FROM propertymaster c ";
		psProperty=conn.prepareStatement(sqlProperty);
		rsProperty=psProperty.executeQuery();
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
<title>Search post</title>
<script>
function validate()
{
		if(document.frm.tranType.value=="")
		{
			alert("Please fill the transaction type");
			document.frm.tranType.focus();
			return false;
		}
}

function isNumberKey(evt)
{
 var charCode = (evt.which) ? evt.which : event.keyCode

  if (charCode > 31 && (charCode < 48 || charCode > 57))
  {	
	return false;
  }
 return true;
}
</script>
</head>

<body>
<form name="frm" action="searchPost.jsp" method="post" onsubmit="return validate()">
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
    <td>&nbsp;</td>
    <td><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2"><h5>Search Post  Requirement</h5></td>
  </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Transaction Type: </td>
    <td><select name="tranType">
        <option value="1">Buy</option>
        <option value="2">Rent / Lease</option>
      </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Property Type: </td>
    <td><select name="propertyType">
        <option value="" >-- Select Property --</option>
        <%
		 while (rsProperty.next())
		 {
		%>
          <option value="<%=rsProperty.getInt("iPropertyID") %>"><%=rsProperty.getString("sPropertyName")%></option>
        <%
		 }
		%>
      </select>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>City:</td>
    <td><select name="iCityID" class="smalltextbox">
        <option value="" >-- Select City --</option>
        <%
        while (rsCity.next())
        {
        %>
        <option value="<%=rsCity.getInt("iCityID") %>"><%=rsCity.getString("iCityName")%></option>
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
    <td>Locality:</td>
    <td><select name="iLocation" class="smalltextbox" id="iLocation" style="width:150px;">
        <option value="" >-- Select Location --</option>
        <%
       while (rsLocation.next())
       {
       %>
        <option value="<%=rsLocation.getInt("iLocationID") %>"><%=rsLocation.getString("iLocationName")%></option>
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
    <td>Area:</td>
    <td><input type="text" name="iArea" onKeyPress="return isNumberKey(event)"/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sq.Ft</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Budget: </td>
    <td>
      <select name="iBudgetID">
        <option value="">-- Select Budget --</option>
        <%
	   while(rsBudget.next())
	   {
	   %>
        <option value="<%=rsBudget.getInt("iBudgetID")%>"><%=rsBudget.getString("sBudgetName")%></option>
       <%
	   }
       %>
      </select>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Bedroom:</td>
    <td><select name='bedroom'>
        <option value="">Select Room</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11+</option>
      </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Floor Number: </td>
    <td><select name='floornumber'>
        <option value="1">Basement</option>
        <option value="2">Ground Floor</option>
        <option value="3">1</option>
        <option value="4">2</option>
        <option value="5">3</option>
        <option value="6">4</option>
        <option value="7">5</option>
        <option value="8">6</option>
        <option value="9">7</option>
        <option value="10">8</option>
        <option value="11">9</option>
        <option value="12">10</option>
        <option value="13">10+</option>
      </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Search" />
      <input type="reset" name="Reset" value="Reset" />
    </td>
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
		 if(psProperty!=null){
			 psProperty.close();
		 }
		 if(psBudget!=null){
			 psBudget.close();
		 }
		 
		 if(rsCity!=null){
			 rsCity.close();
		 }
		 if(rsLocation!=null){
			 rsLocation.close();
		 }
		 if(rsProperty!=null){
			 rsProperty.close();
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