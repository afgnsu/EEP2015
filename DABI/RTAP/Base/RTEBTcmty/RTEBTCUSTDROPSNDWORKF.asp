<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   SET RSC=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTEBTCUSTDROPsndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��w�@�o�ɡA���i���槹�u���שΥ����u����
   IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("REALENGINEER"))) = 0 AND LEN(TRIM(RSXX("REALCONSIGNEE"))) = 0 then
      endpgm="6"
   elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
      endpgm="5"
   ELSE
      sqlyy="select max(SEQ) as SEQ FROM RTEBTCUSTDROPsndworklog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3)& " and prtno='" & key(4) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("SEQ"))) > 0 then
         SEQ=rsyy("SEQ") + 1
      else
         SEQ=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTEBTCUSTDROPsndworklog " _
           &"SELECT   COMQ1, LINEQ1, CUSID,ENTRYNO,PRTNO, " & SEQ & ", getdate(), 'F','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�Τ������u����'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR  " _
           &"FROM RTEBTCUSTDROPsndwork where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTEBTCUSTDROPsndwork set CLOSEdat=getdate(),CLOSEUSR='" & V(0) & "' where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTEBTCUSTDROPsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' AND SEQ=" & SEQ
            CONNXX.Execute sqlyy 
         else
            '���u���סA����s�Τ�h���D��FINISHDAT
            SQLXX=" update RTEBTCUSTDROP set FINISHdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) 
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlyy="delete * FROM RTEBTCUSTDROPsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' AND SEQ=" & SEQ
               CONNXX.Execute sqlyy 
            ELSE
              '���u���סA����s�Τ�D��dropdat
               SQLXX=" update RTEBTCUST set dropdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
               connxx.Execute SQLXX
               If Err.number > 0 then
                  endpgm="2"
                  '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                  errmsg=cstr(Err.number) & "=" & Err.description
                  sqlyy="delete * FROM RTEBTCUSTDROPsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' AND SEQ=" & SEQ
                  CONNXX.Execute sqlyy 
                  sqlyy="update RTEBTCUSTDROP set FINISHdat=null,UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) 
                  CONNXX.Execute sqlyy 
               else
                  endpgm="1"
                  errmsg=""
                  '�o�eEMAIL�q���������f
               '   SQLXX="select * from rtEBTcustdropsndwORk INNER JOIN RTEBTCMTYH ON rtEBTcustdropsndwork.COMQ1=RTEBTCMTYH.COMQ1 " _
               '          &"INNER JOIN  rtEBTcust ON  rtEBTcustdropsndwork.COMQ1= rtEBTcust.COMQ1 AND rtEBTcustdropsndwork.LINEQ1= rtEBTcust.LINEQ1 " _
               '           &"AND rtEBTcustdropSNDWORK.CUSID= rtEBTcust.CUSID INNER JOIN RTEBTCUSTDROP ON " _
               '           &"RTEBTCUSTDROPSNDWORK.COMQ1=RTEBTCUSTDROP.COMQ1 AND  RTEBTCUSTDROPSNDWORK.LINEQ1=RTEBTCUSTDROP.LINEQ1 AND " _
               '           &"RTEBTCUSTDROPSNDWORK.CUSID=RTEBTCUSTDROP.CUSID  AND RTEBTCUSTDROPSNDWORK.ENTRYNO=RTEBTCUSTDROP.ENTRYNO " _
               '           &"where rtEBTcustdropSNDWORK.comq1=" & key(0) & " and rtEBTcustdropSNDWORK.lineq1=" & key(1) & " and " _
               '           &"rtEBTcustdropSNDWORK.cusid='" & key(2) & "' AND rtEBTcustdropSNDWORK.ENTRYNO=" & KEY(3)
               '    RESPONSE.Write SQLXX
                  rsc.open "select * from rtEBTcustdropsndwORk INNER JOIN RTEBTCMTYH ON rtEBTcustdropsndwork.COMQ1=RTEBTCMTYH.COMQ1 " _
                          &"INNER JOIN  rtEBTcust ON  rtEBTcustdropsndwork.COMQ1= rtEBTcust.COMQ1 AND rtEBTcustdropsndwork.LINEQ1= rtEBTcust.LINEQ1 " _
                          &"AND rtEBTcustdropSNDWORK.CUSID= rtEBTcust.CUSID INNER JOIN RTEBTCUSTDROP ON " _
                          &"RTEBTCUSTDROPSNDWORK.COMQ1=RTEBTCUSTDROP.COMQ1 AND  RTEBTCUSTDROPSNDWORK.LINEQ1=RTEBTCUSTDROP.LINEQ1 AND " _
                          &"RTEBTCUSTDROPSNDWORK.CUSID=RTEBTCUSTDROP.CUSID  AND RTEBTCUSTDROPSNDWORK.ENTRYNO=RTEBTCUSTDROP.ENTRYNO " _
                          &"where rtEBTcustdropSNDWORK.comq1=" & key(0) & " and rtEBTcustdropSNDWORK.lineq1=" & key(1) & " and " _
                          &"rtEBTcustdropSNDWORK.cusid='" & key(2) & "' AND rtEBTcustdropSNDWORK.ENTRYNO=" & KEY(3) ,connXX
                  Set jmail = Server.CreateObject("Jmail.Message")
                  jmail.charset="BIG5"
                  jmail.from = "MIS@cbbn.com.tw"
                  Jmail.fromname="�F��AVS�Τ�h��������u�q��"
                  jmail.Subject = "�F��AVS�h���Τ�J" & RSc("CUSNC") & "-" & RSc("AVSNO") & "�A�w��������q��"
                  jmail.priority = 1  
                  body="<html><body><table border=1 width=""80%""> " 
                  BODY=BODY & "<tr><H3>�F��AVS�h���Τ������u�q��</h3></td></tr>" _
                      &"<tr><td bgcolor=lightblue align=center>�D�u</td><td bgcolor=lightblue align=center>���ϦW��</td>"_
                      &"<td bgcolor=lightblue align=center>�Τ�W��</td><td bgcolor=lightblue align=center>�X���s��</td>"_
                      &"<td bgcolor=lightblue align=center>�h���ӽФ�</td><td bgcolor=lightblue align=center>�w�p�A�Ȥ����</td>" _
                      &"<td bgcolor=LIGHTBLUE align=center>����渹</td></tr>"
                  
                  BODY=BODY & "<tr>" _
                      &"<td bgcolor=pink align=left>" &RSc("COMQ1") & "-" & RSc("LINEQ1")  &"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("COMN")  &"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("CUSNC")&"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("AVSNO")&"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("APPLYDAT")&"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("EXPECTDAT")&"</td>" _
                      &"<td bgcolor=pink align=left>" &RSc("prtno")&"</td></TR>" 
                       
                  BODY=BODY & "</table><P><U>�а���h�������@�~</U></body></html>"
                  FROMEMAIL="MIS@CBBN.COM.TW"
                  jmail.HTMLBody = BODY
                  JMail.AddRecipient "mis@cbbn.com.tw","��T��"
                  JMail.AddRecipient "maybe0606@cbbn.com.tw","�F��AVS�������f"
                  jmail.Send ( "219.87.146.239" )      
                  rsC.close
                  set rsc=nothing
               end if
            END IF
         end if      
      end if
   END IF
   RSXX.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�Τ������u�T�{�槹�u���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i���槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "��������u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "����b���u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "��������u�槹�u�ɡA��������J��ک���H���ι�ک���g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    else
       msgbox "�L�k����Τ������u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylinesndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>