<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONN
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSYY=Server.CreateObject("ADODB.RECORDSET")     
   DSN="DSN=RtLib"
   conn.Open DSN
   ' conn.BEGINTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
   '�O���Ȥ�D�ɲ����ɪ����ʶ����̤j��(�Y���u�浲�׮ɤw�O�������ʶ����p��ثe���̤j�ȮɡA��ܤw�g���䥦���ʵo�͡A�h�����\����C
   sqlyy="select max(entryno)as entryno from RTLessorAVSCUSTlog where CUSID='" & KEY(0)& "'"
   rsyy.open sqlyy,conn
   if rsyy.eof then
      xxmaxentryno=0
   else
      xxmaxentryno=rsyy("entryno")
   end if
   rsyy.close     
   '�����ˬd
   sqlxx="select * FROM RTLessorAVSCustCont WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) & " "
   sqlYY="select * FROM RTLessorAVSCUST WHERE  CUSID='" & KEY(0) & "' "
   rsyy.open sqlyy,conn
   RSXX.OPEN SQLXX,conn
     endpgm=""
     '�䤣��Ȥ�����D�ɸ��
     IF RSXX.EOF THEN
        ENDPGM="7"
     '�䤣��Ȥ�D�ɸ��
     ELSEIF RSYY.EOF THEN
        ENDPGM="8" 
     '��Ȥ������Ƥw�@�o�ɡA���i��������������ק@�~
     ELSEIF not isnull(RSXX("canceldat")) THEN
        ENDPGM="6"
     '��Ȥ��Ƨ@�o�ɡA���i��������������ק@�~
     ELSEIF not isnull(RSYY("canceldat")) THEN
        ENDPGM="9"        
     '��Ȥ�w�h���ɡA���i��������������ק@�~
     ELSEIF not isnull(RSYY("DROPdat")) THEN
        ENDPGM="10"           
    'batchno���ťթε��פ鬰�ťծɡA��ܦ��������Ʃ|���������b�ڡA���i�������@�~
     elseif LEN(TRIM(RSXX("batchno"))) = 0 OR isnull(RSXX("FINISHDAT")) then
        endpgm="3"
     'ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u����������b��
     elseif RSXX("paytype")="02" then
        endpgm="5"      
     elseif xxmaxentryno > rsxx("maxentryno") then
        'ENDPGM="11"             
     ELSE
        BATCHNOXX=RSXX("BATCHNO")
     END IF
     RSXX.CLOSE
     RSYY.CLOSE
     

   
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
   
   if endpgm="" then
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustContTRNFR " & "'" & key(0) & "'" & "," & key(1) & ",'" & V(0) & "','" & BATCHNOXX & "'"
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
       msgbox "AVS-City�Τ���������������ק@�~���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
   elseIF frm1.htmlfld.value="3" then
       msgbox "���������Ʃ|���������b�ڡA���i��������������ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
   elseIF frm1.htmlfld.value="4" then
       msgbox "�����b�ڤw�R�b�A���i��������������ק@�~�C(������R�b���)" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u��i�����@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="6" then
       msgbox "�����Ƥw�@�o�ɡA���i��������������ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
     elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��Ȥ�����D�ɸ�ơA���i��������������ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="8" then
       msgbox "�䤣��Ȥ�D�ɸ�ơA���i��������������ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="9" then
       msgbox "�Ȥ��Ƥw�@�o�A���i��������������ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="10" then
       msgbox "�Ȥ��Ƥw�h���A���i��������������ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="11" then
       msgbox "�Ȥ�D�ɤw�i��䥦���ʡA�]���L�k��������������ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    else
       msgbox "�L�k����Τ���������������ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVSCustContTRNFR.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>