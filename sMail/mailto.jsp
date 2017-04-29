<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="sendMail" class="SendMailBean" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%
//here is some example code , i use it to send google mail.
public void smtp(String receiver, String content) throws MessagingException {
if (smtpHost == null)
throw new MessagingException("smtpHost not found");
if (user == null)
throw new MessagingException("user not found");
if (password == null)
throw new MessagingException("password not found");
Properties properties = new Properties();
properties.put("mail.smtp.host", smtpHost); //set smtp server
properties.put("mail.smtp.auth", "true"); //use smtp authen properties.put("mail.transport.protocol", "smtp");
properties.put("mail.smtp.port", "25");
properties.put("mail.smtp.starttls.enable", "true");
Session session = Session.getDefaultInstance(properties,new Authenticator() {public PasswordAuthentication getPasswordAuthentication() {
return new PasswordAuthentication(user, password);
}
});
MimeMessage mimeMsg = new MimeMessage(session);
if (sender != null) {
mimeMsg.setFrom(new InternetAddress(sender));
}
if (receiver != null) {
mimeMsg.setRecipients(Message.RecipientType.TO, parse(receiver));
}
if (subject != null) {
mimeMsg.setSubject(subject, "GBK");
}
MimeBodyPart part = new MimeBodyPart();
part.setText(content == null ? "" : content, "GBK");

part.setContent(content.toString(), "text/html;charset=GBK");
Multipart multipart = new MimeMultipart();
multipart.addBodyPart(part);
mimeMsg.setContent(multipart);
mimeMsg.setSentDate(new Date());
Transport.send(mimeMsg);
}
%>
</body>
</html>
