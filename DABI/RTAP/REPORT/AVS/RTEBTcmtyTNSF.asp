<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   endpgm="1"
   sqlxx="select * FROM RTEBTFtpBuildingRpl WHERE comq1=" & KEY(0) & " and flag='" & key(1) & "' " 
   RSXX.OPEN SQLXX,CONNxx
     '��w�@�o�ɡA���i���浲�ק@�~
     IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
        ENDPGM="3"
     '�w���׮ɡA���i���Ƶ���
     elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0  then
        endpgm="2"
     '���׫e�A�Х�����M�����ɰO��
     elseif LEN(TRIM(RSXX("CLRFLAG"))) = 0 then
        endpgm="5"
     ELSE
          SQLXX=" update RTEBTFtpBuildingRpl set CLOSEdat=getdate(),CLOSEUSR='" & V(0) & "' where comq1=" & KEY(0)  & " and flag='" & key(1) & "' "
           connxx.Execute SQLXX
           If Err.number > 0 then
              endpgm="4"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
              errmsg=cstr(Err.number) & "=" & Err.description
          end if
      END IF
   RSXX.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS���Ϲq�l���ɲ��`��Ƶ��צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="5" then
       msgbox "���浲�׫e�A�Х��M���q�l���ɰO��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="2" then
       msgbox "����Ƥw���סA�������ư��浲�ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="3" then
       msgbox "����Ƥw�@�o�A���i���浲�ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    else
       msgbox "�L�k����AVS���Ϲq�l���ɲ��`��Ƶ��ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylinesndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>