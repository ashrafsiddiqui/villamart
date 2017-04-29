<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();

	PreparedStatement psEditListApprovalOption=null;
	ResultSet rsEditListApprovalOption=null;
	
	String sApprovalOptionList=request.getParameter("listApproval");
	String sApprovalOptionListImage=request.getParameter("listApprovalImage");
	
	try{
		String sqlEditListApprovalOption="SELECT cIsApprovalNeed, cIsImageApprovalNeed FROM list_approval c";
		psEditListApprovalOption=conn.prepareStatement(sqlEditListApprovalOption);
		rsEditListApprovalOption=psEditListApprovalOption.executeQuery();
		if(rsEditListApprovalOption.next())
		{
		  sApprovalOptionList=rsEditListApprovalOption.getString("cIsApprovalNeed");
		  sApprovalOptionListImage=rsEditListApprovalOption.getString("cIsImageApprovalNeed");
		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Edit Administrator Approval Listing</title>
<script>
function trim(s) 
{
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}
function validate()
{
    var chge="Are You Sure To Edit Approval Option!";
	if(confirm(chge)==false)
	{  
	   return false;
	}		
}
 
 </script>
</head>

<body>
<form name="frm" action="saveEAppOptList.jsp" onSubmit="return validate()">
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
   <td width="26%">&nbsp;</td>
    <td colspan="2"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
 
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><h3>Edit Approval Option on Listing </h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Listing Approval Need? </td>
    <td>
	<select name="listApproval">
	  <option value="P" <%if(sApprovalOptionList.equalsIgnoreCase("P")){ out.print("selected=\"selected\"");}%> >Yes</option>
	  <option value="A" <%if(sApprovalOptionList.equalsIgnoreCase("A")){ out.print("selected=\"selected\"");}%>>No</option>
	</select>
	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
   <tr>
    <td>Listing Approval Image Need? </td>
    <td><select name="listApprovalImage">
	  <option value="Y" <%if(sApprovalOptionListImage.equalsIgnoreCase("Y")){ out.print("selected=\"selected\"");}%>>Yes</option>
	  <option value="N" <%if(sApprovalOptionListImage.equalsIgnoreCase("N")){ out.print("selected=\"selected\"");}%>>No</option>
	</select></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="goSubmit" value="Edit" /></td>
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
		 if(psEditListApprovalOption!=null){
			 psEditListApprovalOption.close();
		 }
		 if(rsEditListApprovalOption!=null){
			 rsEditListApprovalOption.close();
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