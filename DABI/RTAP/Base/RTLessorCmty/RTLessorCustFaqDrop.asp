<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM Conn
   Set Conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   Conn.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTLessorCustFaqH WHERE CUSID='" & KEY(0) & "' AND FAQNO='" & KEY(1) & "'"
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,Conn
   endpgm="1"
   '��Τ�w���סA���i�����@�o==>�����ĵ��ת���覡
   IF LEN(TRIM(RSXX("finishDAT"))) <> 0  AND not ISNULL(RSXX("finishdat")) THEN
      ENDPGM="3"
   '�ȪA��w�ଣ�u��A���i�@�o
   elseif LEN(TRIM(RSXX("sndprtno"))) <> 0 then
      endpgm="5"  
   '�ȪA��w�ଣ�u��A���i�@�o
   elseif LEN(TRIM(RSXX("CALLBACKDAT"))) <> 0 then
      endpgm="6"        
   '�ȪA��w�@�o�A���i���Ч@�o    
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   ELSE
     '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustfaqDrop " & "'" & key(0) & "','" & key(1) & "','" & V(0) & "'" 
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
   Conn.Close
   SET RSXX=NOTHING
   set Conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�Τ�ȪA���Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Τ�ȪA���Ƥw���סA���i�@�o�C(�Ч�ε��ת���)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Τ�ȪA���Ƥw�@�o�A���i���а���C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���Τ�ȪA���Ƥw�ଣ�u��A���i�@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    elseIF frm1.htmlfld.value="6" then
       msgbox "�w��CALLBACK(�^�Ф�)�A���i�@�o�C(�Х������^�Ф�)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    else
       msgbox "�L�k����Τ�ȪA���Ƨ@�o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCustfaqdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>