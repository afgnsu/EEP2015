<style>
<!--
.toChar
	{font-size:10.0pt;mso-number-format:"\@";border:0.5pt solid black;}
.toNum
	{font-size:10.0pt;border:0.5pt solid black;}
.toNumY
	{font-size:10.0pt;border:0.5pt solid black;background:peachpuff;}
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
    sql="usp_RTCmtyLine '" &v(0)& "' "
   rs.Open sql, CONN
   
'response.Write sqlstr    
    
    ' ���Ӫ� ===================================================================================
	Response.Charset ="BIG5"    
	Response.ContentType = "Content-Language;content=zh-tw"     
	response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=���ϥD�u���"

	response.Write "<table>"
	response.Write "<tr><td align =center colspan=13><b>���T�e�W�����ѥ��������q</b></td></tr>"
	response.Write "<tr><td align =center colspan=13><b>���ϥD�u���</b></td></tr>"
	'response.Write "<tr><td align =left colspan=13><font size=2><u>�έp���� �ܡG "&v(0)&" </u></font></td></tr>"
	response.Write "<tr><td align =right colspan=13><font size=2>�s�����G" &now()& "</font></td></tr>"
	
if v(0) ="01" then
	 response.Write "<TR>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">�g�P�O</td>" &_
		"<td class=titleN align=""center"">��B�I</td>" &_
		"<td class=titleN align=""center"">HB���X(�T�w)</td>" &_
		"<td class=titleN align=""center"">HB���X(�p�q)</td>" &_
		"<td class=titleN align=""center"">HB���X(����)</td>" &_
		"<td class=titleN align=""center"">HB���X(ADSL)</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�s�����A</td>" &_
		"<td class=titleN align=""center"">�p�q��q���s��</td>" &_
		"<td class=titleN align=""center"">���ֹq���s��</td>" &_
		"<td class=titleN align=""center"">�W�Ҥ��</td>" &_
		"<td class=titleN align=""center"">COT IP</td>" &_
		"<td class=titleN align=""center"">Router IP</td>" &_
		"<td class=titleN align=""center"">IP ���q</td>" &_
		"<td class=titleN align=""center"">���Ĥ��</td>" &_						
		"<td class=titleN align=""center"">���Ϧa�}</td>" &_
		"</TR>"
elseif v(0) ="02" then
		 response.Write "<TR>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">�g�P�O</td>" &_
		"<td class=titleN align=""center"">��B�I</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�D�u�W�e</td>" &_
		"<td class=titleN align=""center"">�������X</td>" &_
		"<td class=titleN align=""center"">�W�Ҥ��</td>" &_
		"<td class=titleN align=""center"">IDSLAM IP</td>" &_
		"<td class=titleN align=""center"">GATEWAY IP</td>" &_
		"<td class=titleN align=""center"">�D�u���q</td>" &_
		"<td class=titleN align=""center"">���Ĥ��</td>" &_						
		"<td class=titleN align=""center"">���Ϧa�}</td>" &_
		"</TR>"
elseif v(0) ="03" then
			 response.Write "<TR>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">�g�P�O</td>" &_
		"<td class=titleN align=""center"">��B�I</td>" &_
		"<td class=titleN align=""center"">HB���X</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�D�u�W�e</td>" &_
		"<td class=titleN align=""center"">�������X</td>" &_
		"<td class=titleN align=""center"">�W�Ҥ��</td>" &_
		"<td class=titleN align=""center"">�D�uIP</td>" &_
		"<td class=titleN align=""center"">RESET�覡</td>" &_
		"<td class=titleN align=""center"">RESET�Ƶ�</td>" &_
		"<td class=titleN align=""center"">���Ĥ��</td>" &_
		"<td class=titleN align=""center"">���Ϧa�}</td>" &_
		"</TR>"
elseif v(0) ="04" then
			 response.Write "<TR>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">�g�P�O</td>" &_
		"<td class=titleN align=""center"">��B�I</td>" &_
		"<td class=titleN align=""center"">HB���X</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�D�u�W�e</td>" &_
		"<td class=titleN align=""center"">�������X</td>" &_
		"<td class=titleN align=""center"">�W�Ҥ��</td>" &_
		"<td class=titleN align=""center"">�D�uIP</td>" &_
		"<td class=titleN align=""center"">RESET�覡</td>" &_
		"<td class=titleN align=""center"">RESET�Ƶ�</td>" &_
		"<td class=titleN align=""center"">���Ĥ��</td>" &_
		"<td class=titleN align=""center"">���Ϧa�}</td>" &_
		"</TR>"
elseif v(0) ="05" then
			 response.Write "<TR>" &_
		"<td class=titleN align=""center"">��קO</td>" &_
		"<td class=titleN align=""center"">�g�P�O</td>" &_
		"<td class=titleN align=""center"">��B�I</td>" &_
		"<td class=titleN align=""center"">HB���X</td>" &_
		"<td class=titleN align=""center"">���ϦW��</td>" &_
		"<td class=titleN align=""center"">�D�u�W�e</td>" &_
		"<td class=titleN align=""center"">�������X</td>" &_
		"<td class=titleN align=""center"">�W�Ҥ��</td>" &_
		"<td class=titleN align=""center"">�D�uIP</td>" &_
		"<td class=titleN align=""center"">RESET�覡</td>" &_
		"<td class=titleN align=""center"">RESET�Ƶ�</td>" &_
		"<td class=titleN align=""center"">���Ĥ��</td>" &_
		"<td class=titleN align=""center"">���Ϧa�}</td>" &_
		"</TR>"
end if
	
		
	Do While Not rs.Eof
		 if v(0) ="01" then	
				response.Write "<TR>" &_
				"<td class=tochar>"& rs("casetype") &"</td>" &_				   
				"<td class=tochar>"& rs("belongnc") &"</td>" &_
				"<td class=tochar>"& rs("operationname") &"</td>" &_
				"<td class=tochar>"& rs("hbno") &"</td>" &_
				"<td class=tochar>"& rs("hbno2") &"</td>" &_
				"<td class=tochar>"& rs("hbno3") &"</td>" &_
				"<td class=tochar>"& rs("hbno4") &"</td>" &_
				"<td class=tochar>"& rs("comn") &"</td>" &_
				"<td class=tochar>"& rs("connecttypenc") &"</td>" &_
				"<td class=tochar>"& rs("t1no2") &"</td>" &_	
				"<td class=tochar>"& rs("t1no3") &"</td>" &_
				"<td class=tochar>"& rs("comcnt") &"</td>" &_
				"<td class=tochar>"& rs("cotip") &"</td>" &_
				"<td class=tochar>"& rs("idslamip") &"</td>" &_
				"<td class=tochar>"& rs("netip") &"</td>" &_								
				"<td class=tochar>"& rs("num") &"</td>" &_				   												
				"<td class=tochar>"& rs("addr") &"</td>"
		 elseif v(0) ="02" then		
				response.Write "<TR>" &_
				"<td class=tochar>"& rs("casetype") &"</td>" &_				   
				"<td class=tochar>"& rs("belongnc") &"</td>" &_
				"<td class=tochar>"& rs("operationname") &"</td>" &_
				"<td class=tochar>"& rs("comn") &"</td>" &_				   				
				"<td class=tochar>"& rs("lineratenc") &"</td>" &_
				"<td class=tochar>"& rs("linetel") &"</td>" &_	
				"<td class=tochar>"& rs("comcnt") &"</td>" &_
				"<td class=tochar>"& rs("idslamip") &"</td>" &_
				"<td class=tochar>"& rs("gateway") &"</td>" &_	
				"<td class=tochar>"& rs("netip") &"</td>" &_											
				"<td class=tochar>"& rs("num") &"</td>" &_				   												
				"<td class=tochar>"& rs("addr") &"</td>"
	   elseif v(0) ="03" then		
				response.Write "<TR>" &_	   	
				"<td class=tochar>"& rs("casetype") &"</td>" &_				   
				"<td class=tochar>"& rs("belongnc") &"</td>" &_
				"<td class=tochar>"& rs("operationname") &"</td>" &_
				"<td class=tochar>"& rs("hbno") &"</td>" &_
				"<td class=tochar>"& rs("comn") &"</td>" &_				   				
				"<td class=tochar>"& rs("lineratenc") &"</td>" &_
				"<td class=tochar>"& rs("cmtytel") &"</td>" &_	
				"<td class=tochar>"& rs("comcnt") &"</td>" &_
				"<td class=tochar>"& rs("ipaddr") &"</td>" &_
				"<td class=tochar>"& rs("resetnc") &"</td>" &_	
				"<td class=tochar>"& rs("resetdesc") &"</td>" &_											
				"<td class=tochar>"& rs("num") &"</td>" &_				   								
				"<td class=tochar>"& rs("addr") &"</td>"
	   elseif v(0) ="04" then		
				response.Write "<TR>" &_	   	
				"<td class=tochar>"& rs("casetype") &"</td>" &_				   
				"<td class=tochar>"& rs("belongnc") &"</td>" &_
				"<td class=tochar>"& rs("operationname") &"</td>" &_
				"<td class=tochar>"& rs("hbno") &"</td>" &_
				"<td class=tochar>"& rs("comn") &"</td>" &_				   				
				"<td class=tochar>"& rs("lineratenc") &"</td>" &_
				"<td class=tochar>"& rs("cmtytel") &"</td>" &_	
				"<td class=tochar>"& rs("comcnt") &"</td>" &_
				"<td class=tochar>"& rs("ipaddr") &"</td>" &_
				"<td class=tochar>"& rs("resetnc") &"</td>" &_	
				"<td class=tochar>"& rs("resetdesc") &"</td>" &_											
				"<td class=tochar>"& rs("num") &"</td>" &_				   								
				"<td class=tochar>"& rs("addr") &"</td>"
	   elseif v(0) ="05" then		
				response.Write "<TR>" &_	   	
				"<td class=tochar>"& rs("casetype") &"</td>" &_				   
				"<td class=tochar>"& rs("belongnc") &"</td>" &_
				"<td class=tochar>"& rs("operationname") &"</td>" &_
				"<td class=tochar>"& rs("hbno") &"</td>" &_
				"<td class=tochar>"& rs("comn") &"</td>" &_				   				
				"<td class=tochar>"& rs("lineratenc") &"</td>" &_
				"<td class=tochar>"& rs("cmtytel") &"</td>" &_	
				"<td class=tochar>"& rs("comcnt") &"</td>" &_
				"<td class=tochar>"& rs("ipaddr") &"</td>" &_
				"<td class=tochar>"& rs("resetnc") &"</td>" &_	
				"<td class=tochar>"& rs("resetdesc") &"</td>" &_											
				"<td class=tochar>"& rs("num") &"</td>" &_				   								
				"<td class=tochar>"& rs("addr") &"</td>"
	   end if
		 response.Write "</TR>"
		 rs.MoveNext      
	Loop
	response.Write "</table>"  
    
	rs.Close
	conn.Close
	set rs = nothing
	set conn = nothing
%>
