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
   ENDPGM=""
 '  On Error Resume Next
   sqlxx="select * FROM RTEBTCUSTm2m3sndwork WHERE avsno='" & KEY(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
 '-----------------------------------------------------------------------------------------------------------------------
 '  ���q�D�n�O�P�_��O���(�j��)�Ȥ�A�����ƬO�_�w�W�Ǧ�EBT,�Y�w�W�ǫh���i�����ת���(���ثe�]�L�h�����ɥ\��G�ȫO�d)
 '  sqlYY="select * FROM RTEBTCUST WHERE AVSNO='" & KEY(0) & "' "
 '  RSYY.Open SQLYY,CONNXX
 '  ENDPGM=""
 '  IF RSYY.EOF THEN
 '     ENDPGM="6"
 '  ELSE
 '  ===>RSYY("DOCKETDAT") �n�אּ��O����Τ�^��EBT���(�٥��}�����)
 '     IF LEN(TRIM(RSYY("DOCKETDAT"))) > 0 THEN ENDPGM="7"
 '  END IF
 '  RSYY.CLOSE
 '=================================================================
   'IF1S
   IF ENDPGM="" THEN
      'RESPONSE.Write SQLXX
   '  RESPONSE.END
     RSXX.OPEN SQLXX,CONNxx
     endpgm="1"
     '��w�@�o�ɡA���i���槹�u���שΥ����u����
     'IF2S
     IF not isnull(RSXX("DROPDAT")) THEN
        ENDPGM="4"
     elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
        endpgm="5"
     elseif isnull(RSXX("CLOSEDAT")) and isnull(RSXX("UNCLOSEDAT")) then
   '  response.Write "aaa"
   '  response.end
        endpgm="3"      
     ELSE
        sqlyy="select max(entryno) as entryno FROM RTEBTCUSTM2M3sndworklog WHERE AVSNO='" & KEY(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
        rsyy.Open sqlyy,connxx
        'IF3-1S
        if len(trim(rsyy("entryno"))) > 0 then
           entryno=rsyy("entryno") + 1
        else
           entryno=1
        end if
        'IF3-1E
        rsyy.close
        set rsyy=nothing
        '���u���ת���
        'IF3-2S
        IF LEN(TRIM(RSXX("CLOSEDAT"))) > 0 THEN
        sqlyy="insert into RTEBTCUSTM2M3sndworklog " _
           &"SELECT   AVSNO,M2M3,seq,PRTNO, " & ENTRYNO & ", getdate(), 'FR','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�Τ��O������u���ת���'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR  " _
           &"FROM RTEBTCUSTM2M3sndwork where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
        '�����u���ת���
        ELSE
        sqlyy="insert into RTEBTCUSTM2M3sndworklog " _
           &"SELECT   AVSNO,M2M3,seq,PRTNO, " & ENTRYNO & ", getdate(), 'UR','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�Τ��O��������u���ת���'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR  " _
           &"FROM RTEBTCUSTM2M3sndwork where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
        END IF
        'IF3-2E
     ' Response.Write sqlyy
        CONNXX.Execute sqlyy     
        'IF3-3S
        If Err.number > 0 then
           endpgm="2"
           errmsg=cstr(Err.number) & "=" & Err.description
        else
           '���u���ת���
           'IF4-1S
           IF LEN(TRIM(RSXX("CLOSEDAT"))) > 0 THEN
              SQLXX=" update RTEBTCUSTM2M3sndwork set CLOSEdat=NULL,CLOSEUSR='' where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
              connxx.Execute SQLXX
              'IF5-1S
              If Err.number > 0 then
                 endpgm="2"
                '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                 errmsg=cstr(Err.number) & "=" & Err.description
                 sqlyy="delete * FROM RTEBTCUSTM2M3sndworklog WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
                 CONNXX.Execute sqlyy 
              else
                '�N�Τ�D�ɤ��h������Τ�O�аO �M��
                 SQLXX=" update RTEBTCUST set DROPdat=NULL,UUSR='" & V(0) & "',UDAT=GETDATE(),OVERDUE=''  where AVSNO='" & key(0) & "'"
                 connxx.Execute SQLXX
                 'IF6-1S
                 If Err.number > 0 then
                    endpgm="2"
                   '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                    errmsg=cstr(Err.number) & "=" & Err.description
                    sqlyy="delete * FROM RTEBTCUSTM2M3sndworklog WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
                    CONNXX.Execute sqlyy 
                 ELSE
                    endpgm="1"
                    errmsg=""
                 END IF
                 'IF6-1E
              end if      
              'IF5-1E
           ELSE
           '�����u���ת���
              SQLXX=" update RTEBTCUSTM2M3sndwork set UNCLOSEdat=NULL,CLOSEUSR='' where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
              connxx.Execute SQLXX
              'IF5-2S
              If Err.number > 0 then
                 endpgm="2"
                '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                 errmsg=cstr(Err.number) & "=" & Err.description
                 sqlyy="delete * FROM RTEBTCUSTM2M3sndworklog WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
                 CONNXX.Execute sqlyy 
              else
                    endpgm="1"
                    errmsg=""
             END IF
             'IF5-2E
           end if      
           'IF4-1E
        end if
        'IF3-3E
     END IF
     'IF2E
     RSXX.CLOSE
   END IF
   'IF1E
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�Τ��O����u�槹�u/�����u���ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "����O����u��|�����סA���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "����O����u��w�@�o�A���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="5" then
       msgbox "����O����u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="6" then
       msgbox "�L�k��즹��O����u�椧�Τ�D�ɸ�ơA�нT�{AVS�Τ�D�ɸ�ƥ��`" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="7" then
       msgbox "�Τ���w���ɡA���i���槹�u���ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    else
       msgbox "�L�k�����O����u�槹�u���ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTEBTCUSTM2M3SNDWORKFR.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>