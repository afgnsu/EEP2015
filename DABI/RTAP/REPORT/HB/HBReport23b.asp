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
    sql="usp_RTCallOutArea '" &v(0)&"','"&v(1)&"','"&v(2)&"','Y' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=HiBuilding�Ȥ� Call Out �W��(�h����)"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=11><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=11><b>HiBuilding�Ȥ� Call Out �W��(�h����)</b></td></tr>"
	'response.Write "<tr><td align =left colspan=11><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=11><font size=2>�s�����G" &now()& "</font></td></tr>"
	
	response.Write "<TR>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">HN���X</td>" &_
		"<td class=titleN align=""center"">�Ȥ�W��</td>" &_
		"<td class=titleN align=""center"">������</td>" &_
		"<td class=titleN align=""center"">�h����</td>" &_
		"<td class=titleN align=""center"">�O�Ҫ�</td>" &_
		"<td class=titleN align=""center"">TEL(H)</td>" &_
		"<td class=titleN align=""center"">TEL(O)</td>" &_
		"<td class=titleN align=""center"">���</td>" &_
		"<td class=titleN align=""center"">�˾��a�}</td>" &_
		"<td class=titleN align=""center"">�b��a�}</td>" &_
		"</TR>"
		
	Do While Not rs.Eof
		response.Write "<TR>" &_
			"<td class=tochar>"& rs("comn") &"</td>" &_
			"<td class=tochar>"& rs("cusno") &"</td>" &_
			"<td class=tochar>"& rs("CUSNC") &"</td>" &_
			"<td class=tochar>"& rs("docketdat") &"</td>" &_
			"<td class=tochar>"& rs("dropdat") &"</td>" &_
			"<td class=toNum>"& rs("gtmoney") &"</td>" &_
			"<td class=tochar>"& rs("home") &"</td>" &_
			"<td class=tochar>"& rs("office") &"</td>" &_
			"<td class=tochar>"& rs("mobile") &"</td>" &_
			"<td class=tochar>"& rs("addr1") &"</td>" &_
			"<td class=tochar>"& rs("addr2") &"</td>" &_
			"</TR>"
		rs.MoveNext      
    	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
