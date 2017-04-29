<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>

<%
		Connection conn = null;
		conn=dbConn.getConnection();
	
		ResultSet rsOptions = null;
		
		PreparedStatement psOptions=null;
		
		PreparedStatement psCurrency=null;
		ResultSet rsCurrency=null;

		String sCurrency="";
		 
			
			String iTransactionType=nullconv(request.getParameter("tranType"));
			String iPropertyID=nullconv(request.getParameter("propertyType"));
			String iCityID=nullconv(request.getParameter("iCityID"));
			String iLocalityID=nullconv(request.getParameter("iLocation"));
			String iArea=nullconv(request.getParameter("iArea"));
			String iBudgetID=nullconv(request.getParameter("iBudgetID"));
			String iBedroom=nullconv(request.getParameter("bedroom"));
			String iNFloor=nullconv(request.getParameter("floornumber"));
			
			String addMysql="";
			
			if(!(iTransactionType).equals(""))
			{
			  addMysql=" and iTransactionType='"+iTransactionType+"'";
			}
			if(!(iPropertyID).equals(""))
			{
			  addMysql=addMysql+" and l.iPropertyID='"+iPropertyID+"'";
			}
			if(!(iCityID).equals(""))
			{
			   addMysql=addMysql+" and l.iCityID='"+iCityID+"'";
			}
			if(!(iLocalityID).equals(""))
			{
			   addMysql=addMysql+" and l.iLocalityID='"+iLocalityID+"'";
			}
			if(!(iArea).equals(""))
			{
			   addMysql=addMysql+" and l.iArea='"+iArea+"'";
			}
			if(!(iBudgetID).equals(""))
			{
			   addMysql=addMysql+" and l.iBudgetID='"+iBudgetID+"'";
			}
			if(!(iBedroom).equals(""))
			{
			   addMysql=addMysql+" and l.iBedRoom='"+iBedroom+"'";
			}
			
		
	try{
		String sqlOption="select l.iPostID, l.sUserID, l.iTransactionType, l.iPropertyID,sPropertyName, l.iCityID, l.iLocalityID, l.iArea, l.iBudgetID, sBudgetName,l.iBedroom, l.cStatus, l.sCreatedBy, l.dCreatedDate, l.sModifiedBy, l.dModifiedDate,c.iCityName,lc.iLocationName,r.sRegEmail,sFirstName, sLastName,iUserContact FROM post_requirement l left join citymaster c on c.iCityID=l.iCityID left join locationmaster lc on lc.iLocationID=l.iLocalityID left join registration r on r.sUserID=l.sUserID left join propertymaster p on p.iPropertyID=l.iPropertyID left join budgetmaster b on b.iBudgetID=l.iBudgetID where l.cStatus='A' "+addMysql+" order by l.dCreatedDate desc";
		psOptions=conn.prepareStatement(sqlOption);
		rsOptions=psOptions.executeQuery();
		
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

	String sUserTypeSession=nullconv((String)session.getAttribute("iUserType"));
	boolean sPendingID=false;
	if(!(sUserTypeSession).equals(""))
	{
	  if(sUserTypeSession.equalsIgnoreCase("1"))
	  {
		 sPendingID=true;
	  }
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<link type="text/css" rel="StyleSheet" href="css/menu.css" />
<title>Search Post</title>
<script src="js/checkbox.js" type="text/javascript"></script>
<script>
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
    <td width="28%">&nbsp;</td>
    <td width="72%"><%=nullconv((String)request.getAttribute("error"))%></td>
  </tr>
  <tr>
    <td colspan="2"><h3>Search Post Requirement</h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <th width="7%" height="26" class="hspry brt brl brb"><input type="checkbox" name="allCheck" onClick="selectallMe()" styleClass="ch" /></th>
          <th width="29%" class="hspry brt brl brb">Location</th>
          <th width="25%" class="hspry brt brl brb">Specification</th>
          <th width="11%" class="hspry brt brl brb">Budget</th>
          <th width="28%" class="hspry brt brl brb brr">Contact</th>
        </tr>
       <%
  boolean nextRow=false;
   while(rsOptions.next())
   {
    nextRow=true;
   String trans=rsOptions.getString("iTransactionType");
   
   if(trans.equalsIgnoreCase("1"))
   {
     trans="for Buy";
   }
   else
   {
     trans="for Rent";
   }
   int iListID=rsOptions.getInt("iPostID");
  %>
        <tr>
			<td class="pd  brb brl"><input type="checkbox" name="iPostID" onClick="selectall()" styleClass="ch" value="<%=iListID%>"/></td>
			<td class="pd  brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> ><%=rsOptions.getString("sPropertyName")%> <%=trans%><br> <%=rsOptions.getString("iCityName")%> <br><%=rsOptions.getString("iLocationName")%></td>
			<td class="pd  brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> >Area <%=rsOptions.getString("iArea")%> sq. ft <br><%=rsOptions.getString("iBedRoom")%> Bedrooms</td>
			<td class="pd  brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> ><%=sCurrency%> <%=rsOptions.getString("sBudgetName")%> <br></td>
			<td class="pd  brb brl brr" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> >Posted Date: <%=getDateFormat(rsOptions.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%> <br><br><span style="text-transform:capitalize"><%=rsOptions.getString("sFirstName")%> <%=rsOptions.getString("sLastName")%></span><br> Contact: <%=rsOptions.getString("iUserContact")%><br> Email: <%=rsOptions.getString("sRegEmail")%><br>&nbsp;</td>
        </tr>
        <%
		}
  if(nextRow==false)
  {
  %>
   <tr>
    <td colspan="5" align="center" class="pd brt brb brl brr"  height="50">No records is found</td>
  </tr>
  <%
  }
  %>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><%if((sPendingID==true) && (nextRow==true)){ %><input type="submit" name="DeleteAll" styleClass="bD" value="Delete"/><%}%></td>
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
		 if(psOptions!=null){
			 psOptions.close();
		 }
		 if(rsOptions!=null){
			 rsOptions.close();
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