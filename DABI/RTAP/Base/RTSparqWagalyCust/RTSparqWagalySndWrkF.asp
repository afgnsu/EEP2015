<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTSparqWagalySndWrk WHERE workno='" & KEY(0) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   if LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"	'�w�@�o
   elseif LEN(TRIM(RSXX("closedat"))) <> 0 then
      endpgm="5"	'�w����
   ELSE
   
   strSP = ""
	  if RSXX("finisheng") ="" and RSXX("finishcons") ="" then 
       	 strSP =strSP & " update RTSparqWagalySndWrk set finisheng=assigneng, finishcons=assigncons WHERE workno='" & key(0) & "' "
	  end if
	  
	  if LEN(TRIM(RSXX("finishdat"))) = 0 then 
      	strSP =strSP & " update RTSparqWagalySndWrk set finishdat=getdate() WHERE workno='" & key(0) & "' "
      	strSP =strSP & " update RTSparqWagalyCust set finishdat=getdate() WHERE cusid='" & key(1) & "' "
	  else
	  	strSP =strSP & " update RTSparqWagalyCust set finishdat='" & RSXX("finishdat") &"' WHERE cusid='" & key(1) & "' "
      end if

      strSP =strSP & " update RTSparqWagalySndWrk set closedat=getdate(), closeusr='" &key(2)& "' WHERE workno='" & key(0) & "' "

      Set ObjRS = connXX.Execute(strSP)
      If Err.number = 0 then
         ENDPGM="1"
         ERRMSG=""
         'conn.CommitTrans
      else
         ENDPGM="2"
         errmsg=cstr(Err.number) & "=" & Err.description
         'conn.rollbackTrans
      end if         
   END IF
   RSXX.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
%> 
<HTML>
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���u�浲�צ��\",0
       Set winDialog=window.Opener
       Set winP=winDialog.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
       winDialog.close
    elseIF frm1.htmlfld.value="4" then
       msgbox "���u��w�@�o�A���൲�סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="5" then
       msgbox "�Фŭ��е��סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    else
       msgbox "�L�k���欣�u��@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTSparqWagalySndWrkF.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>