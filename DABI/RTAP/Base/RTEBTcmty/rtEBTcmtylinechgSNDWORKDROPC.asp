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
   SQLYY="SELECT * FROM RTEBTCMTYLINE WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) 
   RSYY.Open SQLYY,CONNXX
   IF LEN(TRIM(RSYY("CONSIGNEE"))) > 0 THEN
      CONSIGNEE="Y" '�g�P ==> MAIL ����
   ELSE
      AREAID=RSYY("AREAID")
      GROUPID=RSYY("GROUPID")
      CONSIGNEE="N" '���P ==> MAIL���U�շ~�U�έ���
   END IF 
   RSYY.CLOSE   
 '  On Error Resume Next
   sqlxx="select * FROM RTEBTCMTYLINECHGSNDWORK WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
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
      sqlyy="select max(entryno) as entryno FROM RTEBTCMTYLINECHGSNDWORKlog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTEBTCMTYLINECHGSNDWORKlog " _
           &"SELECT   COMQ1, LINEQ1, PRTNO, PRTNO2, " & ENTRYNO & ", getdate(), 'R','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, " _
           &"ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, " _
           &"ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3, " _
           &"REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT,'�D�u���ʬ��u��@�o����', " _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, " _
           &"PRTDAT,EUSR,EDAT,UUSR,UDAT,CLOSEUSR,DROPUSR,UNCLOSEDAT,FINISHDAT  " _
           &"FROM RTEBTCMTYLINECHGSNDWORK where comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTEBTCMTYLINECHGSNDWORK set dropdat=null,dropdesc='�D�u���ʬ��u��@�o����' where comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2)  & "' and prtno2='" & key(3) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTEBTCMTYLINECHGSNDWORKlog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
      end if
   END IF
   IF ENDPGM="1" THEN
      Set jmail = Server.CreateObject("Jmail.Message")
      jmail.charset="BIG5"
      jmail.from = "MIS@cbbn.com.tw"
      Jmail.fromname="AVS�t�γq��"
      jmail.Subject = "�F��AVS�D�u���ʬ��u��J" & KEY(0) & "-" & KEY(1) & "-" & KEY(2) & "�A�@�o����q��"
      jmail.priority = 1  
      body="<html><body><table border=0 width=""100%""><tr><td colspan=2>" _
      &"<H3>�F��AVS�D�u���ʬ��u��@�o����q��</h3></td></tr>" _
      &"<tr><td width=""30%"">&nbsp;</td><td width=""70%"">&nbsp;</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ϥD�u�Ǹ�</td><td bgcolor=pink align=left>" &KEY(0) & "-" & KEY(1) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ʳ渹</td><td bgcolor=pink align=left>" &KEY(2) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���u�渹</td><td bgcolor=pink align=left>" &KEY(3) &"</td></tr>" _      
      &"</table></body></html>"     
      jmail.HTMLBody = BODY
      JMail.AddRecipient "anita@cbbn.com.tw","AVS�`���f"
      JMail.AddRecipient "mis@cbbn.com.tw","��T��"
      JMail.AddRecipient "brian@cbbn.com.tw","�u�ȵ��f"
      IF CONSIGNEE="Y" THEN
        ' JMail.AddRecipient "EDSON@cbbn.com.tw","�Y�B"
      ELSE
         IF AREAID="A2" THEN
            JMail.AddRecipient "lini@cbbn.com.tw","�x���~�U"
         ELSEIF AREAID="A3" THEN
            JMail.AddRecipient "cute0318@cbbn.com.tw","�����~�U"
         ELSEIF AREAID="A1" AND (GROUPID="01" OR GROUPID="07") THEN '���
            JMail.AddRecipient "s525422@cbbn.com.tw","���~�U"
         ELSEIF AREAID="A1" AND (GROUPID="G1" OR GROUPID="G2" OR GROUPID="G3"  OR GROUPID="G4"  OR GROUPID="02" OR GROUPID="03" OR GROUPID="04" OR GROUPID="05" OR GROUPID="06") THEN '�x�_
            JMail.AddRecipient "tiffany01@cbbn.com.tw","�x�_�~�U"            
         END IF
      END IF
      jmail.Send( "219.87.146.239" )              
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
       msgbox "�D�u���ʬ��u��@�o���ন�\",0
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
       msgbox "�����ʬ��u��|���@�o�A���i����@�o����@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k���沧�ʬ��u��@�o����@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTEBTCMTYLINECHGSNDWORKdropC.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>