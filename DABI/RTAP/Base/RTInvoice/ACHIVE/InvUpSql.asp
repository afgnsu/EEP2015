<%@ LANGUAGE = VBScript %>
<!-- #include file="uploadx.asp" -->
<%
'Response.Write "<br>Name=""" & GetFormVal("name") & """"
'Response.Write "<br>Sex=""" & GetFormVal("sex") & """"
'Response.Write "<br>province=""" & GetFormVal("province") & """"
'Response.Write "<br>city=""" & GetFormVal("city") & """"
'Response.Write "<br>lover=""" & GetFormVal("lover") & """"
dim filename
path = Server.MapPath("./") & "\excel\"
filename = SaveFile("fruit",path,8192,2)
If	filename <> "*TooBig*" Then
	'�פJEXCEL�ɦܸ�Ʈw
	Dim XSLconn, SQLconn, rs
	Set XSLconn = Server.CreateObject("ADODB.Connection")
	Set SQLconn = Server.CreateObject("ADODB.Connection")
	Set rs = Server.CreateObject("ADODB.Recordset")

	SQLconn.Open "DSN=RTLib"
	XSLconn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & path & filename & ";Extended Properties=Excel 8.0;"
	
	'�R���¸�� ===============================================================================		
	sql = "delete from rtinvtemp where batch is null"
	SQLconn.Execute sql					 

	'�G�p�פJ =================================================================================
	intI=0
	Set rs = XSLconn.Execute("SELECT 2 as INVTYPE,* FROM [�G�p$] WHERE [�P��~�W] is not null")
	While Not rs.EOF
		For intJ = 0 to 21 
			if rs.Fields(intJ).Value <> Empty then 
			col = rs.Fields(intJ).Value
			else
			col=""    	       
			end if

			select case intJ
				case 0			'�Ĥ@��(�G�por�T�p)
					 row = col
				case 1,2,6,10,11,12,13,14,15,16,18,19,20,21
					 row = row &","""& col &""""
				case 3,4,5,7,8	'�Ʀr��
					if len(col)=0 then col="0"
					 row = row &","& col
				case 9			'�����
					 row = row &",'"& col &"'"			
				case else 
					 row = row
			end select
			'Response.Write rs.Fields(0) & "<br>"
		Next						 
		'Response.Write row & "<br>"
		sql = "INSERT INTO rtinvtemp (INVTYPE, GROUPNC, PRODNC, QTY, UNITAMT, RCVAMT, "&_
			"TAXTYPE, SALEAMT, TAXAMT, INVDAT, INVNO, UNINO, INVTITLE, "&_
			"���ϦW��, �Τ�W��, �a�}, �p���q��, �I�u�H��, "&_
			  "�~�ȶ}�o���, �~�ȶ}�o�H��, �Ƶ�) VALUES (" & row & ")"
'response.Write sql				  
		SQLconn.Execute sql					 
		intI = intI +1
		rs.MoveNext
	Wend
	Response.Write "�G�p�@�W��" & intI  & "��<br>"
	rs.Close

	'�T�p�פJ =================================================================================
	intI=0
	Set rs = XSLconn.Execute("SELECT 3 as INVTYPE,* FROM [�T�p$] WHERE [�P��~�W] is not null")
	While Not rs.EOF
		For intJ = 0 to 21 
			if rs.Fields(intJ).Value <> Empty then 
			col = rs.Fields(intJ).Value
			else
			col=""    	       
			end if

			select case intJ
				case 0			'�Ĥ@��(�G�por�T�p)
					row = col
				case 1,2,6,10,11,12,13,14,15,16,18,19,20,21
					row = row &","""& col &""""
				case 3,4,5,7,8	'�Ʀr��
					if len(col)=0 then col="0"
					row = row &","& col
				case 9			'�����
					 row = row &",'"& col &"'"			
				case else 
					 row = row
			end select
			'Response.Write rs.Fields(0) & "<br>"
		Next						 
		'Response.Write row & "<br>"
		sql ="INSERT INTO rtinvtemp (INVTYPE, GROUPNC, PRODNC, QTY, UNITAMT, RCVAMT, "&_
			"TAXTYPE, SALEAMT, TAXAMT, INVDAT, INVNO, UNINO, INVTITLE, "&_
			"���ϦW��, �Τ�W��, �a�}, �p���q��, �I�u�H��, "&_
			  "�~�ȶ}�o���, �~�ȶ}�o�H��, �Ƶ�) VALUES (" & row & ")"
'response.Write sql			  
		SQLconn.Execute sql
		intI = intI +1			 
		rs.MoveNext
	Wend
	Response.Write "�T�p�@�W��" & intI  & "��<br>"
	rs.Close

	set rs = nothing
	SQLconn.Close
	XSLconn.Close
	set SQLconn = nothing
	set XSLconn = nothing    
    '��smis��Ʈw
    'sql= "usp_HBCustDrop '1' "
    'conn.Execute(sql)
    'set conn = nothing
    Response.Write "<br><br>""" & filename & """ ��r�ɤW�ǧ���..."
    Response.Write "<p><a href=""/rtap/Base/RTInvoice/InvoicePRT.asp"">�o���C�L</a></p>"
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
