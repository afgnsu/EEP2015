<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   '�ˬd���h����ƬO�_�w���שΤ뵲
   DSN="DSN=RtLib"
   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select * from HBCUSTDROP where HBCustDrop.serno=" & ARYPARMKEY(0) 
   conn.Open DSN
  ' RESPONSE.Write SQL
   rs.Open sql,conn,3,3
   If rs("prtno") <>"" then   
      rs.close
      set rs=nothing
      endpgm="2"      
   Elseif rs("status") <> "���" then   
      rs.close
      set rs=nothing
      endpgm="3"            
   Elseif rs("OVERDUEDROP") = "Y" then   
      rs.close
      set rs=nothing
      endpgm="4"            
   ELSE
      rs("OVERDUEDROP")="Y"
      rs("OVERDUETNSDAT")=DATEVALUE(NOW)
      rs.update
      rs.close
      set rs=nothing
      endpgm="1"
   End if
   conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�����h���@�~����",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    elseif frm1.htmlfld.value="2" then 
        msgbox "����Ƥw�C�L(������渹),���i����" & "  " & errmsg
    elseif frm1.htmlfld.value="3" then 
        msgbox "�D���ᤣ�i���楻���@�~" & "  " & errmsg        
    else
       msgbox "�w������h���@�~�A�������а���" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTFaqDropK.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>