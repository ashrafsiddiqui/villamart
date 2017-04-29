<%
String sUserType=nullconv((String)session.getAttribute("iUserType"));
String sPending="";
if(!(sUserType).equals(""))
{
  if(sUserType.equalsIgnoreCase("1"))
  {
   sPending= "<a href='pendUser.jsp'>Pending User</a>&nbsp;&nbsp;&nbsp; <a href='addCity.jsp'>Add City</a>&nbsp;&nbsp;&nbsp; <a href='viewCity.jsp'>Edit City</a>&nbsp;&nbsp;&nbsp; <a href='addLocation.jsp'>Add Location</a>&nbsp;&nbsp;&nbsp; <a href='viewLocation.jsp'>Edit Location</a> &nbsp;&nbsp;&nbsp; <a href='viewproperty.jsp'>Edit Property</a>&nbsp;&nbsp;&nbsp;<a href='addproperty.jsp'>Add Property</a> &nbsp;&nbsp;&nbsp; <a href='doSearchPost.jsp'>Search Post Requirement</a>  &nbsp;&nbsp;&nbsp; <a href='viewforget.jsp'>Pending Forget Password</a> &nbsp;&nbsp;<a href='myList.jsp'>My Listing</a>&nbsp;&nbsp;&nbsp; <a href='myPost.jsp'>My Posting</a> &nbsp;&nbsp;&nbsp;<a href='myProfile.jsp'>My Profile</a> &nbsp;&nbsp;&nbsp;<a href='chgPwd.jsp'>Change Password</a> &nbsp;&nbsp;&nbsp;<a href='myResponse.jsp'>My Responses</a>";
  }
  else if(sUserType.equalsIgnoreCase("2"))
  {
   sPending= "<a href='addCity.jsp'>Add City</a>&nbsp;&nbsp;&nbsp; <a href='viewCity.jsp'>Edit City</a>&nbsp;&nbsp;&nbsp; <a href='addLocation.jsp'>Add Location</a>&nbsp;&nbsp;&nbsp; <a href='viewLocation.jsp'>Edit Location</a>&nbsp;&nbsp;&nbsp; <a href='myList.jsp'>My Listing</a>&nbsp;&nbsp;&nbsp; <a href='myPost.jsp'>My Posting</a> &nbsp;&nbsp;&nbsp;<a href='myProfile.jsp'>My Profile</a> &nbsp;&nbsp;&nbsp;<a href='chgPwd.jsp'>Change Password</a>&nbsp;&nbsp;&nbsp;<a href='myResponse.jsp'>My Responses</a>";
  }
  else if(sUserType.equalsIgnoreCase("3"))
  {
   sPending= "<a href='myList.jsp'>My Listing</a>&nbsp;&nbsp;&nbsp; <a href='myPost.jsp'>My Posting</a> &nbsp;&nbsp;&nbsp;<a href='myProfile.jsp'>My Profile</a> &nbsp;&nbsp;&nbsp;<a href='chgPwd.jsp'>Change Password</a> &nbsp;&nbsp;&nbsp;<a href='myResponse.jsp'>My Responses</a>";
  }
}
%>