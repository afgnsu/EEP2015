<%@ Language=VBScript %>
<%
   key=request("key")
   arykey=split(key,";")
   Set conn=Server.CreateObject("ADODB.Connection")  
   DSN="DSN=RtLib"
   conn.Open DSN
   On Error Resume Next
   if session("COMQ1")="" or SESSION("COMN")="" then
      endpgm="3"
      errmsg="�e������Ӥ[,������T�w����,�Э��s���楻�@�~!"
   else
      updsql="update rtcustadsl set comq1=" & session("COMQ1") & ",housename='" & session("COMN") & "' where cusid='" & arykey(0) & "' and entryno=" & arykey(1)
      conn.Execute updsql 
      conn.Close
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         endpgm="1"
         errmsg=""
      end if
   end if
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    on error resume next
    if frm1.htmlfld.value="1" then
    '   msgbox "�Ȥ��ƻP�����ɤw�إ߳s��,�Ы�[���s��z]�e�{�̷s���!",0
       Set winP=window.Opener
       Set docP=winP.document       
    '   docP.all("keyform").Submit
       winP.close             
       window.close
    else
   '    msgbox "�L�k�إ߳s��,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTjoincustCFM.asp>
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>