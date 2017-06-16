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

	sqlstr="select a.cusnc, Isnull(b.SHORTNC, isnull(e.areanc, '')) as belongnc, isnull(d.shortnc,'') as sales, "_
				&"isnull(g.cusnc, '') as engineer, PHONENUM, realrcvamt "_
				&"from RTSparq0809Cust a "_
				&"left outer join RTObj b on a.CONSIGNEE = b.CUSID "_
				&"left outer join RTEmployee c inner join RTObj d on d.CUSID = c.CUSID on c.EMPLY = a.SALESID "_
				&"left outer join RTArea e on e.areaid = a.areaid and e.areatype ='3' "_
				&"left outer join RTObj g on g.cusid = a.setupemployee "_
				&"WHERE	a.applydat Between '" &v(0)& "' and '" &v(1)& "' "_
 				&"order by 	2,1 "
'response.Write sqlstr    
    rs.Open sqlstr, CONN
    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�t��0809�~�Z���Ӫ�.xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=7><b>�K�X�ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=7><b>�t��0809�~�Z���Ӫ�</b></td></tr>"
	response.Write "<tr><td align =center colspan=7><font size=2><u>�ӽФ�"& v(0)&"��"& v(1)&"�Τ�</u></font></td></tr>"
	response.Write "<tr><td align =right colspan=7><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
    			   "<td class=titleY>�Ǹ�</td>" &_
				   "<td class=titleY>�Τ�W��</td>" &_
				   "<td class=titleY>�~���Ұ�</td>" &_
				   "<td class=titleY>�~�ȤH��</td>" &_
				   "<td class=titleY>�˾����u</td>" &_
				   "<td class=titleY>�x��</td>" &_
				   "<td class=titleY>�ꦬ���B</td>" &_
				   "</TR>"
	SERNO =0
	'BonusSum = 0
	Do While Not rs.Eof
		SERNO = SERNO +1
		'BonusSum = BonusSum + rs("BONUS")
	    response.Write "<TR>" &_
				   "<td class=toNum>"& SERNO &"</td>" &_
				   "<td class=tochar>"& rs("CUSNC") &"</td>" &_
				   "<td class=tochar>"& rs("belongnc") &"</td>" &_				   
				   "<td class=tochar>"& rs("sales") &"</td>" &_
				   "<td class=tochar>"& rs("engineer") &"</td>" &_
				   "<td class=toNum>"& rs("PHONENUM") &"</td>" &_
				   "<td class=toNum>"& rs("realrcvamt") &"</td>" &_				   
				   "</TR>"
      rs.MoveNext
    Loop
    rs.Close
    
'    response.Write "<TR>" &_
'				   "<td class=titleN>&nbsp; </td>" &_
'				   "<td class=titleN>�X�p</td>" &_
'   				   "<td class=titleN>&nbsp; </td>" &_				   
'				   "<td class=titleN>&nbsp; </td>" &_
'				   "<td class=titleN>&nbsp; </td>" &_
'				   "<td class=titleN>&nbsp; </td>" &_
'				   "<td class=titleN>&nbsp; </td>" &_
'				   "<td class=titleN>&nbsp; </td>" &_				   
'				   "</TR>"
	response.Write "</table>"  
	

'' �p�p�� ========================================================================================
'    sqlstr="select	Isnull(d.CUSNC, '����}') as EMPLY, Count(*) as NUM, Count(*) * 300  as Bonus "_
'		  &"from	KTSCust a "_
'		  &"		left outer join RTEmployee c inner join RTObj d on d.CUSID = c.CUSID on c.EMPLY = a.EMPLY "_
'		  &"WHERE	a.APPLYDAT Between '"& v(0) &"' and '"& v(1) &"' "_
'		  &"group by Isnull(d.CUSNC, '����}') "
''response.Write sqlstr    
'    rs.Open sqlstr, CONN
'
'	response.Write "<br><br><table>"	
'   response.Write "<TR>" &_
'				   "<td colspan=4 style='mso-ignore:colspan'></td>" &_
'   				   "<td class=titleY>�M�פH��</td>" &_
'				   "<td class=titleY>�}�q���</td>" &_
'				   "<td class=titleY>�}�q����($300/��)</td>" &_				   
'				   "</TR>"
'	SERNO =0
'	BonusSum = 0
'	Do While Not rs.Eof
'		SERNO = SERNO + rs("NUM")
'		BonusSum = BonusSum + rs("BONUS")
'	    response.Write "<TR>" &_
'				   "<td colspan=4 style='mso-ignore:colspan'></td>" &_
'				   "<td class=tochar>"& rs("EMPLY") &"</td>" &_
'				   "<td class=toNum>"& rs("NUM") &"</td>" &_
'				   "<td class=toNum>"& rs("BONUS") &"</td>" &_
'				   "</TR>"
'      rs.MoveNext
'    Loop
'    rs.Close
'	conn.Close
'	set rs = nothing
'	set conn = nothing
	
'    response.Write "<TR>" &_
'				   "<td colspan=4 style='mso-ignore:colspan'></td>" &_
'				   "<td class=titleN>�X�p</td>" &_
'				   "<td class=titleN>"& SERNO&"</td>" &_
'				   "<td class=titleN>"& BonusSum &"</td>" &_
'				   "</TR></table>"
	'response.Write "<br><br><font size=2>" &_
	'			   "�`�g�z�G�@�@�@�@�@�@�@���`�g�z�G�@�@�@�@�@�@�@�����D�ޡG�@�@�@�@�@�@�@���D�ޡG�@�@�@�@�@�@�@�s��H�G</font>"
%>
