<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   'SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTfareastSndWrk WHERE wrkno ='" & KEY(0) & "' "
   'sqlYY="select COUNT(*) AS CNT FROM RTfareastCUST WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CANCELDAT IS NULL AND DROPDAT IS NULL AND STRBILLINGDAT IS NOT NULL "
   RSXX.OPEN SQLXX,CONNxx
   'RSYY.OPEN SQLYY,CONNxx
   endpgm="1"
   if LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("closedat"))) <> 0 then
      endpgm="5"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="update RTfareastSndWrk set canceldat=getdate(),cancelusr='" &V(0)& "' where wrkno='" &key(0)&"' "
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
   'RSYY.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   'SET RSYY=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���Ǥj�e�W���ϫ��D�u���u��@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="4" then
       msgbox "�D�u���u��w�@�o�A���i���Ƨ@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "�D�u���u��w���סA���i�@�o�C" & "  " & frm1.htmlfld1.value
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