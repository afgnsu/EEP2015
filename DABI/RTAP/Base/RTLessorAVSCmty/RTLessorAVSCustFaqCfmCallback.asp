<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONN
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
 
   sqlxx="select * FROM RTLessorAVSCUSTFaqH WHERE CUSID='" & KEY(0) & "' and FAQNO='" & key(1) & "' "
   RSXX.OPEN SQLXX,CONN
   '��w�@�o�ɡA���i�����ȪA�^�Ф�
   IF LEN(TRIM(RSXX("CANCELDAT"))) <> 0 THEN
      ENDPGM="3"
   '�w���׮ɡA���i�����ȪACALLBACK���
   elseif LEN(TRIM(RSXX("FINISHDAT"))) <> 0 then
      endpgm="4"
   '�����ͬ��u��ɡA���i�����ȪACALLBACK���
   elseif LEN(TRIM(RSXX("SNDPRTNO"))) = 0 AND ISNULL(RSXX("SNDWORK")) then
      endpgm="5"
   '�w��CALLBACK����ɡA���i���а���
   elseif LEN(TRIM(RSXX("CALLBACKDAT"))) <> 0  then
      endpgm="6"      
   elseif LEN(TRIM(RSXX("SNDPRTNO"))) > 0 AND ISNULL(RSXX("SNDCLOSEDAT")) then
      endpgm="7"            
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustFaqCfmCallback " & "'" & key(0) & "'" & ",'" & key(1) & "','" & V(0) & "'" 
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
conn.Close
SET RSXX=NOTHING
set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City�Τ�ȪA���ȪACALLBACK������\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i�����ȪA�^�Ф�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�w���׮ɡA���i�����ȪACALLBACK���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����ͬ��u��ɡA���i�����ȪACALLBACK���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "�w��CALLBACK����ɡA���i���а���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    elseIF frm1.htmlfld.value="7" then
       msgbox "���u��|�����סA���i�����^�Ф�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close               
    else
       msgbox "�L�k�����ȪACALLBACK����@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScustFaqCfmCallBack.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>