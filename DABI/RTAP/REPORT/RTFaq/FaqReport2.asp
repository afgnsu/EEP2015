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
    sql="usp_RTCallOutNeedData '1', '"&v(0)&"', '"&v(1)&"', '"&v(2)&"', '"&v(3)&"' "

'response.write "sql="& sql
'response.end

   rs.Open sql, CONN
     
'response.Write sql    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=CALL OUT �O�������`��"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=5><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=5><font size=3>CALL OUT �O�������`��</font></td></tr>"
	response.Write "<tr><td align =right colspan=5><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
    			   "<td class=titleN>�Ǹ�</td>" &_
    			   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>�a��</td>" &_
				   "<td class=titleN>�g�P��</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
				   "</TR>"
	serno=0
	Do While Not rs.Eof
	    serno = serno+1
	    response.Write "<TR>" &_
				   "<td class=tonum>"& serno &"</td>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_
   				   "<td class=tochar>"& rs("areanc") &"</td>" &_
				   "<td class=tochar>"& rs("consignee") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
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
%>
