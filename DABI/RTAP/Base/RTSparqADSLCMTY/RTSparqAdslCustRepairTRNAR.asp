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
   DSN="DSN=RtLib"
   conn.Open DSN
   ' conn.BEGINTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
   sqlxx="select * FROM RTSparqAdslCustRepair WHERE CUSID='" & KEY(0) & "' and entryno=" & key(1) 
   sqlYY="select * FROM RTSparqAdslCust WHERE CUSID='" & KEY(0) & "' "
   rsyy.open sqlyy,conn
   RSXX.OPEN SQLXX,conn

     endpgm="1"
     '��Ȥ���צ��ڸ�Ƥw�@�o�ɡA���i�����������b�ڧ@�~
     IF not isnull(RSXX("canceldat")) THEN
        ENDPGM="3"
     '�L���ڤ�, ���i����
     ELSEIF isnull(RSXX("rcvmoneydat")) THEN
        ENDPGM="5"
     '��Ȥ�w�h���ɡA�����@�o
     ELSEIF not isnull(RSYY("DROPdat")) THEN
        ENDPGM="10"           
     'batchno�����ťթε��פ餣���ťծɡA��ܦ������צ��ڸ�Ƥw�������b�ڡA���i���Ʋ���
     elseif LEN(TRIM(RSXX("batchno"))) <> 0 OR LEN(TRIM(RSXX("FINISHDAT"))) > 0 then
        endpgm="3"
     '�������B��0�̡A���i����
     elseif RSXX("moveamt")=0 and RSXX("equipamt")=0 and RSXX("setamt")=0 and RSXX("returnamt")=0 then
        endpgm="4"      
     ELSE
        '�I�sstore procedure��s�����ɮ�
        strSP="usp_RTSparqAdslCustRepairAR " & "'" & key(0) & "'" & "," & key(1) & ",'" & V(0) & "', 'MF', '' "
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
       msgbox "�t��399�Τ���צ����������b�ڦ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
	elseIF frm1.htmlfld.value="3" then
       msgbox "�������צ��ڸ�Ƥw�������b�ڡA���i���Ʋ���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="4" then
       msgbox "�������B��0�̡A���i���������b��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="5" then
       msgbox "�L���ڤ�A���i���������b��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="6" then
       msgbox "���צ��ڸ�Ƥw�@�o�ɡA���i�����������b�ڧ@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="10" then
       msgbox "�Ȥ��Ƥw�h���A�����@�o���צ��ڸ�ơC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    else
       msgbox "�L�k����Τ���צ����������b�ڧ@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    end if
    winP.focus()
    window.close
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTSparqAdslCustRepairTRNAR.asp" ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>
