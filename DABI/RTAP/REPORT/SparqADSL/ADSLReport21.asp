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
    sql="select	a.comq1, a.lineq1, isnull(isnull(g.shortnc, i.areanc),'') as belongnc, b.comn, isnull(c.cutnc, '')+a.township+a.raddr as addr, "_
	   &"isnull(f.cusnc,'') as sales, '�s������' as applytype, d.codenc as linerate, j.codenc as connectnc "_
	   &"from	RTSparq499CmtyLine a "_
	   &"inner join RTSPARQ499CMTYH b on a.comq1 = b.comq1 "_
	   &"left outer join RTCounty c on c.cutid = a.cutid "_
	   &"left outer join RTCode d on d.code = a.linerate and kind ='D3' "_
	   &"left outer join RTEmployee e inner join RTObj f on e.cusid = f.cusid on e.emply = a.salesid "_
	   &"left outer join RTObj g on g.cusid = a.consignee "_
	   &"left outer join RTCtyTown h inner join RTArea i on i.areaid = h.areaid and i.areatype ='3' on h.cutid = a.cutid and h.township = a.township "_
	   &"left outer join RTCode j on j.code = a.connecttype and j.kind ='G5' "_	   
	   &"where	a.ADSLAPPLYDAT between '"&v(0)&"' and '"&v(1)&"' "

   rs.Open sql, CONN
     
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=Sparq499���ϥD�u�e��M��"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=11><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=11><b>�u�諬499ADSL�D�u�e��M��-ñ�^</b></td></tr>"
	response.Write "<tr><td align =center colspan=11><b>�e��M��-ñ�^</b></td></tr>"	
	response.Write "<tr><td align =left colspan=11><font size=2><u>�D�u�ӽФ�G "&v(0)&" </u></font></td></tr>"
	'response.Write "<tr><td align =right colspan=11><font size=2>�s�����G" &now()& "</font></td></tr>"
    response.Write "<TR>" &_
				   "<td class=titleN>�ֹ�</td>" &_
				   "<td class=titleN>���ϧǸ�</td>" &_
				   "<td class=titleN>�D�u�Ǹ�</td>" &_	   
				   "<td class=titleN>�Ұ�</td>" &_	   
				   "<td class=titleN>�D�u�W��</td>" &_
				   "<td class=titleN>�w�˦a�}</td>" &_
				   "<td class=titleN>�~���p���H</td>" &_
				   "<td class=titleN>�ӽ����O</td>" &_
				   "<td class=titleN>�ӽ��W�e</td>" &_
				   "<td class=titleN>�s���覡</td>" &_
				   "<td class=titleN>�Ƶ�</td>" &_
				   "</TR>"

	Do While Not rs.Eof
	    response.Write "<TR>" &_
				   "<td class=tochar>&nbsp;</td>" &_				   
				   "<td class=tochar>"& rs("comq1") &"</td>" &_
				   "<td class=tochar>"& rs("lineq1") &"</td>" &_
				   "<td class=tochar>"& rs("belongnc") &"</td>" &_
				   "<td class=tochar>"& rs("comn") &"</td>" &_
				   "<td class=tochar>"& rs("addr") &"</td>" &_
				   "<td class=tochar>"& rs("sales") &"</td>" &_
				   "<td class=tochar>"& rs("applytype") &"</td>" &_
				   "<td class=tochar>"& rs("linerate") &"</td>" &_
				   "<td class=tochar>"& rs("connectnc") &"</td>" &_
				   "<td class=tochar>&nbsp;</td>" &_				   
				   "</TR>"
      rs.MoveNext
    Loop
	response.Write "</table>"  
	response.Write "<br><br><font size=2>" &_
				   "�f��H�G�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�t��ñ���G�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�s��G</font>"
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
