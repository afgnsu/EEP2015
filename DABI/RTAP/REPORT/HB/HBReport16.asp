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
    sql="usp_RTAllCaseCount '" &v(0)& "' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�U��ץ����u��&��Ʋέp"

	response.Write "<table>"
	response.Write "<tr><td align =center colspan=15><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=15><b>�U��ץ����u��&��Ʋέp</b></td></tr>"
	response.Write "<tr><td align =left colspan=15><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=15><font size=2>�s�����G" &now()& "</font></td></tr>"
	
	response.Write "<TR>" &_
		"<td class=titleN colspan=""2"" rowspan=""2"">&nbsp;</td>" &_    
		"<td class=titleN align=""center"" colspan=""3"">�x�_</td>" &_
		"<td class=titleN align=""center"" colspan=""3"">���</td>" &_
		"<td class=titleN align=""center"" colspan=""3"">�x��</td>" &_
		"<td class=titleN align=""center"" colspan=""3"">����</td>" &_
		"<td class=titleN align=""center"" rowspan=""2"">�p�p</td>" &_
		"</TR>"
	response.Write "<TR>" &_
		"<td class=titleN align=""center"">���P</td>" &_
		"<td class=titleN align=""center"">�g�P</td>" &_
		"<td class=titleN align=""center"">�p�p</td>" &_
		"<td class=titleN align=""center"">���P</td>" &_
		"<td class=titleN align=""center"">�g�P</td>" &_
		"<td class=titleN align=""center"">�p�p</td>" &_
		"<td class=titleN align=""center"">���P</td>" &_
		"<td class=titleN align=""center"">�g�P</td>" &_
		"<td class=titleN align=""center"">�p�p</td>" &_
		"<td class=titleN align=""center"">���P</td>" &_
		"<td class=titleN align=""center"">�g�P</td>" &_
		"<td class=titleN align=""center"">�p�p</td>" &_
		"</TR>"
		
	if rs("num") ="����" then
		colored = tonum
	else
		colored = tonumY
	end if
		
	Do While Not rs.Eof
		if rs("num") ="����" then
			colored = "tonumY"
		else
			colored = "tonum"
		end if
	
		response.Write "<TR>" &_
			"<td class=tochar>"& rs("casetype") &"</td>" &_				   
			"<td class=tochar>"& rs("num") &"</td>" &_
			"<td class=" &colored& ">"& rs("c1aa") &"</td>" &_
			"<td class=" &colored& ">"& rs("c1ab") &"</td>" &_
			"<td class=" &colored& ">"& rs("c1") &"</td>" &_
			"<td class=" &colored& ">"& rs("c2aa") &"</td>" &_
			"<td class=" &colored& ">"& rs("c2ab") &"</td>" &_
			"<td class=" &colored& ">"& rs("c2") &"</td>" &_
			"<td class=" &colored& ">"& rs("c3aa") &"</td>" &_
			"<td class=" &colored& ">"& rs("c3ab") &"</td>" &_
			"<td class=" &colored& ">"& rs("c3") &"</td>" &_
			"<td class=" &colored& ">"& rs("c4aa") &"</td>" &_
			"<td class=" &colored& ">"& rs("c4ab") &"</td>" &_
			"<td class=" &colored& ">"& rs("c4") &"</td>" &_
			"<td class=" &colored& ">"& rs("sumh") &"</td>" 
		response.Write "</TR>"
		rs.MoveNext      
    	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
