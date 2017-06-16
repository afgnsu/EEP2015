<%
    parm=request("key")
    v=split(parm,";")

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=���Ǥj�e�W�W�ӥ��R�b�C��.xls"

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

	<Style ss:ID="toDate">
   		<Borders>
		    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman"/>
		<NumberFormat ss:Format="Short Date"/>
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


 <Worksheet ss:Name="AVS">
  <Table>
<!--
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���T�e�W�����ѥ��������q</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���Ǥj�e�W�h����@����</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="4" ss:StyleID="TitleDate"><Data ss:Type="String">�s�����G<%=now()%> </Data></Cell>
   </Row>
-->
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�b�ڽs��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
	<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�������I</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">���R���B</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�w�R���B</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���R���B</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�R�b��</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�R�b��</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�R�߶��@</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�R�߶��G</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ͤ�</Data></Cell>    
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�h����</Data></Cell>    
    
   </Row>
<%
	sql="SELECT  c.BATCHNO, a.COMN,b.CUSNC, g.CODENC as ARAC, c.PERIOD, c.AMT, c.REALAMT, " &_
		"c.AMT - c.REALAMT AS DIFFAMT, c.MDAT, h.CUSNC AS MUSR, c.COD1, " &_
		"case when c.COD2 like '�W��%' then ''+c.COD2+'' " &_
		"when c.COD2 like '�h��%' then ''+c.COD2+'' " &_
		"when c.COD2 like '�H�Υd%' then ''+c.COD2+'' else c.COD2 end as COD2, " &_
		"c.CDAT, b.Dropdat " &_
		"FROM RTfareastCmtyH a " &_
		"INNER JOIN RTfareastCust b ON a.COMQ1 = b.COMQ1 " &_
		"RIGHT OUTER JOIN RTfareastCust AR c ON b.CUSID = c.CUSID " &_
		"LEFT OUTER JOIN RTEmployee f INNER JOIN RTObj h ON f.CUSID = h.CUSID ON c.MUSR = f.EMPLY " &_
		"LEFT OUTER JOIN RTCode g ON c.ARTYPE = g.CODE AND g.KIND = 'N2' " &_
		"WHERE (c.AMT <> c.REALAMT) and c.canceldat is null and cod2 like '%�W��%' " &_
		"ORDER BY c.CDAT desc "
	rs.Open sql, CONN
	serno=0				   
	Do While Not rs.Eof
	    serno = serno+1
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("BATCHNO") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("COMN") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("CUSNC") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ARAC") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("PERIOD") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("amt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("realamt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("DIFFAMT") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("MDAT") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("MUSR") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("COD1") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("COD2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("CDAT") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("Dropdat") &"</Data></Cell>" &_
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
