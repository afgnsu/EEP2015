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
   SET RSzz=Server.CreateObject("ADODB.RECORDSET")     
   DSN="DSN=RtLib"
   conn.Open DSN
   'conn.BeginTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
 
   sqlxx="select * FROM RTLessorCUSTDROP WHERE CUSID='" & KEY(0) & "' and ENTRYNO=" & key(1) 
   sqlyy="select * FROM RTLessorCUST WHERE CUSID='" & KEY(0) & "'"
   RSXX.OPEN SQLXX,CONN
   RSyy.OPEN SQLyy,CONN
   if LEN(TRIM(rsxx("batchno"))) = 0 THEN 
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustDROPFR " & "'" & key(0) & "'," & key(1) & ",'" & V(0) & "'" 
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
   ELSE
   sqlzz="select * FROM RTLessorCUSTar WHERE CUSID='" & KEY(0) & "' and batchno='" & rsxx("batchno") & "' "   
   rszz.open sqlzz,conn
   '���h����|�����סA���i���浲�ת���
'   response.write sqlzz
  '    response.end
   IF ISNULL(RSXX("FINISHDAT")) THEN
      ENDPGM="3"
    elseif isnull(RSyy("dropdat"))   then
      endpgm="4"            
    elseif RSzz("realamt") <> 0 or len(trim(rszz("mdat"))) > 0  then
      endpgm="5"                
   ELSE
'    response.write "bbb"
'      response.end
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustDROPFR " & "'" & key(0) & "'," & key(1) & ",'" & V(0) & "'" 
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
   RSzz.CLOSE
   
   END IF
   RSXX.CLOSE
   RSyy.CLOSE

   
conn.Close
SET RSXX=NOTHING
SET RSyy=NOTHING
SET RSzz=NOTHING
set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�Τ�h���浲�ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���h����|�����סA���i���浲�ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Ȥ�ثe�ëD�h�����A�A���i����h�����ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="5" then
       msgbox "���h���椧�����b�ڤw�R�b�A���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    else
       msgbox "�L�k����h���浲�ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorcustDROPfr.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>