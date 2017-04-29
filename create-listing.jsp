<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<%@ include file="sessionchk.jsp"%>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>

<%
		Connection conn=null;
		conn=dbConn.getConnection();

		PreparedStatement psCity=null;
		ResultSet rsCity=null;
		
		PreparedStatement psLocation=null;
		ResultSet rsLocation=null;
		
		PreparedStatement psProperty=null;
		ResultSet rsProperty=null;
		
		PreparedStatement psCurrency=null;
		ResultSet rsCurrency=null;

		String sCurrency="";

		try{
			String sqlCity="SELECT * FROM citymaster c";
			psCity=conn.prepareStatement(sqlCity);
			rsCity=psCity.executeQuery();
			
			String sqlLocation="SELECT * FROM locationmaster c";
			psLocation=conn.prepareStatement(sqlLocation);
			rsLocation=psLocation.executeQuery();
			
			String sqlProperty="SELECT * FROM propertymaster c";
			psProperty=conn.prepareStatement(sqlProperty);
			rsProperty=psProperty.executeQuery();
			
			String sqlCurrency="SELECT sCurrencyName, sSymbol FROM currency b where sStatus='A'";
			psCurrency=conn.prepareStatement(sqlCurrency);
			rsCurrency=psCurrency.executeQuery();
			if(rsCurrency.next())
			{
			 sCurrency=rsCurrency.getString("sSymbol");
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
<title>Create Listing</title>
<script>
function trim(s) 
{
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}
function validate()
{
		if(document.frm.tranType.value=="")
		{
			alert("Please fill the transaction type");
			document.frm.tranType.focus();
			return false;
		}
		else if(document.frm.propertyType.value=="")
		{
			alert("Please fill type of property");
			document.frm.propertyType.focus();
			return false;
		}
		else if(trim(document.frm.sPropertyAddress.value)=="")
		{
			alert("Please fill address of property");
			document.frm.sPropertyAddress.focus();
			return false;
		}
		else if(document.frm.iCityID.value=="")
		{
			alert("Please fill city column");
			document.frm.iCityID.focus();
			return false;
		}
		else if(document.frm.iLocation.value=="")
		{
			alert("Please fill location value");
			document.frm.iLocation.focus();
			return false;
		}
		else if(document.frm.iArea.value=="")
		{
			alert("Please fill your area value");
			document.frm.iArea.focus();
			return false;
		}
		else if(document.frm.iTotalPrice.value=="")
		{
			alert("Please fill your total price");
			document.frm.iTotalPrice.focus();
			return false;
		}
		else if(document.frm.bedroom.value=="")
		{
			alert("Please fill bedroom value");
			document.frm.bedroom.focus();
			return false;
		}
		else if(document.frm.floornumber.value=="")
		{
			alert("Please fill number of floor value");
			document.frm.floornumber.focus();
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
<form name="frm" action="doListing.jsp" method="post" onsubmit="return validate()">
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
    <td valign="top">&nbsp;</td>
    <td valign="top"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2" valign="top"><h5>List Your Property</h5></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Transaction Type: </td>
    <td><select name="tranType">
        <option value="1">Sell</option>
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
    <td>Property Address: </td>
    <td><input type="text" name="sPropertyAddress"/></td>
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
    <td>Total Price: </td>
    <td><input type="text" name="iTotalPrice" onKeyPress="return isNumberKey(event)"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;in <%=sCurrency%>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Is the price negotiable? </td>
    <td><input name="cPriceNegotiable" type="radio" value="Y" />Yes &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="cPriceNegotiable" type="radio" value="N"  checked="checked"/>No </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Bedroom:</td>
    <td><select name='bedroom'>
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
    <td><input type="submit" name="Submit" value="Save" /></td>
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
		 
		 if(rsCity!=null){
			 rsCity.close();
		 }
		 if(rsLocation!=null){
			 rsLocation.close();
		 }
		 if(rsProperty!=null){
			 rsProperty.close();
		 }
		 if(psCurrency!=null){
			 psCurrency.close();
		 }
		 if(rsCurrency!=null){
			 rsCurrency.close();
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