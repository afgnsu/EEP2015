<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   Fusr=request("Fusr")
   Fusrid=Split(fusr,";")
   If len(trim(Fusr)) > 0 then
      parmKey=Request("Key")
      aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
      logonid=session("userid")
      Call SrGetEmployeeRef(Rtnvalue,1,logonid)
           V=split(rtnvalue,";")  
      Set conn=Server.CreateObject("ADODB.Connection")  
      Set rs=server.CreateObject("ADODB.Recordset")
      DSN="DSN=RtLib"
      sql="select * from RTFaqH where CASENO='" & aryparmkey(0) & "'"
      'Response.Write "SQL=" & SQL
      conn.Open DSN
      rs.Open sql,conn,3,3
      If rs.EOF then
         rs.close
         set rs=nothing
         endpgm="5"
         errmsg=aryparmkey(0)
      elseIf IsNull(rs("DropDATE")) and Isnull(rs("finishdate"))  then   
         rs("finishdate")=now()
         '�̾ڦw���H�������O�s�񤣦P���("1"���~��,"2"���޳N,"4"���ȪA=>�s�񬰦w���H����,"3"���t��=>�s�񬰼t����)
         if fusrid(1)="1" or fusrid(1)="2" or fusrid(1)="4" then
            rs("finishusr")=Fusrid(0)
            rs("finishfac")=""
         else
            rs("finishfac")=Fusrid(0)
            rs("finishusr")=""
         end if
         rs.update
         rs.close
         set rs=nothing
         endpgm="1"
      Elseif not IsNull(rs("finishdate")) then
         rs.close
         set rs=nothing
         endpgm="3"
      Else
         rs.close
         set rs=nothing
         endpgm="2"      
      End if
      conn.Close
   else
      endpgm="4"
   end if

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       'msgbox "�ȶD�B�z�浲�ק@�~����",0
    elseif frm1.htmlfld.value="3" then
       msgbox "���ȶD��w���סA���i���е���" & "  " & errmsg      
    elseif frm1.htmlfld.value="4" then
       msgbox "�п�J���u�H��" & "  " & errmsg            
    elseif frm1.htmlfld.value="5" then
       msgbox "�ȶD�渹�䤣��--" & "  " & errmsg                      
    else
       msgbox "���ȶD��w�@�o�A���i����" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTFaqfinishK.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>