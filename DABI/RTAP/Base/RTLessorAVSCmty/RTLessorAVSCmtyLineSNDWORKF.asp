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
   sqlxx="select * FROM RTLessorAVSCmtyline WHERE comq1=" & KEY(0) & " and lineq1=" & KEY(1)
   rsxx.open sqlxx,conn
   if rsxx.eof then
      '�䤣��D�u����
      endpgm="7"
   elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 or LEN(TRIM(RSXX("cancelDAT"))) <> 0 then
      '�D�u�w�h���Χ@�o�A���i�i��D�u���u����
      endpgm="8"
  else
      xxadslapplydat=rsxx("adslapplydat")    
      xxCONTAPPLYDAT=rsxx("CONTAPPLYDAT")   
   end if
   rsxx.close
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorAVScmtylineHardware WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and dropdat is null and rcvfinishdat is null "
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF THEN
   ELSEIF RSXX("CNT") > 0 THEN
      ENDPGM="12"
   END IF
   RSXX.CLOSE
   '�ˬd�Ӭ��u��U���]�ƬO�_�Ҥw�짴���~��ε{��
   sqlxx="select count(*) as CNT FROM RTLessorAVScmtylineHardware WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' and dropdat is null "
   RSXX.OPEN SQLXX,CONN
   IF RSXX.EOF OR RSXX("CNT") < 1 THEN
      ENDPGM="13"
   END IF
   RSXX.CLOSE   
'�W�z���T��
if endpgm="" then
   endpgm="1"
  
   sqlxx="select * FROM RTLessorAVSCmtylineSndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
   RSXX.OPEN SQLXX,CONN
   '��w�@�o�ɡA���i���槹�u���שΥ����u����
   IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("REALENGINEER"))) = 0 AND LEN(TRIM(RSXX("REALCONSIGNEE"))) = 0 then
      endpgm="6"
   '�зǤu�{���׮ɡA�]�Ʀw�ˤ�ΥD�u���q�餣�i�ť�
   elseif (isnull(RSXX("Equipsetupdat")) or isnull(rsxx("adslapplydat"))) AND RSXX("sndkind")="ST" then
      endpgm="9"      
   elseif (NOT isnull(RSXX("Equipsetupdat")) or NOT isnull(rsxx("adslapplydat"))) AND RSXX("sndkind")<>"ST" then
      endpgm="10"            
   '�D�u�w���q�ɡA���i�A��"�зǤu�{"���ت����u��
   elseif (LEN(TRIM(xxadslapplydat)) <> 0 or LEN(TRIM(xxCONTAPPLYDAT)) <> 0 )and len(trim("SNDKIND"))="ST"  THEN
      endpgm="5"
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVScmtylineSndworkF "  & key(0) & "," & key(1) & ",'" & key(2) & "','" & V(0) & "'"
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
       msgbox "AVS-City�D�u���u�槹�u���צ��\",0
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
       msgbox "���D�u���u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���D�u�w���q�A���i�A��[�D�u���q]�����u��C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close               
    elseIF frm1.htmlfld.value="6" then
       msgbox "���D�u���u�槹�u�ɡA��������J��ڸ˾��H���ι�ڸ˾��g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣��D�u���ɡA�L�k���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="8" then
       msgbox "�D�u�w�h���Χ@�o�A�L�k����(���u�楲���@�o)�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="9" then
       msgbox "�зǤu�{���׮ɡA�]�Ʀw�˨���ΥD�u���q�餣�i�ťաC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="10" then
       msgbox "�D�зǤu�{���׮ɡA�]�Ʀw�˨���ΥD�u���q�饲���ťաC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    elseIF frm1.htmlfld.value="12" then
       msgbox "���D�u���u��]�Ƹ�Ƥ��A�|���]�ƥ��짴���~��ε{�ǡA���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="13" then
       msgbox "���D�u���u�楼�إߥD�u�]�Ƹ�ơA���i���槹�u���ק@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
   else
       msgbox "�L�k����D�u���u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVScmtylinesndworkf.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>