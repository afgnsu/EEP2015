<style>
<!--
.toChar
	{font-size:10.0pt;mso-number-format:"\@";border:0.5pt solid black;}
.toNum
	{font-size:10.0pt;border:0.5pt solid black;}
.titleY
	{font-size:10.0pt;font-weight:bold;background:peachpuff;border:0.5pt solid black;}
.titleN
	{font-size:10.0pt;font-weight:bold;background:silver;border:1.0pt solid black;}
-->
</style>

<%
    'server.scripttimeout =30000
    parm=request("parm")
    v=split(parm,";")
	if v(0) ="*" then v(0) ="%"
	if v(1) ="*" then v(1) ="%"	

    Dim rs,conn, formid
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    rs.Open "usp_RTCmtyCustCount '" &v(0)& "','" &v(1)& "','" &v(2)& "','" &v(3)& "','" &v(4)& "' ", CONN
     
'response.Write sqlstr    
    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�U��׫Ȥ�Ʋέp��.xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=9><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=9><b>�U��׫Ȥ�Ʋέp��</b></td></tr>"
	response.Write "<tr><td align =center colspan=11><font size=2><u>�έp����: "& v(2)&"��"& v(3)&"�Τ�</u></font></td></tr>"
	response.Write "<tr><td align =right colspan=9><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
				   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>��/�g�P</td>" &_
				   "<td class=titleN>�Ұ�</td>" &_				   
				   "<td class=titleN>�~�ȭ�</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
				   "<td class=titleN>���϶}�q��</td>" &_
				   "<td class=titleN>���Ϧa�}</td>" &_				   
				   "<td class=titleY>���Ĥ��</td>" &_
				   "<td class=titleY>�h�����</td>" &_
				   "</TR>"

	Do While Not rs.Eof
	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_				   
				   "<td class=tochar>"& rs("belongid") &"</td>" &_
				   "<td class=tochar>"& rs("belongnc") &"</td>" &_
				   "<td class=tochar>"& rs("salesman") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_				   
				   "<td class=tochar>"& rs("lineapplydat") &"</td>" &_
				   "<td class=tochar>"& rs("addr") &"</td>" &_
				   "<td class=toNum>"& rs("num") &"</td>" &_
				   "<td class=toNum>"& rs("dropnum") &"</td>" &_				   
				   "</TR>"
      rs.MoveNext
    Loop
	response.Write "</table>"  
	

    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
	
%>
