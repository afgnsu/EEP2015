<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONN
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
 
   sqlxx="select * FROM RTLessorAVSCUSTDROP WHERE CUSID='" & KEY(0) & "' and ENTRYNO=" & key(1) 
   sqlyy="select * FROM RTLessorAVSCUST WHERE CUSID='" & KEY(0) & "' "
   RSXX.OPEN SQLXX,CONN
   RSyy.OPEN SQLyy,CONN
   '��w�@�o�ɡA���i����ȪA�浲��
   IF LEN(TRIM(RSXX("CANCELDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("FINISHDAT"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSyy("batchno"))) = 0 AND RSXX("DROPKIND")="02" then
      endpgm="7"      
   elseif LEN(TRIM(RSXX("SNDPRTNO"))) = 0 OR ISNULL(rsxx("SNDWORK")) then
      endpgm="5"
   elseif LEN(TRIM(RSXX("SNDPRTNO"))) <> 0 AND ISNULL(RSXX("SNDWORKCLOSE"))  then
      endpgm="6"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustDROPF " & "'" & key(0) & "'," & key(1) & ",'" & V(0) & "'" 
      'response.write strSP
      'response.end     
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
       msgbox "AVS-City�Τ�h���浲�צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i����h���浲��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���h����w���סA���i���ư���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���h����|���������u��A���u��ݵ��׫�l�i����h���浲�ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���h���椧������u��|�����סA���i����h���浲�ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="7" then
       msgbox "���Ȥᤧ�D�ɤ��õL�����b�ڽs����ơA�L�k����h���浲�ק@�~�C(���p����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    else
       msgbox "�L�k����h���浲�ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScustDROPf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>