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
  'M3�~����楻�@�~(�[�WRTEBTCUST��OVERDUE�~�i���楻�@�~���P�_)
   sqlxx="select * FROM RTEBTCUST WHERE avsno='" & KEY(0) & "' "
   RSXX.OPEN SQLXX,CONNxx
   if rsxx("overdue") <> "Y" THEN
      ENDPGM="6"
   ELSE
      ENDPGM="1"
   END IF
   RSXX.CLOSE
 '  On Error Resume Next
   IF ENDPGM="1" THEN
      sqlxx="select * FROM RTEBTCUSTm2m3 WHERE avsno='" & KEY(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2)
      'RESPONSE.Write SQLXX
    '  RESPONSE.END
      RSXX.OPEN SQLXX,CONNxx
      endpgm="1"
      '��w�@�o�ɡA���i����M3����
      IF RSXX("M2M3") <> "303" THEN
         ENDPGM="5"
      ELSEIF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
         ENDPGM="3"
      elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0  then
         endpgm="4"
      ELSE
         sqlyy="select max(entryno) as entryno FROM RTEBTCUSTm2m3log WHERE avsno='" & KEY(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2)
         rsyy.Open sqlyy,connxx
      
         if len(trim(rsyy("entryno"))) > 0 then
            entryno=rsyy("entryno") + 1
         else
            entryno=1
         end if
         rsyy.close
         set rsyy=nothing
         sqlyy="insert into RTEBTCUSTm2m3log " _
              &"SELECT   avsno, m2m3,seq, " & ENTRYNO & ", getdate(), 'F','" &  v(0) & "', " _
              &"SOCIALID, BSCSCUSNO, SOPCUSNO, AMT, AVSNO, CONTRACTSTS, UPDFLG, " _
              &"UPDITEM, CBCTEL, ARCSRESULTFLAG, ARCSHOLDFLAG, " _
              &"ARCSLAWPUSHFLAG, ARCSTEMPPAYFLAG, STOPBILLINGFLAG, " _
              &"BSCSCUSTOMERID, CLOSEDAT, CLOSEUSR, DROPDAT, DROPUSR  " _
              &"FROM RTEBTCUSTm2m3 where avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2)
        ' Response.Write sqlyy
         CONNXX.Execute sqlyy     
         If Err.number > 0 then
            endpgm="2"
            errmsg=cstr(Err.number) & "=" & Err.description
         else
            SQLXX=" update RTEBTCUSTm2m3 set CLOSEdat=getdate(),CLOSEUSR='" & V(0) & "' where avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2)
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlyy="delete * FROM RTEBTCUSTm2m3log WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " AND ENTRYNO=" & ENTRYNO
               CONNXX.Execute sqlyy 
            else
               '���u���סA����sRTEBTCUST�Τ�D�ɰh����Τ����O��(�nOVERDUE="Y"�~���ߪ���]��ܤv����LM2������u�@�~)
               SQLXX=" update RTEBTCUST set DROPdat=getdate() where avsno='" & key(0) & "' AND OVERDUE='Y' AND DROPDAT IS NULL "
               connxx.Execute SQLXX
               If Err.number > 0 then
                  endpgm="2"
                  '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                  errmsg=cstr(Err.number) & "=" & Err.description
                  sqlyy="delete * FROM RTEBTCUSTm2m3log WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2) & " AND ENTRYNO=" & ENTRYNO
                  CONNXX.Execute sqlyy 
                  sqlyy="UPDATE RTEBTCUSTm2m3 SET CLOSEDAT=NULL,CLOSEUSR="" WHERE avsno='" & key(0) & "' and m2m3='" & key(1) & "' and seq=" & key(2)
                  CONNXX.Execute sqlyy 
               ELSE
                  endpgm="1"
                  errmsg=""
               END IF
            end if      
         end if
      END IF
      RSXX.CLOSE
      connXX.Close
      SET RSXX=NOTHING
      set connXX=nothing
   END IF
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�Τ��OM3���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i����M3����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "��M3����Ƥw��s��Ʈw�A���i���ư���M3����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�DM3�Τᤣ�i���楻�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="6" then
       msgbox "�Ȥ�D�ɩ|����M2�O���A���i����M3��s�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                         
    else
       msgbox "�L�k����M3���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcustm2m3sndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>