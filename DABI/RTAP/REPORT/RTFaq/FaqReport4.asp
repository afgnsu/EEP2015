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
    sql="usp_RTFaqListTY '" & v(0) &"', '"& v(1) &"' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=��˭]�ȶD�@����"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=13><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=13><b>��˭]�ȶD�@����</b></td></tr>"
	response.Write "<tr><td align =left colspan=13><font size=2><u>�έp����"&v(0)&" �� "&v(1)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=13><font size=2>�s�����G" &now()& "</font></td></tr>"
	
	response.Write "<TR>" &_
		"<td class=titleN align=""center"">�k��</td>" &_
		"<td class=titleN align=""center"">�ץ�s��</td>" &_
		"<td class=titleN align=""center"">�������O</td>" &_
		"<td class=titleN align=""center"">�m��</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�Ȥ�W��</td>" &_
		"<td class=titleY align=""center"">���z�ɶ�</td>" &_
		"<td class=titleY align=""center"">���z�H</td>" &_
		"<td class=titleN align=""center"">�ư����u</td>" &_
		"<td class=titleN align=""center"">�ư��t��</td>" &_
		"<td class=titleY align=""center"">�B�z���</td>" &_
		"<td class=titleY align=""center"">�B�z�H��</td>" &_
		"<td class=titleY align=""center"">�B�z���I</td>" &_
		"</TR>"
		
	Do While Not rs.Eof
		response.Write "<TR>" &_
			"<td class=tochar>"& rs("belongNC") &"</td>" &_
			"<td class=tochar>"& rs("caseno") &"</td>" &_
			"<td class=tochar>"& rs("casetype") &"</td>" &_
			"<td class=tochar>"& rs("areanc") &"</td>" &_
			"<td class=tochar>"& rs("comn") &"</td>" &_
			"<td class=tochar>"& rs("faqman") &"</td>" &_
			"<td class=tochar>"& rs("rcvdate") &"</td>" &_
			"<td class=tochar>"& rs("rcvusr") &"</td>" &_
			"<td class=tochar>"& rs("finishusr") &"</td>" &_
			"<td class=tochar>"& rs("finishfac") &"</td>" &_
			"<td class=tochar>"& rs("logdate") &"</td>" &_
			"<td class=tochar>"& rs("logusr") &"</td>" &_
			"<td class=tochar>"& rs("logdesc") &"</td>" &_
			"</TR>"
		rs.MoveNext      
    	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
