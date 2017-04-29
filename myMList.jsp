<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	ResultSet rsMList=null;
	PreparedStatement psMList=null;
	
	String iListIDs=nullconv(request.getParameter("iListID"));           
	String sSUserID=nullconv((String)session.getAttribute("sUserID"));
	try{
			String sqlMList="SELECT l.iListID, l.sUserID, l.iTransactionType, l.iPropertyID,sPropertyName," +
							" l.sPropertyAddress, l.iCityID, l.iLocalityID, l.iArea, l.iTotalPrice, l.iBedRoom, " +
							" l.iNFloor, l.cPriceNegotiable, l.dCreatedDate,c.iCityName,lc.iLocationName,r.sRegEmail," +
							" sFirstName, sLastName,iUserContact " +
							"     FROM list_requirement l " +
							"       left join citymaster c on c.iCityID=l.iCityID " +
							"       left join locationmaster lc on lc.iLocationID=l.iLocalityID " +
							"       left join registration r on r.sUserID=l.sUserID" +
							"       left join propertymaster p on p.iPropertyID=l.iPropertyID " +
							"            where l.cStatus='A' and iListID='"+iListIDs+"' and l.sUserID='"+nullconv(sSUserID)+"' " +
							"               order by l.dCreatedDate desc";
			psMList=conn.prepareStatement(sqlMList);
			rsMList=psMList.executeQuery();
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
<title>My List</title>
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
	
	function goRecord(iListID)
	{
	  var pathURL="deleteList.jsp";
	  window.open(pathURL+"?iListID="+iListID,"_self");
	}
	function goSubmitForm()
	{
		var chge="Are you sure to Delete!";
		if(confirm(chge)==false)
		{  
		   return false;
		}
	}
	function onErrorLoad(im)
	{
		var id="im"+im;
		document.getElementById(id).src="proImage/blank.jpg";
		document.getElementById(id).style.width="1px";
		document.getElementById(id).style.height="1px";
	}
	function openWindow(iListID)
	{
		window.open("display.jsp?iListID="+iListID,'my','status=no,menubar=no,scrollbars=yes,toolbar=no,resize=yes');
	}
</script> 
</head>

<body>
<script>
fieldSName("iListID","frm");
</script>
<form name="frm" action="dList.jsp" onSubmit="return goSubmitForm()">
  <input type="hidden" name="iListID" value="<%=iListIDs%>">
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
    <td><h3>My List of Property </h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th height="26">&nbsp;</th>
    <th class="hspry brt brl"><input type="checkbox" name="allCheck" onClick="selectallMe()" styleClass="ch" /></th>
    <th class="hspry brt brl">Location</th>
    <th class="hspry brt brl">Specification</th>
    <th class="hspry brt brl">Price</th>
    <th class="hspry brt brl brr">Contact</th>
    <th >&nbsp;</th>
  </tr>
  
   <%
  boolean nextRow=false;
   
   String br="";
   if(rsMList.next())
   {
    nextRow=true;
	if(!rsMList.isFirst())
    {
     br="border-top:1px solid #003366;";
    }
   String neo=rsMList.getString("cPriceNegotiable");
   String trans=rsMList.getString("iTransactionType");
   if(neo.equalsIgnoreCase("Y"))
   {
     neo="Negotiable";
   }
   else
   {
     neo="Not Negotiable";
   }
   
   if(trans.equalsIgnoreCase("1"))
   {
     trans="for Sale";
   }
   else
   {
     trans="for Rent";
   }
   int iListID=rsMList.getInt("iListID");
  %>
  <tr>
    <td>&nbsp;</td>
    <td class="pd brt brb brl"><input type="checkbox" name="iListID" onClick="selectall()" styleClass="ch" value="<%=iListID%>"/>  <img src="proImage/<%=iListID%>.jpg" id="im<%=iListID%>" onError="onErrorLoad('<%=iListID%>')" onClick="openWindow('<%=iListID%>')" width="90" height="100">&nbsp;</td>
    <td class="pd brt brb brl" onClick="goRecord('<%=iListID%>')" ><%=rsMList.getString("sPropertyName")%> <%=trans%><br> <%=rsMList.getString("sPropertyAddress")%> <br><%=rsMList.getString("iCityName")%> <br><%=rsMList.getString("iLocationName")%></td>
    <td class="pd brt brb brl" onClick="goRecord('<%=iListID%>')">Area <%=rsMList.getString("iArea")%> sq. ft <br><%=rsMList.getString("iBedRoom")%> Bedrooms</td>
    <td class="pd brt brb brl"  onclick="goRecord('<%=iListID%>')">RM <%=rsMList.getString("iTotalPrice")%> <br><%=neo%></td>
    <td class="pd brt brb brl brr" onClick="goRecord('<%=iListID%>')">Posted Date: <%=getDateFormat(rsMList.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%> <br><br><span style="text-transform:capitalize"><%=rsMList.getString("sFirstName")%> <%=rsMList.getString("sLastName")%></span><br> Contact: <%=rsMList.getString("iUserContact")%><br> Email: <%=rsMList.getString("sRegEmail")%><br>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td height="25" class="brb brl brr" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right"><img src="images/photo.jpg" /></td>
    <td align="left" style="padding-left:5px"><a href="uLoad.jsp?iListID=<%=iListID%>">Upload Photo</a></td>
  </tr>
</table>
 </td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <%}
  if(nextRow==false)
  {
  %>
   <tr>
    <td>&nbsp;</td>
    <td colspan="5" align="center" height="50" class="pd brt  brb brl brr">No records is found</td>
    <td>&nbsp;</td>
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
</table>
</td>
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
		 if(psMList!=null){
			 psMList.close();
		 }
		 if(rsMList!=null){
			 rsMList.close();
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