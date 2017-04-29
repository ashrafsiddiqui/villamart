<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>

<%
			Connection conn = null;
			conn=dbConn.getConnection();
			
			ResultSet rsOptions = null;
			
			PreparedStatement psOptions=null;
		 	PreparedStatement psCurrency=null;
			ResultSet rsCurrency=null;
			
			String iPropertyID=nullconv(request.getParameter("property_type"));
			String pageNo=nullconv(request.getParameter("sPage"));
			
			String sCurrency="";
			
			int iShowRows=10;
			int iTotalRows=nullIntconv(request.getParameter("iTotalRows"));
	  		int iTotalPages=nullIntconv(request.getParameter("iTotalPages"));
	  		int iPageNo=nullIntconv(request.getParameter("iPageNo"));
	  		int cPageNo=nullIntconv(request.getParameter("cPageNo"));
			int iStartResultNo=0;
	  		int iEndResultNo=0;
			
			String addMysql="";
			if(iPageNo==0)
			{
				iPageNo=0;
			}
			else{
				iPageNo=Math.abs((iPageNo-1)*iShowRows);
			}
			if(iShowRows==0)
			{
				iShowRows=10;
			}
			
			if(!(iPropertyID).equals(""))
			{
			  addMysql=addMysql+" and l.iPropertyID='"+iPropertyID+"'";
			}
		
	   try{
            String sqlOption="SELECT l.iListID, l.sUserID, l.iTransactionType, l.iPropertyID,sPropertyName, l.sPropertyAddress, l.iCityID, l.iLocalityID, l.iArea, l.iTotalPrice, l.iBedRoom, l.iNFloor, l.cPriceNegotiable, l.dCreatedDate,c.iCityName,lc.iLocationName,r.sRegEmail,sFirstName, sLastName,iUserContact,(select count(*) from list_requirement l where l.cStatus='A' "+addMysql+") as cnt FROM list_requirement l left join citymaster c on c.iCityID=l.iCityID left join locationmaster lc on lc.iLocationID=l.iLocalityID left join registration r on r.sUserID=l.sUserID left join propertymaster p on p.iPropertyID=l.iPropertyID where l.cStatus='A' "+addMysql+" order by l.dCreatedDate desc limit "+iPageNo+","+iShowRows+"";
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
<title>Search Property List</title>
<script src="js/checkbox.js" type="text/javascript"></script>
<script>
  function goRecord(iListID)
  {
      var pathURL="deleteList.jsp";
      window.open(pathURL+"?iListID="+iListID,"_self");
  }
  function goSubmitForm(ob,pageNo)
  {
    var chge="Are you sure to Delete!";
	
	if(ob=="S")
	{
	  document.frm.iPageNo.value=pageNo
	  document.frm.submit(); 
	}
	else
	{
	 document.frm.action="dList.jsp"
	 if(confirm(chge)==false)
	 {  
		   return false;
	 }
	}
  }
  
  function goSubmitPageForm(sPageNo)
  {
      document.frm.cPageNo.value=sPageNo
      document.frm.iPageNo.value=sPageNo;
	  document.frm.submit(); 
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
    window.open("display.jsp?iListID="+iListID,'my','width=600,height=661,status=no,menubar=no,scrollbars=yes,toolbar=no,resize=yes');
  }
</script>
</head>

<body>
<script>
fieldSName("iListID","frm");
</script>
<form name="frm"  onSubmit="return goSubmitForm();" method="post">
<input type="hidden" name="iPageNo" value="<%=iPageNo%>">
<input type="hidden" name="cPageNo" value="<%=cPageNo%>">
<input type="hidden" name="iShowRows" value="<%=iShowRows%>">

<input type="hidden" name="property_type" value="<%=iPropertyID%>">
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
    <td colspan="2"><h3> List of Property </h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="right"><div id="tot"></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th height="26" class="hspry brl brt"><input type="checkbox" name="allCheck" onClick="selectallMe()" styleClass="ch" /></th>
    <th class="hspry brt brl">Location</th>
    <th class="hspry brt brl">Specification</th>
    <th class="hspry brt brl">Price</th>
    <th class="hspry brt brr brl">Contact</th>
  </tr>
  <%
  boolean nextRow=false;
  String br="";
   while(rsOptions.next())
   {
   nextRow=true;
   
   String neo=rsOptions.getString("cPriceNegotiable");
   String trans=rsOptions.getString("iTransactionType");
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
  
   int iListID=rsOptions.getInt("iListID");
   iTotalRows=rsOptions.getInt("cnt");
  %>
  <tr>
    <td class="pd brt brb brl"><input type="checkbox" name="iListID" onClick="selectall()" styleClass="ch" value="<%=iListID%>"/> <img src="proImage/<%=iListID%>.jpg" id="im<%=iListID%>" onError="onErrorLoad('<%=iListID%>')" onClick="openWindow('<%=iListID%>')" width="90" height="100">&nbsp;</td>
    <td class="pd brt brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> ><%=rsOptions.getString("sPropertyName")%> <%=trans%><br> <%=rsOptions.getString("sPropertyAddress")%> <br><%=rsOptions.getString("iCityName")%> <br><%=rsOptions.getString("iLocationName")%></td>
    <td class="pd brt brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> >Area <%=rsOptions.getString("iArea")%> sq. ft <br><%=rsOptions.getString("iBedRoom")%> Bedrooms</td>
    <td class="pd brt brb brl" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> ><%=sCurrency%> <%=rsOptions.getString("iTotalPrice")%> <br><%=neo%></td>
    <td class="pd brt brb brl brr" <%if(sPendingID==true){ out.println("onclick=\"goRecord('"+iListID+"')\"");}%> >Posted Date: <%=getDateFormat(rsOptions.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%> <br><br><span style="text-transform:capitalize"><%=rsOptions.getString("sFirstName")%> <%=rsOptions.getString("sLastName")%></span><br> Contact: <%=rsOptions.getString("iUserContact")%><br> Email: <%=rsOptions.getString("sRegEmail")%><br>&nbsp;</td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td height="25" class="brb brl brr" align="center"><a href="response.jsp?iListID=<%=iListID%>&iType=L"><img src="images/res.gif" border="0"/> Response This List</a></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
  </tr> 
  <%}
  if(nextRow==false)
  {
  %>
   <tr>
    <td colspan="5" align="center" height="50" class="pd brt  brb brl brr">No records is found</td>
  </tr>
  <%
  }
  
 		 try{
			if(iTotalRows<(iPageNo+iShowRows))
			{
				iEndResultNo=iTotalRows;
			}
			else
			{
				iEndResultNo=(iPageNo+iShowRows);
			}
			iStartResultNo=(iPageNo+1);
			iTotalPages=((int)(Math.ceil((double)iTotalRows/iShowRows)));
			
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
  %>
   
  
  
</table></td>
  </tr>
</table></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<%if(iTotalRows>0){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
     <td colspan="2"><%if(sPendingID==true){ %><input type="submit" name="DeleteAll" styleClass="bD" value="Delete" /><%}%></td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
   </tr>
   <script>
   document.getElementById("tot").innerHTML="<b>Rows <%=iStartResultNo%> - <%=iEndResultNo%> &nbsp;&nbsp;Total Result  <%=iTotalRows%> </b>";
   </script>
   <tr>
     <td colspan="4"><div>
	 <%
	    int i=0;
	    
		int cPage=0;
		cPage=((int)(Math.ceil((double)iEndResultNo/50)));
		if((cPage*5)-(5)>0)
		{
		 %>
		 <span onClick="goSubmitPageForm('<%=(cPage*5)-(4+5)%>')" class="pg pd" style="cursor:pointer"><< Previous</span>
		 <%
		}
		
	    for(i=((cPage*5)-4);i<=(cPage*5);i++)
		{
		  if(i==((iPageNo/10)+1))
		  {
		  %>
		   <span onClick="goSubmitForm('S','<%=i%>')" class="pg pd" style="cursor:pointer;color: red"><b><%=i%></b></span>
		  <%
		  }
		  else if(i<=iTotalPages)
		  {
		  %>
		   <span onClick="goSubmitForm('S','<%=i%>')" class="pg pd" style="cursor:pointer"><%=i%></span>
		  <% 
		  }
		}
		if(iTotalPages>5 && i<iTotalPages)
		{
		 %>
		 <span onClick="goSubmitPageForm('<%=i%>')" class="pg pd" style="cursor:pointer">>> Next</span>
		 <%
		}
	  %>
 </div></td>
     <td>Total Pages  <b><%=iTotalPages%></b></td>
   </tr>
   <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<%}%>
</td>
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