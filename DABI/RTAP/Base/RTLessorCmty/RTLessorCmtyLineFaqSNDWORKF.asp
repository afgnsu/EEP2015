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
   '�ˬd�Ȥ���
   sqlxx="select * FROM RTLessorCMTYLINE WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1)
   sqlyy="select * FROM RTLessorCmtyLineFAQH WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " and FAQNO='" & key(2) & "' "
  ' response.write sqlyy
   rsyy.open sqlyy,conn
   rsxx.open sqlxx,conn
   if rsxx.eof then
      '�䤣��Ȥ����
      endpgm="7"
   elseif rsyy.eof then
      '�䤣�즹���׬��u����ݫȪA����
      endpgm="10"
   elseif LEN(TRIM(RSXX("cancelDAT"))) <> 0 then
      '�D�u�w�@�o
      endpgm="8"
   elseif LEN(TRIM(RSXX("dropdat"))) <> 0 then
      '�D�u�w�M�u
      endpgm="15"      
  elseif LEN(TRIM(RSyy("cancelDAT"))) <> 0 then
      '�D�u�ȶD���Ƥw�@�o
      endpgm="11"      
   elseif len(trim(rsyy("SNDCLOSEDAT"))) > 0 then
      '�����׬��u����ݫȪA��w�����u�浲�פ�A�гs����T��
      endpgm="12"            
   end if
   rsxx.close
   rsyy.close
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorCMTYLINEFAQHardware WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " AND faqno='" & key(2) & "' and prtno='" & key(3) & "' and dropdat is null and rcvfinishdat is null "
   'response.write sqlxx
   'response.end
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF THEN
   ELSEIF RSXX("CNT") > 0 THEN
      ENDPGM="9"
   END IF
   RSXX.CLOSE

'�W�z���T��
if endpgm="" then
   endpgm="1"
  
   sqlxx="select * FROM RTLessorCmtylineFAQsndwork WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " AND faqno='" & key(2) & "' and prtno='" & key(3) & "' "
   sqlyy="select count(*) as cnt FROM RTLessorCmtylineFaqSndworkFixCode WHERE COMQ1=" & KEY(0) & " AND LINEQ1=" & KEY(1) & " AND faqno='" & key(2) & "' and prtno='" & key(3) & "' "
   RSXX.OPEN SQLXX,CONN
   RSyy.OPEN SQLyy,CONN
   '��w�@�o�ɡA���i���槹�u���שΥ����u����
   IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("REALENGINEER"))) = 0 AND LEN(TRIM(RSXX("REALCONSIGNEE"))) = 0 then
      endpgm="6"
   elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
      endpgm="5"
   elseif LEN(TRIM(RSXX("BATCHNO"))) <> 0  then
      endpgm="13"      
   elseif rsyy("cnt") < 1 then
      endpgm="14"            
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCmtyLineFAQSndworkF " & key(0) & "," & key(1) & ",'" & key(2) & "','" & key(3) & "','" & V(0) & "'"
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
   RSyy.CLOSE
end if
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
       msgbox "ET-City�D�u���׬��u�槹�u���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i���槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����׬��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����׬��u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "�����׬��u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��D�u���ɡA�L�k���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="8" then
       msgbox "�D�u�w�@�o�A�L�k����(���u�楲���@�o)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="15" then
       msgbox "�D�u�w�M�u�A�L�k����(���u�楲���@�o)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="9" then
       msgbox "�����׬��u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{��(����Ωλ�Υ�����)�A���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="10" then
       msgbox "�䤣�즹���׬��u����ݫȪA����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="11" then
       msgbox "�����׬��u����ݫȪA���Ƥw�@�o�A���i���槹�u���ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close               
    elseIF frm1.htmlfld.value="12" then
       msgbox "�����׬��u����ݫȪA��w�����u�浲�פ�A�гs����T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    elseIF frm1.htmlfld.value="13" then
       msgbox "�����׬��u��w���������b�ڡA�L�k���Ƶ��סA�гs����T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="14" then
       msgbox "���׬��u�浲�׮ɡA�����Ŀ���׳B�z�L�{�����ο�J�B�z�覡" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                                  
    else
       msgbox "�L�k������׬��u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorCmtylineFAQsndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>