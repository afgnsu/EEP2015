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
   rsxx.open SQLXX,conn
   if rsxx.eof then
      endpgm="6"
      xxdatasrc=""
      xxprtno=""
   else
      xxdatasrc=rsxx("datasrc")
      xxprtno=rsxx("prtno")
   end if
   rsxx.close
   '�̾ڬ��u��ƨӷ��A���O�ˬd���ݬ��u�檬�A�O�_�ŦX����
   '(�D�u�M�u������u��)
   if xxdatasrc="01" then
      sqlxx="select * FROM RTLessorCmtyLineDropsndwork WHERE prtno='" & xxprtno & "'"
   end if
   rsxx.open sqlxx,conn
   if rsxx.eof then
      endpgm="7"
   '���~��γ���ݬ��u��w���u(�Υ����u)���סB�w�@�o�B�w�������b�ڮɡA���i�����γ浲�ת���
   elseif len(trim(rsxx("dropdat")))> 0 THEN
      endpgm="5"
   ELSEIF len(trim(rsxx("closedat")))> 0 or len(trim(rsxx("unclosedat")))> 0 THEN
      endpgm="8"
   ELSEIF len(trim(rsxx("batchno")))> 0 then
      endpgm="9"
   end if
   rsxx.close
   '�ˬd���~����檬�A
if endpgm="1" then
   sqlxx="select * FROM RTLessorCustRTNHardware WHERE rcvprtno='" & key(0) & "'"
   RSXX.OPEN SQLXX,conn
  '�w�@�o�A���i���ת���
   IF LEN(TRIM(RSXX("CANCELdat"))) <> 0 THEN
      ENDPGM="3"
   '�|�����סA���i���ת���
   elseIF isnull(rsxx("closedat")) then
      ENDPGM="4"
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustHardwareRTNFR " & "'" & key(0) & "','" & rsxx("datasrc") & "','" & V(0) & "'" 
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
end if
conn.Close
SET RSXX=NOTHING
set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���~����浲�ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���~�����w�@�o�A���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���~�����|�����סA���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���~�������ݬ��u��w�@�o�A���i���沾��浲�ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="6" then
       msgbox "Ū�����~�����o�Ϳ��~�A�L�k���檫�~����浲�ת���(�гq����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="7" then
       msgbox "Ū�����~�������ݬ��u��o�Ϳ��~�A�L�k���檫�~����浲�ת���(�гq����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="8" then
       msgbox "���~�������ݬ��u��w���u���שΥ����u���סA���i���沾��浲�ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="9" then
       msgbox "���~������ݬ��u��w�������b�ڡA���i���沾��浲�ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    else
       msgbox "�L�k���檫�~����浲�ת���@�~(�гq����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCustHardwareRTNFR.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>