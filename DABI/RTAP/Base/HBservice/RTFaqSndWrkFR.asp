<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTSndWork WHERE workno='" & KEY(0) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   if (not isnull(RSXX("finishdat"))) and RSXX("finishusr") <> V(0) then
      endpgm="3"	'�D�짹�u�H
   elseif not isnull(RSXX("canceldat")) then
      endpgm="4"	'�w�@�o
   elseif isnull(RSXX("finishdat")) then
      endpgm="5"	'�����u
   ELSE
      strSP ="update RTSndWork set finishdat=null,finishusr='',finishtyp='' WHERE workno='" & KEY(0) & "' "
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
       msgbox "���u����ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�Ȧ��짹�u�H�i���হ���u��A���ॢ�� !!" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="4" then
       msgbox "���u��w�@�o�A�������C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="5" then
       msgbox "���u��|���㧹�u�A�������C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    else
       msgbox "�L�k���欣�u�����@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTFaqSndWrkFR.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>