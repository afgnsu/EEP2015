<%
    parm=request("key") & ";"
    v=split(parm,";")
	'v(0)= v(0)&";"
%>
<html>
	<head>
		<meta http-equiv="Content-Language" content="zh-tw">
		<title>Seednet�{8�����ɶפJ�@�~</title>

<script language=vbscript>
Sub cmdcancel_onClick
  window.close
End Sub
</script>		

	</head>
	<BODY style="BACKGROUND: lightblue">
		<form method="POST" action="uploadReckon.asp?key=<%=V(0)%>" enctype="multipart/form-data">
			<table align="center">
				<tr><tb>�п�ܱ��פJ��Seednet������</tb></tr>
				<tr></tr>
				<tr><td>���X�ɡG<input type="file" name="fruit" size="20"></td></tr>
			</table>	
			<p><center>
				<input type="submit" value="�פJ" name="subbutt" ID="Submit1">
				<INPUT TYPE="button" VALUE="����" ID="cmdcancel" NAME="cmdcancel">
			</center><HR>			  
		</form>

	</body>
</html>
