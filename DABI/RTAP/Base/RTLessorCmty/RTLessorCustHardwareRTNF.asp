<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   endpgm="1"

   sqlxx="select * FROM RTLessorCustRtnHardware WHERE rcvprtno='" & key(0) & "'"
   RSXX.OPEN SQLXX,conn
  '�w�@�o�A���i����
   IF LEN(TRIM(RSXX("CANCELdat"))) <> 0 THEN
      ENDPGM="3"
   '�w���פ��i���Ƶ���
   elseIF len(trim(rsxx("closedat"))) > 0 then
      ENDPGM="4"
   '������J��ڲ���H�ι�ڲ���g�P��
   elseIF len(trim(rsxx("REALENGINEER"))) = 0 AND len(trim(rsxx("REALCONSIGNEE"))) = 0 then
      ENDPGM="5"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustHardwareRtnF " & "'" & key(0) & "','" & rsxx("datasrc") & "','" & V(0) & "'" 
      Set ObjRS = conn.Execute(strSP)
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
   conn.Close
   SET RSXX=NOTHING
   set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���~����浲�צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���~�����w�@�o�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���~�����w���סA���i���Ƶ���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "������J��ڲ���H�ι�ڲ���g�P�Ӥ�i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    else
       msgbox "�L�k���檫�~����浲�ק@�~(�гq����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCustHardwareRtnF.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>