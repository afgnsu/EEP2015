<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���T�e�W�����ѥ��������q</title>
</head>
<script language="JavaScript" fptype="dynamicanimation">
<!--
function dynAnimation() {}
function clickSwapImg() {}
//-->
</script>
<script language="JavaScript1.2" fptype="dynamicanimation" src="animate.js">
</script>

<script language=vbscript>
  sub newurl(num)
    select case num
      case 1
        prog="/webap/rtap/Base/RTInvoice/RTInvImportXls.asp"
      case 2
        prog="/webap/rtap/Base/RTInvoice/RTInvoiceK.asp"
      case 3
        prog="/rtap/Base/RTInvoice/RTInvReportDialog1.asp"
      case 4
        prog="/webap/rtap/Base/RTInvoice/RTInvMonthK.asp"
      case 5
        prog="/rtap/Base/RTInvoice/DIALOG1.asp"
      case 6
        prog="/rtap/Base/RTInvoice/DIALOG2.asp"
      case else
    end select
    xx=(window.screen.width -7)
    yy=(window.screen.height -74)
    features="top=0,left=0,status=yes,location=no,menubar=no,scrollbars=yes" & ",height=" & yy & ",width=" & xx
    result=window.open(prog,"ppAP",features)
    'window.event.returnValue=False
  end sub
</script>
<body bgcolor="#c3c9d2">
<table border="0" width="100%">
  <tr>
    <td width="20%"></td>
    <td width="60%" align="middle"><font color="#0000ff">���T�e�W�����ѥ��������q</font></td>
    <td width="20%"><font color="#0000ff">����G<%=DATEVALUE(NOW)%></font></td>
  </tr>
  <tr>
    <td width="20%">�@</td>
    <td width="60%" align="middle"><font color="#0000ff">�o���@�~</font></td>
    <td width="20%"><font color="#0000ff">�ɶ��G<%=timeVALUE(TIME)%></font></td>
  </tr>

</table>
<HR>
<CENTER>
<TABLE style="WIDTH: 300px; HEIGHT: 75px" cellSpacing=0 cellPadding=0 bgColor=antiquewhite border=1>
  
  <TR>
    <TD style="WIDTH: 25%"  bgColor=#3e7373>
      <P style="COLOR: yellow;font-size:12pt"" align=center>�o���@�~���@</P></TD></TR>
  <TR>
    <TD onclick="newurl(1)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�פJExcel��" ID="B1" NAME="B1">
        </FONT></TD></TR>
  <TR>
    <TD onclick="newurl(2)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�o���D�ɺ��@" ID="B2" NAME="B2">
        </FONT></TD></TR>
  <TR>
    <TD onclick="newurl(3)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�C �L �o ��" NAME="B3">
        </FONT></TD></TR>
  <TR>
    <TD onclick="newurl(4)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�o���r�y���@" NAME="B4">
        </FONT></TD></TR>
  <TR>
    <TD onclick="newurl(5)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�o�����Ӫ�C�L" NAME="B5">
        </FONT></TD></TR>
  <TR>
    <TD onclick="newurl(6)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�o���@����" NAME="B6">
        </FONT></TD></TR>
</TABLE>
  <p></p>


</CENTER>
</body></HTML>
