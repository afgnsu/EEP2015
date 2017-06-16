<%
    parm=request("parm")
    v=split(parm,";")

	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�M�ת��ϥΤ�C��.xls"

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


 <Worksheet ss:Name="�M�ת��ϥΤ�">
  <Table>
<!--
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���T�e�W�����ѥ��������q</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">�t�հh����@����</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="8" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>
-->   
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ�N�X</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ�W</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Τ�IP</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">������</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">���u��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">������</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�}�l�p�O��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�����</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�����</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�h����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�p���q��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
   </Row>
<%
	sql="select	 convert(varchar(5), a.comq1)+'-'+convert(varchar(5), a.lineq1) as comq, " &_
		"c.comn, a.cusid, a.cusnc, IP11, a.freecode, a.finishdat, a.docketdat, a.strbillingdat, a.newbillingdat, " &_
		"a.duedat, a.dropdat, a.contacttel, d.cutnc+a.township2+a.raddr2 as addr " &_
		"from	RTPrjCust a " &_
		"inner join RTPrjCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
		"inner join RTPrjCmtyH c on c.comq1 = b.comq1 " &_
		"left outer join RTcounty d on d.cutid = a.cutid2 " &_
		"where a.canceldat is null and b.canceldat is null "

	if v(0) ="" and v(1)="" then
	else
		sql = sql & " and a.duedat between '" &v(0)& "' and '" &v(1)& "' order by a.duedat, a.comn, a.cusnc "
	end if
		

	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("IP11") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("freecode") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("finishdat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("docketdat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("strbillingdat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("newbillingdat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("duedat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("dropdat") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("contacttel") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
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
