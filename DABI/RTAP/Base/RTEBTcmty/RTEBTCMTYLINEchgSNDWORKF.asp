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
   sqlxx="select * FROM RTEBTCMTYLINECHGsndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   sndtype=""
   endpgm="1"
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
   SQLYY="SELECT * FROM RTEBTCMTYLINECHG WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " AND PRTNO='" & KEY(2) & "' "
   RSYY.Open SQLYY,CONNXX
   NCOMQ1=RSYY("NCOMQ1")
   NLINEQ1=RSYY("NLINEQ1")
  ' IF ISNULL(RSYY("UPDEBTCHKDAT")) OR  ISNULL(RSYY("UPDEBTTNSDAT")) THEN
   IF ISNULL(RSYY("UPDEBTCHKDAT"))  THEN  '(���u�ˬd�ӽмf�֤�A�ӥӽ����ɤ�]�|�������ҥ�920429�G�����ˬd
      ENDPGM="8" '��D�u�����ɩ|���VEBT���X�ӽЮɡA���i���槹�u�@�~
   END IF
   RSYY.CLOSE 
   IF ENDPGM <> "8" THEN
    '��D�u���ʬ��u��w�@�o�ɡA���i���槹�u���שΥ����u����
     IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
        ENDPGM="3"
     '��D�u���ʬ��u��˾����u��ťծ�,���i���槹�u�Υ����u����
     elseif ISNULL(RSXX("CLOSEDAT"))  then
        endpgm="7"            
     '��D�u���ʬ��u�槹�u���פ�Υ����u���פ餣���ťծɡA���i���槹�u����
     elseif LEN(TRIM(RSXX("FINISHDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
        endpgm="4"      
     ELSE
      sndtype=rsxx("sndtype")
      sqlyy="select max(entryno) as entryno FROM RTEBTCMTYLINECHGsndworklog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      'set rsyy=nothing
      sqlyy="insert into RTEBTCMTYLINECHGsndworklog " _ 
           &"SELECT   COMQ1, LINEQ1, PRTNO, PRTNO2, " & ENTRYNO & ", GETDATE() ,'F','" & V(0) & "',SENDWORKDAT, PRTUSR, ASSIGNENGINEER1, ASSIGNENGINEER2, " _
           &"ASSIGNENGINEER3, ASSIGNENGINEER4, ASSIGNENGINEER5, ASSIGNCONSIGNEE, REALENGINEER1, REALENGINEER2, REALENGINEER3, " _
           &"REALENGINEER4, REALENGINEER5, REALCONSIGNEE, DROPDAT,DROPDESC, CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT,STOCKCLOSEUSR, STOCKFINCHK, SNDTYPE, HOSTCABLENO, MEMO, " _
           &"PRTDAT, EUSR, EDAT, UUSR, UDAT, CLOSEUSR, DROPUSR, UNCLOSEDAT,finishdat " _
           &"FROM RTEBTCMTYLINEchgsndwork where comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTEBTcmtylineCHGsndwork set FINISHdat=getdate() ,CLOSEUSR='" & V(0) & "' where comq1=" & KEY(0) & " and lineq1=" & key(1)  & " and prtno='" & key(2) & "' and prtno2='" & key(3) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTEBTcmtylinechgsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & "' and prtno='" & key(2) & "' and prtno2='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            '���u���סA�Y���зǤu�{�B�s���l�u�{�B���q�B���q�Υ[�˳]�ƥB�D�u�����ɩ|�����������̡A����s�D�u�����ɲ���������finishdat
            '�ϥΪ̦A�N�ӵ��w���u�����ʿ�J�����f�֤����ɦ�EBT�A��EBT�^��OK����OK��A��s�D�u�D�ɤ��������ʸ��(�����������ɱ����{���t�d)
            IF sndtype ="OC" OR  sndtype ="OP" OR  sndtype ="ST" OR  sndtype ="CB" THEN
               SQLXX=" update RTEBTcmtylineCHG set FINISHdat=getdate() ,UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " and PRTNO='" & key(2)  & "' AND RTEBTcmtylineCHG.FINISHdat IS NULL "
               STS="3"
               connxx.Execute SQLXX
               '���ʫe���D�u�n��s�M�u��
               SQLXX=" update RTEBTcmtyline set DROPDAT=getdate() ,UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND RTEBTcmtyline.ADSLAPPLYDAT IS NULL "
               STS="3"
               connxx.Execute SQLXX
               '���ʫ᪺�D�u�n��s���q��
               SQLXX=" update RTEBTcmtyline set ADSLAPPLYDAT=getdate() ,UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & NCOMQ1 & " and lineq1=" & NLINEQ1 & " AND RTEBTcmtyline.ADSLAPPLYDAT IS NULL "
               STS="3"
               connxx.Execute SQLXX
               If Err.number > 0 then
                  endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                  errmsg=cstr(Err.number) & "=" & Err.description
                  sqlyy="delete * FROM RTEBTcmtylinechgsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & "' and prtno='" & key(2) & "' and prtno2='" & key(3)& "' AND ENTRYNO=" & ENTRYNO
                  CONNXX.Execute sqlyy 
               ELSE
                  endpgm="1"
                  errmsg=""
               END IF
            END IF
         end if      
      end if
    END IF
   END IF
   SQLYY="SELECT * FROM RTEBTCMTYH WHERE COMQ1=" & KEY(0)
   RSYY.Open SQLYY,CONNXX
   COMN=RSYY("COMN")
   RSYY.CLOSE
   IF ENDPGM="1" AND STS="3" THEN '��ݧ�s�D�u�����u�骺���u����(STS=3)����~���n�q�������H��
      FROMEMAIL="MIS@CBBN.COM.TW"
      Set jmail = Server.CreateObject("Jmail.Message")
      jmail.charset="BIG5"
      jmail.from = "MIS@cbbn.com.tw"
      Jmail.fromname="AVS�t�γq��"
      IF STS="1" THEN
         jmail.Subject = "AVS���ϡJ" & COMN & "�A���ʬ��u��J" & KEY(0) & "-" & KEY(1) & "-" & KEY(2) & "-" & KEY(3) & "�A���u���׳q��"
      ELSE
         jmail.Subject = "AVS���ϡJ" & COMN & "�A���ʬ��u��J" & KEY(0) & "-" & KEY(1) & "-" & KEY(2) & "-" & KEY(3) & "�A�����u���׳q��"
      END IF
      
      jmail.priority = 1  
      body="<html><body><table border=0 width=""60%""><tr><td colspan=2>" _
      &"<H3>�F��AVS�D�u���ʬ��u���׳q��</h3></td></tr>" _
      &"<tr><td width=""30%"">&nbsp;</td><td width=""70%"">&nbsp;</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ϥD�u�Ǹ�</td><td bgcolor=pink align=left>" &KEY(0) & "-" & KEY(1) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ϦW��</td><td bgcolor=pink align=left>" &comn & "-" & KEY(1) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���ʳ渹</td><td bgcolor=pink align=left>" &KEY(2) &"</td></tr>" _
      &"<tr><td bgcolor=lightblue align=center>���u�渹</td><td bgcolor=pink align=left>" &KEY(3) &"</td></tr>" _
      &"</table>" _
      &"<P><U>���D�u���ʤw���u����</U></body></html>"  
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
      jmail.Send ( "219.87.146.239" )      
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
       msgbox "AVS�D�u���ʬ��u�槹�u���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���ʳ�w�@�o�ɡA���i���槹�u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "��D�u���ʳ槹�u���פ�Υ����u���פ餣���ťծɡA���i���槹�u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���D�u���ʬ��u�w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���D�u���ʬ��u�浲�׮ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "���u��˾����u��ťծ�,���i���槹�u�Υ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="8" then
       msgbox "��D�u�����ɩ|���VEBT���X�ӽЮɡA���i���槹�u�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                         
    else
       msgbox "�L�k����D�u���ʬ��u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylineCHGsndworkF.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>