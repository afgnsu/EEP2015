<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   '�M���Ȥ��ɤ����ϧǸ��Ϊ��ϦW�٥H�F��簣�s�����ĪG
   '--------------------------
   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select * from rtcustadsl where cusid='" & aryparmkey(1) & "' and entryno=" & aryparmkey(2)
  ' Response.Write "SQL=" & SQL
   conn.Open DSN
   rs.Open sql,conn,3,3
 '�ȮɱN�w���ɦܤ��عq�H���i�簣�������==>for �]�M�u�ӱN�Ȥ�֤J�䥦�u�����G(91/07/25)
 '  If Isnull(rs("TRANSDAT")) then   
      rs("comq1")=0
      rs("housename")=""
      rs.update
      rs.close
      set rs=nothing
      endpgm="1"
 '  Elseif Not IsNull(rs("transdat")) then   
 '     rs.close
 '     set rs=nothing
 '     endpgm="3"      
 '  End if
   conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Ȥ��Ƥw�q�����ɭ簣�s�����\",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    elseif frm1.htmlfld.value="3" then 
        msgbox "���Ȥ�w���ɦܤ��عq�H���m�A���i�簣�s��" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTdisconnect.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>