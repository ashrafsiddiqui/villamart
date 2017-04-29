<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	ResultSet rsMyPost=null;
	PreparedStatement psMyPost=null;
	
	PreparedStatement psCurrency=null;
	ResultSet rsCurrency=null;

	String sCurrency="";
	
	String iPageID=nullconv(request.getParameter("iPageID"));           
	String sSUserID=nullconv((String)session.getAttribute("sUserID"));
	try{
		String sqlMyPost="select l.iPostID, l.sUserID, l.iTransactionType, l.iPropertyID,sPropertyName, l.iCityID, l.iLocalityID,"
		                 +" l.iArea, l.iBudgetID, sBudgetName,l.iBedroom, l.cStatus, l.sCreatedBy, l.dCreatedDate, l.sModifiedBy,"
						 +" l.dModifiedDate,c.iCityName,lc.iLocationName,r.sRegEmail,sFirstName, sLastName,iUserContact" 
						 +"   FROM post_requirement l" 
						 +"	    left join citymaster c on c.iCityID=l.iCityID "
						 +"		left join locationmaster lc on lc.iLocationID=l.iLocalityID" 
						 +"		left join registration r on r.sUserID=l.sUserID" 
						 +"	    left join propertymaster p on p.iPropertyID=l.iPropertyID "
						 +"		left join budgetmaster b on b.iBudgetID=l.iBudgetID" 
						 +"		  where l.cStatus='A' and l.sUserID='"+nullconv(sSUserID)+"' order by l.dCreatedDate desc";
		psMyPost=conn.prepareStatement(sqlMyPost);
		rsMyPost=psMyPost.executeQuery();
		
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
<title>My Post</title>
<script src="js/checkbox.js" type="text/javascript"></script>
<script>
	function validate()
	{
		var chge="Are you sure to Delete List!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
	} 
	function cancalit()
	{
		history.back();
	}
	function goRecord(iPostID)
	{
	  var pathURL="deletePost.jsp";
	  window.open(pathURL+"?iPostID="+iPostID,"_self");
	}
	function goSubmitForm()
	{
		var chge="Are you sure to Delete!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
	}
</script>
</head>

<body>
<script>
fieldSName("iPostID","frm");
</script>
<form name="frm" action="dPost.jsp" onSubmit="return goSubmitForm();">
<input type="hidden" name="iPageID" value="My">
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
    <td><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td><h3>My Post Requirement</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="br">
   <tr>
    <th class="hspry"><input type="checkbox" name="allCheck" onClick="selectallMe()" styleclass="ch" /></th>
    <th class="hspry">Location</th>
    <th class="hspry">Specification</th>
    <th class="hspry">Budget</th>
    <th class="hspry">Contact</th>
  </tr>
  <%
   boolean nextRow=false;
   while(rsMyPost.next())
   {
    nextRow=true;
   String trans=rsMyPost.getString("iTransactionType");
   
   if(trans.equalsIgnoreCase("1"))
   {
     trans="for Buy";
   }
   else
   {
     trans="for Rent";
   }
   int iListID=rsMyPost.getInt("iPostID");
  %>
  <tr>
    <td class="pd"><input type="checkbox" name="iPostID" onClick="selectall()" styleClass="ch" value="<%=iListID%>"/></td>
    <td onClick="goRecord('<%=iListID%>')" class="pd"><%=rsMyPost.getString("sPropertyName")%> <%=trans%><br> <%=rsMyPost.getString("iCityName")%> <br><%=rsMyPost.getString("iLocationName")%></td>
    <td onClick="goRecord('<%=iListID%>')" class="pd">Area <%=rsMyPost.getString("iArea")%> sq. ft <br><%=rsMyPost.getString("iBedRoom")%> Bedrooms</td>
    <td onClick="goRecord('<%=iListID%>')" class="pd"><%=sCurrency%> <%=rsMyPost.getString("sBudgetName")%> <br></td>
    <td onClick="goRecord('<%=iListID%>')" class="pd">Posted Date: <%=getDateFormat(rsMyPost.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%> <br><br><span style="text-transform:capitalize"><%=rsMyPost.getString("sFirstName")%> <%=rsMyPost.getString("sLastName")%></span><br> Contact: <%=rsMyPost.getString("iUserContact")%><br> Email: <%=rsMyPost.getString("sRegEmail")%><br>&nbsp;</td>
  </tr>
 <%}
  if(nextRow==false)
  {
  %>
   <tr>
    <td colspan="5" align="center" height="50" >No records is found</td>
  </tr>
  <%
  }
  %>
</table>
</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><input type="submit" name="DeleteAll" styleClass="bD" value="Delete"/></td>
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
		 if(psMyPost!=null){
			 psMyPost.close();
		 }
		 if(rsMyPost!=null){
			 rsMyPost.close();
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