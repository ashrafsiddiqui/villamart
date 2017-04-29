<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.text.*,java.util.*" errorPage="" %>
<%@include file="function.jsp"%>
<%
String iListID=request.getParameter("iListID");
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Cache-Control", "no-store");
response.addHeader("Expires", "0");
response.addHeader("pragma","no-cache");

    String sUserTypeSession=nullconv((String)session.getAttribute("iUserType"));
	String sSessonUserID=nullconv((String)session.getAttribute("sUserID"));
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
<title>Image</title>
<link type="text/css" rel="StyleSheet" href="css/style.css" />
<script>
function validate()
{
       var chge="Are you sure to Delete Image!";
		if(confirm(chge)==false)
		{  
			return false;
		}
}

</script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="81%">&nbsp;</td>
    <td width="12%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><img src="images/logo.jpg" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="22%">&nbsp;</td>
        <td width="57%"><%=nullconv((String)request.getAttribute("error"))%></td>
        <td width="8%">&nbsp;</td>
        <td width="13%"><a href="dImage.jsp?iListID=<%=iListID%>" class="bBDelete" onclick="return validate()" onmouseover="this.className='bMBDelete'" onmouseout="this.className='bBDelete'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
      </tr>
    </table></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center"><a href="#" onclick="window.close()">Close Windows</a></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><img src="proImage/<%=iListID%>.jpg" id="im<%=iListID%>"></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
