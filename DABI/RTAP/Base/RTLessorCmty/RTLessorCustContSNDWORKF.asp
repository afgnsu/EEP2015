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
   sqlxx="select * FROM RTLessorCUST WHERE CUSID='" & KEY(0) & "' "
   sqlyy="select * FROM RTLessorCUSTcont WHERE  CUSID='" & KEY(0) & "' and entryno=" & key(1)
  ' response.write sqlyy
   rsyy.open sqlyy,conn
   rsxx.open sqlxx,conn
   if rsxx.eof then
      '�䤣��Ȥ����
      endpgm="7"
   elseif rsyy.eof then
      '�䤣��Ȥ�������
      endpgm="13"
   elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 then
      '�Ȥ�w�h��(�����Ĵ_���@�~)
      endpgm="12"
   elseif LEN(TRIM(RSXX("cancelDAT"))) <> 0 then
      '�Ȥ�w�@�o
      endpgm="8"
   elseif isnull(RSyy("strbillingDAT")) <> 0 then
      '�����ƶ}�l�p�O��A���i�ť�
      endpgm="15"            
   elseif LEN(TRIM(RSyy("cancelDAT"))) <> 0 then
      '�Ȥ������Ƥw�@�o
      endpgm="14"      
   elseif rsyy("amt")=0 then
      '������e���������B=0 (�L�k�������b��)
      endpgm="9"
   elseif len(trim(rsyy("batchno"))) > 0 then
      '�����Ƥv���������b��
      endpgm="10"      
   elseif len(trim(rsyy("finishdat"))) > 0 then
      '�����Ƥw���סA���i���Ƶ���(���p����T��)
      endpgm="17"            
   else
      '�Ȧs�Ȥ�i�ϥδ���
      tempperiod=rsyy("period")
      temprcvmoney=rsyy("amt")
      temppaytype=rsyy("paytype")
      tempcardno=rsyy("CREDITCARDNO")
   end if
   rsxx.close
   rsyy.close
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorCUSTCONTHardware WHERE CUSID='" & KEY(0) & "' AND entryno=" & key(1) & " and prtno='" & key(2) & "' and dropdat is null and rcvfinishdat is null "
   'response.write sqlxx
   'response.end
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF THEN
   ELSEIF RSXX("CNT") > 0 THEN
      ENDPGM="16"
   END IF
   RSXX.CLOSE

'�W�z���T��
if endpgm="" then
   endpgm="1"
  
   sqlxx="select * FROM RTLessorCUSTContsndwork WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) & " and prtno='" & key(2) & "' "
   RSXX.OPEN SQLXX,CONN
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
      endpgm="11"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCustContARSndworkF " & "'" & key(0) & "'" & "," & key(1) & ",'" & key(2) & "','" & V(0) & "'" & "," & tempperiod & "," & temprcvmoney & ",'" & temppaytype & "','" & tempcardno & "'"
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
       msgbox "ET-City�Τ᦬�ڬ��u�槹�u���צ��\",0
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
       msgbox "�����ڬ��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����ڬ��u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "�����ڬ��u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��Ȥ���ɡA�L�k���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="8" then
       msgbox "�Ȥ�w�h���Χ@�o�A�L�k����(���u�楲���@�o)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="9" then
       msgbox "�Τ�����������B���s�A�L�k���������b�ڸ�ơA�нT�{�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="10" then
       msgbox "���Τ������Ƥw���������b���ɡA���i���ư���(�Ь���T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="11" then
       msgbox "�����ڬ��u��w���������b���ɡA���i���ư���(�Ь���T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="12" then
       msgbox "���Ȥ�D�ɤw�h���A������Ĵ_���@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close               
    elseIF frm1.htmlfld.value="13" then
       msgbox "�䤣��Ȥ��������ɡA�L�k���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="14" then
       msgbox "�Ȥ������Ƥw�@�o�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    elseIF frm1.htmlfld.value="15" then
       msgbox "���浲�ק@�~�ɡA�����Ƥ�[�}�l�p�O��]���i�ťաC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="16" then
       msgbox "�����ڬ��u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{��(����Ωλ�Υ�����)�A���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                          
    elseIF frm1.htmlfld.value="17" then
       msgbox "�Ȥ�����D�ɤw���סA���i���ư��浲�ק@�~(���p����T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    else
       msgbox "�L�k���榬�ڬ��u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorcustContsndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>