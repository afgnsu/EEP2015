<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSZZ=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   sqlxx="select * FROM RTLessorCUSTReturnsndwork WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) & " and prtno='" & key(2) & "' "
   sqlzz="select * FROM RTLessorCustRCVHardware WHERE prtno='" & KEY(2) & "' and canceldat is null "
   RSXX.OPEN SQLXX,conn
   RSZZ.OPEN SQLZZ,conn
   endpgm="1"
   '���u���פ�Υ����u���פ餣���ťծɡA���ET-City���u�T�{��w���סA���i�@�o
   IF LEN(TRIM(RSXX("closeDAT"))) <> 0 or LEN(TRIM(RSXX("uncloseDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("dropdat"))) <> 0 then
      endpgm="4"
   elseif not rszz.eof then
      endpgm="5"           
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustReturnARSndworkDrop " & "'" & key(0) & "'," & key(1) & ",'" & key(2) & "','" & V(0) & "'" 
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
   RSZZ.CLOSE
   conn.Close
   SET RSXX=NOTHING
   SET RSZZ=NOTHING
   set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�Τ�_�����ڬ��u��@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���_�����ڬ��u��w���u(�����u)���סA���i�@�o(���@�o�Х��M���˾����u��)�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���_�����ڬ��u��w�@�o�A���i���а���@�o�@�~�G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����u��w���ͪ��~��γ�A���i�����@�o(�Х����ફ�~��γ�)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                      
    else
       msgbox "�L�k����_�����ڬ��u��@�o�@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorcustreturnsndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>