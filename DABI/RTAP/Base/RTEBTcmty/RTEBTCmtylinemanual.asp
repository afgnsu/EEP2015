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
   endpgm="1"
 '  On Error Resume Next
   '��ӥD�uEBT�w�^�ЮɡA���i�A�����ʦ^��
   sqlxx="select * FROM RTEBTCMTYLINE WHERE COMQ1=" & key(0) & " and LINEQ1=" & key(1) & " "
   RSXX.OPEN SQLXX,CONNxx
   if not isnull(rsxx("EBTAPPLYOKRTN")) or len(trim(rsxx("EBTAPPLYOKRTN"))) > 0 then
      endpgm="3"
   ELSEIF isnull(rsxx("APPLYUPLOADDAT")) THEN
      endpgm="4"
   ELSEIF isnull(rsxx("ADSLAPPLYDAT")) THEN
      endpgm="5"      
   end if
   rsxx.Close
   if endpgm="1" then
           SQLXX=" update RTEBTCMTYLINE set EBTAPPLYOKRTN=getdate() where COMQ1=" & key(0) & " and LINEQ1=" & key(1) & " AND EBTAPPLYOKRTN IS NULL "
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
            else
               endpgm="1"
               errmsg=""
            end if      
   end if
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�D�u��ʦ^�Ч@�~���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��ӥD�uEBT�w�^�ЮɡA���i�A�����ʦ^��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "��ӥD�u�^��EBT���ɼf�֤鬰�ťծɡA���i�����ʦ^��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "��ӥD�u�|�����q�A���i�����ʦ^��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    else
       msgbox "�L�k�����ʦ^�Ч@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTEBTCMTYLINEMANUAL.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>