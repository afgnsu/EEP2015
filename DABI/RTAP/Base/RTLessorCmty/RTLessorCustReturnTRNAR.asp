<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSYY=Server.CreateObject("ADODB.RECORDSET")     
   SET RSzz=Server.CreateObject("ADODB.RECORDSET")   
   DSN="DSN=RtLib"
   conn.Open DSN
   ' conn.BEGINTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
   sqlxx="select * FROM RTLessorCustReturn WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) 
   sqlYY="select * FROM RTLessorCUST WHERE CUSID='" & KEY(0) & "' "
   sqlzz="select count(*) as cnt FROM RTLessorCustReturnsndwork WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) & " and dropdat is null and unclosedat is null and closedat is null "
   rsyy.open sqlyy,conn
   RSXX.OPEN SQLXX,conn
   RSzz.OPEN SQLzz,conn
     endpgm="1"
     '�䤣��Ȥ�_���D�ɸ��
     IF RSXX.EOF THEN
        ENDPGM="7"
     '�䤣��Ȥ�D�ɸ��
     ELSEIF RSYY.EOF THEN
        ENDPGM="8" 
     '��Ȥ�_����Ƥw�@�o�ɡA���i�����������b�ڧ@�~
     ELSEIF not isnull(RSXX("canceldat")) THEN
        ENDPGM="6"
     '��Ȥ��Ƨ@�o�ɡA�����@�o
     ELSEIF not isnull(RSYY("canceldat")) THEN
        ENDPGM="9"        
     '��Ȥ�w�|���h���ɡA���i����_���������b��
     ELSEIF isnull(RSYY("DROPdat")) THEN
        ENDPGM="10"           
     '�}�l�p�O��ťծɡA���i����������
     ELSEIF isnull(RSXX("strbillingdat")) THEN
        ENDPGM="11"             
     'batchno�����ťթε��פ餣���ťծɡA��ܦ����_����Ƥw�������b�ڡA���i���Ʋ���
     elseif LEN(TRIM(RSXX("batchno"))) <> 0 OR LEN(TRIM(RSXX("FINISHDAT"))) > 0 then
        endpgm="3"
     '�������B��0�̡A���i����
     elseif RSXX("amt")=0 then
        endpgm="4"      
     'ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u�沣�������b��
     elseif RSXX("paytype")="02" then
        endpgm="5"      
    '����ú�O�覡����A�Y���s�b���ڬ��u���ơA�h�����Ѭ��u��i�浲�ײ��������b��
     elseif RSzz("cnt") > 0 then
        endpgm="12"                
     ELSE
        '�I�sstore procedure��s�����ɮ�
        strSP="usp_RTLessorCustReturnTRNAR " & "'" & key(0) & "'" & "," & key(1) & ",'" & V(0) & "'"
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
     RSYY.CLOSE
     RSzz.CLOSE
   conn.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   SET RSzz=NOTHING
   set conn=nothing
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�Τ�_���������b�ڦ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
   elseIF frm1.htmlfld.value="3" then
       msgbox "�����_����Ƥw�������b�ڡA���i���Ʋ���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�������B��0�̡A���i���������b��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="5" then
       msgbox "ú�O�覡���{���I�ڮɡA�����Ѧ��ڬ��u�沣�������b��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="6" then
       msgbox "�_����Ƥw�@�o�ɡA���i�����������b�ڧ@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
     elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��Ȥ�_���D�ɸ�ơA�L�k�����������b�ڵ��ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="8" then
       msgbox "�䤣��Ȥ�D�ɸ�ơA�L�k�����������b�ڵ��ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="9" then
       msgbox "�Ȥ��Ƥw�@�o�A�����@�o�_�����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="10" then
       msgbox "�Ȥ��Ʃ|���h���A���i����_���������b�ڧ@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="11" then
       msgbox "�}�l�p�O��ťծɤ��i���������ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="12" then
       msgbox "���_����Ƥw�s�b���ڬ��u��A�����Ѭ��u��i�浲�ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                               
    else
       msgbox "�L�k����Τ�_���������b�ڧ@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTLessorCustReturnTRNAR.asp" ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>