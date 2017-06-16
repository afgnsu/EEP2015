<%
    parm=request("parm")
    v=split(parm,";")

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=��Ʋ��ʲέp��.xls"

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

  <Style ss:ID="SubTitle">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   		<Borders>
    		<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
    		<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1" ss:Color="#000000"/>
   		</Borders>
   <Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Size="10"/>
   <Interior ss:Color="#FFFF99" ss:Pattern="Solid"/>
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
		<NumberFormat ss:Format="#,##0_ ;[Red]\-#,##0\ "/>
  	</Style>

	<Style ss:ID="toSum">
   		<Font ss:FontName="�s�ө���" x:CharSet="136" x:Family="Roman" ss:Color="Blue" ss:Bold="1"/>
   		<NumberFormat ss:Format="#,##0_ ;[Red]\-#,##0\ "/>
  	</Style>
 </Styles>


 <Worksheet ss:Name="AVS+ET">
  <Table>
<!--
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���T�e�W�����ѥ��������q</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">�t�չs�Τ�@����</Data></Cell>
   </Row>
-->
   <Row>
    <Cell ss:MergeAcross="7" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�����G<%=v(0)%>��<%=v(1)%> </Data></Cell>
   </Row>

   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��/�g�P</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұϩ���</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�w���u��������</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">�w���u�������W�L14��</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">������</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">����ӽФ�</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�h����</Data></Cell>
   </Row>
<%
    sql="usp_RTCustCountChange '"&v(0)&"', '"&v(1)&"', 'A' "
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("belongnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("salesnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish14") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("docket") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("newbilling") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("droped") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


 <Worksheet ss:Name="�t��">
  <Table>

   <Row>
    <Cell ss:MergeAcross="6" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�����G<%=v(0)%>��<%=v(1)%> </Data></Cell>
   </Row>

   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��/�g�P</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұϩ���</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">�w���u��������</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">�w���u�������W�L14��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">������</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�h����</Data></Cell>
   </Row>
<%
    sql="usp_RTCustCountChange '"&v(0)&"', '"&v(1)&"', 'B' "
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("belongnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("salesnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish14") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("docket") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("droped") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


<Worksheet ss:Name="So-net">
  <Table>

   <Row>
    <Cell ss:MergeAcross="6" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�����G<%=v(0)%>��<%=v(1)%> </Data></Cell>
   </Row>

   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��/�g�P</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұϩ���</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">�w���u��������</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">�w���u�������W�L14��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">������</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�h����</Data></Cell>
   </Row>
<%
    sql="usp_RTCustCountChange '"&v(0)&"', '"&v(1)&"', 'C' "
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("belongnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("salesnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("finish14") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("docket") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("droped") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>



<%
	conn.Close
	set rs = nothing
	set conn = nothing
%>
</Workbook>
