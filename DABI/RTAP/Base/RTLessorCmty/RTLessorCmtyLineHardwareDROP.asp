<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   endpgm="1"
  '����ݬ��u��w�p��w�s��A���i�@�o��(stockcloseym<>'')
   sqlxx="select * FROM RTLessorCmtyLineHardware WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and seq=" & key(3)
   sqlyy="select * FROM RTLessorCmtyLinesndwork WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "'"
   rsxx.Open sqlxx,conn
   rsyy.Open sqlyy,conn
  '�w�@�o
   IF LEN(TRIM(RSXX("dropdat"))) <> 0 THEN
      ENDPGM="3"
   '���ݬ��u��w���סA���i�@�o�]��
   elseIF len(trim(rsyy("closedat"))) > 0 or len(trim(rsyy("unclosedat"))) > 0 then
      ENDPGM="4"
   '�w�������b�ڤ��i�@�o
   elseIF len(trim(rsxx("batchno"))) > 0 then
      ENDPGM="5"      
   '�w�ફ�~��γ椣�i�@�o
   elseIF len(trim(rsxx("rcvprtno"))) > 0 then
      ENDPGM="6"                
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCmtyLineHardwareDrop " & key(0) & "," & key(1) & ",'" & key(2) & "'," & key(3) & ",'" & V(0) & "'" 
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
   RSyy.CLOSE
   conn.Close
   SET RSXX=NOTHING
   SET RSyy=NOTHING
   set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�D�u�]�Ʀw�˸�Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����]�Ƥw�@�o�A���i���Ч@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���ݬ��u��w���סA���i�@�o�]�Ʃ���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "�w�������b�ڡA���i�@�o(���@�o���������@�o���u��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    elseIF frm1.htmlfld.value="6" then
       msgbox "�w�ફ�~��γ�A���i�@�o(���@�o�Х����ફ�~��γ�)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    else
       msgbox "�L�k����]�Ʀw�˸�Ƨ@�o,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtlessorcmtylinehardwaredrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>