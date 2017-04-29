<%
String sUserType=nullconv((String)session.getAttribute("iUserType"));
String sPending="";
if(!(sUserType).equals(""))
{
  if(sUserType.equalsIgnoreCase("1"))
  {
   %>
   <div class="headers">Seller</div>
<ul class="categorylinks">
		<li><a href="myProfile.jsp">My Profile</a></li>
		<li><a href="myList.jsp">My Listing </a></li>
		<li><a href="chgPwd.jsp">Change Password</a></li>
</ul>

<div class="headers">Administrator</div>
<ul class="categorylinks">
		<li><a href="viewproperty.jsp">Edit Property</a></li>
		<li><a href="approveList.jsp">Pending Approval List</a></li>
		<li><a href="approvePost.jsp">Pending Approval Post</a></li>
		<li><a href="doSearchPost.jsp">Search Post</a></li>
</ul>
   <%
  }
  else if(sUserType.equalsIgnoreCase("2"))
  {
  %>
  <div class="headers">Buyer</div>
<ul class="categorylinks">
		<li><a href="myProfile.jsp">My Profile</a></li>
		<li><a href="myList.jsp">My Listing </a></li>
		<li><a href="chgPwd.jsp">Change Password</a></li>
</ul>

<div class="headers">Administrator</div>
<ul class="categorylinks">
		<li><a href="approveList.jsp">Pending Approval List</a></li>
		<li><a href="approvePost.jsp">Pending Approval Post</a></li>
</ul>
  <%
  }
  else if(sUserType.equalsIgnoreCase("3"))
  {
  %>
  <div class="headers">My Profile</div>
<ul class="categorylinks">
		<li><a href="myProfile.jsp">My Profile</a></li>
		<li><a href="myList.jsp">My Listing </a></li>
		<li><a href="myPost.jsp">My Posting</a></li>
		<li><a href="chgPwd.jsp">Change Password</a></li>
</ul>
  <%
  }
}
%>


