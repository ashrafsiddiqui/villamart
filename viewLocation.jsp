<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%
		Connection conn=null;
		conn=dbConn.getConnection();
		
		PreparedStatement psLocation=null;
		ResultSet rsLocation=null;
		
		try{
			String sqlLocation="SELECT * FROM locationmaster l left join citymaster c on c.iCityID=l.iCityID";
			psLocation=conn.prepareStatement(sqlLocation);
			rsLocation=psLocation.executeQuery();
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
<title>View Location</title>
<script>
function goRecord(iLocationID)
{
  window.open("editLocation.jsp?iLocationID="+iLocationID,"_self")
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
    <td>&nbsp;</td>
    <td colspan="3"><h3>View Location</h3></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="2"><%=nullconv((String)request.getAttribute("error"))%></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="br">
        <tr>
          <td width="35%" class="hspry">Location  Name</td>
          <td width="24%" class="hspry">Under City Name</td>
          <td width="41%" class="hspry">Created By</td>
        </tr>
        <%
     while (rsLocation.next())
     {
      %>
        <tr>
          <td onclick="goRecord('<%=rsLocation.getInt("iLocationID") %>')" class="pd"><%=rsLocation.getString("iLocationName")%>&nbsp;</td>
          <td onclick="goRecord('<%=rsLocation.getInt("iLocationID") %>')" class="pd"><%=nullconv(rsLocation.getString("iCityName"))%>&nbsp;</td>
          <td onclick="goRecord('<%=rsLocation.getInt("iLocationID") %>')" class="pd"><%=nullconv(rsLocation.getString("sCreatedBy"))%>&nbsp;</td>
        </tr>
        <%
	}
	%>
      </table></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
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
             if(psLocation!=null){
                 psLocation.close();
             }
			 if(rsLocation!=null){
                 rsLocation.close();
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