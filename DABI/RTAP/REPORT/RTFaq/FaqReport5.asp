<style>
<!--
.toChar
	{font-size:10.0pt;mso-number-format:"\@";border:0.5pt solid black;}
.toNum
	{font-size:10.0pt;border:0.5pt solid black;}
.toNumY
	{font-size:10.0pt;border:0.5pt solid black;background:peachpuff;}
.titleY
	{font-size:10.0pt;font-weight:bold;background:peachpuff;border:0.5pt solid black;}
.titleN
	{font-size:10.0pt;font-weight:bold;background:silver;border:1.0pt solid black;}
-->
</style>

<%
    parm=request("parm")
    v=split(parm,";")

    Dim rs,conn, formid
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    sql="usp_RTFaqSum '" & v(0) &"', '"& v(1) &"' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�ȵ��@����"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=6><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=6><b>�ȵ��@����</b></td></tr>"
	response.Write "<tr><td align =left colspan=6><font size=2><u>�έp����: "&v(0)&" �� "&v(1)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=6><font size=2>�s�����G" &now()& "</font></td></tr>"
	
	response.Write "<TR>" &_
		"<td class=titleN align=""center"">�ȪA�H��</td>" &_
		"<td class=titleN align=""center"">�ץ����O</td>" &_
		"<td class=titleN align=""center"">���z�q��</td>" &_
		"<td class=titleN align=""center"">�l��q��</td>" &_
		"<td class=titleN align=""center"">���׳q��</td>" &_
		"<td class=titleY align=""center"">�����q��</td>" &_
		"</TR>"
		
	Do While Not rs.Eof
		response.Write "<TR>" &_
			"<td class=tochar>"& rs("rcvusr") &"</td>" &_
			"<td class=tochar>"& rs("comtype") &"</td>" &_
			"<td class=toNum>"& rs("sumrcv") &"</td>" &_
			"<td class=toNum>"& rs("sumadd") &"</td>" &_
			"<td class=toNum>"& rs("sumfinish") &"</td>" &_
			"<td class=toNumY>"& rs("sumunfinish") &"</td>" &_
			"</TR>"
		rs.MoveNext      
    	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
