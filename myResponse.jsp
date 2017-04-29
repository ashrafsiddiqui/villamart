<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.text.*,java.util.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psResponse=null;
		ResultSet rsResponse=null;
		
		String sSUserID=nullconv((String)session.getAttribute("sUserID"));
		
		try{
			String sqlResponse="SELECT r.iMessageID, r.sUserID, r.iPostID, r.iListID, r.sSubject, r.tMessage, r.sStatus,"
			                    +" r.sRead, r.sCreatedBy, r.sCreatedDate,l.sUserID,sRegEmail,sFirstName, sLastName,iUserContact"
								+"    FROM response r "
								+"	  left join list_requirement l on l.iListID=r.iListID "
								+"	  left join registration g on g.sUserID=r.sUserID "
								+"	        where l.sUserID=? order by r.sCreatedDate desc";
			psResponse=conn.prepareStatement(sqlResponse);
			psResponse.setString(1,sSUserID);
			rsResponse=psResponse.executeQuery();
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
<title>My Response</title>
<script>
function goRecord(iMessageID)
{
 window.open("viewResponse.jsp?iMessageID="+iMessageID,"_self")
}
</script>
</head>

<body>
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
    <td colspan="3"><h3> Response I Got </h3></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="br">
  <tr>
    <td width="25%" class="hspry">List ID</td>
    <td width="25%" class="hspry">Subject</td>
    <td width="35%" class="hspry">Message</td>
    <td width="20%" class="hspry">Send By</td>
    </tr>
     <%
	 boolean nextRow=false;
     while (rsResponse.next())
     {
	   nextRow=true;
      %>
  <tr>
    <td style="padding-left:5px; cursor:pointer">List ID: <a href="myMList.jsp?iListID=<%=rsResponse.getString("iListID")%>" class="lnk"><%=rsResponse.getString("iListID")%></a> <br>Posted: <%=getDateFormat(rsResponse.getTimestamp("sCreatedDate"),"dd.MMM.yyyy hh:mm a")%></td>
    <td onclick="goRecord('<%=rsResponse.getInt("iMessageID") %>')" style="padding-left:5px; cursor:pointer"><%=rsResponse.getString("sSubject")%></td>
    <td onclick="goRecord('<%=rsResponse.getInt("iMessageID") %>')" style="padding-left:5px; cursor:pointer"><%=nullconv(rsResponse.getString("tMessage"))%></td>
    <td onclick="goRecord('<%=rsResponse.getInt("iMessageID") %>')" style="padding-left:5px; cursor:pointer"><span style="text-transform:capitalize"><%=rsResponse.getString("sFirstName")%> <%=rsResponse.getString("sLastName")%></span><br> Contact: <%=rsResponse.getString("iUserContact")%><br> Email: <%=rsResponse.getString("sRegEmail")%></td>
    </tr>
    <%}
  if(nextRow==false)
  {
  %>
   <tr>
    <td colspan="4" align="center" height="50">No records is found</td>
  </tr>
  <%
  }
  %>
</table></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
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

</body>
</html>
<%
	try{
		 if(psResponse!=null){
			 psResponse.close();
		 }
		 if(rsResponse!=null){
			 rsResponse.close();
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