<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONN
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSYY=Server.CreateObject("ADODB.RECORDSET") 
   SET RSZZ=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
 
   sqlxx="select * FROM RTLessorAVSCMTYLINEdrop WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " and entryno=" & key(2)
   sqlYY="select COUNT(*) AS CNT FROM RTLessorAVSCMTYLINEHardware WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " and dropdat is null and rcvfinishdat is not null and qty > 0 "
   sqlzz="select COUNT(*) AS CNT FROM RTLessorAVSCMTYLINEfaqHardware WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " and dropdat is null and rcvfinishdat is not null and qty > 0 "
   RSXX.OPEN SQLXX,CONN
   RSYY.OPEN SQLYY,CONN
   RSZZ.OPEN SQLZZ,CONN
   '��w�@�o�ɡA���i�ଣ�u��
   IF LEN(TRIM(RSXX("CANCELDAT"))) <> 0 THEN
      ENDPGM="3"
   '�w���׮ɡA���i�ଣ�u��
   elseif LEN(TRIM(RSXX("closedat"))) <> 0 then
      endpgm="4"
   '�w�����u��ɡA���i���а���
   elseif LEN(TRIM(RSXX("SNDPRTNO"))) <> 0  then
      endpgm="5"
   '�Y�L�]�ơA�h���i�����������u��
 '  elseif rsyy("cnt")=0 and rszz("cnt")=0  then
 '     endpgm="6"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCmtyLineDropTRNSndwork "  & key(0) & "," & key(1) & "," & key(2) & ",'" & V(0) & "'" 
    '  response.write strSP
    '  response.end     
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
   RSYY.CLOSE
   RSZZ.CLOSE
conn.Close
SET RSXX=NOTHING
SET RSYY=NOTHING
SET RSZZ=NOTHING
set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City�D�u�M�u���������u�榨�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i�������u��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�w���׮ɡA���i�������u��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�w��������u��ɡA���i���а���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���D�u�L����]�Ƹ�ơA���i���ͩ�����u��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    else
       msgbox "�L�k����M�u���������u��@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScmtylinedropTRNSndwork.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>