<%       
      '---------------------------------------- 
      '   contentId = jmail.AddAttachment("d:\cbnweb\webap\rtap\base\stockmoney\teatime_930419.htm") ==>�������[�ɮ׮ɥ�
	   '  JMail.appendbodyfromfile "d:\cbnweb\webap\rtap\base\stockmoney\teatime_930419.htm" ==>�A��txt��
	   '  JMail.addurlattachment "HTTP://cbbn.money.hinet.net/food_files/food_930429.htm","teatime_930429.htm",TRUE
	   '  JMail.addattachment "D:\CBNWEB\WEBAP\RTAP\basE\stockmoney\FOOD_930419.htm",TRUE,"text/html"
	     Server.ScriptTimeout = 30000
	     endpgm="1"
         KEY=REQUEST("KEY")
         keyary=split(key,";")
         set jmail=server.createobject("jmail.message")
         jmail.charset="BIG5"
         jmail.from = "money@cbbn.com.tw"
         Jmail.fromname="[���¤W��]�ȪA����"
         jmail.priority = 1
         '------------------------------------------------
         ' CONN SECTION
         '------------------------------------------------
         DSN="DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
         Set Conn = Server.CreateObject("ADODB.Connection")
         Conn.Open DSN
         Set RS = Server.CreateObject("ADODB.Recordset") 
         Set RSXX = Server.CreateObject("ADODB.Recordset") 
         '=--------------------------------------------------
         '�U�ȯ�
         if keyary(1)="Y" THEN
            '------------------------------------------------
            '�ˬd�Ӥ餧�U�ȯ��q�l���O�_�w�o�e ==> �Ҷq�@��i�঳�h���q�l���A�G���H�������P�_��¦�A�ӥH�C�@���U�ȯ���Ƥ�sndflag���D�A���O�U�ȯ��o�e�������٬O��s�C
            '------------------------------------------------
         '   ddstr=cint(mid(keyary(0),9,2))
         '   sql="select substring(dd," & ddstr & ",1) as dflag from STNEWSPAPERSNDLOG where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='01' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
         '   rs.Open sql,conn
         '   if not rs.eof then
         '      flag=rs("dflag")
         '   else
         '      flag=""
         '   end if
         '   rs.close
         '   if flag <> "1" then 
               msg="[���¤W��]�D���ǤU�ȯ��q�l��" & KEYARY(0)
               jmail.Subject="[���¤W��]�D���ǤU�ȯ��q�l��" & KEYARY(0)
               '-------
               SQL="SELECT * from stteatime where sndflag <> 'Y' "
               rsXX.Open sql,conn,3,3
               DO WHILE NOT RSXX.EOF
                  if not rsXX.eof THEN
                     EIP=rsXX("ip")
                     EDATE=rsXX("t")
                     ESUBJECT=rsXX("subject")
                     ENOTE=rsXX("note")
                     ERRFLG=""
                     RSXX("SNDFLAG")="Y"
                     RSXX.UPDATE
                   else
                     EIP=""
                     EDATE=""
                     ESUBJECT=""
                     ENOTE=""
                     errflg="Y"
                   end if
               '-----
                   BODYTXT="<html><head><meta http-equiv='Content-Language' content='zh-cn'>" _
                         &"<link rel='stylesheet' href='style.css' type='text/css'>"  _
                         &"<meta http-equiv='Content-Type' content='text/html; charset=big5'><title></title></head>" _
                         &"<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#FFFFFF' width='100%' id='AutoNumber1' height='26' bgcolor='#FFFFFF' bordercolorlight='#99CCFF'>" _
                         &"<tr><td width='100%' height='26' bgcolor='#FFFFFF'><p align='center'><FONT SIZE='6' COLOR='BLUE'><B>���¤W��D���ǤU�ȯ��q�l��</FONT></p>" _
                         &"</td></tr><table bgcolor='7285CF' style='FILTER: alpha(opacity=50)'></table><body background='img/bg.gif'>" _
                         &"<br><div align='center'><center><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#808080' width='88%' id='AutoNumber5' height='23' bgcolor='#F5F5F5'>" _
                         &"</table></center></div><BR><div align='center'><center><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#99CCFF' width='89%' id='AutoNumber1' height='135' bordercolorlight='#99CCFF'>" _
                         &"<tr><td width='100%' height='22' colspan='2' bgcolor='#F5F5F5'>&nbsp;<U><font size='4'>�D�D:</font><font size='4' color='#80AA00'>" & ESUBJECT  _
                         &"</font></U></td></tr><tr><td width='81%' height='109' bgcolor='#ffffff'><div align='center'>" _
                         &"<center><table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='564' id='AutoNumber4' height='4'>" _
                         &"<tr><td width='614' style='font-size: 2pt' height='3' colspan='3'></td></tr><tr><td width='39' height='4' style='font-size: 2pt'></td>" _
                         &"<td width='571' height='4'>�o��ɶ�:" & EDATE & "&nbsp;&nbsp; IP:" & EIP & "</td>" _
                         &"<td width='4' height='4'></td></tr><tr><td width='39' height='1' style='font-size: 2pt'></td><td width='571' height='1'><hr color='#C0C0C0' size='1'>" _
                         &"</td><td width='4' height='1'></td></tr><tr><td width='39' height='1' style='font-size: 2pt' rowspan='2'></td>" _
                         &"<td width='571' height='12'><b><font size='4' color='#0000FF'>�D�D:" & ESUBJECT & "</font></b></td>" _
                         &"<td width='4' height='1' rowspan='2'></td></tr><tr><td width='571' height='4' style='font-size: 3pt'></td>" _
                         &"</tr><tr><td width='39' height='106' style='font-size: 2pt' rowspan='3'></td><td width='571' height='90'><font size='4'>" & ENOTE & "</font></td>" _
                         &"<td width='4' height='106' rowspan='3'></td></tr><tr><td width='571' height='9'><hr color='#C0C0C0' size='1'>" _
                         &"</td></tr><tr><td width='571' height='7'>&nbsp; </font> <font color='#0080C0'></font>&nbsp</td></tr><tr><td width='614' style='font-size: 2pt' height='3' colspan='3'></td>" _
                         &"</tr></table></center></div></td></tr></table></center></div><br></tr><tr><td bgcolor='#ACD6FF' height='14'></td></tr></table><div align='center'><center><table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#808080' width='90%' id='AutoNumber3' height='22' bgcolor='#F5F5F5'><tr><td width='19%' height='22' bgcolor='#E4E4E4'><p align='center'>" _
                         &"<p align='center'>�D�D��:1 ����:1</td><td width='81%' height='22'><p align='center'></td></tr></table></center></div><br><p align='center'></p></table>" _
                         &"<P><P>���¤W����}�J<A HREF='http://cbbn.money.hinet.net'>http://cbbn.money.hinet.net</a></body></html>" _

                   '-------
                   IF ERRFLG <> "Y" THEN
                  '�D�|��
                      SQL="SELECT EMAIL,cusnc FROM NonMemberNewspaper WHERE (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '01') AND " _
                         &"(ENDDAT IS NULL) AND (CLOSEFLAG = '') and email<>'' " 
                      RS.Open SQL,CONN
                      DO while not rs.eof
                         Jmail.Recipients.clear
                         jmail.Subject="[���¤W��]�D���ǤU�ȯ��q�l��" & KEYARY(0)
                         jmail.HTMLBody=BODYTXT
                         JMail.AddRecipient RS("EMAIL"),RS("CUSNC")
                         jmail.Send ( "jmail:jmail1@118.163.60.171" )   
                        '��s�D�|���q�l���o�e���
                         sqlxx=" update NonMemberNewspaper set sndcnt=sndcnt+1,LASTSNDDAT=GETDATE() where email='" & rs("email") & "' and (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '01') "
                         conn.Execute sqlxx
                         RS.MoveNext
                      LOOP
                      '�H�e�޲z���@��
                      Jmail.Recipients.clear
                      jmail.Subject="[���¤W��]�D���ǤU�ȯ��q�l��" & KEYARY(0)
                      jmail.HTMLBody=BODYTXT
                      JMail.AddRecipient "MIS@CBBN.COM.TW","�q�l���޲z��"
                      JMail.AddRecipient "tank@CBBN.COM.TW","�x��"
                      JMail.AddRecipient "AVON@CBBN.COM.TW","�q�l�����ɭ�"
                      jmail.Send ( "jmail:jmail1@118.163.60.171" )   
                      RS.Close   
                     '�|��
                      SQL="SELECT STMember.memberid,STMember.EMAIL as email,STMember.cusnc FROM STMemberNewsPaper INNER JOIN STMember ON " _
                         &"STMemberNewsPaper.MEMBERID = STMember.MEMBERID WHERE (STMemberNewsPaper.NEWSPAPERKIND = 'A2') AND " _
                         &"(STMemberNewsPaper.NEWSPAPERCODE = '01') AND (STMemberNewsPaper.ENDDAT IS NULL) AND " _
                         &"(STMemberNewsPaper.CLOSEFLAG = '') AND (STMember.EMAIL <> '')  "
                      RS.Open SQL,CONN
                      DO while not rs.eof
                         Jmail.Recipients.clear
                         jmail.Subject="[���¤W��]�D���ǤU�ȯ��q�l��" & KEYARY(0)
                         jmail.HTMLBody=BODYTXT
                         JMail.AddRecipient RS("EMAIL"),RS("CUSNC")
                         jmail.Send ( "jmail:jmail1@118.163.60.171" )   
                         '��s�|���q�l���o�e���
                         sqlxx=" update STMemberNewsPaper set sndcnt=sndcnt+1,LASTSNDDAT=GETDATE() where memberid='" & rs("memberid") & "' and (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '01') "
                         conn.Execute sqlxx   
                         RS.MoveNext
                      LOOP
                      RS.Close
                      '��s�q�l���o�e�H����(STNEWSPAPERSNDLOG)
                      SQL="SELECT NEWSPAPERKIND, NEWSPAPERCODE, YY, MM, DD, MONEND from STNEWSPAPERSNDLOG where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='01' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                      RS.Open SQL,CONN,3,3
                      IF RS.EOF THEN
                         RS.AddNew
                         RS("NEWSPAPERKIND")="A2"
                         RS("NEWSPAPERCODE")="01"
                         RS("YY")=mid(keyary(0),1,4)
                         RS("MM")=mid(keyary(0),6,2)
                         RS("DD")=STRING(31,"0")
                         RS.UPDATE
                      '
                         sqlxx="update STNEWSPAPERSNDLOG set dd=STUFF(DD, CONVERT(int, SUBSTRING('" & keyary(0) & "', 9, 2)), 1, '1') where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='01' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                         conn.Execute sqlxx
                         if err.number > 0 then
                            endpgm="2"
                         end if
                      ELSE
                         sqlxx="update STNEWSPAPERSNDLOG set dd=STUFF(DD, CONVERT(int, SUBSTRING('" & keyary(0) & "', 9, 2)), 1, '1') where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='01' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                         conn.Execute sqlxx
                         if err.number > 0 then
                            endpgm="2"
                         end if
                      END IF
                      RS.CLOSE
                   end if
                   RSXX.MoveNext
               LOOP  
               RSXX.CLOSE
         '   END IF
         END IF
         '�p�е�
         if keyary(2)="Y" THEN
            '------------------------------------------------
            '�ˬd�Ӥ餧�p�е�q�l���O�_�w�o�e
            '------------------------------------------------
            ddstr=cint(mid(keyary(0),9,2))
            sql="select substring(dd," & ddstr & ",1) as dflag from STNEWSPAPERSNDLOG where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='02' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
            rs.Open sql,conn
            if not rs.eof then
               flag=rs("dflag")
            else
               flag=""
            end if
            rs.close
            '�Ӥ�|���o�e�p�е�ɤ~�i����
            if flag <> "1" then 
               msg="[���¤W��]�D���Ǩp�е�q�l��" & KEYARY(0)
               jmail.Subject="[���¤W��]�D���Ǩp�е�q�l��" & KEYARY(0)
               yymmdd=trim(cstr(cint(mid(keyary(0),1,4))-1911)) & mid(keyary(0),6,2) & mid(keyary(0),9,2)
               FILENAME="food_" & yymmdd & ".htm"
               JMail.addurlattachment "HTTP://cbbn.money.hinet.net/food_files/" & filename,filename,TRUE
               '�D�|��
               SQL="SELECT EMAIL,cusnc FROM NonMemberNewspaper WHERE (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '02') AND " _
                  &"(ENDDAT IS NULL) AND (CLOSEFLAG = '') and email<>'' " 
               RS.Open SQL,CONN
               DO while not rs.eof
                  Jmail.Recipients.clear
                  Jmail.body="[���¤W��]�D���Ǩp�е�q�l���J" & keyary(0)
                  jmail.Subject="[���¤W��]�D���Ǩp�е�q�l��" & KEYARY(0)
                  JMail.AddRecipient RS("EMAIL"),RS("CUSNC")
                  jmail.Send ( "jmail:jmail1@118.163.60.171" )   
                  '��s�D�|���q�l���o�e���
                  sqlxx=" update NonMemberNewspaper set sndcnt=sndcnt+1,LASTSNDDAT=GETDATE() where email='" & rs("email") & "' and (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '02') "
                  conn.Execute sqlxx
                  RS.MoveNext
               LOOP
               '�H�e�޲z���@��
               Jmail.Recipients.clear
               jmail.Subject="[���¤W��]�D���Ǩp�е�q�l��" & KEYARY(0)
               Jmail.body="[���¤W��]�D���Ǩp�е�q�l���J" & keyary(0)
              ' JMail.addurlattachment "HTTP://cbbn.money.hinet.net/food_files/" & filename,filename,TRUE
               JMail.AddRecipient "MIS@CBBN.COM.TW","�q�l���޲z��"
               JMail.AddRecipient "tank@CBBN.COM.TW","�x��"
               JMail.AddRecipient "AVON@CBBN.COM.TW","�q�l�����ɭ�"
               jmail.Send ( "jmail:jmail1@118.163.60.171" )   

               RS.Close   
               '�|��
               SQL="SELECT STMember.memberid,STMember.EMAIL as email,STMember.cusnc FROM STMemberNewsPaper INNER JOIN STMember ON " _
                  &"STMemberNewsPaper.MEMBERID = STMember.MEMBERID WHERE (STMemberNewsPaper.NEWSPAPERKIND = 'A2') AND " _
                  &"(STMemberNewsPaper.NEWSPAPERCODE = '02') AND (STMemberNewsPaper.ENDDAT IS NULL) AND " _
                  &"(STMemberNewsPaper.CLOSEFLAG = '') AND (STMember.EMAIL <> '') "
               RS.Open SQL,CONN
               DO while not rs.eof
                  Jmail.Recipients.clear
                  Jmail.body="[���¤W��]�D���Ǩp�е�q�l���J" & keyary(0)
                  jmail.Subject="[���¤W��]�D���Ǩp�е�q�l��" & KEYARY(0)
                  JMail.AddRecipient RS("EMAIL"),RS("CUSNC")
                  jmail.Send ( "jmail:jmail1@118.163.60.171" )   
                  '��s�|���q�l���o�e���
                  sqlxx=" update STMemberNewsPaper set sndcnt=sndcnt+1,LASTSNDDAT=GETDATE() where memberid='" & rs("memberid") & "' and (NEWSPAPERKIND = 'A2') AND (NEWSPAPERCODE = '02') "
                  conn.Execute sqlxx   
                  RS.MoveNext
               LOOP
               RS.Close
                '��s�q�l���o�e�H����(STNEWSPAPERSNDLOG)
                SQL="SELECT NEWSPAPERKIND, NEWSPAPERCODE, YY, MM, DD, MONEND from STNEWSPAPERSNDLOG where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='02' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                RS.Open SQL,CONN,3,3
                IF RS.EOF THEN
                   RS.AddNew
                   RS("NEWSPAPERKIND")="A2"
                   RS("NEWSPAPERCODE")="02"
                   RS("YY")=mid(keyary(0),1,4)
                   RS("MM")=mid(keyary(0),6,2)
                   RS("DD")=STRING(31,"0")
                   RS.UPDATE
                   RS.CLOSE
                '
                   sqlxx="update STNEWSPAPERSNDLOG set dd=STUFF(DD, CONVERT(int, SUBSTRING('" & keyary(0) & "', 9, 2)), 1, '1') where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='02' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                   conn.Execute sqlxx
                   if err.number > 0 then
                      endpgm="2"
                   end if
                ELSE
                   sqlxx="update STNEWSPAPERSNDLOG set dd=STUFF(DD, CONVERT(int, SUBSTRING('" & keyary(0) & "', 9, 2)), 1, '1') where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='02' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
                   conn.Execute sqlxx
                   if err.number > 0 then
                      endpgm="2"
                   end if
                END IF
           end if
         END IF
            '��r�Z
         if keyary(3)="Y" THEN
            '------------------------------------------------
            '�ˬd�Ӥ�???�Ϊ̤�???�Ϊ�....���t����r�Z�q�l���O�_�w�o�e
            '------------------------------------------------
            ddstr=cint(mid(keyary(0),9,2))
            sql="select substring(dd," & ddstr & ",1) as dflag from STNEWSPAPERSNDLOG where NEWSPAPERKIND='A2' AND NEWSPAPERCODE='03' AND YY='" & mid(keyary(0),1,4) & "' AND MM='" & mid(keyary(0),6,2) & "' "
            rs.Open sql,conn
            if not rs.eof then
               flag=rs("dflag")
            else
               flag=""
            end if
            if flag <> "1" then 
               msg="[�ª��e�t��]��r�Z�q�l��" & KEYARY(0)
               jmail.Subject="[�ª��e�t��]��r�Z�q�l��" & KEYARY(0)
            end if
         END IF

	    '-------------------------------------------------
         Set RS = Nothing 
         Set RSXX = Nothing 
         Conn.Close         
         Set Conn = Nothing 
         

         
%>
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�q�l���o�e����",0
       Set winP=window.Opener
       Set docP=winP.document       
       winP.focus()              
       window.CLOSE
    elseif frm1.htmlfld.value="2" then
       msgbox "�q�l���o�e����",0
       Set winP=window.Opener
       Set docP=winP.document       
       winP.focus()              
       window.CLOSE       
    else
       msgbox "�L�k����q�l���o�e�@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtyhardwaredrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>