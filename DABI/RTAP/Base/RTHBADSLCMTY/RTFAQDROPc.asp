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
   sqlxx="select * FROM HBADSLCMTYFIXH WHERE fixno='" & KEY(0) & "' "
  ' RESPONSE.Write SQLXX
  ' RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   IF ISNULL(RSXX("dropdat")) THEN
      ENDPGM="3"
   ELSE
      sqlyy="select max(entryno) as entryno FROM HBADSLCMTYFIXHlog WHERE fixno='" & KEY(0) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into HBADSLCMTYFIXHlog " _
           &"SELECT  FIXNO," & ENTRYNO & ", getdate(), 'R','" &  v(0) & "', " _
           &"COMQ1, LINEQ1, COMTYPE,  DEVICETYPE, RCVMAN, RCVTIME, MEMO1, MEMO2, " _
           &"MEMO3, DROPDAT,  DROPUSR, CLOSEDAT, CLOSEUSR " _
           &"FROM HBADSLCMTYFIXH where FIXNO='" & key(0) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update HBADSLCMTYFIXH set dropdat=NULL,DROPUSR='' where FIXNO='" & KEY(0) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM HBADSLCMTYFIXHlog WHERE FIXNO='" & key(0)  & "' AND ENTRYNO=" & ENTRYNO
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
       msgbox "���ϥD���ȶD�@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����ϥD���ȶD�|���@�o�A���i����@�o����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k������ϥD���ȶD�@�o����@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTFAQDROP.ASP ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>