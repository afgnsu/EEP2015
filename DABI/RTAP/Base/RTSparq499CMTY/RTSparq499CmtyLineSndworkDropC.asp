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
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTSparq499CmtyLINEsndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A����
   IF LEN(TRIM(RSXX("bonuscloseym"))) <> 0 THEN
      ENDPGM="3"
   elseif ISNULL(RSXX("DROPDAT")) THEN
      endpgm="4"
   ELSE
      sqlyy="select max(entryno) as entryno FROM RTSparq499CmtyLINEsndworklog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTSparq499CmtyLINEsndworklog(COMQ1, LINEQ1, PRTNO, ENTRYNO, CHGDAT, CHGCODE, CHGUSR, " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, " _
           &"ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3,REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT, " _
           &"DROPDESC, CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, PRTDAT, EUSR, EDAT, UUSR, UDAT, CLOSEUSR, DROPUSR, UNCLOSEDAT, FINISHDAT) " _
           &"SELECT   COMQ1, LINEQ1, PRTNO, " & ENTRYNO & ", getdate(), 'R','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, " _
           &"ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, " _
           &"ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3, " _
           &"REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT,'�D�u���u��@�o����', " _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, " _
           &"PRTDAT,EUSR,EDAT,UUSR,UDAT,CLOSEUSR,DROPUSR,UNCLOSEDAT,FINISHDAT  " _
           &"FROM RTSparq499CmtyLINEsndwork where comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTSparq499Cmtylinesndwork set dropdat=null,dropdesc='�D�u���u��@�o����',dropusr='' where comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTSparq499CmtyLINEsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
      end if
   END IF
   IF ENDPGM="1" THEN
      FROMEMAIL="MIS@CBBN.COM.TW"
      Set jmail = Server.CreateObject("Jmail.Message")
      jmail.charset="BIG5"
      jmail.from = "MIS@cbbn.com.tw"
      Jmail.fromname="�t���u�����499�t�γq��"
      jmail.Subject = "�u�����499���u��J" & KEY(0) & "-" & KEY(1) & "-" & KEY(2) & "�A�@�o����q��"
      jmail.priority = 1  
      body="<html><body><table border=0 width=""100%""><tr><td colspan=2>" _
      &"<H3>�t���u�����499�D�u���u��@�o����q��</h3></td></tr>" _
      &"<tr><td width=""30%"">&nbsp;</td><td width=""70%"">&nbsp;</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ϥD�u�Ǹ�</td><td bgcolor=pink align=left>" &KEY(0) & "-" & KEY(1) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���u�渹</td><td bgcolor=pink align=left>" &KEY(2) &"</td></tr>" _
      &"</table></body></html>"     
      jmail.HTMLBody = BODY
      'JMail.AddRecipient "anita@cbbn.com.tw","�u��499�`���f"
      JMail.AddRecipient "mis@cbbn.com.tw","��T��"
      'JMail.AddRecipient "brian@cbbn.com.tw","�u�ȵ��f"
      jmail.Send( "118.163.60.171" )              
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
       msgbox "�D�u���u��@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "������p��~��w�s�b��Ʈɪ�ܸӵ���Ƨ��u�����뤧�����w����,���i�A�@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����u��|���@�o�A���i����@�o����@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k���欣�u��@�o����@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTSparq499Cmtylinesndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>