<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	String iBudgetID=request.getParameter("iBudgetID");
	
	PreparedStatement psBudget=null;
	ResultSet rsBudget=null;
	
	String sBudgetName="";
	String iMinBudget="";
	String iMaxBudget="";
	
	try{
		String sqlBudget="SELECT iBudgetID, sBudgetName, iMinBudget, iMaxBudget, sCreatedBy, dCreatedDate, sModifiedBy, dModifiedDate FROM budgetmaster b where iBudgetID="+nullIntconv(iBudgetID)+"";
		psBudget=conn.prepareStatement(sqlBudget);
		rsBudget=psBudget.executeQuery();
		if(rsBudget.next())
		{
		  sBudgetName=rsBudget.getString("sBudgetName");
		  iMinBudget=rsBudget.getString("iMinBudget");
		  iMaxBudget=rsBudget.getString("iMaxBudget");
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
<title>Edit Budget</title>
<script>
function trim(s) 
{
    return s.replace( /^\s*/, "" ).replace( /\s*$/, "" );
}

function validate()
{
		var chge="Are you sure to Edit Record!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
		if(trim(document.frm.sBudgetName.value)=="")
		{
			alert("Please fill Budget name");
			document.frm.sBudgetName.focus();
			return false;
		}
		if(trim(document.frm.sSymbol.value)=="")
		{
			alert("Please fill Budget symbol");
			document.frm.sSymbol.focus();
			return false;
		}
}
	function cancalit()
	{
	 window.open("viewBudget.jsp","_self")
	}
	
	function deleteRecord()
	{
	 var chge="Are you sure to Delete Record!";
	 if(confirm(chge)==true)
	 {  
		 document.frm.action="deleteBudget.jsp"
		 document.frm.submit();
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
<form name="frm" action="saveEBudget.jsp" onSubmit="return validate()">
<input type="hidden" name="iBudgetID" value="<%=iBudgetID%>">
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
    <td colspan="2"><h3>Edit Budget</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Budget Name</td>
    <td><input type="text" name="sBudgetName" value="<%=sBudgetName%>"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Budget Minimum</td>
    <td><input type="text" name="iMinBudget" value="<%=iMinBudget%>" onKeyPress="return isNumberKey(event)"/></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Budget Maximum</td>
    <td><input type="text" name="iMaxBudget" value="<%=iMaxBudget%>" onKeyPress="return isNumberKey(event)"/></td>
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