<%@ LANGUAGE = VBScript %>
<%
    parm=request("parm")
    v=split(parm,";")
%>

<!-- #include file="uploadx.asp" -->
<%
dim filename, filename2
path = Server.MapPath("/WebAp/misFTP/SparqFtp/") & "\"
filename2 = SaveFile("fruit",path,4096,2)
filename = SaveFile("fruit2",path,4096,2)
If	filename <> "*TooBig*" and filename2 <> "*TooBig*" Then
    '��smis��Ʈw
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
    Set rs = conn.Execute("usp_RTSparqFtp '3','" & v(0) &"'")
	Set rs=Nothing
    set conn = nothing

	'ftp�W��
	Set fso = CreateObject("Scripting.FileSystemObject")        
	Set fsoini = fso.CreateTextFile("d:\CBNWEB\WebAP\misFTP\SparqFtp\ftp.ini", True)
	fsoini.WriteLine("sparq")
	fsoini.WriteLine("sparqexcel")
	fsoini.WriteLine("lcd d:\CBNWEB\WebAP\misFTP\SparqFtp")
	'fsoini.WriteLine("cd sparq")
	fsoini.WriteLine("put " & filename2)
	fsoini.WriteLine("put " & filename)	
	fsoini.WriteLine("bye")						
	fsoini.Close
	Response.Redirect "/WebAP/misFtp/SparqFtp/ftp.shtml"
	
    'Response.Write "<br><br>""" & filename & """��r�ɤW�ǧ���..."
Else
	Response.Write "<br><br>���j�p�W�X 4 MB������"
End IF

%>
 
<html>
	<head>
		<title>�W�ǵ��G</title>
		
<script language=vbscript>
Sub cmdcancel_onClick
  window.close
End Sub
</script>		

	</head>
	<BODY style="BACKGROUND: lightblue">
		<p><center>
			  <INPUT TYPE="button" VALUE="����" ID="cmdcancel" NAME="cmdcancel">
		</center><HR>			  
		</p>
	</body>
</html>
