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
    'sql="usp_RTSparq499AreaScore '"&v(0)&"' "
	sql="select 	d.cusnc, b.exttel + case when b.exttel<>'' and b.sphnno<>'' then '-' else '' end+ b.sphnno as ncicno, "_
	   &" '�פ�A��' as updatenc, /*convert(varchar(10), getdate(), 111)*/ b.dropdat as processdat "_
	   &"from 	RTSparqAdslChg a "_
	   &"inner join RTSparqAdslCust b on a.cusid = b.cusid and a.entryno = b.entryno "_
	   &"inner join RTSparqAdslCmty c on b.comq1 = c.cutyid "_
	   &"inner join RTObj d on d.cusid = b.cusid "_
	   &"left outer join RTCounty e on e.cutid = b.cutid2 "_
	   &"left outer join RTCtyTown f inner join rtarea g on g.areaid = f.areaid and g.areatype ='3' on f.cutid = c.cutid and f.township= c.township	"_
	   &"left outer join RTObj h on h.cusid = c.consignee	"_
	   &"where	a.modifycode ='DR' and a.dropdat is null and a.transdat is not null "_
	   &"and	a.docketdat between '" &v(0)& "' and '" &v(1)& "' "_
	   &"order by a.EDAT "
'response.Write sql

   rs.Open sql, CONN
     
    ' ���Ӫ� ===================================================================================
	'Response.Charset ="BIG5"
	'Response.ContentType = "Content-Language;content=zh-tw"     
	'Response.ContentType = "application/vnd.ms-excel"
	'Response.AddHeader "Content-Disposition","filename=Sparq399�ΤᲧ�ʥӽвM��"
	response.Write "<html><head><meta http-equiv=content-type content=""text/html; charset=big5""><head>"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=7><b>�K�X���ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=7><b>���ϫ�399ADSL�ΤᲧ�ʥӽвM��</b></td></tr>"
	response.Write "<tr><td align =center colspan=7><font size=2>TEL:02-2655-2888#311�@�@�@FAX:02-2655-2940</font></td></tr>"	
	response.Write "<tr><td align =left colspan=3><font size=2><b>ATTN:</b> ���ɯ�IVY</font></td><td align =right colspan=4><font size=2>����G" &now()& "</font></td></tr>"
	
	
    response.Write "<TR>" &_
    			 "<td class=titleY>�Ǹ�</td>" &_
	   		   "<td class=titleY>�Τ�W��</td>" &_
				   "<td class=titleY>��b�N�X</td>" &_
				   "<td class=titleY>���ʶ���</td>" &_
				   "<td class=titleY>�h����</td>" &_
				   "<td class=titleY>NCIC�B�z��</td>" &_
				   "<td class=titleY>***�Ƶ�***</td>" &_
				   "</TR>"
	serno=0				   
	Do While Not rs.Eof
	    serno = serno+1
	    response.Write "<TR>" &_
				   "<td class=tonum>"& serno &"</td>" &_	    
				   "<td class=tochar>"& rs("cusnc") &"</td>" &_				   
				   "<td class=tochar>"& rs("ncicno") &"</td>" &_
				   "<td class=tochar>"& rs("updatenc") &"</td>" &_
				   "<td class=tochar>"& rs("processdat") &"</td>" &_
				   "<td class=tochar>&nbsp;</td>" &_			   
				   "<td class=tochar>&nbsp;</td>"			   				   								   
		response.Write "</TR>"
      rs.MoveNext      
    Loop
    
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
	response.Write "</table>"
	response.Write "</html>"
%>
