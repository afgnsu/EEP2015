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
    rs.Open "usp_RTCustDocketDrop '" &v(0)& "','" &v(1)& "' ", CONN
     
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�U��ץ_�Ϫ��P���ϳ����h�����Ʋέp"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=8><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=8><b>�U��ץ_�Ϫ��P���ϳ����h�����Ʋέp</b></td></tr>"
	'response.Write "<tr><td align =center colspan=11><font size=2><u>�e��ӽФ�"& v(0)&"��"& v(1)&"�Τ�</u></font></td></tr>"
	response.Write "<tr><td align =right colspan=8><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
				   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>����</td>" &_
				   "<td class=titleN>�m��</td>" &_	   
				   "<td class=titleN>���ϦW��</td>" &_	   
				   "<td class=titleN>�~�ȤH��</td>" &_	   				   				   
				   "<td class=titleY>������</td>" &_
				   "<td class=titleY>�h����</td>" &_
				   "<td class=titleY>����</td>" &_				   
				   "</TR>"

	Do While Not rs.Eof
	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_				   
				   "<td class=tochar>"& rs("cutnc") &"</td>" &_
				   "<td class=tochar>"& rs("township") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
				   "<td class=tochar>"& rs("sales") &"</td>" &_				   				   
				   "<td class=tonum>"& rs("docketnum") &"</td>" &_
				   "<td class=tonum>"& rs("dropnum") &"</td>" &_
				   "<td class=tonum>"& rs("overnum") &"</td>" &_				   
				   "</TR>"
      rs.MoveNext
    Loop
	response.Write "</table>"  
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
