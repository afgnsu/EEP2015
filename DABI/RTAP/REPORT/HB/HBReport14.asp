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
    parm=request("parm")
    v=split(parm,";")
	if v(2) ="*" then v(2) ="%"
	if v(3) ="*" then v(3) ="%"	

    Dim rs,conn, formid
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    rs.Open "usp_RTCustDropList '" &v(2)& "','" &v(3)& "','" &v(0)& "','" &v(1)& "' ", CONN
     
'response.Write sqlstr    
    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�U��װh��,������Ӫ�.xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=13><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=13><b>�U��װh��,������Ӫ�</b></td></tr>"
	'response.Write "<tr><td align =center colspan=13><font size=2><u>�e��ӽФ�"& v(0)&"��"& v(1)&"�Τ�</u></font></td></tr>"
	response.Write "<tr><td align =right colspan=13><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
				   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>��/�g�P</td>" &_
				   "<td class=titleN>�Ұ�</td>" &_
				   "<td class=titleN>�~�ȭ�</td>" &_
				   "<td class=titleN>�u�{�v</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
				   "<td class=titleY>�Ȥ�W��</td>" &_
				   "<td class=titleY>�h����</td>" &_
				   "<td class=titleY>���A</td>" &_
				   "<td class=titleN>TEL(H)</td>" &_
				   "<td class=titleN>TEL(O)</td>" &_
				   "<td class=titleN>���</td>" &_
				   "<td class=titleN>�Ȥ�a�}</td>" &_
				   "</TR>"

	Do While Not rs.Eof
	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_				   
				   "<td class=tochar>"& rs("belongid") &"</td>" &_
				   "<td class=tochar>"& rs("belongnc") &"</td>" &_
				   "<td class=tochar>"& rs("salesnc") &"</td>" &_
				   "<td class=tochar>"& rs("engineernc") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
				   "<td class=tochar>"& rs("cusnc") &"</td>" &_
				   "<td class=tochar>"& rs("dropdat") &"</td>" &_
				   "<td class=tochar>"& rs("status") &"</td>" &_
				   "<td class=tochar>"& rs("home") &"</td>" &_
				   "<td class=tochar>"& rs("office") &"</td>" &_
				   "<td class=tochar>"& rs("mobile") &"</td>" &_				   				   				   				   
				   "<td class=tochar>"& rs("addr") &"</td>" &_
				   "</TR>"
      rs.MoveNext
    Loop
	response.Write "</table>"  
	

    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
	
%>
