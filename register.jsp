<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psCountry=null;
		ResultSet rsCountry=null;
		
		PreparedStatement psCity=null;
		ResultSet rsCity=null;
		
		PreparedStatement psLocation=null;
		ResultSet rsLocation=null;
		
		try{
		    String sqlCountry="SELECT * FROM countrymaster c ";
			psCountry=conn.prepareStatement(sqlCountry);
			rsCountry=psCountry.executeQuery();
			
			String sqlCity="SELECT * FROM citymaster c";
			psCity=conn.prepareStatement(sqlCity);
			rsCity=psCity.executeQuery();
			
			String sqlLocation="SELECT * FROM locationmaster c";
			psLocation=conn.prepareStatement(sqlLocation);
			rsLocation=psLocation.executeQuery();
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
<title>Real Estate Registration</title>
<script>
function trim(s) 
{
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}

function validateEmail(emailValue) 
{
	var objRegExp  = /(^[a-z]([a-z_\.]*)@([a-z_\.]*)([.][a-z]{3})$)|(^[a-z]([a-z_\.]*)@([a-z_\.]*)(\.[a-z]{3})(\.[a-z]{2})*$)/i;

    return objRegExp.test(emailValue);
}

function validate()
{
		var str=/^[A-Za-z][.A-Za-z ]{0,100}$/;

		if((trim(document.frm.sFirstName.value)=="") || str.test(trim(document.frm.sFirstName.value))==false)
		{
			alert("Please fill your first name and should be characters only");
			document.frm.sFirstName.focus();
			return false;
		}
		else if(trim(document.frm.sLastName.value)=="" || str.test(trim(document.frm.sLastName.value))==false)
		{
			alert("Please fill last name value and should be characters only");
			document.frm.sLastName.focus();
			return false;
		}
		else if(trim(document.frm.iCountryID.value)=="")
		{
			alert("Select Country");
			document.frm.iCountryID.focus();
			return false;
		}
		else if(trim(document.frm.iCityID.value)=="")
		{
			alert("Please fill city value");
			document.frm.iCityID.focus();
			return false;
		}
		else if(trim(document.frm.iLocation.value)=="")
		{
			alert("Please fill location value");
			document.frm.iLocation.focus();
			return false;
		}
		else if((trim(document.frm.sRegEmail.value)=="") || validateEmail(document.frm.sRegEmail.value)==false)
		{
			alert("Please fill email value and should be email format");
			document.frm.sRegEmail.focus();
			return false;
		}
		else if(trim(document.frm.dd.value)=="DD" || (trim(document.frm.dd.value)<1) || (trim(document.frm.dd.value)>31))
		{
			alert("Please fill date of birth value");
			document.frm.dd.focus();
			return false;
		}
		else if(trim(document.frm.yyyy.value)=="YYYY" || trim(document.frm.yyyy.value).length<4)
		{
			alert("Please fill date of birth value");
			document.frm.yyyy.focus();
			return false;
		}
		else if(trim(document.frm.sRegGender.value)=="")
		{
			alert("Please fill gender value");
			document.frm.sRegGender.focus();
			return false;
		}
		else if(trim(document.frm.iUserContact.value)=="")
		{
			alert("Please fill contact value");
			document.frm.iUserContact.focus();
			return false;
		}
		else if(trim(document.frm.sUserID.value)=="")
		{
			alert("Please fill username value");
			document.frm.sUserID.focus();
			return false;
		}
		else if(trim(document.frm.sPassword.value)=="")
		{
			alert("Please fill password value");
			document.frm.sPassword.focus();
			return false;
		}
		else if(trim(document.frm.sCPassword.value)=="")
		{
			alert("Please fill your confirmation password");
			document.frm.sCPassword.focus();
			return false;
		}
		
		if(trim(document.frm.sPassword.value)!=trim(document.frm.sCPassword.value)!="")
		{
		    alert("Password and confirmation password is not matched");
			document.frm.sCPassword.focus();
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

function init()
{
	  document.frm.sFirstName.focus();
}
</script>
</head>

<body onload="init()">
<form name="frm" action="regVillaMart.jsp" method="post" onsubmit="return validate()" >
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
   <td colspan="2" valign="top"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
    <tr>
      <td width="22%" valign="top">&nbsp;</td>
      <td width="78%" valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2"><h3>REGISTRATION FORM</h3></td>
    </tr>
	<tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	<tr>
      <td colspan="2"><h4>Business Information</h4></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	 <tr>
      <td>User Profile</td>
      <td><select name="iUserLevel" class="smalldropdown" >
          <option value="1">Individual User</option>
          <option value="2">Agent/Brokers</option>
		  <option value="3">Builder</option>
		  <option value="4">Corporate</option>
        </select></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2"><h4>Personal Information</h4></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>First Name: </td>
      <td><input type="text" name="sFirstName"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Last Name: </td>
      <td><input type="text" name="sLastName"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	<tr>
      <td>Country:</td>
      <td><select name="iCountryID" class="smalltextbox">
          <option value="" >-- Select Country --</option>
     <%
     while (rsCountry.next())
     {
      %>
      <option value="<%=rsCountry.getInt("iCountryID") %>"><%=rsCountry.getString("sCountryName")%></option>
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
      <td>Location:</td>
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
        </select> </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>E-mail:</td>
      <td><input type="text" name="sRegEmail"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Date of Birth: </td>
      <td><input  type="text"  name="dd" maxlength="2"   class="smallesttextbox"  value='DD'  style='width:30px;' onKeyPress="return isNumberKey(event)"/>
        <select name="mm"  class="smalldropdown" >
          <option value = '01' >Jan </option>
          <option value = '02' >Feb </option>
          <option value = '03' >Mar </option>
          <option value = '04' >Apr </option>
          <option value = '05' >May </option>
          <option value = '06' >Jun </option>
          <option value = '07' >Jul </option>
          <option value = '08' >Aug </option>
          <option value = '09' >Sep </option>
          <option value = '10' >Oct </option>
          <option value = '11' >Nov </option>
          <option value = '12' >Dec </option>
        </select>
    <input type="text" name="yyyy" maxlength="4" class="smallesttextbox" value="YYYY" style='width:45px;'  onKeyPress="return isNumberKey(event)"/>    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Gender:</td>
      <td><select name="sRegGender" class="smalldropdown" >
          <option value="Male">Male</option>
          <option value="Female" >Female</option>
        </select>      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Contact No: </td>
      <td><input type="text" name="iUserContact" onKeyPress="return isNumberKey(event)"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
	<tr>
  <td colspan="2" valign="top"><h4>User Login Information</h4></td>
  </tr>
<tr>
    <td width="22%">&nbsp;</td>
    <td width="78%">&nbsp;</td>
  </tr>
   <tr>
    <td>Create Username* : </td>
    <td><input type="sUserID" name="sUserID"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td>Password * : </td>
    <td><input type="password" name="sPassword"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Confirm Password * : </td>
    <td><input type="password" name="sCPassword"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="Register" /></td>
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
<script>callETabID('2')</script>
</body>
</html>
<%
	try{
	     if(psCountry!=null){
			 psCountry.close();
		 }
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