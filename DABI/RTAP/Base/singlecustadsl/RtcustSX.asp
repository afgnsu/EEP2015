<%
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t,t1
  t=""
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="�P�@���ϦW�٦�=>" & s1 & " �H����"
     t=t & " singlecustadsl.cusid <> '*' "
     t1=" Having Count(*) >= " & s1 
  else
     s="�Ȥ�W�١G����  "
     t=t & " singlecustadsl.cusid <> '*' "
     t1=" Having Count(*) >= 3"  
  end if

  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=t1
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
Sub btn1_onClick()
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  winP.focus()
  window.close
End Sub
Sub SrReNew()
  Window.form.Submit
End Sub
-->
</script>
</head>
<body>
<form method="post" id="form">
<center>
<table width="80%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="80%" border=1 cellPadding=0 cellSpacing=0>
 
<tr><td class=dataListHead width="30%">�P�@���ϦW�٦�</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="25" class=dataListEntry>�H����
    </td></tr>
</table>
<table width="80%" align=right><tr><td></td><td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</FORM>
</body>
</html>
<!-- #include file="rtgetBRANCHBUSS.inc" -->