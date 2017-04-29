<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psPendingUser=null;
		ResultSet rsPendingUser=null;
		
		String sUserIDForm=request.getParameter("sUserIDform");
		String sStatus="";
		String sUserTypeForm="";
		String sUserNameForm="";
		
		String sCityName="";
		
		try{
			String sqlCity="SELECT iUserType,sFirstName, sLastName,sStatus FROM registration c where sUserID=?";
			psPendingUser=conn.prepareStatement(sqlCity);
			psPendingUser.setString(1,sUserIDForm);
			rsPendingUser=psPendingUser.executeQuery();
			
			if(rsPendingUser.next())
			{
			  sUserTypeForm=rsPendingUser.getString("iUserType");
			  sUserNameForm=rsPendingUser.getString("sFirstName")+" "+rsPendingUser.getString("sLastName");
			  sStatus=rsPendingUser.getString("sStatus");
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
<title>Activate Pending User</title>
<script>
	function validate()
	{
		var chge="Are you sure to Modify!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
	} 
	function cancalit()
	{
		window.open("pendUser.jsp","_self")
	}
	
	function deleteRecord()
	{
	 var chge="Are you sure to Delete Record!";
	 if(confirm(chge)==true)
	 {  
	 document.frm.action="deleteUser.jsp"
	 document.frm.submit();
	 }
	}
</script>   
</head>

<body>
<form name="frm" action="saveEUser.jsp" onSubmit="return validate()">
<input type="hidden" name="sUserIDform" value="<%=sUserIDForm%>">
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
    <td><span class="error"><%=nullconv((String)request.getParameter("error"))%></span></td>
  </tr>
  <tr>
    <td colspan="2"><h3>Edit User</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>UserID</td>
    <td style="text-transform:capitalize;font-weight:bold"><%=sUserIDForm%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>User  Name</td>
    <td style="text-transform:capitalize;font-weight:bold"><%=sUserNameForm%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>User Type</td>
    <td><select name="sUserType">
        <option value="1" <%if(sUserTypeForm.equalsIgnoreCase("1")){out.println("selected='true'");}%> >Admin</option>
        <option value="2" <%if(sUserTypeForm.equalsIgnoreCase("2")){out.println("selected='true'");}%> >Power User</option>
        <option value="3" <%if(sUserTypeForm.equalsIgnoreCase("3")){out.println("selected='true'");}%> >End user</option>
      </select></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>User Status</td>
    <td><select name="sStatus">
        <option value="A" <%if(sStatus.equalsIgnoreCase("A")){out.println("selected='true'");}%> >Active</option>
		<option value="P" <%if(sStatus.equalsIgnoreCase("P")){out.println("selected='true'");}%> >Pending</option>
        <option value="D" <%if(sStatus.equalsIgnoreCase("D")){out.println("selected='true'");}%> >Deactive</option>
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
    <td width="50%"><%if(!sUserTypeForm.equalsIgnoreCase("1")){%><input type="button" name="delete" value="Delete" onclick="deleteRecord()"/><%}%></td>
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
