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
    sql="usp_RTFaqList '"&v(0)&"', '"&v(1)&"', '"&v(2)&"', '"&v(3)&"', '"&v(4)&"', '"&v(5)&"', '"&v(6)&"', '"&v(7)&"' "

   rs.Open sql, CONN
     
'response.Write sql    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�ȶD�@����.xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=14><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=14><font size=3>�Ȥ�@���� </font></td></tr>"
	response.Write "<tr><td align =right colspan=14><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
    			   "<td class=titleN>��קO</td>" &_
				   "<td class=titleN>�Ұ�</td>" &_
				   "<td class=titleN>�u�{�v</td>" &_
				   "<td class=titleN>���ϦW��</td>" &_
				   "<td class=titleN>�Τ�W��</td>" &_
				   "<td class=titleN>���z�ɶ�</td>" &_
				   "<td class=titleN>���z�H</td>" &_
				   "<td class=titleN>�ȶD��C�L��</td>" &_
				   "<td class=titleN>�ȪA�B�z</td>" &_
				   "<td class=titleN>�ư����u</td>" &_
				   "<td class=titleY>�B�z���</td>" &_
				   "<td class=titleY>�B�z�H��</td>" &_
   				   "<td class=titleY>�B�z���I</td>" &_
				   "<td class=titleN>�ήɧ���</td>" &_
				   "</TR>"

	Do While Not rs.Eof
	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("casetype") &"</td>" &_
   				   "<td class=tochar>"& rs("areanc") &"</td>" &_
   				   "<td class=tochar>"& rs("operationname") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
				   "<td class=tochar>"& rs("faqman") &"</td>" &_
				   "<td class=tochar>"& rs("rcvdate") &"</td>" &_
				   "<td class=tochar>"& rs("rcvusr") &"</td>" &_
				   "<td class=tochar>"& rs("faqprtdate") &"</td>" &_
				   "<td class=tochar>"& rs("memo") &"</td>" &_
				   "<td class=tochar>"& rs("finishusr") &"</td>" &_
				   "<td class=tochar>"& rs("logdate") &"</td>" &_
				   "<td class=tochar>"& rs("logusr") &"</td>" &_
				   "<td class=tochar>"& rs("logdesc") &"</td>" &_
				   "<td class=tochar>"& rs("fixtime") &"</td>" &_
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
