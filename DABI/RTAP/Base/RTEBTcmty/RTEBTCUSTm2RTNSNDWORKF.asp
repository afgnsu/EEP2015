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
   endpgm="1"
   sqlxx="select * FROM RTEBTCUST WHERE avsno='" & KEY(0) & "' "
   RSXX.Open SQLXX,CONNXX
   IF NOT RSXX.EOF THEN
      IF NOT ISNULL(RSXX("DROPDAT")) THEN
         '�Τ�D�ɤw�h�����i�_���A�ݭ��s�ӽ�
         ENDPGM="9"
      ELSEIF RSXX("OVERDUE") <> "Y" THEN
         '�Τ�D�ɩ|��������@�~�Τ��@�~�����u�A���i����_�����u�@�~
         ENDPGM="8"
      ELSE
         ENDPGM="1"
      END IF
   ELSE
      '�Τ�D�ɧ䤣�즹�Τ��ơA�гq����T��!
      endpgm="7"
   END IF
   RSXX.CLOSE
 '  On Error Resume Next
IF ENDPGM="1" THEN     
   sqlxx="select * FROM RTEBTCUSTm2RTNsndwork WHERE avsno='" & KEY(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and RTNno='" & key(3) & "' "
   RSXX.OPEN SQLXX,CONNxx
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
      sqlyy="select max(entryno) as entryno FROM RTEBTCUSTm2m3sndworklog WHERE avsno='" & KEY(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTEBTCUSTm2RTNsndworklog " _
           &"SELECT   avsno, m2m3,seq,RTNNO, " & ENTRYNO & ", getdate(), 'F','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�Τ�_�����u����'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR  " _
           &"FROM RTEBTCUSTm2RTNsndwork where avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and RTNno='" & key(3) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTEBTCUSTm2RTNsndwork set CLOSEdat=getdate(),CLOSEUSR='" & V(0) & "' where avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and RTNno='" & key(3) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTEBTCUSTm2RTNsndworklog WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and RTNno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            '���u���סA����sm2m3�Τ�D��FINISHDAT
           ' SQLXX=" update RTEBTCUSTm2m3 set closedat=getdate(),CLOSEUSR='" & V(0) & "' where avsno='" & key(0) & "' and m2m3='" & key(1) & "' "
           ' connxx.Execute SQLXX
           ' If Err.number > 0 then
           '    endpgm="2"
           '    '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
           '    errmsg=cstr(Err.number) & "=" & Err.description
           '    sqlyy="delete * FROM RTEBTCUSTm2m3sndworklog WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "'  and prtno='" & key(2) & "' AND ENTRYNO=" & ENTRYNO
           '    CONNXX.Execute sqlyy 
           ' ELSE
               '���u���סA����s�Τ�D��OVERDUE(�bM3�ɤ~�����s�h����)
               SQLXX=" update RTEBTCUST set overdue=''  where avsno='" & key(0) & "' "
               connxx.Execute SQLXX
               If Err.number > 0 then
                  endpgm="2"
                 '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                  errmsg=cstr(Err.number) & "=" & Err.description
                  sqlyy="delete * FROM RTEBTCUSTm2RTNsndworklog WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " and RTNno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
                  CONNXX.Execute sqlyy 
                 '�o�Ϳ��~�ɡA�٭�w�Q��s��M2M3���u���פ��e
                '  sqlyy="UPDATE RTEBTCUSTm2m3 SET closeDAT=NULL, UDAT=GETDATE()  WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' "
                '  CONNXX.Execute sqlyy 
               ELSE
                  endpgm="1"
                  errmsg=""
               END IF
           ' END IF
         end if      
      end if
   END IF
   RSXX.CLOSE
 END IF
 connXX.Close
 SET RSXX=NOTHING
 set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�Τ�_���u�槹�u���צ��\",0
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
       msgbox "���_���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���_���u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���_���u�槹�u�ɡA��������J��ڴ_���H���ι�ڴ_���g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "�Τ�D�ɧ䤣�즹�Τ��ơA�гq����T����U�T�{�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="8" then
       msgbox "���Τ�w�h�����i�_���A�ݭ��s�ӽ�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="9" then
       msgbox "�Τ�D�ɩ|��������@�~�Τ��@�~�����u�A���i����_�����u�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                                   
    else
       msgbox "�L�k����_���u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcustm2RTNsndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>