<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
  ' On error Resume Next
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  

   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select * from hb2002act221 where  serno=" & aryparmkey(0) 
   conn.Open DSN
   rs.Open sql,conn,3,3
   If not IsNull(rs("dropdat")) then   
      rs("dropdat")=null
      rs("dropusr")=""
      rs.update
      endpgm="1"
      rs.close
      set rs=nothing
   Else
      rs.close
      set rs=nothing
      endpgm="2"
   End if
   if Err.number > 0 then
      Response.Write "�@�o�^�йL�{�o�Ͳ��`�A�гq����T�H���B�z�C"
   else
   end if
   conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Ȥ�q���Ƥw�^��",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    else
       msgbox "���Ȥ�q�楼�@�o�����^��" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="rtsndinfo.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>