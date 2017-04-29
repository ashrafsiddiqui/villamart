<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>

<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	ResultSet rsPendingApproveList=null;
	PreparedStatement psPendingApproveList=null;
	PreparedStatement psCurrency=null;
	ResultSet rsCurrency=null;
	
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
	
	String sSUserID=nullconv((String)session.getAttribute("sUserID"));
	try{
		String sqlPendingApproveList="SELECT l.iListID, l.sUserID, l.iTransactionType, l.iPropertyID,sPropertyName, l.sPropertyAddress," 
									 +" l.iCityID, l.iLocalityID, l.iArea, l.iTotalPrice, l.iBedRoom, l.iNFloor, l.cPriceNegotiable," 
									 +" l.dCreatedDate,c.iCityName,lc.iLocationName,r.sRegEmail,sFirstName, sLastName,iUserContact,(select count(*) from list_requirement l where l.cStatus='P') as cnt  "
									 +"   FROM list_requirement l "
									 +"    left join citymaster c on c.iCityID=l.iCityID "
									 +"	   left join locationmaster lc on lc.iLocationID=l.iLocalityID "
									 +"    left join registration r on r.sUserID=l.sUserID "
									 +"	   left join propertymaster p on p.iPropertyID=l.iPropertyID "
									 +"          where l.cStatus='P' order by l.dCreatedDate desc limit "+iPageNo+","+iShowRows+"";
		psPendingApproveList=conn.prepareStatement(sqlPendingApproveList);
		rsPendingApproveList=psPendingApproveList.executeQuery();
		
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
<title>Pending Approve List</title>
<script src="js/checkbox.js" type="text/javascript"></script>
<script>
	function goSubmitPageForm(sPageNo)
	{
		  document.frm.cPageNo.value=sPageNo
		  document.frm.iPageNo.value=sPageNo;
		  document.frm.submit(); 
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
	 if(confirm(chge)==true)
	 {  
		  document.frm.submit(); 
	 }
	}
  }
	
	function appList()
	{
	 var chg="Are you sure to Approved!";
	 document.frm.action="appList.jsp"
	 if(confirm(chg)==true)
	 {  
		  document.frm.submit(); 
	 }
	}
		
</script> 
</head>

<body>
<script>
	fieldSName("iListID","frm");
</script>
<form name="frm">
<input type="hidden" name="iPageID" value="app">
<input type="hidden" name="iPageNo" value="<%=iPageNo%>">
<input type="hidden" name="cPageNo" value="<%=cPageNo%>">
<input type="hidden" name="iShowRows" value="<%=iShowRows%>">
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
    <td><h3>Pending Approve List of Property </h3></td>
  </tr>
  <tr>
    <td align="right"><div id="tot"></div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th class="hspry brt brl"><input type="checkbox" name="allCheck" onClick="selectallMe()" styleClass="ch" /></th>
    <th class="hspry brt brl">Location</th>
    <th class="hspry brt brl">Specification</th>
    <th class="hspry brt brl">Price</th>
    <th class="hspry brt brl brr">Contact</th>
  </tr>
  <%
  boolean nextRow=false;
   
   String br="";
   while(rsPendingApproveList.next())
   {
    nextRow=true;
	
   String neo=rsPendingApproveList.getString("cPriceNegotiable");
   String trans=rsPendingApproveList.getString("iTransactionType");
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
   int iListID=rsPendingApproveList.getInt("iListID");
   iTotalRows=rsPendingApproveList.getInt("cnt");
  %>
  <tr>
    <td class="pd brt brb brl"><input type="checkbox" name="iListID" onClick="selectall()" styleClass="ch" value="<%=iListID%>"/></td>
    <td class="pd brt brb brl"><%=rsPendingApproveList.getString("sPropertyName")%> <%=trans%><br> <%=rsPendingApproveList.getString("sPropertyAddress")%> <br><%=rsPendingApproveList.getString("iCityName")%> <br><%=rsPendingApproveList.getString("iLocationName")%></td>
    <td class="pd brt brb brl">Area <%=rsPendingApproveList.getString("iArea")%> sq. ft <br><%=rsPendingApproveList.getString("iBedRoom")%> Bedrooms</td>
    <td class="pd brt brb brl"><%=sCurrency%> <%=rsPendingApproveList.getString("iTotalPrice")%> <br><%=neo%></td>
    <td class="pd brt brb brl brr">Posted Date: <%=getDateFormat(rsPendingApproveList.getTimestamp("dCreatedDate"),"dd.MMM.yyyy hh:mm a")%> <br><br><span style="text-transform:capitalize"><%=rsPendingApproveList.getString("sFirstName")%> <%=rsPendingApproveList.getString("sLastName")%></span><br> Contact: <%=rsPendingApproveList.getString("iUserContact")%><br> Email: <%=rsPendingApproveList.getString("sRegEmail")%><br>&nbsp;</td>
  </tr>
  <tr>
    <td id="nCl">&nbsp;</td>
    <td id="nCl">&nbsp;</td>
    <td id="nCl">&nbsp;</td>
    <td id="nCl">&nbsp;</td>
    <td id="nCl">&nbsp;</td>
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
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%if(iTotalRows>0){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
<%}%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><input type="button" name="appAll" styleclass="bD" value="Approve List" onclick="appList()"  class="bD"/>   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="DeleteAll" styleclass="bD" value="Delete" onclick="goSubmitForm()"/></td>
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
		 if(psPendingApproveList!=null){
			 psPendingApproveList.close();
		 }
		 if(rsPendingApproveList!=null){
			 rsPendingApproveList.close();
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