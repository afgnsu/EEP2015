<%  
  usr = request("usr")
  pwd = request("pwd")
  typ = request("typ")
  Msg="�п�J�z���ϥΪ̱b���αK�X"    
  session("passed") = False
  
  if typ = "login" or typ="" then
     typ1 = "checked" 
     typ2 = "" 
  elseif typ = "chgpw" then
     typ1 = "" 
     typ2 = "checked" 
  end if
  
  If Not (IsEmpty(Request("Usr")) or Request("Usr") = "" or Request("PWD") = "" or IsEmpty(Request("PWD"))) Then
     Set conn=Server.CreateObject("ADODB.Connection")
     conn.open "DSN=RTLib"
     Set rs=Server.CreateObject("ADODB.Recordset")
    '������g�P�ӻPisp���Y�ɤ��s�b�g�P�ӻP�F��isp�����Y��ƪ�,�~�i�i�J
     sql = "SELECT rtconsignee.CUSID, rtconsignee.CUSNO, rtconsignee.PASSWORD,rtconsignee.COMTYPE FROM RTConsignee inner join rtconsigneeisp on rtconsignee.cusid=rtconsigneeisp.cusid and rtconsigneeisp.isp='04' WHERE CUSNO='" & USR & "'"     
     
     rs.open sql,conn
     If Not rs.EOF Then
        if pwd <> trim(rs("PASSWORD")) then
           msg ="�K�X���~�I"
        else
           msg ="�K�X���T�I"
           Session("UserID")=rs("CUSID")
           Session("COMTYPE")=rs("COMTYPE")
           'Session("UserPW")=rs("CUSID")
           Session("passed") = True
           if typ = "login" then '���ɦ�[�g�P��]���D�e��
              '�F��
              if TRIM(rs("cusid"))="70771579" then
                 Response.Redirect "http://www.avsl.com.tw/avsconsignee/rtebtcmtyinq.asp"
              else
                 Response.Redirect "http://www.avsl.com.tw/avsconsignee/rtebtcmtyinq.asp"
              end if
           elseif typ = "chgpw" then '���ɦ�[�ק�K�X]������
              Response.Redirect "http://www.avsl.com.tw/avsconsignee/chgpwd2.asp?uid="&usr
           end if   
        end if
     else
        Msg="�b�����s�b!"
     End If
     rs.Close
     conn.close
  End If
  
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=big5">
		<title>���T�g�P�ӫȤ�d�ߨt��</title>
	</head>
	<body bgcolor="" text="#000000">
<table width="700" border="0" cellspacing="0" cellpadding="0" height="385">
  <tr> 
    <td> 
      <div align="center"> 
        <form action="logon.asp" name="frm1" method="post">
          <p>&nbsp;</p>
          <p align="center"><b><font color="#000000" size="3"><img src="images/consignee.gif" width="511" height="95"></font> 
            <br>
            </b> 
          <p> 
          <table align="center" width="521" border="1" cellspacing="1" cellpadding="3" bordercolor="#003366" height="51">
            <tr> 
              <td width="76" height="16" bgcolor="#E0F0F8" align="center"><font color="#000000" size="2">�b 
                ��</font></td>
              <td width="191" height="16" bgcolor="#E0F0F8"> 
                <input type="TEXT" id="usr" name="usr" size=15 value="<%=USr%>">
              </td>
              <td width="98" height="16" bgcolor="#E0F0F8"> 
                <p align="center"><font color="#000000" size="2">�K �X</font> 
              </td>
              <td width="167" height="16" bgcolor="#E0F0F8"> 
                <input type="password" id="pwd" name="PWD" size=15 value="<%=PWD%>">
              </td>
            </tr>
            <tr> 
              <td width="98" height="16" bgcolor="#E0F0F8"> 
                <p align="center"><font color="#000000" size="2">����ʧ@</font> 
              </td>
              <td width="532" height="16" bgcolor="#E0F0F8" colspan="4"> 
                <p> 
                  <input type="radio" name=typ value=login <%=typ1%>>
                  <font size="2">�n�J</font>&nbsp;&nbsp;&nbsp; 
                  <input type="radio" name=typ value=chgpw <%=typ2%>>
                  <font size="2">�ק�K�X</font></p>
              </td>
            </tr>
            <tr> 
              <td width="532" height="16" bgcolor="" colspan="4"> 
                <p align="center"> 
                  <input type="submit" name="b1" value="���@��">
                </p>
              </td>
            </tr>
            <tr> 
              <td width="76" height="16" bgcolor="#E0F0F8" align="center"><font size="2">�T���C</font></td>
              <td width="456" height="16" colspan="3" bgcolor="#E0F0F8"><font size="2">&nbsp;<%=msg%></font> 
              </td>
            </tr>
          </table>
          <p><br>
            <br>
            <br>
            <br>
            <br>
            <br>
          </p>
        </form>
      </div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="right"> </div>
      <hr size="1" color=666666  noshade width="600">
    </td>
  </tr>
  <tr> 
    <td height="2"> 
      <div align="center"> <font color="#333333" size="2" face="Verdana, Arial, Helvetica, sans-serif">Copyright 
        2001 COSMACTIVE CO.,Ltd </font> </div>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
