<style>
<!--
.toChar2
	{font-size:10.0pt;mso-number-format:"\@";border:0.5pt solid black;}
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
	sql="usp_RTCallOutNeedData '2', '"&v(0)&"', '"&v(1)&"', '"&v(2)&"', '"&v(3)&"' "

   rs.Open sql, CONN
     
'response.Write sql    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=CALL OUT �O����"
	response.Write "<table>"
	'response.Write "<tr><td align =center colspan=12><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=12><font size=3>CALL OUT �O����</font></td></tr>"
	response.Write "<tr><td align =right colspan=12><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
    			   "<td class=titleN>No.</td>" &_
    			   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
    			   "<td class=titleY>CALL OUT �ɶ�</td>" &_
    			   "<td class=titleY>CALL OUT �H��</td>" &_
				   "<td class=titleN>�Ȥ�W��</td>" &_
				   "<td class=titleN>�Ȥ᪬�A</td>" &_
				   "<td class=titleN>TEL1</td>" &_
				   "<td class=titleN>TEL2</td>" &_
				   "<td class=titleN>���</td>" &_
				   "<td class=titleY>�q�X���G</td>" &_
				   "<td class=titleY>����</td>" &_
				   "</TR>"
	serno=0
	Do While Not rs.Eof
	    serno = serno+1
	    response.Write "<TR>" &_
				   "<td class=tonum>"& serno &"</td>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
   				   "<td class=tochar>&nbsp;</td>" &_
   				   "<td class=tochar>&nbsp;</td>" &_
				   "<td class=tochar>"& rs("cusnc") &"</td>" &_
				   "<td class=tochar>"& rs("custstats") &"</td>" &_
				   "<td class=tochar>"& rs("tel1") &"</td>" &_
				   "<td class=tochar>"& rs("tel2") &"&nbsp;</td>" &_
				   "<td class=tochar>"& rs("mobile") &"&nbsp;</td>" &_
   				   "<td class=tochar>&nbsp;</td>" &_
   				   "<td class=tochar>&nbsp;</td>" &_
				   "</TR>"
      rs.MoveNext
    Loop
	response.Write "</table>"  
	'response.Write "<br><br><font size=2>" &_
	'			   "�f��H�G�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�t��ñ���G�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�s��G</font>"
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
	response.Write "</table>"
%>
