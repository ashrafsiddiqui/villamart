<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>



<HTML>
<HEAD>
<TITLE>OC4J JSP Sample - Sending Mail using Java Mail API</TITLE>
</HEAD>
<BODY background="../../images/Background.gif">

 <SCRIPT LANGUAGE="JavaScript1.1">
    function submission1() {
      if(document.form1.p_from.value =="" ||
         document.form1.p_to.value =="" ||
         document.form1.p_smtpServer.value =="") {
        alert("Host, From and To fields are mandatory.");
        return;
      }

      
      document.form1.submit();
    }
  </SCRIPT>
  <CENTER><BR>
  <br>
  <BR>
   <TABLE BGCOLOR=black WIDTH=100% CELLPADDING="1">
    <TR><TD>

    
    </TD></TR>
   </TABLE>
   <TABLE BORDER=0 >
    <TR>
    <TD>
      <FORM METHOD="get" name="form1" action="SendMail.jsp">
      <TABLE BORDER=0 CELLPADDING=4>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>Mail Server Host</b></TD>

              <TD ALIGN=LEFT width="298">
                
                <INPUT TYPE="text" NAME="p_smtpServer" SIZE=60 >
          </TD>
        </TR>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>From</b></TD>
              <TD ALIGN=LEFT width="298">
                <INPUT TYPE="TEXT" SIZE=60 MAXLENGTH=60 NAME="p_from">
          </TD>

        </TR>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>To</b></TD>
              <TD ALIGN=LEFT width="298">
                <INPUT TYPE=TEXT SIZE=60 MAXLENGTH=200 NAME="p_to">
          </TD>
        </TR>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>CC</b></TD>
              <TD ALIGN=LEFT width="298">
                <INPUT TYPE=TEXT SIZE=60 MAXLENGTH=200 NAME="p_cc">
          </TD>

        </TR>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>BCC</b></TD>
              <TD ALIGN=LEFT width="298">
                <INPUT TYPE=TEXT SIZE=60 MAXLENGTH=200 NAME="p_bcc">
          </TD>
        </TR>
        <TR>
              <TD ALIGN=RIGHT width="124"><b>Subject</b></TD>
              <TD ALIGN=LEFT width="298">
                <INPUT TYPE=TEXT SIZE=60 MAXLENGTH=100 NAME="p_subject">
          </TD>
        </TR>

      </TABLE>
          <b>Message</b><br>
      <TEXTAREA NAME="p_message" ROWS="10" COLS="66" SIZE="2000"></TEXTAREA>
      <BR><BR>
      <CENTER>
      <INPUT TYPE="BUTTON" VALUE=" Send " onClick="submission1();">  
      <INPUT TYPE=RESET VALUE="Reset Form"><br>
      </CENTER>
      </FORM>
    </TD>
    </TR>
  </TABLE>
  </CENTER>
  </BODY>

</HTML>