<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select * from RTCUST where COMQ1=" & aryparmkey(0) & " AND CUSID='" & ARYPARMKEY(1) & "' AND ENTRYNO=" & ARYPARMKEY(2)
   conn.Open DSN
   rs.Open sql,conn,3,3
   If NOT IsNull(rs("DROPDAT")) AND ISNULL(RS("FINISHDAT")) AND ISNULL(RS("DOCKETDAT")) then   
      rs("DROPDAT")=NULL
      rs.update
      rs.close
      set rs=nothing
      endpgm="1"
   ElseIF NOT ISNULL("DROPDAT") AMD ( NOT ISNULL("FINISHDAT") OR NOT ISNULL("DOCKETDAT") ) THEN
      rs.close
      set rs=nothing
      endpgm="3"      
   Else
      rs.close
      set rs=nothing
      endpgm="2"
   End if
   conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Ȥ�@�o���ন�\",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Ȥᬰ�h����A���i����@�o����" & "  " & errmsg       
    else
       msgbox "���Ȥ�|���J�@�o�A���i�@�o����" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTCUSTDropC.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>