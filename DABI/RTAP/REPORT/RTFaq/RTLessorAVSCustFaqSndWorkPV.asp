<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
   Key=split(request("key"),";")

   logonid=Request.ServerVariables("LOGON_USER")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  

   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=Server.CreateObject("ADODB.Recordset")  
   DSN="DSN=RtLib"
   conn.Open DSN
   SQL="select * from RTLessorAVSCustFaqH  where cusid ='" & key(0) & "' and faqno ='" & key(1) & "' "
   rs.Open sql,conn,3,3
   if not rs.EOF then
      rs("prtusr")=V(0)
      rs("prtdat")=now()      
      rs.update
   end if
   rs.close
   SQL="select * from RTLessorAVSCustFaqSndwork  where cusid ='" & key(0) & "' and faqno ='" & key(1) & "' and prtno ='" & key(2) & "' "
   rs.Open sql,conn,3,3
   if not rs.EOF then
      rs("prtusr")=V(0)
      rs("prtdat")=now()      
      rs.update
   end if
   rs.close
   conn.close   
   On error Resume next
   If Err.number <= 0 then
      endpgm="1"
      errmsg=""
      session("Scaseno")=  key(1) 
      session("Ecaseno")=  key(2) 
      session("typ")=  "7" 
   else
      endpgm="2"
      errmsg=cstr(Err.number) & "=" & Err.description
   end if
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�ȶD���p�B�z��C�L����",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.frm2.submit
    else
       msgbox "�L�k�C�L,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTLessorAVSCustFaqSndWorkPV.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
<form name=frm2 method=post action="RTFaQP.asp">
</form>
</html>