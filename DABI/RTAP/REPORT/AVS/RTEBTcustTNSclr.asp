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
   SQLXX="select * FROM RTEBTcust WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and cusid='" & key(2) & "' "
   'response.Write sqlxx
   RSXX.Open SQLxx,CONNXX
   select case KEY(3)
     'AVS�Τ�ӽ�
     CASE "A"
         '�w�����A����M���ӽ����ɰO��
         IF LEN(TRIM(RSXX("DOCKETDAT"))) > 0 THEN
            ENDPGM=3
         '�|�����X�ӽСA����M���ӽ����ɰO��
         ELSEIF ISNULL(RSXX("APPLYDAT")) OR ISNULL(RSXX("APPLYTNSDAT")) THEN
            ENDPGM=4
         '�w���Τ�avs�X���s���A����M���ӽ����ɰO��
         ELSEIF LEN(TRIM(RSXX("avsNO")))  > 0 THEN
            ENDPGM=5
         END IF         
         if endpgm=1 then
            sqlxx="update rtebtcust set APPLYTNSDAT=null,TRANSNOAPPLY='' FROM rtebtcUST WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
            connxx.execute sqlxx
            If Err.number > 0 then
                  endpgm="4"
                  errmsg=cstr(Err.number) & "=" & Err.description
            else
               sqlxx="update RTEBTFtpAvsparaRpl set CLRFLAG=getdate(),clrusr='" & v(0) & "' where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' and flag='" & key(3) & "' "
               connxx.execute sqlxx
            end if
         end if
     'AVS�Τ��������
     CASE "F"
         'AVS�Τ�L�������ɰO����AVS�Τ�|�������A����M���������ɰO��
         IF ISNULL(RSXX("DOCKETDAT")) OR ISNULL(RSXX("TRANSDAT")) OR ISNULL(RSXX("TRANSNODOCKET")) THEN
            ENDPGM=6
         END IF         
         if endpgm=1 then
            sqlxx="update rtebtCUST set TRANSDAT=null,TRANSNODOCKET='' FROM rtebtCUST WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
            connxx.execute sqlxx
            If Err.number > 0 then
                  endpgm="4"
                  errmsg=cstr(Err.number) & "=" & Err.description
            else
               sqlxx="update RTEBTFtpAvsparaRpl set CLRFLAG=getdate(),clrusr='" & v(0) & "' where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' and flag='" & key(3) & "' "
               connxx.execute sqlxx
            end if
         end if
     '
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
       msgbox "AVS�Τ�q�l���ɲ��`��ƲM���ӽаO�����\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Τ�w�����A���i����ӽаO���M���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Τ�|���ӽСA��������M���ӽаO���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "���Τ�w���oAVS�X���s���A���i����M���ӽаO���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="6" then
       msgbox "AVS�Τ�L�������ɰO���A���i�M���������ɰO��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    else
       msgbox "�L�k����AVS�Τ�q�l���ɲ��`��ƲM���ӽаO���@�~" & "  " & frm1.htmlfld1.value
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