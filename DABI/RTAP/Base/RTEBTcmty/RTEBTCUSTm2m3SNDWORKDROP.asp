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
   sqlxx="select * FROM RTEBTCUSTm2m3sndwork WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '���u���פ�Υ����u���פ餣���ťծɡA���AVS���u�T�{��w���סA���i�@�o
   IF LEN(TRIM(RSXX("closeDAT"))) <> 0 or LEN(TRIM(RSXX("uncloseDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("dropdat"))) <> 0 then
      endpgm="4"
   ELSE
      sqlyy="select max(entryno) as entryno FROM RTEBTCUSTm2m3sndworklog WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "'"
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTEBTCUSTm2m3sndworklog " _
           &"SELECT  avsno,m2m3,seq,PRTNO, " & ENTRYNO & ", getdate(), 'D','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�Τ����u��@�o'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR " _
           &"FROM RTEBTCUSTm2m3sndwork where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTEBTCUSTm2m3sndwork set dropdat=getdate(),dropdesc='AVS�Τ����u��@�o' where AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTEBTCUSTm2m3sndworklog WHERE AVSNO='" & key(0) & "' and M2M3='" & key(1) & "' and seq=" & key(2) & " and prtno='" & key(3) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
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
       msgbox "AVS�Τ��O����u��@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "������u��w���u���סA���i�@�o(���@�o�Х��M���˾����u��)�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "������u��w�@�o�A���i���а���@�o�@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k�������u��@�o�@�~,���~�T���G" & "  " & frm1.htmlfld1.value
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