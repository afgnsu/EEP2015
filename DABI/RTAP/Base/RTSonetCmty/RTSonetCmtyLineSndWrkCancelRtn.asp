<%@ Language=VBScript %>
<% KEY=SPLIT(REQUEST("KEY"),";")
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTSonetSndWrk WHERE wrkno ='" & KEY(0) & "' "
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '���u��|���@�o�A���i�@�o����
   IF ISNULL(RSXX("CANCELDAT"))   THEN
      ENDPGM="3"
  ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="update RTSonetSndWrk set canceldat=null, cancelusr='' where wrkno ='" & KEY(0) & "' "
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
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "So-net�D�u���u��@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�D�u���u��|���@�o�A���i����@�o����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k����D�u���u��@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="" ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>