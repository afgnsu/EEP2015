<%
  Set conn=Server.CreateObject("ADODB.Connection")  
  Set RS=Server.CreateObject("ADODB.recordset")  
  DSN="DSN=RTLib"
  conn.Open DSN  
  sql="select * from HB2002ACT1 where  DROPDAT IS NULL AND SENDMAILDAT IS NULL and email='edson@cbbn.com.tw' "  
  rs.Open sql,conn
  subject="���T�e�W2002�Ȥ�^�Q�a�������---����Ǹ�.."
  body="<html><body><table border=0 width=""100%""><tr><td colspan=2>" _
        &"<H3>���T�e�W2002�Ȥ�^�Q�a�������---����Ǹ�</h3></td></tr>" _
        &"<tr><td width=""30%"">&nbsp;</td><td width=""70%"">&nbsp;</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>����Ǹ�</td><td bgcolor=pink align=left>" &rs("serno") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>�m�W</td><td bgcolor=pink align=left>" &rs("name") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>�ʧO</td><td bgcolor=pink align=left>" &rs("sexc") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>���q�q��</td><td bgcolor=pink align=left>" &rs("telc") & "#" & rs("EXT") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>��a�q��</td><td bgcolor=pink align=left>" &rs("telH") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>��ʹq��</td><td bgcolor=pink align=left>" &rs("mobile") & "</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>E-Mail</td><td bgcolor=pink align=left>" &rs("email") &"</td></tr>" _
        &"<tr><td bgcolor=lightblue align=center>��ƶ�g��</td><td bgcolor=pink align=left>" &rs("edat") &"</td></tr>" _
        &"<tr><td>&nbsp;</td><td><br><input type=button value="" ���� "" onclick=""vbscript:window.close""" _
        &" style=""cursor:hand"" id=button1 name=button1></td></tr>" _
        &"</table></body></html>"  
  email="service@cbbn.com.tw"
  Set objMail=CreateObject("CDONTS.Newmail")   
  Do while not rs.EOF
  '   rs("sendmaildat")=now()
  '   rs.update     
 '    objMail.BodyFormat=0
 '    objMail.MailFormat=0
     Response.Write "from=" & email & ";TO=" & rs("email") & ";subject=" & subject & ";body=" & body & "<BR>"
     objMail.Send email,rs("email"),subject,body

  loop
  Set ObjMail=Nothing
%>
