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
   SQLXX="select * FROM RTEBTCMTYH WHERE comq1=" & KEY(0) 
   'response.Write sqlxx
   RSXX.Open SQLxx,CONNXX
   '�|�����X�ӽСA����M���ӽ����ɰO��
   IF ISNULL(RSXX("UPDEBTDAT")) AND LEN(TRIM(RSXX("TRANSNOAPPLY")))=0 THEN
      ENDPGM=3
   END IF         
   if endpgm=1 then
      sqlxx="update rtebtcmtyH set UPDEBTDAT=null,TRANSNOAPPLY='' FROM rtebtcmtyH WHERE comq1=" & KEY(0) 
      connxx.execute sqlxx
      If Err.number > 0 then
         endpgm="4"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         sqlxx="update RTEBTFtpBuildingRpl set CLRFLAG=getdate(),clrusr='" & v(0) & "' where comq1=" & key(0)  & " and flag='" & key(1) & "' "
         connxx.execute sqlxx
      end if
   end if
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
       msgbox "AVS���Ϲq�l���ɲ��`��ƲM�����ɰO�����\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����ϩ|�����ɡA���i�������ɰO���M���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k����AVS���Ϲq�l���ɲ��`��ƲM�����ɰO���@�~" & "  " & frm1.htmlfld1.value
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