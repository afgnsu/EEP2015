<!-- #include virtual="/webap/include/lockright.inc" -->
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
  if len(trim(s1)) > 0 then
     S=S & "����N��:(�]�t'" & s1 & "'�r��) "
     T=T & " AND RTBankbranch.branchno like '%" & S1 & "%' "
  end if
  if len(trim(s2)) > 0 then
     S=S & "����W��:(�]�t'" & s2 & "'�r��) "
     T=T & " AND RTBankbranch.branchnc like '%" & S2 & "%' "
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
  <tr class=dataListTitle align=center>�Ȧ�����Ʒj�M����</td><tr>
</table>
<table width="60%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">����N��</td>
    <td width="60%" bgcolor=silver>
           <input class=dataListEntry name="search1" maxlength=50 size=10 style="TEXT-ALIGN: left" ID="Text2">
    </td></tr>
<tr><td class=dataListHead width="40%">����W��</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search2" maxlength=50 size=20 style="TEXT-ALIGN: left"></td></tr>
</table>
<table width="60%" align=right><tr><td></td>
<td align=right>
<input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
<input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td>
</tr></table>
</body>
</html>