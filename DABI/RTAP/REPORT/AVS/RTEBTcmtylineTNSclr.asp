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
   SQLXX="select * FROM RTEBTCMTYLINE WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
   'response.Write sqlxx
   RSXX.Open SQLxx,CONNXX
   select case KEY(2)
     '�D�u�ӽ�
     CASE "A"
         '�w���q�A����M���ӽ����ɰO��
         IF LEN(TRIM(RSXX("ADSLAPPLYDAT"))) > 0 THEN
            ENDPGM=3
         '�|�����X�ӽСA����M���ӽ����ɰO��
         ELSEIF ISNULL(RSXX("UPDEBTDAT")) OR ISNULL(RSXX("UPDEBTCHKDAT")) THEN
            ENDPGM=4
         '�w���D�u�X���s���A����M���ӽ����ɰO��
         ELSEIF LEN(TRIM(RSXX("CONTRACTNO")))  > 0 THEN
            ENDPGM=5
         END IF         
         if endpgm=1 then
            sqlxx="update rtebtcmtyline set UPDEBTDAT=null,TRANSNOAPPLY='' FROM rtebtcmtyline WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
            connxx.execute sqlxx
            If Err.number > 0 then
                  endpgm="4"
                  errmsg=cstr(Err.number) & "=" & Err.description
            else
               sqlxx="update RTEBTFtpAdslRpl set CLRFLAG=getdate(),clrusr='" & v(0) & "' where comq1=" & key(0) & " and lineq1=" & key(1) & " and flag='" & key(2) & "' "
               connxx.execute sqlxx
            end if
         end if
     '�D�u���q�^��
     CASE "F"
         '�D�u�L���q�^�����ɰO���ΥD�u�|�����q�A����M�����q�^�����ɰO��
         IF ISNULL(RSXX("APPLYUPLOADTNS")) OR ISNULL(RSXX("APPLYUPLOADDAT")) OR ISNULL(RSXX("ADSLAPPLYDAT")) THEN
            ENDPGM=6
         END IF         
         if endpgm=1 then
            sqlxx="update rtebtcmtyline set applyuploadtns=null,TRANSNOdocket='' FROM rtebtcmtyline WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
            connxx.execute sqlxx
            If Err.number > 0 then
                  endpgm="4"
                  errmsg=cstr(Err.number) & "=" & Err.description
            else
               sqlxx="update RTEBTFtpAdslRpl set CLRFLAG=getdate(),clrusr='" & v(0) & "' where comq1=" & key(0) & " and lineq1=" & key(1) & " and flag='" & key(2) & "' "
               connxx.execute sqlxx
            end if
         end if
     '�D�u�ӽЫ����(���q����)
     CASE ELSE
   END SELECT   
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
       msgbox "AVS�D�u�q�l���ɲ��`��ƲM���ӽаO�����\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���D�u�w���q�A���i����ӽаO���M���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���D�u�|���ӽСA��������M���ӽаO���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���D�u�w���o�X���s���A���i����M���ӽаO���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="6" then
       msgbox "AVS�D�u�L���q�^�����ɰO���A���i�M�����q�^���O��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    else
       msgbox "�L�k����AVS�D�u�q�l���ɲ��`��ƲM���ӽаO���@�~" & "  " & frm1.htmlfld1.value
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