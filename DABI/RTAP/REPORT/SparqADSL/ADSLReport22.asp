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
    sql="usp_RTSparq499AreaScore '"&v(0)&"' "

   rs.Open sql, CONN
     
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=Sparq499�U�ղ֭p�`��"
	response.Write "<table>"
	response.Write "<tr><td align =center colspan=8><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=8><b>Sparq499�U�ղ֭p�`��</b></td></tr>"
	response.Write "<tr><td align =left colspan=8><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=8><font size=2>�s�����G" &now()& "</font></td></tr>"
	
    response.Write "<TR>" &_
    			   "<td class=titleY>�~�ȲէO</td>" &_
				   "<td class=titleY>�`���ϼ�</td>" &_
				   "<td class=titleY>�`�D�u��</td>" &_
				   "<td class=titleY>�`�ӽФ��</td>" &_
				   "<td class=titleY>�`�}�q��</td>" &_
				   "<td class=titleY>�`�w�ˤ��</td>" &_
				   "<td class=titleY>�֭p������</td>" &_
				   "<td class=titleY>�������</td>" &_				   				   				   
				   "</TR>"
	
	sumflag =rs("breakid")
	sumCmty = 0
	sumLine = 0
	sumApply = 0
	sumOpen = 0
	sumFinish = 0	
	sumDocket = 0		
	sumAvg = 0		
	Do While Not rs.Eof
		if sumflag <> rs("breakid") then
			response.Write "<TR>" &_
				   "<td class=titleN>�U���`�p</td>" &_
   				   "<td class=titleN>" &sumCmty& "</td>" &_				   
				   "<td class=titleN>" &sumLine& "</td>" &_
				   "<td class=titleN>" &sumApply& "</td>" &_
				   "<td class=titleN>" &sumOpen& "</td>" &_
				   "<td class=titleN>" &sumFinish& "</td>" &_
				   "<td class=titleN>" &sumDocket& "</td>" &_
				   "<td class=titleN>" &sumAvg& "</td>" &_				   
				   "</TR>"
			totalCmty = sumCmty
			totalLine = sumLine
			totalApply = sumApply
			totalOpen = sumOpen
			totalFinish = sumFinish		
			totalDocket = sumDocket					
			totalAvg = sumAvg
			sumCmty = 0
			sumLine = 0
			sumApply = 0
			sumOpen = 0
			sumFinish = 0	
			sumDocket = 0		
			sumAvg = 0		
		end if 

	    response.Write "<TR>" &_
				   "<td class=tochar>"& rs("breaknc") &"</td>" &_				   
				   "<td class=tonum>"& rs("numCmty") &"</td>" &_
				   "<td class=tonum>"& rs("numLine") &"</td>" &_
				   "<td class=tonum>"& rs("numApply") &"</td>" &_
				   "<td class=tonum>"& rs("numOpen") &"</td>" &_
				   "<td class=tonum>"& rs("numFinish") &"</td>" &_
				   "<td class=tonum>"& rs("numDocket") &"</td>" 
		if rs("numOpen") = 0 then 
			response.Write "<td class=tonum>0</td>"
		else				   		
			response.Write "<td class=tonum>"& Round(rs("numDocket")/rs("numOpen"), 1) &"</td>" 
		end if				   
		response.Write "</TR>"

		sumCmty = sumCmty + rs("numCmty")
		sumLine = sumLine + rs("numLine")
		sumApply = sumApply + rs("numApply")
		sumOpen = sumOpen + rs("numOpen")
		sumFinish = sumFinish + rs("numFinish")
		sumDocket = sumDocket + rs("numDocket")
		if rs("numOpen") <> 0 then sumAvg = sumAvg + Round(rs("numDocket")/rs("numOpen"), 1)
      
      sumflag =rs("breakid")      
      rs.MoveNext      
    Loop

	response.Write "<TR>" &_
		   "<td class=titleN>�g�P���`�p</td>" &_
		   "<td class=titleN>" &sumCmty& "</td>" &_				   
		   "<td class=titleN>" &sumLine& "</td>" &_
		   "<td class=titleN>" &sumApply& "</td>" &_
		   "<td class=titleN>" &sumOpen& "</td>" &_
		   "<td class=titleN>" &sumFinish& "</td>" &_
		   "<td class=titleN>" &sumDocket& "</td>" &_
		   "<td class=titleN>" &sumAvg& "</td>" &_				   
		   "</TR>"

	totalCmty = totalCmty + sumCmty
	totalLine = totalLine + sumLine
	totalApply = totalApply + sumApply
	totalOpen = totalOpen + sumOpen
	totalFinish = totalFinish + sumFinish
	totalDocket = totalDocket + sumDocket
	totalAvg = totalAvg + sumAvg
	response.Write "<TR>" &_
		   "<td class=titleY>�����X�p</td>" &_
   		   "<td class=titleY>" &totalCmty& "</td>" &_				   
		   "<td class=titleY>" &totalLine& "</td>" &_
		   "<td class=titleY>" &totalApply& "</td>" &_
		   "<td class=titleY>" &totalOpen& "</td>" &_
		   "<td class=titleY>" &totalFinish& "</td>" &_
		   "<td class=titleY>" &totalDocket& "</td>" &_
		   "<td class=titleY>" &totalAvg& "</td>" &_		   		   		   
		   "</TR>"
    
	response.Write "</table>"  
    
    rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
