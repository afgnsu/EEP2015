<%
    parm=request("parm")
    v=split(parm,";")
%>
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-tw">
		<title>Sparq499 Excel���ɤW�ǧ@�~</title>
<script language=vbscript>
Sub cmdcancel_onClick
  window.close
End Sub
</script>		
	</head>
	<BODY style="BACKGROUND: lightblue">
		<form method="POST" action="upload499.asp?parm=<%=v(0)%>" enctype="multipart/form-data">
		<table align="center"">
			<tr><tb>�п�ܱ��W�Ǥ�Sparq Excel��</tb></tr>
			<tr></tr>
			<tr><td>Excel��(499���)�G<input type="file" name="fruit" size="30"></td></tr>
		</table>	
		<p><center>
			   <input type="submit" value="�W��" name="subbutt" ID="Submit1">
			  <INPUT TYPE="button" VALUE="����" ID="cmdcancel" NAME="cmdcancel">
		</center><HR>			  
		</form>
		<p><b>�`�N�ƶ��G</b><br><br>
			1.��r�ɥ�����Excel��<br>
		</p>
	</body>
</html>
