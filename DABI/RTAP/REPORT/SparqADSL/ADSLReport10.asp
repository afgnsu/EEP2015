<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=�t�դΦ����קC�Τ����.xls"

    'parm=request("parm")
    'v=split(parm,";")

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


 <Worksheet ss:Name="�s��">
  <Table>
<!--
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">���T�e�W�����ѥ��������q</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="4" ss:StyleID="Title"><Data ss:Type="String">�t�հh����@����</Data></Cell>
   </Row>
-->
   <Row>
    <Cell ss:MergeAcross="13" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>

   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 0"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


 <Worksheet ss:Name="�@��">
  <Table>
   <Row>
    <Cell ss:MergeAcross="14" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>

   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�Ȥ�W��</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 1"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusnc") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


 <Worksheet ss:Name="�G��">
  <Table ID="Table2">
   <Row>
    <Cell ss:MergeAcross="13" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 2"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


<Worksheet ss:Name="�T��">
  <Table ID="Table3">
   <Row>
    <Cell ss:MergeAcross="13" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 3"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


<Worksheet ss:Name="�|��">
  <Table ID="Table4">
   <Row>
    <Cell ss:MergeAcross="13" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 4"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


<Worksheet ss:Name="����">
  <Table ID="Table5">
   <Row>
    <Cell ss:MergeAcross="13" ss:StyleID="TitleDate"><Data ss:Type="String">�έp�I�����G<%=datevalue(now())%> </Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">��קO</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�s���覡</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ұ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�Ǹ�</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ϦW��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�W�Ҥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�D�u�t�v</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�����q��</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�D�u����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ȥ��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">����</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�m��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�a�}</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�Ƶ�</Data></Cell>
   </Row>
<%
	sql="usp_RTCmtyLowCust 5"
	rs.Open sql, CONN
	Do While Not rs.Eof
	    response.Write "<Row>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("casetype") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("connectnc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("areanc") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comq") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("comcnt") &"</Data></Cell>" &_
			"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linespeed") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("linetel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toDate""><Data ss:Type=""String"">"& rs("linearrivedat") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toNum""><Data ss:Type=""Number"">"& rs("custnum") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("addr") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("remark") &"</Data></Cell>" &_
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
