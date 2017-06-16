<%
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","filename=���T�q�l��-" & cstr(datepart("yyyy",now())) & "-" & cstr(datepart("m",now())) & "-" & cstr(datepart("d",now())) & ".xls"

    parm=request("parm")
    xparm=split(parm,";")
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
   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>
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


 <Worksheet ss:Name="���T�}�q�ɤJ">
  <Table>
   <Row ss:AutoFitHeight="0">
    <Cell ss:MergeAcross="48" ss:StyleID="Title"><Data ss:Type="String">���T�q�l���ɳ����β���</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="48" ss:StyleID="TitleDate"><Data ss:Type="String">���ɤ���G<%=now()%> </Data></Cell>
   </Row>
   <Row>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�y����</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�ӽФ��</Data></Cell>
	<Cell ss:StyleID="Header"><Data ss:Type="String">���u���</Data></Cell>	
    <Cell ss:StyleID="Header"><Data ss:Type="String">�ӽк���</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���ʥN�X</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�q�ܸ��X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">��b���X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">��O�ӥN�X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�~�ȭ��N�X</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�Ȥ����O</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���q�W��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���q�t�d�H</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">�t�d�H�����Ҧr��</Data></Cell>
    <Cell ss:StyleID="HeaderS"><Data ss:Type="String">���q�νs</Data></Cell>
    <Cell ss:StyleID="Header"><Data ss:Type="String">�A�Ȥ��</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�u�f�N�X</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�Τ�W��</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�p���H�ҷ����O</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�p���H�ҷӸ��X</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�p���H�ٿ�</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�p���H�W��</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�p���H�p���q��</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�p���H�X�ͤ��</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�p���H��ʹq��</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�ҷ����O</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�ҷӸ��X</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�ٿ�</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�W��</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�p���q��</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�N�z�H�X�ͤ��</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�b�H�l���ϸ�</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�b�H����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�b�H�m����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�b�H�a�}</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">���y�l���ϸ�</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">���y����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">���y�m����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">���y�a�}</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�˾��l���ϸ�</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�˾�����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�˾��m����</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�˾��a�}</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">���ϦW��</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">IP ADDRESS FROM</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">IP ADDRESS END</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">NCIC�w�B�z���</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�ĤG�ҷ����O</Data></Cell>
<Cell ss:StyleID="Header"><Data ss:Type="String">�ĤG�ҷӸ��X</Data></Cell>
<Cell ss:StyleID="HeaderS"><Data ss:Type="String">�ӽЮѽs��</Data></Cell>
   </Row>
<%      rs.Open "usp_RTFarEastapplylist '" & xparm(0) & "','" & xparm(1) & "'", CONN
	serno=0				   
	Do While Not rs.Eof
	    serno = serno+1
            xserno=right("0000" & cstr(serno),4)
            yserno=rs("seq") & xserno
            '�u�f�N�X
             if rs("paycycle")="06" then
                if rs("case_no")="1054" then
                   xxx="SBAA140603-007"
                elseif rs("case_no")="1053" then
                   xxx="SBAA140602-007"
                elseif rs("case_no")="1052" then
                   xxx="SBAA140601-007"
                else
                   xxx=""
               end if
             elseif rs("paycycle")="02" then
               if rs("case_no")="1054" then
                  xxx="SBAA140603-005"
               elseif rs("case_no")="1053" then
                  xxx="SBAA140602-005"
               elseif rs("case_no")="1052" then
                  xxx="SBAA140601-005"
               else
                 xxx=""
               end if
             elseif rs("paycycle")="03" then
               if rs("case_no")="1054" then
                  xxx="SBAA140603-006"
               elseif rs("case_no")="1053" then
                  xxx="SBAA140602-006"
               elseif rs("case_no")="1052" then
                  xxx="SBAA140601-006"
               else
                  xxx=""
               end if
             else
               xxx=""
             end if
	    response.Write "<Row>" &_
		"<Cell ss:StyleID=""toNum""><Data ss:Type=""String"">"& yserno &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("applydat") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("docketdat") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("applykind") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("updcode") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("updtel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("memberid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("mak_id") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("sale_id") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cust_kind") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("company_name") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("coboss") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cobossid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("company_id") &"</Data></Cell>" &_
                "<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("case_no") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& xxx &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cusnc") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("codenc") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("socialid") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("sex_kind") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("contact_name") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("contact_tel") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("contact_birth") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("contact_mobile") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_cardtype") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_idno") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_callname") &"</Data></Cell>" &_
                "<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_name") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_tel") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("agent_birth") &"</Data></Cell>" &_
		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("zip3") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc3") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township3") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("raddr3") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("zip2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("raddr2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("zip1") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("cutnc1") &"</Data></Cell>" &_
                "<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("township1") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("raddr1") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("comn") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ip11s") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ip11e") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("ncicdate") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("codenc2") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("secondno") &"</Data></Cell>" &_
    		"<Cell ss:StyleID=""toChar""><Data ss:Type=""String"">"& rs("apply_no") &"</Data></Cell>" &_
			"</Row>"
      rs.MoveNext
    Loop
    rs.Close
%>
  </Table>
 </Worksheet>


</Workbook>
