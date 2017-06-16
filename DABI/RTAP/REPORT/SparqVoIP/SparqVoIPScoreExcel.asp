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

	sqlstr="select 	case when c.shortnc is null then '���P' else '�g�P' end as breakid, "_
		  &"isnull(c.shortnc, d.areanc) as breaknc, a.consigneesale, "_
		  &"sum(case when applydat between dateadd(d, -6,'" &v(0)& "') and '" &v(0)& "' then 1 else 0 end) as newapplynum, "_
		  &"sum(case when applydat <= '" &v(0)& "'  then 1 else 0 end) as applynum, "_
		  &"sum(case when wrkrcvdat <= '" &v(0)& "'  then 1 else 0 end) as sndwrknum, "_
		  &"sum(case when docketdat <= '" &v(0)& "'  then 1 else 0 end) as docketnum "_
		  &"from rtsparqvoipcust a "_
		  &"left outer join RTCtyTown b inner join RTArea d on d.areaid = b.areaid and d.areatype ='3' on b.cutid = a.cutid2 and b.township = a.township2 "_
		  &"left outer join RTobj c on a.consignee = c.cusid "_
		  &"where a.dropdat is null and a.freecode <>'Y' "_
		  &"group by case when c.shortnc is null then '���P' else '�g�P' end, isnull(c.shortnc, d.areanc), a.consigneesale "_
		  &"order by 1,2 "
'response.Write sqlstr    
    rs.Open sqlstr, CONN
    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�t��VoIP�~�Z�`��.xls"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=6><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=6><b>�t��VoIP�~�Z�`��</b></td></tr>"
	response.Write "<tr><td align =center colspan=6><font size=2><u>�έp���� ��" &v(0)& "</u></font></td></tr>"
	response.Write "<tr><td align =right colspan=6><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
		"<td class=titleY>�~�ȲէO</td>" &_
		"<td class=titleY>�g�P�Ӷ}�o�~��</td>" &_		
		"<td class=titleY>���g�s�W���</td>" &_
		"<td class=titleY>�`�ӽФ��</td>" &_
		"<td class=titleY>�`���u��</td>" &_
		"<td class=titleY>�`������</td>" &_
		"</TR>"
	
	sumflag =rs("breakid")
	newapplysum = 0
	applysum = 0
	sndwrksum = 0
	docketsum = 0
	Do While Not rs.Eof
		if sumflag <> rs("breakid") then
			response.Write "<TR>" &_
				   "<td class=titleN>�U���`�p</td>" &_
				   "<td class=titleN>&nbsp;</td>" &_				   
   				   "<td class=titleN>" &newapplysum& "</td>" &_				   
				   "<td class=titleN>" &applysum& "</td>" &_
				   "<td class=titleN>" &sndwrksum& "</td>" &_
				   "<td class=titleN>" &docketsum& "</td>" &_
				   "</TR>"
			newapplytotal = newapplysum
			applytotal = applysum
			sndwrktotal = sndwrksum
			dockettotal = docketsum
			newapplysum = 0
			applysum = 0
			sndwrksum = 0
			docketsum = 0
		end if 

	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("breaknc") &"</td>" &_				   
				   "<td class=tochar>"& rs("consigneesale") &"</td>" &_
				   "<td class=tonum>"& rs("newapplynum") &"</td>" &_
				   "<td class=tonum>"& rs("applynum") &"</td>" &_
				   "<td class=tonum>"& rs("sndwrknum") &"</td>" &_
				   "<td class=tonum>"& rs("docketnum") &"</td>" &_
				   "</TR>"

		newapplysum = newapplysum + rs("newapplynum")
		applysum = applysum + rs("applynum")
		sndwrksum = sndwrksum + rs("sndwrknum")
		docketsum = docketsum + rs("docketnum")
      
      sumflag =rs("breakid")      
      rs.MoveNext      
    Loop

	response.Write "<TR>" &_
		   "<td class=titleN>�g�P���`�p</td>" &_
		   "<td class=titleN>&nbsp;</td>" &_				   
   		   "<td class=titleN>" &newapplysum& "</td>" &_				   
		   "<td class=titleN>" &applysum& "</td>" &_
		   "<td class=titleN>" &sndwrksum& "</td>" &_
		   "<td class=titleN>" &docketsum& "</td>" &_
		   "</TR>"

	
	newapplytotal = newapplytotal + newapplysum
	applytotal = applytotal + applysum
	sndwrktotal = sndwrktotal + sndwrksum
	dockettotal = dockettotal + docketsum
	response.Write "<TR>" &_
		   "<td class=titleY>�����X�p</td>" &_
		   "<td class=titleY>&nbsp;</td>" &_				   		   
   		   "<td class=titleY>" &newapplytotal& "</td>" &_				   
		   "<td class=titleY>" &applytotal& "</td>" &_
		   "<td class=titleY>" &sndwrktotal& "</td>" &_
		   "<td class=titleY>" &dockettotal& "</td>" &_
		   "</TR>"
    
	response.Write "</table>"  

    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing

'' �p�p�� ========================================================================================
'    sqlstr="select	Isnull(d.CUSNC, '����}') as EMPLY, Count(*) as NUM, Count(*) * 300  as Bonus "_
'		  &"from	KTSCust a "_
'		  &"		left outer join RTEmployee c inner join RTObj d on d.CUSID = c.CUSID on c.EMPLY = a.EMPLY "_
'		  &"WHERE	a.APPLYDAT Between '"& v(0) &"' and '"& v(0) &"' "_
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
'	response.Write "<br><br><font size=2>" &_
'				   "�`�g�z�G�@�@�@�@�@�@�@���`�g�z�G�@�@�@�@�@�@�@�����D�ޡG�@�@�@�@�@�@�@���D�ޡG�@�@�@�@�@�@�@�s��H�G</font>"
%>
