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

    Dim rs,conn, formid
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    sql="usp_RTSparqEnv '" & v(0) &"', '" & v(1) &"', '" & v(2) &"' "
'response.Write sql           
   rs.Open sql, CONN

    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�t�իȤ�H�ʤ@����"
	response.Write "<table>"
	'response.Write "<tr><td align =center colspan=9><b>�K�X���ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=9><b>�t�իȤ�H�ʦC�L�@����</b></td></tr>"
	'response.Write "<tr><td align =left colspan=9><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=9><font size=2>�s�����G" &now()& "</font></td></tr>"
	
    response.Write "<TR>" &_
    			   "<td class=titleN>��קO</td>" &_
    			   "<td class=titleN>��B�I</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
				   "<td class=titleN>�Ȥ�W��</td>" &_
				   "<td class=titleY>������</td>" &_
				   "<td class=titleN>TEL(H)</td>" &_
				   "<td class=titleN>TEL(O)</td>" &_
				   "<td class=titleN>���</td>" &_
				   "<td class=titleN>�Ȥ�a�}</td>" &_
				   "</TR>"
	'i=0
	Do While Not rs.Eof
		'i=i+1
	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_
				   "<td class=tochar>"& rs("operationname") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
				   "<td class=tochar>"& rs("cusnc") &"</td>" &_
				   "<td class=tochar>"& rs("docketdat") &"</td>" &_
				   "<td class=tochar>"& rs("home") &"</td>" &_
				   "<td class=tochar>"& rs("office") &"</td>" &_
				   "<td class=tochar>"& rs("mobile") &"</td>" &_
				   "<td class=tochar>"& rs("raddr") &"</td>" &_				   				   
				   "</TR>"
      rs.MoveNext      
    Loop

	response.Write "</table>"  
    
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>

