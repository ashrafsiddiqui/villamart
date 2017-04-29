<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.text.SimpleDateFormat,java.sql.*,java.io.*,java.util.*,org.apache.commons.fileupload.*,org.apache.commons.io.output.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.disk.*" errorPage="" %>
<jsp:useBean id="dbConn" scope="request" class="com.villa.db.DBProperties"/>
<%@ include file="sessionchk.jsp"%>
<%@ include file="function.jsp"%>
<%
	Connection conn=null;
	conn=dbConn.getConnection();
	
	String iListID=request.getParameter("iListID");
	
	PreparedStatement psImageProperty=null;
	
	byte[] b=null;
	try{
		String sqlImageProperty="insert into list_album (iListID, bImage, cStatus) values(?,?,'P')";
		psImageProperty=conn.prepareStatement(sqlImageProperty);
		
		DiskFileItemFactory factory = new DiskFileItemFactory();

		ServletFileUpload sfu = new ServletFileUpload(factory);
		List items = sfu.parseRequest(request);

		Iterator iter = items.iterator();
		
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (!item.isFormField()) {
		        b = item.get();
		    } 
		}
		
		
		psImageProperty.setInt(1,nullIntconv(iListID));
		psImageProperty.setBytes(2,b);
		
		psImageProperty.executeUpdate();
		
		try{
		 if(psImageProperty!=null){
			 psImageProperty.close();
		 }
		 		 
		 if(conn!=null){
		  conn.close();
		 }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		response.sendRedirect("successImage.jsp");
	}
	catch(Exception e)
	{
	  e.printStackTrace();
	  response.sendRedirect("uploadAppImage.jsp");
	}

%>

