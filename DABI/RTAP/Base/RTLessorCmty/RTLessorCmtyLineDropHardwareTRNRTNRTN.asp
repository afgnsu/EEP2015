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
   sqlxx="select * FROM RTLessorCmtyLineDropSndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND entryno=" & KEY(2) & " AND PRTNO='" & KEY(3) & "' "
   RSXX.OPEN SQLXX,Conn
   '�䤣�쬣�u����
   if rsxx.eof then
      endpgm="3"
   '���u��w���u���שΥ����u���סA���i���ફ�~�����
   elseif len(trim(rsxx("closedat" ))) > 0 or len(trim(rsxx("unclosedat" ))) > 0 then
      endpgm="4"
   '���u��w�@�o�A���i���ફ�~�����
   elseif len(trim(rsxx("dropdat"))) > 0 then
      endpgm="5"
   '���u��w���������b�ڡA���i���ફ�~�����
   elseif len(trim(rsxx("cdat"))) > 0 or len(trim(rsxx("batchno"))) > 0 then
      endpgm="6"      
   end if
   rsxx.close
   '�ˬd�]���ɱ���
   sqlxx="select * FROM RTLessorCmtyLineDropHardware WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND entryno=" & KEY(2) & " AND PRTNO='" & KEY(3) & "' and seq=" & key(4)
 '  response.write sqlxx
  ' response.end
   RSXX.OPEN SQLXX,Conn
   '�L�i��]�Ƹ��
   if RSXX.EOF  then
      endpgm="10"   
   ELSEIF len(trim(rsxx("dropdat"))) > 0 then
      endpgm="7"
   elseif len(trim(rsxx("rcvprtno"))) = 0 then
      endpgm="8"
   elseif len(trim(rsxx("rcvfinishdat"))) > 0 then
      endpgm="9"
   ELSE
      XXRCVPRTNO=rsxx("rcvprtno")
   end if
   rsxx.close
  
if endpgm="" then
   '�I�sstore procedure��s�����ɮ�
   strSP="usp_RTLessorCmtyLineDropHardwareTRNRTNRTNExe " & "'" & XXRCVPRTNO & "','" & V(0) & "'" 
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
       msgbox "ET-City�D�u���u�]�ƪ��ફ�~�����@�~���\",0
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
       msgbox "���u��w���u���שΥ����u���סA���i���ફ�~�����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���u��w�@�o�A���i���ફ�~�����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="6" then
       msgbox "���u��w���������b�ڡA����i�ફ�~�����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="7" then
       msgbox "���]�Ƥw�@�o�A���i���ફ�~�����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    elseIF frm1.htmlfld.value="8" then
       msgbox "���]�Ʃ|���ફ�~�����A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="9" then
       msgbox "���]�Ƥ����~�����w�g���סA���i����(������Х��������~����浲�ק@�~)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="10" then
       msgbox "���]�Ƥ��]���ɸ�Ƥ��s�b�A���i����(�гq����T��)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                                     
    else
       msgbox "�L�k����D�u���u�]�ƪ��ફ�~�����@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCmtyLineDrophardwaretrnrTNrtn.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>