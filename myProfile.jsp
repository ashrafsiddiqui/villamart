<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();

	PreparedStatement psCity=null;
	ResultSet rsCity=null;
	
	PreparedStatement psLocation=null;
	ResultSet rsLocation=null;
	
	PreparedStatement psProfile=null;
	ResultSet rsProfile=null;
	
	String sSUserID=nullconv((String)session.getAttribute("sUserID"));
	String sFirstName="";
	String sLastName="";
	String iCityID="";
	String iLocation="";
	String sRegEmail="";
	String dd="";
	String mm="";
	String yyyy="";
	String iDateBirth="";
	String sRegGender="";
	String iUserContact="";
	String sPassword="";
	String sCPassword="";
    
	try{
		String sqlCity="SELECT * FROM citymaster c ";
		psCity=conn.prepareStatement(sqlCity);
		rsCity=psCity.executeQuery();
		
		String sqlLocation="SELECT * FROM locationmaster c ";
		psLocation=conn.prepareStatement(sqlLocation);
		rsLocation=psLocation.executeQuery();
		
		String sqlProfile="SELECT * FROM registration r where sUserID='"+sSUserID+"'";
		psProfile=conn.prepareStatement(sqlProfile);
		rsProfile=psProfile.executeQuery();
		
		if(rsProfile.next())
		{
		   sFirstName=nullconv(rsProfile.getString("sFirstName"));
		   sLastName=nullconv(rsProfile.getString("sLastName"));
		   iCityID=nullconv(rsProfile.getString("iCityID"));
		   iLocation=nullconv(rsProfile.getString("iLocation"));
		   sRegEmail=nullconv(rsProfile.getString("sRegEmail"));
		   iDateBirth=nullconv(rsProfile.getString("iDateBirth"));
		   sRegGender=nullconv(rsProfile.getString("sRegGender"));
		   iUserContact=nullconv(rsProfile.getString("iUserContact"));
		}
		yyyy=iDateBirth.substring(0,4);
		mm=iDateBirth.substring(5,7);
		dd=iDateBirth.substring(8,10);
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
<title>My Profile</title>
<script>
function validate()
{
		if(document.frm.sFirstName.value=="")
		{
			alert("Please fill your first name");
			document.frm.sFirstName.focus();
			return false;
		}
		else if(document.frm.sLastName.value=="")
		{
			alert("Please fill last name value");
			document.frm.sLastName.focus();
			return false;
		}
		else if(document.frm.sRegEmail.value=="")
		{
			alert("Please fill email value");
			document.frm.sRegEmail.focus();
			return false;
		}
		else if(document.frm.sRegGender.value=="")
		{
			alert("Please fill gender value");
			document.frm.sRegGender.focus();
			return false;
		}
		else if(document.frm.iCityID.value=="")
		{
			alert("Please fill city value");
			document.frm.iCityID.focus();
			return false;
		}
		else if(document.frm.iLocation.value=="")
		{
			alert("Please fill location value");
			document.frm.iLocation.focus();
			return false;
		}
		else if(document.frm.iUserContact.value=="")
		{
			alert("Please fill contact value");
			document.frm.iUserContact.focus();
			return false;
		}
		
	var chge="Are you sure to Modify!";
	if(confirm(chge)==false)
	{  
	   return false;
	}
}

</script>
</head>

<body>
<form name="frm" action="editProfile.jsp" method="post" onsubmit="return validate()">
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
      <td width="29%" valign="top">&nbsp;</td>
      <td width="71%" valign="top"><%=nullconv((String)request.getAttribute("error"))%></td>
    </tr>
    <tr>
      <td colspan="2"><h3>My Profile </h3></td>
    </tr>
    
    <tr>
      <td colspan="2"><h4>My Information</h4></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>First Name: </td>
      <td><input type="text" name="sFirstName" value="<%=sFirstName%>"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Last Name: </td>
      <td><input type="text" name="sLastName" value="<%=sLastName%>"/></td>
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
	 if(rsCity.getString("iCityID").equalsIgnoreCase(iCityID))
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
    </select> </tr>
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
	 if(rsLocation.getString("iLocationID").equalsIgnoreCase(iLocation))
	 {
	 %>
	  <option value="<%=rsLocation.getInt("iLocationID") %>" selected="selected"><%=rsLocation.getString("iLocationName")%></option>
	 <%
	 }
	 else
	 {
	  %>
	  <option value="<%=rsLocation.getInt("iLocationID") %>"><%=rsLocation.getString("iLocationName")%></option>
	 <%
	 }
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
      <td><input type="text" name="sRegEmail" value="<%=sRegEmail%>" size="50"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Date of Birth: (DD Month YYYY) </td>
      <td><input  type="text"  name="dd" maxlength="2"   class="smallesttextbox"  value="<%=dd%>"  style='width:30px;' />
        <select name="mm"  class="smalldropdown" >
          <option value = '01' <%if(mm.equalsIgnoreCase("1")){out.println("selected='true'");}%>>Jan </option>
          <option value = '02' <%if(mm.equalsIgnoreCase("2")){out.println("selected='true'");}%>>Feb </option>
          <option value = '03' <%if(mm.equalsIgnoreCase("3")){out.println("selected='true'");}%>>Mar </option>
          <option value = '04' <%if(mm.equalsIgnoreCase("4")){out.println("selected='true'");}%>>Apr </option>
          <option value = '05' <%if(mm.equalsIgnoreCase("5")){out.println("selected='true'");}%>>May </option>
          <option value = '06' <%if(mm.equalsIgnoreCase("6")){out.println("selected='true'");}%>>Jun </option>
          <option value = '07' <%if(mm.equalsIgnoreCase("7")){out.println("selected='true'");}%>>Jul </option>
          <option value = '08' <%if(mm.equalsIgnoreCase("8")){out.println("selected='true'");}%>>Aug </option>
          <option value = '09' <%if(mm.equalsIgnoreCase("9")){out.println("selected='true'");}%>>Sep </option>
          <option value = '10' <%if(mm.equalsIgnoreCase("10")){out.println("selected='true'");}%> >Oct </option>
          <option value = '11' <%if(mm.equalsIgnoreCase("11")){out.println("selected='true'");}%> >Nov </option>
          <option value = '12' <%if(mm.equalsIgnoreCase("12")){out.println("selected='true'");}%>>Dec </option>
        </select>
    <input type="text" name="yyyy" maxlength="4" class="smallesttextbox" value="<%=yyyy%>" style='width:45px;'  />    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Gender:</td>
      <td><select name="sRegGender" class="smalldropdown" >
          <option value="Male" <%if(sRegGender.equalsIgnoreCase("Male")){out.println("selected='true'");}%>>Male</option>
          <option value="Female" <%if(sRegGender.equalsIgnoreCase("Female")){out.println("selected='true'");}%> >Female</option>
        </select>      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Contact No: </td>
      <td><input type="text" name="iUserContact" value="<%=iUserContact%>"/></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="Submit" /></td>
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
		 if(psProfile!=null){
			 psProfile.close();
		 }
		 
		 if(rsCity!=null){
			 rsCity.close();
		 }
		 if(rsLocation!=null){
			 rsLocation.close();
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