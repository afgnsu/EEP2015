<!-- #include virtual="/webap/include/lockright.inc" -->
<html>
<head>

<script language="VBScript">
<!--
Sub btn_onClick()
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("search1").value=document.all("T1").value
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
-->
</script>
</head>
<body>
<!-- #include virtual="/WebUtility/DBAUDI/DataList.css" -->
<form name="form">
<center>
<div class=datalisttitle>�п�J�]��ܡ^�j�M����</div><p>
<table border=1 cellspacing=0 cellpadding=0>
<tr><td class=datalisthead>�j�M����</td>
<td>
<input class=dataLISTENTRY MAXLENGTH=9 SIZE=9 type="text" name="T1"><td>
</td>
<td>
<input class=datalistbutton type="SUBMIT" name="btn" onsubmit="btn_onclick" value="���@��"><td>
</form>
</body>
</html>