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
      case 11
        prog="RTSparqCustARK1.asp"                 
      case 12
        prog="RTSparqCustARK3.asp"                      
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
    <td width="60%" align="middle"><font color="#0000ff">�t�ձb�ȧ@�~</font></td>
    <td width="20%"><font color="#0000ff">�ɶ��G<%=timeVALUE(TIME)%></font></td>
  </tr>

</table>
<HR>
<CENTER>
<TABLE style="WIDTH: 300px; HEIGHT: 30px" cellSpacing=0 cellPadding=0 bgColor=antiquewhite border=1 ID="Table1">
  
  <TR>
    <TD style="WIDTH: 25%"  bgColor=#3e7373 >
      <P style="COLOR: yellow;font-size:12pt"" align=center>�b�Ƚ]��</P></TD></TR>
  <TR>
     <TD onclick="newurl(11)"  style="WIDTH: 70%">
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON"  style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�������I�b�ڨR�P�@�~" ID="Button2" NAME="B3">
        </FONT>
  </TR>
  <TR>
     <TD onclick="newurl(12)"  style="WIDTH: 70%">
        <FONT style="COLOR: darkorchid;font-size:12pt">
        <INPUT type="BUTTON"  style="WIDTH: 100%;height:30;font-size:12pt"  VALUE="�C���������I�b�ڬd��" ID="Button2" NAME="B3">
        </FONT>
  </TR>  
  </table>

</CENTER>
</body>
</HTML>