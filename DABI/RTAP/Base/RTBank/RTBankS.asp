<!-- #include virtual="/webap/include/lockright.inc" -->
<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �Ȧ����O
    rs.Open "SELECT CODE,CODEnc from RTCODE WHERE KIND='G1' " _
           &"ORDER BY CODE ",conn
    s3="<option value="";�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       s3= s3 & "<option value=""='" & rs("CODE") & "';" & "�G" &  rs("CODEnc") & """>" & rs("CODENC") & "</option>" & vbcrlf
    rs.movenext
    Loop
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  s1=document.all("search1").value
  s2=document.all("search2").value  
  s3ary=Split(document.all("search3").value,";")
  if len(trim(s1)) > 0 then
     S=S & "�Ȧ�N��:(�]�t'" & s1 & "'�r��) "
     T=T & " AND RTBank.HEADNO like '%" & S1 & "%' "
  end if
  if len(trim(s2)) > 0 then
     S=S & "�Ȧ�W��:(�]�t'" & s2 & "'�r��) "
     T=T & " AND RTBank.HEADNC like '%" & S2 & "%' "
  end if  
  if len(trim(s3ary(0))) > 0 then
     s=s & "�Ȧ����O:" & s3ary(1)
     t=t & " and RTbank.banktype " & s3ary(0)
  end if
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
Sub btn1_onClick()
  window.close
End Sub
-->
</script>
</head>
<body>
<center>
<table width="60%">
  <tr class=dataListTitle align=center>�Ȧ��Ʒj�M����</td><tr>
</table>
<table width="60%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�Ȧ�N��</td>
    <td width="60%" bgcolor=silver>
           <input class=dataListEntry name="search1" maxlength=50 size=10 style="TEXT-ALIGN: left" ID="Text2">
    </td></tr>
<tr><td class=dataListHead width="40%">�Ȧ�W��</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search2" maxlength=50 size=20 style="TEXT-ALIGN: left"></td></tr>
<tr><td class=dataListHead width="40%">�Ȧ����O</td>
    <td width="60%"  bgcolor=silver>
     <select name="SEARCH3" class=dataListEntry>
     <%=S3%>
     </select>
     </td></tr>               
</table>
<table width="60%" align=right><tr><td></td>
<td align=right>
<input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
<input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td>
</tr></table>
</body>
</html>