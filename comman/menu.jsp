<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@include file="../function.jsp"%>
<%
String status="Login";
String fileCall="login.jsp";
String sSessonUserID=nullconv((String)session.getAttribute("sUserID"));
if(!(sSessonUserID).equals(""))
{
status="Logout";
fileCall="logout.jsp";
sSessonUserID="Hi!  "+nullconv((String)session.getAttribute("sUsername"));
}
%>
<script type="text/javascript" src="js/ddtabmenu.js"></script>

<!-- CSS for Tab Menu #1 -->
<link rel="stylesheet" type="text/css" href="css/ddtabmenu.css" />

<!-- CSS for Tab Menu #2 -->
<link rel="stylesheet" type="text/css" href="css/glowtabs.css" />

<!-- CSS for Tab Menu #3 -->
<link rel="stylesheet" type="text/css" href="css/solidblocksmenu.css" />

<!-- CSS for Tab Menu #4 -->
<link rel="stylesheet" type="text/css" href="css/ddcolortabs.css" />

<!-- CSS for Tab Menu #5 -->
<link rel="stylesheet" type="text/css" href="css/chromemenu.css" />

<script type="text/javascript">
var eTabID=-1;
function callETabID(iTabID)
{
eTabID=iTabID
ddtabmenu.definemenu("ddtabs5", eTabID) 
}
ddtabmenu.definemenu("ddtabs5", eTabID) 

</script>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  
  <tr>
    <td>
<div id="ddtabs5">
<ul>
<li><a href="index.jsp" rel="cm1"><span>Home</span></a></li>
<li><a href="doSearch.jsp" rel="cm2"><span>Search</span></a></li>
<%
if(sSessonUserID.equals(""))
{
%>
<li><a href="register.jsp" rel="cm3"><span>Register</span></a></li>
<%
}
%>
<li><a href="create-listing.jsp"><span>List your property</span></a></li>
<li><a href="create-posting.jsp"><span>Post your Requirement</span></a></li>
<li><a href="<%=fileCall%>"><span><%=sSessonUserID%> <%=status%></span></a></li>
</ul>
</div>

<DIV class="tabcontainer">

<div id="cm1" class="tabcontent"> Welcome to dream house estate. 
</div>

<div id="cm2" class="tabcontent">
Search your dream house </a>.
</div>

<div id="cm3" class="tabcontent"> Register here to get more advance feature of dream house e.g Post requirement, List requirement
</div>

</DIV></td>
  </tr>
</table>
