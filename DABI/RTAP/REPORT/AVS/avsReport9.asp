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
.title
	{font-size:10.0pt;font-weight:bold;border:1.0pt solid black;}
-->
</style>

<%
    parm=request("parm")
    v=split(parm,";")

    Dim rs,conn, formid
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    sqlstr="select	a.comq1, a.lineq1, a.cusid, c.comn, a.cusnc, a.socialid, "_
		  &"case d.telno  when '' then '�@' else d.telno end as telno, "_
		  &"case d.telno  when '' then 0 else 1 end as telnum, "_
		  &"a.avsno, a.docketdat, '�v�����h��' as remark "_
		  &"from	rtebtcust a "_
		  &"inner join rtebtcmtyline b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 "_
		  &"inner join rtebtcmtyh c on c.comq1 = b.comq1 "_
		  &"left outer join rtebtcustext d on d.comq1 = a.comq1 and d.lineq1 = a.lineq1 "_
		  &"and d.cusid = a.cusid and d.dropdat is null "_
		  &"WHERE	a.dropdat Between '"& v(0) &"' and '"& v(1) &"' "_
		  &"order by 4,5 "
'response.Write sqlstr    
    rs.Open sqlstr, CONN
    
    
    ' ���Ӫ� ===================================================================================
	'Response.Charset ="BIG5"    
	'Response.ContentType = "Content-Language;content=zh-tw"     
	'response.ContentType = "application/vnd.ms-excel"
	'Response.AddHeader "Content-Disposition","filename=AVS�h���^�вM��.xls"
	response.Write "<table>"
	'response.Write "<tr><td align =center colspan=7><b>���T�e�W�����ѥ��������q</b></td></tr>"
	'response.Write "<tr><td align =center colspan=2><font size=2><u>�h����"& v(0)&"��"& v(1)&"�Τ�</u></font></td></tr>"
	'response.Write "<tr><td align =right colspan=11><font size=2>�s�����G" &now()& "</font></td></tr>"
	response.Write "<tr><td align =center colspan=7 rowspan=5 class=title><b><font size=4>���T�h�� / �^�вM��</font></b></td>"
	response.Write "<td align =left colspan=2 class=title><font size=2>�i�����G" &v(0)& "</font></td></tr>"
	response.Write "<tr><td align =left colspan=2 class=title><font size=2>�i����G���T</font></td></tr>"	
	response.Write "<tr><td align =left colspan=2 class=title><font size=2>�p���H���G�䫺��</font></td></tr>"
	response.Write "<tr><td align =left colspan=2 class=title><font size=2>�p���q�ܡG02-26552888#311</font></td></tr>"
	response.Write "<tr><td align =left colspan=2 class=title><font size=2>�ǯu�q�ܡG02-26552940</font></td></tr>"
    response.Write "<TR>" &_
				   "<td class=titleY>�y����</td>" &_
				   "<td class=titleY>���ϦW��</td>" &_
				   "<td class=titleY>�Τ�W��</td>" &_
				   "<td class=titleY>�νs / ID</td>" &_
				   "<td class=titleY>�Ӹ˸��X</td>" &_
				   "<td class=titleY>�ӽнu��</td>" &_
				   "<td class=titleY>�X���s��</td>" &_
				   "<td class=titleY>������</td>" &_
				   "<td class=titleY>�Ƶ�</td>" &_
				   "</TR>"
	SERNO =0
	CbcSum = 0
	Do While Not rs.Eof
		SERNO = SERNO +1
		CbcSum = CbcSum + rs("telnum")
	    response.Write "<TR>" &_
				   "<td class=toNum>"& SERNO &"</td>" &_
				   "<td class=tochar>"& rs("COMN") &"</td>" &_
				   "<td class=tochar>"& rs("CUSNC") &"</td>" &_
				   "<td class=tochar>"& rs("SOCIALID") &"</td>" &_
				   "<td class=tochar>"& rs("TELNO") &"</td>" &_
				   "<td class=toNum>"& rs("TELNUM") &"</td>" &_
				   "<td class=tochar>"& rs("AVSNO") &"</td>" &_
				   "<td class=tochar>"& rs("DOCKETDAT") &"</td>" &_
				   "<td class=tochar>"& rs("REMARK") &"</td>" &_
				   "</TR>"
      rs.MoveNext
    Loop
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
	response.Write "</table>"  
	

' �p�p�� ========================================================================================
	response.Write "<br><br><table>"
    response.Write "<TR>" &_
				   "<td colspan=2 style='mso-ignore:colspan'></td>" &_
   				   "<td colspan=2><font size=2>�e����M��:</font></td>" &_
   				   "<td colspan=2></td>" &_
   				   "<td colspan=2><font size=2>�}�q���߱M��:</font></td>" &_
				   "</TR>" &_
					
				   "<TR>" &_
				   "<td colspan=2 style='mso-ignore:colspan'></td>" &_
   				   "<td class=titleY align=center>���~</td>" &_
				   "<td class=titleY align=center>���/�u��</td>" &_
   				   "<td colspan=2></td>" &_
   				   "<td class=titleY align=center>���~</td>" &_
				   "<td class=titleY align=center>���/�u��</td>" &_
				   "</TR>" &_
				   
				   "<TR>" &_
				   "<td colspan=2 style='mso-ignore:colspan'></td>" &_
   				   "<td class=titleN>AVS</td>" &_
				   "<td class=tochar>�@" &SERNO& "�@��@" &SERNO&"�@�u</td>" &_
   				   "<td colspan=2></td>" &_
   				   "<td class=titleN>AVS</td>" &_
				   "<td class=tochar>�@�@��@�@�u</td>" &_
				   "</TR>" &_
				   
				   "<TR>" &_
				   "<td colspan=2 style='mso-ignore:colspan'></td>" &_
   				   "<td class=titleN>CBC</td>" &_
				   "<td class=tochar>�@" &CbcSum& "�@��@" &CbcSum&"�@�u</td>" &_
   				   "<td colspan=2></td>" &_
   				   "<td class=titleN>CBC</td>" &_
				   "<td class=tochar>�@�@��@�@�u</td>" &_
				   "</TR>" &_

				   
				   "<TR>" &_
				   "<td colspan=2 style='mso-ignore:colspan'></td>" &_
   				   "<td class=titleN>EM</td>" &_
				   "<td class=tochar>�@�@��@�@�u</td>" &_
   				   "<td colspan=2></td>" &_
   				   "<td class=titleN>AVS</td>" &_
				   "<td class=tochar>�@�@��@�@�u</td>" &_
				   "</TR>" &_

				   "</table>"

%>
