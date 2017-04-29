<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.net.*,java.io.*,java.sql.*,java.util.*,javax.mail.*,javax.mail.internet.*" errorPage="" %>
<%!
 public String send(String p_from, String p_to, String p_cc, String p_bcc,String p_subject, String p_message, String p_smtpServer) {
     System.out.println("in beans");
	String l_result = "<BR><BR><BR><BR><BR><BR><BR>";
    // Name of the Host machine where the SMTP server is running
    String l_host = p_smtpServer;
    
    // Gets the System properties
    Properties l_props = System.getProperties();

    System.out.println("in beans");
    // Puts the SMTP server name to properties object
    l_props.put("mail.smtp.host", l_host);

    // Get the default Session using Properties Object
    Session l_session = Session.getDefaultInstance(l_props, null);

    l_session.setDebug(true); // Enable the debug mode

    try {
      MimeMessage l_msg = new MimeMessage(l_session); // Create a New message

      l_msg.setFrom(new InternetAddress(p_from)); // Set the From address

      // Setting the "To recipients" addresses
      l_msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse(p_to, false));

      // Setting the "Cc recipients" addresses
      l_msg.setRecipients(Message.RecipientType.CC,InternetAddress.parse(p_cc, false));

      // Setting the "BCc recipients" addresses

      l_msg.setRecipients(Message.RecipientType.BCC,InternetAddress.parse(p_bcc, false));

      l_msg.setSubject(p_subject); // Sets the Subject

      // Create and fill the first message part
      MimeBodyPart l_mbp = new MimeBodyPart();
      l_mbp.setText(p_message);

      // Create the Multipart and its parts to it
      Multipart l_mp = new MimeMultipart();
      l_mp.addBodyPart(l_mbp);


      // Add the Multipart to the message
      l_msg.setContent(l_mp);

      // Set the Date: header
      l_msg.setSentDate(new java.util.Date());

      // Send the message
      Transport.send(l_msg);
      // If here, then message is successfully sent.
      // Display Success message
      l_result = l_result + "<FONT SIZE=4 COLOR=\"blue\"><B>Success!</B>"+ "<FONT SIZE=4 COLOR=\"black\"> "+"<HR><FONT color=green><B>Mail was successfully sent to </B></FONT>: "+p_to+"<BR>";
      //if CCed then, add html for displaying info
      if (!p_cc.equals(""))
        l_result = l_result +"<FONT color=green><B>CCed To </B></FONT>: "+p_cc+"<BR>";
      //if BCCed then, add html for displaying info
      if (!p_bcc.equals(""))
        l_result = l_result +"<FONT color=green><B>BCCed To </B></FONT>: "+p_bcc ;

      l_result = l_result+"<BR><HR>";
    } catch (MessagingException mex) { // Trap the MessagingException Error
        // If here, then error in sending Mail. Display Error message.
        l_result = l_result + "<FONT SIZE=4 COLOR=\"blue\"> <B>Error : </B><BR><HR> "+  "<FONT SIZE=3 COLOR=\"black\">"+mex.toString()+"<BR><HR>";
    } catch (Exception e) {

        // If here, then error in sending Mail. Display Error message.
        l_result = l_result + "<FONT SIZE=4 COLOR=\"blue\"> <B>Error : </B><BR><HR> "+"<FONT SIZE=3 COLOR=\"black\">"+e.toString()+"<BR><HR>";

        e.printStackTrace();
    }//end catch block
    finally {
      return l_result;
    }
  }
%>

 <HTML>
  <HEAD>

  <TITLE>Testing</TITLE>
  </HEAD>
  <BODY>
<%
    String l_from    = request.getParameter("p_from");
    String l_to      = request.getParameter("p_to");
    String l_cc      = request.getParameter("p_cc");
    String l_bcc     = request.getParameter("p_bcc");
    String l_subject = request.getParameter("p_subject");
    String l_message = request.getParameter("p_message");

    String l_smtpSvr = request.getParameter("p_smtpServer");
    session.setAttribute("smtpServer",l_smtpSvr);
	//java.util.Date raDate=new java.util.Date();
	//System.out.println("ssss\n\n");
	//System.out.println(raDate);
    String l_result  = send(l_from,l_to,l_cc,l_bcc,l_subject,l_message,l_smtpSvr);
	System.out.println("ssss\n\n");
  %>
 <%=l_result%>
  <FONT SIZE="3" COLOR="blue">
  <A HREF="InputsForm.jsp">Compose Mail</A></FONT>
  </BODY>
</HTML>
 

 