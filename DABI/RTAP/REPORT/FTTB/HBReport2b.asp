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
    sql="usp_RTFTTBApplyList 'B', '" & v(0) &"' "
   rs.Open sql, CONN
   
'response.Write sqlstr
	if rs.RecordCount >0 then
		workplace = rs("WORKPLACE")
	end if
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=HiBuilding�ȤᲾ��FTTB�M��"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=6><b><font size=4>HiBuilding�ȤᲾ��FTTB(ADSL)�~�ȥӽЫO�d��Mail & my web�Ȥ����</font></b></td></tr>"
	response.Write "<tr><td align =left colspan=2><font size=2>�ӽФ���G" &v(0)&"</font></td><td align=left colspan=2><font size=2>������B�B�G" &workplace& "</font></td><td align=left colspan=2><font size=2>�p���H�G</font></td></tr>"
	'response.Write "<tr><td align =left colspan=6><font size=2><u>�έp����"&v(0)&" �� "&v(1)&" </u></font></td></tr>"
	'response.Write "<tr><td align =right colspan=6><font size=2>�s�����G" &now()& "</font></td></tr>"

	response.Write "<TR>" &_
		"<td class=titleN align=""center"">��HiBuilding�Ȥ�W��</td>" &_
		"<td class=titleN align=""center"">HiBuilding HN</td>" &_
		"<td class=titleN align=""center"">FTTB(ADSL)HN</td>" &_
		"<td class=titleN align=""center"">E-Mail</td>" &_
		"<td class=titleN align=""center"">�O�dmy web(�Ŀ�)</td>" &_
		"<td class=titleN align=""center"">�Ȥ�s���q��</td>" &_
		"</TR>"
	
	Do While Not rs.Eof
			response.Write "<TR>" &_
				"<td class=tochar>"& rs("CUSNC") &"</td>" &_
				"<td class=tochar>"& rs("HBCUSNO") &"</td>" &_
				"<td class=tochar>"& rs("FTTBCUSNO") &"</td>" &_
				"<td class=tochar>"& rs("V3EMAIL") &"</td>" &_
				"<td class=tochar>"& rs("OTHSRV4") &"</td>" &_
				"<td class=tochar>"& rs("CONTACTTEL") &"</td>" &_
				"</TR>"
		rs.MoveNext      
    Loop
    	
	response.Write "<tr></tr><tr></tr><tr><td align =left colspan=2><font size=2>������B�Bñ���^�СG</font></td><td align=left colspan=2><font size=2>���عq�H��B�B�G" &workplace& "</font></td><td align=left colspan=2><font size=2>���T�s��H�G</font></td></tr>"
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing

%>
