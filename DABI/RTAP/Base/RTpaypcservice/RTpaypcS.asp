<!-- #include virtual="/webap/include/lockright.inc" -->
<html>
<head>

<script language="VBScript">
<!--
Sub btn_onClick()
  Dim winP,docP,S,t
  t=""
  s=""
  s1ary=split(document.all("D1").value,";")
  s2=document.all("search2").value
  s=s & "RT�I�u�O�Ω��Ӫ�C�L���p�G" & s1ary(1) & "  " & "�C�L�帹�G�t('" & s2 & "')�r��"
  if s1ary(0)="1" then
     t=t & " and datalength(rtrim(rtcust.paydtlprtno)) >0 "
  elseif s1ary(0)="2" then
     t=t & " and  rtcust.paydtldat IS not NULL "
  elseif s1ary(0)="3" then
     t=t & " and  rtcust.paydtldat Is null "
 
  end if
  if len(trim(s2))> 0 then
     t=t & " and rtcust.paydtlprtno like '%" & s2 & "%'"
  end if     
  '---t transfor to array
  't=t & ";" & s2
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
<!-- #include virtual="/WebUtility/DBAUDI/DataList.css" -->
<form name="form">
<center>
<div class=datalisttitle>�п�J�]��ܡ^RT�I�u�O�Ω��Ӫ�C�L�j�M����</div><p>
<table border=1 cellspacing=0 cellpadding=0>
<tr>
<td class=datalisthead>RT�I�u�O�Ω��Ӫ�C�L���p</td>
<td bgcolor="silver">
	<select class=dataLISTENTRY name="D1" size=1 readonly>
	    <option value="2;�w�C�L">�w�C�L</option></td></TR></select>
		<!--
		<option value="1;����">��  ��</option>
		<option value="2;�w�f��">�w�f��</option>
		-->
<tr><td class=datalisthead>�C�L�帹</td><td bgcolor="silver">
	<input class=datalistentry name="search2" size="9" maxlength="9">
</td></tr>
</table>
<table><tr><td></td><td align="right">
	<input class=datalistbutton type="submit" name="btn" onsubmit="btn_onclick" value="�d�@��">
    <input class=datalistbutton type="button" name="btn1" value="���@��">
</td></tr></table>
</form>
</body>
</html>