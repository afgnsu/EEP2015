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
 '  On Error Resume Next
   '����O��Ƥw�g�إߩ���u��B���@�o�ɤ��i�����@�o��O���
   sqlxx="select COUNT(*) as cnt FROM RTEBTCUSTm2m3SNDWORK WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " AND DROPDAT IS NULL AND UNCLOSEDAT IS NULL"
   RSXX.OPEN SQLXX,CONNxx
   if cnt > 0 then
      endpgm="5"
   end if
   rsxx.Close
   if endpgm="1" then
      sqlxx="select * FROM RTEBTCUSTm2m3 WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2)
      RSXX.OPEN SQLXX,CONNxx
      '��w���׮ɤ��i�@�o
      IF LEN(TRIM(RSXX("closeDAT"))) <> 0  THEN
         ENDPGM="3"
      elseif LEN(TRIM(RSXX("dropdat"))) <> 0 then
         endpgm="4"
      ELSE
         sqlyy="select max(entryno) as entryno FROM RTEBTCUSTm2m3log WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2)
         rsyy.Open sqlyy,connxx
      
         if len(trim(rsyy("entryno"))) > 0 then
            entryno=rsyy("entryno") + 1
         else
            entryno=1
         end if
         rsyy.close
         set rsyy=nothing
         sqlyy="insert into RTEBTCUSTm2m3log " _
              &"SELECT  CUSNC, M2M3,SEQ," & ENTRYNO & ", getdate(), 'D','" &  v(0) & "', " _
              &"SOCIALID, BSCSCUSNO, SOPCUSNO, AMT, AVSNO,CONTRACTSTS, UPDFLG, UPDITEM, CBCTEL, ARCSRESULTFLAG, " _
              &"ARCSHOLDFLAG, ARCSLAWPUSHFLAG, ARCSTEMPPAYFLAG,STOPBILLINGFLAG, BSCSCUSTOMERID, CLOSEDAT, CLOSEUSR, DROPDAT, DROPUSR " _
              &"FROM RTEBTCUSTm2m3 where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2)
     ' Response.Write sqlyy
         CONNXX.Execute sqlyy     
         If Err.number > 0 then
            endpgm="2"
            errmsg=cstr(Err.number) & "=" & Err.description
         else
            SQLXX=" update RTEBTCUSTm2m3 set dropdat=getdate() where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2)
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlyy="delete * FROM RTEBTCUSTm2m3log WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " AND ENTRYNO=" & ENTRYNO
               CONNXX.Execute sqlyy 
            else
               endpgm="1"
               errmsg=""
            end if      
         end if
      END IF
      RSXX.CLOSE
   end if
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�Τ��O���ӧ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "M2M3��O��Ƥw���u���סA���i�@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "����O��Ƥw�@�o�A���i���а���@�o�@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "����O��Ƥw�إߩ���u��A���i�����@�o(�Х��@�o����u��ΰ��楼���u����)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    else
       msgbox "�L�k�����O���ӧ@�o�@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtCUSTM2M3SNDWORKDROP.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>