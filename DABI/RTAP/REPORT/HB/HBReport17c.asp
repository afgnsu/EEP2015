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
    sql="usp_RTEngCmtyCustCount 'C', '" & v(0) &"' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�u�ȤH���U��ת��Ͻu�Ƥ�Ʋέp(�t�g�P).xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=7><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=7><b>�u�ȤH���U��ת��Ͻu�Ƥ�Ʋέp(�t�g�P)</b></td></tr>"
	response.Write "<tr><td align =left colspan=7><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=7><font size=2>�s�����G" &now()& "</font></td></tr>"
	
	response.Write "<TR>" &_
		"<td class=titleN align=""center"" >�m��</td>" &_
		"<td class=titleN align=""center"">����</td>" &_
		"<td class=titleN align=""center"">�u�ȤH��</td>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">���g�P</td>" &_
		"<td class=titleY align=""center"">�u��</td>" &_
		"<td class=titleY align=""center"">���</td>" &_
		"</TR>"
		
	Do While Not rs.Eof
		response.Write "<TR>" &_
			"<td class=tochar>"& rs("CUTNC") &"</td>" &_
			"<td class=tochar>"& rs("TOWNSHIP") &"</td>" &_
			"<td class=tochar>"& rs("CUSNC") &"</td>" &_
			"<td class=tochar>"& rs("casetype") &"</td>" &_
			"<td class=tochar>"& rs("belongnc") &"</td>" &_
			"<td class=tonum>"& rs("LINENUM") &"</td>" &_
			"<td class=tonum>"& rs("CUSTNUM") &"</td>" &_
			"</TR>"
		rs.MoveNext      
    	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
