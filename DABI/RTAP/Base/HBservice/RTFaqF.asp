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
   sqlxx="select * FROM RTFaqM WHERE caseno='" & KEY(0) & "' "
   sqlyy="select * FROM RTSndWork WHERE linkno='" & KEY(0) & "' and (worktype ='01' or worktype ='09') and canceldat is null and finishdat is null" 
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   RSyy.OPEN SQLyy,CONNxx
   endpgm="1"
   if not rsyy.EOF then
      ENDPGM="3"	'�|���u�楼���u
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"	'�w�@�o
   elseif LEN(TRIM(RSXX("closedat"))) <> 0 then
      endpgm="5"	'�w����
   ELSE
      strSP ="update RTFaqM set closedat=getdate(),closeusr='"& V(0) &"' WHERE caseno='" & KEY(0) & "' "
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
   RSyy.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   SET RSyy=NOTHING
   set connXX=nothing
%> 
<HTML>
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�ȶD�浲�צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���u��|�����u�A�L�k����!!" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="4" then
       msgbox "�ȶD��w�@�o�A���൲�סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="5" then
       msgbox "�Фŭ��е��סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    else
       msgbox "�L�k����ȶD��@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTFaqF.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>