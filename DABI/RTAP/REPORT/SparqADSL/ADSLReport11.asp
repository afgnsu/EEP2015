<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�t�դ���@����"

    parm=request("parm")
    v=split(parm,";")

    Dim rs,conn
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
%>

<?xml version="1.0" encoding="Big5"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">

 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <ActiveSheet>0</ActiveSheet>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 
 <Styles>
	<Style ss:ID="Default" ss:Name="Normal">
		<Alignment ss:Vertical="Center"/>
		<Borders/>
		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Size="12"/>
		<Interior/>
		<NumberFormat/>
		<Protection/>
  	</Style>

  <Style ss:ID="Title">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Size="12" ss:Bold="1"/>
  </Style>

  <Style ss:ID="TitleDate">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   </Borders>
   <Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman"/>
  </Style>

	<Style ss:ID="Header">
		<Alignment ss:Horizontal="Center"/>
   		<Borders>
    		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Bold="1"/>
   		<Interior ss:Color="peachpuff" ss:Pattern="Solid"/>
  	</Style>

	<Style ss:ID="HeaderS">
		<Alignment ss:Horizontal="Center"/>
   		<Borders>
    		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Bold="1"/>
   		<Interior ss:Color="Silver" ss:Pattern="Solid"/>
  	</Style>

	<Style ss:ID="toChar">
		<Borders>
    		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman"/>
   		<NumberFormat ss:Format="@"/>
  	</Style>

	<Style ss:ID="toNum">
   		<Borders>
		    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman"/>
  	</Style>
 </Styles>


 <Worksheet ss:Name="Sparq399����">
  <Table>
<!--
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���T�e�W�����ѥ��������q</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">�t�դ���@����</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="4" ss:StyleID="TitleDate"><Data ss:Type="String">�s�����G<%=now()%> </Data></Cell>
   </Row>
-->
   <Row>
    <Cell ss:StyleID="Header"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">��b�N�X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�Ȥ�m�W</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�����Ҧr��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
   </Row>
<%
    sql="select c.comn, a.exttel+'-'+sphnno as ncicno, b.cusnc, a.socialid, dropdat "_
       &"from rtsparqadslcust a inner join rtobj b on a.cusid = b.cusid "_
       &"inner join rtsparqadslcmty c on c.cutyid = a.comq1 "_
       &"where dropdat <='" &v(0)& "' and overdue ='Y' "_
       &"ORDER by 1, 3 "
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
   			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ncicno") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("socialid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("dropdat") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


 <Worksheet ss:Name="Sparq499����">
  <Table>
   <Row>
    <Cell ss:StyleID="Header"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">��b�N�X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�Ȥ�m�W</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�����Ҧr��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
   </Row>
<%
    sql="select c.comn, a.nciccusno+'-'+sphnno as ncicno, a.cusnc, a.socialid, a.dropdat "_
       &"from RTSparq499Cust a "_
       &"inner join RTSparq499CmtyH c on c.COMQ1 = a.comq1 "_
       &"where a.dropdat <='" &v(0)& "' and a.overdue ='Y' "_
       &"ORDER by 1, 3 "
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
   			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ncicno") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("socialid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("dropdat") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close

	conn.Close
	set rs = nothing
	set conn = nothing
%>
  </Table>
 </Worksheet>


</Workbook>
