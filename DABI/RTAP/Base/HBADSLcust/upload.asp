<%@ LANGUAGE = VBScript %>
<!-- #include file="uploadx.asp" -->
<!-- #include virtual="/Webap/include/database.inc" -->
<%
'Response.Write "<br>Name=""" & GetFormVal("name") & """"
'Response.Write "<br>Sex=""" & GetFormVal("sex") & """"
'Response.Write "<br>province=""" & GetFormVal("province") & """"
'Response.Write "<br>city=""" & GetFormVal("city") & """"
'Response.Write "<br>lover=""" & GetFormVal("lover") & """"
dim filename
path = Server.MapPath("./") & "\txt\"
filename = SaveFile("fruit",path,4096,0)
If	filename <> "*TooBig*" Then
    Set conn=Server.CreateObject("ADODB.Connection")
	conn.Open DSN
    '�פJ��r��
    sql= "BULK INSERT RTLib.dbo.HBCustDrop FROM '"& path & filename &"' "&_
      	 "WITH (FIRSTROW =2, FORMATFILE ='"& path & "upload.fmt') "
    conn.Execute(sql)
    '��smis��Ʈw
    sql= "usp_HBCustDrop '1' "
    conn.Execute(sql)
    set conn = nothing
    Response.Write "<br><br>""" & filename & """��r�ɤW�ǤW�ǧ���..."
Else
	Response.Write "<br><br>���j�p�W�X 4 MB������"
End IF

'filename = SaveFile("fruit2",path,1024,0)
'If filename <> "*TooBig*" Then
'Response.Write "<br><br>""" & filename & """�w�g�W��"
'Else
'Response.Write "<br><br>���W�X����Ӥj"
'End IF
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
