<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONN
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RS=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   conn.Open DSN
   endpgm="1"
 '  On Error Resume Next

   sql="select * FROM RTSparq0809CustTEL WHERE cusid='" & KEY(0) & "' AND SEQ=" & KEY(1)
   rs.Open sql,conn
   CANCELDAT=rs("CANCELDAT")
   RS.CLOSE
   if LEN(TRIM(CANCELDAT)) > 0 then
     endpgm="2"
   else
     endpgm="1"
     sql="update RTSparq0809CustTEL set canceldat=getdate() where cusid='" & key(0) & "' AND SEQ=" & KEY(1)
     conn.Execute sql
   end if
   conn.Close
   SET RS=NOTHING
   set conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Τ�0809�q�ܸ�Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="2" then
       msgbox "���q�ܤw�@�o�A���i���Ч@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k����Τ�0809�q�ܸ�Ƨ@�o,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtyhardwaredrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>