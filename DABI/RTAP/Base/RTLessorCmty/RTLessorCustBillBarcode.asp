<%
    parm=request("key")
    v=split(parm,";")
	v(0)= v(0)&";"
%>
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-tw">
		<title>ET-City ���X�ɶפJ�@�~</title>

<script language=vbscript>
Sub cmdcancel_onClick
  window.close
End Sub
</script>		

	</head>
	<BODY style="BACKGROUND: lightblue">
		<form method="POST" action="upload.asp?key=<%=V(0)%>" enctype="multipart/form-data">
			<table align="center"">
				<tr><tb>�п�ܱ��פJ��ET-City ���X��</tb></tr>
				<tr></tr>
				<tr><td>���X�ɡG<input type="file" name="fruit" size="20"></td></tr>
			</table>	
			<p><center>
				<input type="submit" value="�פJ" name="subbutt" ID="Submit1">
				<INPUT TYPE="button" VALUE="����" ID="cmdcancel" NAME="cmdcancel">
			</center><HR>			  
		</form>

		<p><b>�`�N�ƶ��G</b><br><br>
			1.��r�ɥ������¤�r�ɡA���ɦW�� .barcode<br>
			2.��r�ɤ��e�t�T�����A�U���H[����]�j�}�A���t���W�١A�C�C�Ҭ���ƦC<br>
			3.�T�����̶����GSeednet�Τ�s��, ���j�W�ӱ��X, ATM��b���X<br>
		</p>
	</body>
</html>
