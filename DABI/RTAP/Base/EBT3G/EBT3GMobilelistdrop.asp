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
   sqlxx="select * FROM ebt3gmobilelist WHERE EBT3GMOBILENO='" & KEY(0) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��w�Q�ϥΤ�����ʹq�ܸ��X�A���i���P
   IF NOT ISNULL(RSXX("usedat")) or len(trim(rsxx("usecusid"))) > 0 THEN
      ENDPGM="3"
   '����ʹq�ܸ��X�w���P�A���i���Ƶ��P
   elseif not isnull(RSXX("DROPMARKDAT")) then
      endpgm="4"
   ELSE
         SQLXX=" update EBT3GMOBILElist set DROPMARKDAT=getdate() where EBT3GMOBILENO='" & KEY(0) & "'"
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
         else
               endpgm="1"
               errmsg=""
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
       msgbox "�F�˦�ʹq�ܵ��P���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�Q�ϥΤ�����ʹq�ܸ��X�A���i���P" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "����ʹq�ܸ��X�w���P�A���i���Ƶ��P" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    else
       msgbox "�o�Ͳ��`�A�L�k���P��ʹq�ܸ�ơA�гq����T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=ebt3gmobilelistdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>