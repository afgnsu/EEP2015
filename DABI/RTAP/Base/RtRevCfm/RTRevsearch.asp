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
  s=s & "�]�ȼf�֪��p�G" & s1ary(1) & "  " & "�C�L�帹�G�t('" & s2 & "')�r��"
  if s1ary(0)="1" then
     t=t & " and datalength(rtrim(rtcust.RCVDTLNo)) >0 "
  elseif s1ary(0)="2" then
     t=t & " and  rtcust.FINRDFMDAT Is not null "
  elseif s1ary(0)="3" then
     t=t & " AND rtcust.FINRDFMDAT Is null "
  end if
  if len(trim(s2))> 0 then
     t=t & " and rtcust.rcvdtlno like '%" & s2 & "%'"
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
<div class=datalisttitle>�п�J�]��ܡ^�]�ȼf�ַj�M����</div><p>
<table border=1 cellspacing=0 cellpadding=0>
<tr>
<td class=datalisthead>�]�ȼf�֪��p</td>
<td bgcolor="silver">
	<select class=dataLISTENTRY  SIZE=1 name="D1">
		<!--<option value="1;����">��  ��</option>
		<option value="2;�w�f��">�w�f��</option>-->
		<option value="3;���f��">���f��</option>
	</select>
</td></TR>
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