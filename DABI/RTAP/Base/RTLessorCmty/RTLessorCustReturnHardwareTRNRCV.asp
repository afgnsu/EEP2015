<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM Conn
   Set Conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   Conn.Open DSN
 '  �ˬd�Ӭ��u��O�_�w���שΧ@�o�Τw�L�i��]�ƶ���
   sqlxx="select * FROM RTLessorCustReturnSndwork WHERE CUSID='" & KEY(0) & "' AND ENTRYNO=" & KEY(1) & " AND PRTNO='" & KEY(2) & "' "
   RSXX.OPEN SQLXX,Conn
   '�䤣�쬣�u����
   if rsxx.eof then
      endpgm="3"
   '���u��w���u���שΥ����u���סA���i�ફ�~��γ�
   elseif len(trim(rsxx("closedat" ))) > 0 or len(trim(rsxx("unclosedat" ))) > 0 then
      endpgm="4"
   '���u��w�@�o�A���i�ફ�~��γ�
   elseif len(trim(rsxx("dropdat"))) > 0 then
      endpgm="5"
   '���u��w���������b�ڡA���i�ફ�~��γ�
   elseif len(trim(rsxx("cdat"))) > 0 or len(trim(rsxx("batchno"))) > 0 then
      endpgm="6"      
   end if
   rsxx.close
   '�ˬd�O�_�������ફ�~��γ檺�]��
   sqlxx="select count(*) as CNT FROM RTLessorCustReturnHardware WHERE CUSID='" & KEY(0) & "' AND ENTRYNO=" & KEY(1) & " AND PRTNO='" & KEY(2) & "' AND dropdat is null and rcvprtno='' and rcvfinishdat is null and batchno='' and qty > 0 "
 '  response.write sqlxx
  ' response.end
   RSXX.OPEN SQLXX,Conn
   '�L�i��]�Ƹ��
   if rsxx("cnt") = 0 then
      endpgm="7"
   end if
   rsxx.close
  
if endpgm="" then
   '�I�sstore procedure��s�����ɮ�
   strSP="usp_RTLessorCustReturnHardwareTRNRCVExe " & "'" & key(0) & "'," & key(1) & ",'" & key(2) & "','" & V(0) & "'" 
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
Conn.Close
SET RSXX=NOTHING
set Conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�Τ�_�����u�]���ફ�~��γ�@�~���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�䤣�쬣�u����!" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���u��w���u���שΥ����u���סA���i�ફ�~��γ�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���u��w�@�o�A���i�ફ�~��γ�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="6" then
       msgbox "���u��w���������b�ڡA���i�ફ�~��γ�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="7" then
       msgbox "���u��w�L�䥦�]�ƥi�ફ�~��γ�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    else
       msgbox "�L�k����Τ�_�����u�]���ફ�~��γ�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCustReturnhardwaretrnrcv.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>