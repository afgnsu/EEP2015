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
   '�ˬd�Ȥ���
   sqlxx="select * FROM RTLessorAVSCUST WHERE CUSID='" & KEY(0) & "' "
   rsxx.open sqlxx,conn
   if rsxx.eof then
      '�䤣��Ȥ����
      endpgm="7"
   elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 or LEN(TRIM(RSXX("cancelDAT"))) <> 0 then
      '�Ȥ�w�h���Χ@�o
      endpgm="8"
   elseif rsxx("rcvmoney")=0 then
      '�������B=0 (�L�k�������b��)
      endpgm="9"
   elseif len(trim(rsxx("batchno"))) > 0 then
      '�v���������b��
      endpgm="10"      
   elseif len(trim(rsxx("finishdat"))) > 0 then
      '���Ȥ�w���u���סA���i���ư���
      endpgm="14"            
   else
      '�Ȧs�Ȥ�i�ϥδ���
      tempperiod=rsxx("period")
      temprcvmoney=rsxx("rcvmoney")
      temppaytype=rsxx("paytype")
      tempcardno=rsxx("CREDITCARDNO")
   end if
   rsxx.close
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorAVSCUSTHardware WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' and dropdat is null and rcvfinishdat is null "
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF THEN
   ELSEIF RSXX("CNT") > 0 THEN
      ENDPGM="12"
   END IF
   RSXX.CLOSE
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorAVSCUSTHardware WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' and dropdat is null "
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF OR RSXX("CNT") < 1 THEN
      ENDPGM="13"
   END IF
   RSXX.CLOSE   
'�W�z���T��
if endpgm="" then
   endpgm="1"
  
   sqlxx="select * FROM RTLessorAVSCUSTsndwork WHERE CUSID='" & KEY(0) & "' and prtno='" & key(1) & "' "
   RSXX.OPEN SQLXX,CONN
   '��w�@�o�ɡA���i���槹�u���שΥ����u����
   IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("REALENGINEER"))) = 0 AND LEN(TRIM(RSXX("REALCONSIGNEE"))) = 0 then
      endpgm="6"
   '�Τ���dMAC���i�ť�
   elseif LEN(TRIM(RSXX("MAC"))) = 0 then
      endpgm="15"      
 '�Τ���dMAC���׬�17��    
   elseif LEN(TRIM(RSXX("MAC"))) <> 17 then
      endpgm="16"       
 '�Τ�W�h����]�ƥN�����i�ť�  
   elseif LEN(TRIM(RSXX("HOSTNO"))) = 0 then
      endpgm="17"     
 '�Τ�W�h����]��PORT�����i�ť�  
   elseif LEN(TRIM(RSXX("HOSTPORT"))) = 0 then
      endpgm="18"                
   elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
      endpgm="5"
   elseif LEN(TRIM(RSXX("BATCHNO"))) <> 0  then
      endpgm="11"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustARSndworkF " & "'" & key(0) & "'" & ",'" & key(1) & "','" & V(0) & "'" & "," & tempperiod & "," & temprcvmoney & ",'" & temppaytype & "','" & tempcardno & "'"
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
       msgbox "AVS-City�Τ�˾����u�槹�u���צ��\",0
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
       msgbox "���˾����u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���˾����u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���˾����u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
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
       msgbox "���Τ�Ӹ˸�Ƥw���������b���ɡA���i���ư���(�Ь���T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="11" then
       msgbox "���˾����u��w���������b���ɡA���i���ư���(�Ь���T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    elseIF frm1.htmlfld.value="12" then
       msgbox "���˾����u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{�ǡA���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="13" then
       msgbox "���˾����u�楼�إߥΤ�]�Ƹ�ơA���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    elseIF frm1.htmlfld.value="14" then
       msgbox "�Ȥ�D�ɤw���u���סA���i���ư��浲�ק@�~(���p����T��)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    elseIF frm1.htmlfld.value="15" then
       msgbox "�˾����׮ɡA�Τ���dMAC���i�ťաC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="16" then
       msgbox "�Τ���dMAC���ץ�����20��A�нT�{�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close         
    elseIF frm1.htmlfld.value="17" then
       msgbox "�˾����׮ɡA�Τ�W�h����]�ƥN�����i�ť�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    elseIF frm1.htmlfld.value="18" then
       msgbox "�˾����׮ɡA�Τ�W�h����]��PORT�����i�ť�" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                               
    else
       msgbox "�L�k����˾����u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScustsndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>