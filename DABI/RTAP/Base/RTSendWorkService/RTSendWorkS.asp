<!-- #include virtual="/webap/include/lockright.inc" -->
<%key=request("KEY")%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  s1ary=Split(document.all("search1").value,";")
  s="  �o�]���A�G" & s1ary(1) 
  k1=document.all("HK1").value
  if s1ary(0) <> "" then
     t=t & " and a.comq1=" & k1 & " and a.sndinfodat is not null AND (a.reqdat " & s1ary(0) & ")"
  else
     t=t & " and a.comq1=" & k1 
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
<table width="50%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="50%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�o�]���A</td>
    <td width="60%" class=dataListEntry >
      <select name="search1" size="1">
        <option value="is null;���o�]" selected>���o�]</option>
        <option value="is not null;�w�o�]">�w�o�]</option>
        <option value=";����">����</option>
 
</table>
<table width="50%" align=right><tr><td></td><td align=right>
  <input type="button" value=" �d�� " class=dataListButton name="btn" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
  <input type=text name="HK1" value=<%=key%> style="display:none"></td></tr></table>
</body>
</html>