<%
if Request.ServerVariables("LOGON_USER") = "CBBN\ytshih" then
	testBtn = " "
else
	testBtn = " disabled "
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
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
        prog="\WEBAP\RTAP\BASE\HBservice\RTFaqK.asp"
      case 2
        prog="\WEBAP\RTAP\BASE\HBservice\RTFaqCustK.asp"
      case 3
        prog="\WEBAP\RTAP\BASE\HBservice\RTFaqCmtyK.asp"
      case 4
        prog="\WEBAP\RTAP\BASE\RTHBADSLCMTY\RTResetK.asp"
      case 5
        prog="\WEBAP\RTAP\BASE\HBservice\RTFaqCmtySndWrkK.asp"
      case 6
        prog="\WEBAP\RTAP\BASE\RTHBADSLCMTY\RTResetDslamK.asp"

      case else
    end select
    xx=(window.screen.width -7)
    yy=(window.screen.height -74)
    features="top=0,left=0,status=yes,location=no,menubar=no,scrollbars=yes" & ",height=" & yy & ",width=" & xx
    result=window.open(prog,"ppAP",features)
    window.event.returnValue=False
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
    <td width="60%" align="middle"><font color="#0000ff">�ȶD��ƺ��@</font></td>
    <td width="20%"><font color="#0000ff">�ɶ��G<%=timeVALUE(TIME)%></font></td>
  </tr>

</table>
<HR>
<CENTER>
<TABLE style="WIDTH: 300px; HEIGHT: 75px" cellSpacing=0 cellPadding=0 bgColor=antiquewhite border=1>
  
  <TR>
    <TD style="WIDTH: 25%"  bgColor=#3e7373>
      <P style="COLOR: yellow;font-size:16pt" align=center><FONT size=3>�ȶD��ƺ��@</FONT></P></TD></TR>
  <TR>
    <TD onclick="newurl(1)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�U��׫ȶD���@" ID="B1" NAME="B1">
        </FONT></TD>
  </TR>
  <tr><td> &nbsp; </td></tr>  
  <TR>
    <TD onclick="newurl(2)">
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�Ȥ��Ƭd��" ID="B2" NAME="B2">
        </FONT></TD>
  </TR>

  <TR>
    <TD onclick="newurl(3)">
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="���ϸ�Ƭd��" ID="B3" NAME="B2">
        </FONT></TD>
  </TR>
  <tr><td> &nbsp; </td></tr>
  <TR>
    <TD onclick="newurl(5)">
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="���ϥD�����׬d��" ID="B5" NAME="B5">
        </FONT></TD>
  </TR>
  <tr><td> &nbsp; </td></tr>
  <TR>
    <TD onclick="newurl(4)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="����Reset�@�~" ID="B4" NAME="B4">
        </FONT></TD>
  </TR>
  <TR>
    <TD onclick="newurl(6)" >
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="iDslam�۰�Restart��ƺ��@" ID="B6" NAME="B6">
        </FONT></TD>
  </TR>

</TABLE>


<p>
<TABLE style="WIDTH: 300px; HEIGHT: 75px" cellSpacing=0 cellPadding=0 bgColor=antiquewhite border=1 ID="Table1">
<!--
  <TR>
    <TD style="WIDTH: 25%"  bgColor=#3e7373>
      <P style="COLOR: yellow;font-size:16pt" align=center><FONT size=3>��h�_�@�~</FONT></P></TD></TR>
  <TR>
    <TD onclick="newurl(5)" disabled>
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" disabled style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�Ȥ�h�����_���^���@�~" ID="Button3" NAME="B1">
        </FONT></TD>
  </TR>
  <TR>
    <TD onclick="newurl(6)" disabled>
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" disabled style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�Ȥ�h�����_���d��" ID="Button3" NAME="B1">
        </FONT></TD>
  </TR>
  <TR>
    <TD onclick="newurl(7)" disabled>
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON" disabled style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�Ȥ�h������ک������v���R" ID="Button3" NAME="B1">
        </FONT></TD>
  </TR>
-->
</TABLE>
</CENTER>
</body></HTML>
