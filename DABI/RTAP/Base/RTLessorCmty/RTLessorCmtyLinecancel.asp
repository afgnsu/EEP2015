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
   sqlxx="select * FROM RTlessorCMTYLINE WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
   sqlYY="select COUNT(*) AS CNT FROM RTlessorCUST WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CANCELDAT IS NULL AND DROPDAT IS NULL AND (STRBILLINGDAT IS NOT NULL OR NEWBILLINGDAT IS NOT NULL OR DOCKETDAT IS NOT NULL OR FINISHDAT IS NOT NULL ) "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   RSYY.OPEN SQLYY,CONNxx
   endpgm="1"
   '�u���w���X�ӽСA���i�@�o
   IF LEN(TRIM(RSXX("APPLYDAT"))) <> 0   THEN
      ENDPGM="3"
   '�u���w�@�o�A���i���Ƨ@�o
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   '���u�����|���h�����Τ�A���i�����@�o�D�u
   elseif RSYY("CNT") > 0 then
      endpgm="7"      
   '�u���w�M�u�A�����A�@�o
   elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 then
      endpgm="5"      
   '�u���w���q�A���i�@�o
   elseif LEN(TRIM(RSXX("ADSLAPPLYDAT"))) <> 0 then
      endpgm="6"            
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCMTYLINECANCEL " & key(0) & "," & key(1) & ",'" & V(0) & "'" 
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
   RSYY.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�D�u�@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�u���w���X�ӽСA���i�@�o(�вM���ӽФ�)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�u���w�@�o�A���i���Ƨ@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "�u���w�M�u�A�����A�@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close        
    elseIF frm1.htmlfld.value="6" then
       msgbox "�u���w���q�A���i�@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="7" then
       msgbox "���u�����|���h�����Τ�A���i�����@�o�D�u�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    else
       msgbox "�L�k����Τ�ӽЧ@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtlessorCMTYLINEDROP.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>