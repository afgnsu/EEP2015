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
   sqlxx="select * FROM RTLessorAVSCUST WHERE CUSID='" & KEY(0) & "' "
   sqlyy="select * FROM RTLessorAVSCustReturn WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1)
   rsyy.open sqlyy,conn
   rsxx.open sqlxx,conn
   if rsxx.eof then
      '�䤣��Ȥ����
      endpgm="7"
   elseif rsyy.eof then
      '�䤣��Ȥ�_�����
      endpgm="13"
 '  elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 then
      '�Ȥ�w�h��,���i����
 '     endpgm="12"
   elseif LEN(TRIM(RSXX("cancelDAT"))) <> 0 then
      '�Ȥ�w�@�o,���i����
      endpgm="8"
   elseif LEN(TRIM(RSyy("cancelDAT"))) <> 0 then
      '�Ȥ�_����Ƥw�@�o,���i����
      endpgm="14"      
   else
      '�Ȧs�Ȥ�i�ϥδ���
      tempperiod=rsyy("period")
      temprcvmoney=rsyy("amt")
      temppaytype=rsyy("paytype")
      tempcardno=rsyy("CREDITCARDNO")
   end if
   rsxx.close
   rsyy.close
   '�O���Ȥ�D�ɲ����ɪ����ʶ����̤j��(�Y���u�浲�׮ɤw�O�������ʶ����p��ثe���̤j�ȮɡA��ܤw�g���䥦���ʵo�͡A�h�����\����C
   sqlyy="select max(entryno)as entryno from RTLessorAVSCUSTlog where CUSID='" & KEY(0)& "'"
   rsyy.open sqlyy,conn
   if rsyy.eof then
      xxmaxentryno=0
   else
      xxmaxentryno=rsyy("entryno")
   end if
   rsyy.close

'�W�z���T��
if endpgm="" then
   endpgm="1"
  
   sqlxx="select * FROM RTLessorAVSCustReturnsndwork WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) & " and prtno='" & key(2) & "' "
   RSXX.OPEN SQLXX,CONN
   BATCHNOXX=RSXX("BATCHNO")
   '�ˬd�����b���ɬO�_�w�R�b
   sqlyy="select * FROM RTLessorAVSCUSTAR WHERE CUSID='" & KEY(0) & "' AND BATCHNO='" & BATCHNOXx & "'"
   rsyy.open sqlyy,conn
   if rsyy.eof THEN
   ELSE
      if len(trim(rsyy("mdat")))>0 OR RSYY("REALAMT") > 0 then
      '�����b�ڤw�R�b���i���ת���
         endpgm="4"
      end if
   end if
   RSyy.CLOSE     
   if endpgm="1" then    
   '���u��|�����׮ɡA���i����
   IF isnull(RSXX("CLOSEDAT")) and isnull(RSXX("unCLOSEDAT"))  THEN
      ENDPGM="3"
   elseif len(trim(rsxx("dropdat"))) > 0 then
      ENDPGM="5"
   elseif xxmaxentryno > rsxx("maxentryno") then
      ENDPGM="6"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustReturnARSndworkFR " & "'" & key(0) & "'," & key(1) & ",'" & key(2) & "','" & V(0) & "','" & batchnoxx & "'" 
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
   end if
   RSXX.CLOSE
end if
conn.Close
SET RSXX=NOTHING
SET RSYY=NOTHING
set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City�Τ᦬�ڬ��u�浲�ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����u��|�����סA���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����b�ڤw�R�b�A���i���浲�ת���@�~(�лP��T���sô)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����u��w�@�o�A���i����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="6" then
       msgbox "�Ȥ�D�ɤw�i��䥦���ʡA�]���L�k���欣�u�����@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
   elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��Ȥ���ɡA�L�k����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="8" then
       msgbox "�Ȥ�w�h���Χ@�o�A�L�k����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="12" then
       msgbox "���Ȥ�D�ɤw�h���A���i����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close               
    elseIF frm1.htmlfld.value="13" then
       msgbox "�䤣��Ȥ�_������ɡA�L�k����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="14" then
       msgbox "�Ȥ�_����Ƥw�@�o�A���i����C" & "  " & frm1.htmlfld1.value
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
<form name=frm1 method=post action=RTLessorAVSCustReturnsndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>