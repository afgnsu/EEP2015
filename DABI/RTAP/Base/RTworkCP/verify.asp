<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
logonid=session("userid")
Call SrGetEmployeeRef(Rtnvalue,1,logonid)
V=split(rtnvalue,";")  
dim ObjRS,strSP,endpgm,prtno
       prtno=session("workcanprtno")
       strSP="USP_okcancel 'A','"& prtno &"','"& V(0) &"'"
       Set conn=Server.CreateObject("ADODB.Connection")  
       DSN="DSN=RtLib"
       conn.Open DSN
       If len(trim(prtno)) > 0 THEN
          Set rs=Server.CreateObject("ADODB.Recordset") 
          SQL="select * from rtcust where INSPRTNO='" & prtno & "'"
          'Response.Write "SQL=" & SQL
          rs.Open sql,conn
          if rs.EOF then
              endpgm="4"
              errmsg=prtno
          elseif rs("settype") <> "2" and rs("settype") <> "3" then
              endpgm="3"
          elseif Not IsNull(rs("FINISHDAT")) then
              endpgm="5"
          end if
          rs.Close
          set rs=nothing
       end if
       if endpgm="" then
          On Error Resume Next
          Set ObjRS = conn.Execute(strSP)      
          conn.Close
          If Err.number > 0 then
             endpgm="2"
             errmsg=cstr(Err.number) & "=" & Err.description
          else
             endpgm="1"
             errmsg=""
          end if
       End if              
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    Set winP=window.Opener
    Set docP=winP.document
    if frm1.HTMLfld.value="1" then
       msgbox "RT���u��C�L�M�P����",0
       docP.all("keyform").Submit
    elseif frm1.HTMLfld.value="2" then
       msgbox "RT���u��C�L�M�P����,���~�T���G" & "  " & frm1.HTMLfld1.value
    elseif frm1.HTMLfld.value="3" then
       msgbox "RT���u��C�L�M�P����,���~�T���G���C�L��ƫD(�t��)��(�޳N��)�I�u�A�L�v���M�P�I"
    elseif frm1.HTMLfld.value="4" then
       msgbox "RT���u��C�L�M�P����,���~�T���G�t�Χ䤣��帹--" & frm1.HTMLfld1.value & "��������!"   
    elseif frm1.HTMLfld.value="5" then
       msgbox "RT���u��C�L�M�P����,���~�T���G���C�L�帹--�w���u,���i�M�P"              
    end if
    winP.focus()              
    window.close        
 end sub
</script>   
<form name=frm1 method=post action=verify.asp>
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form> 



































