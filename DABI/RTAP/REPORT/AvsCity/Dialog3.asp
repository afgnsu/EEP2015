<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>���ک��Ӫ�(AVS+ET)</TITLE>
<SCRIPT language=VBScript>
Sub cmdSure_onClick
  PGM="/report/AvsCity/Report3.asp?parm=" 
  symd=document.all("search1").value
  eymd=document.all("search2").value
  'IF LEN(TRIM(SYMD))=0 THEN SYMD=datevalue(now())
  'IF LEN(TRIM(EYMD))=0 THEN SYMD=datevalue(now())
  window.open pgm & symd &";"& eymd &";"
   window.close
End Sub
Sub cmdcancel_onClick
  window.close
End Sub

sub b1_onclick()
	if isdate(document.all("search1").value) then
		objEF2KDT.varDefaultDateTime=document.all("search1").value
	end if
	call objEF2KDT.show(1)
	if objEF2KDT.strDateTime <> "" then
	    document.all("search1").value = objEF2KDT.strDateTime
	end if
end sub
sub b2_onclick()
	if isdate(document.all("search2").value) then
		objEF2KDT.varDefaultDateTime=document.all("search2").value
	end if
	call objEF2KDT.show(1)
	if objEF2KDT.strDateTime <> "" then
	    document.all("search2").value = objEF2KDT.strDateTime
	end if
end sub

</SCRIPT>
</HEAD>
<OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E" codeBase=http://www.cbbn.com.tw/stock/EF2KDT.CAB#version=9,0,0,3 
	height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	width=60 >
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270"></OBJECT>

<BODY style="background:lightblue">
<DIV align=Center><i><font face="�з���" size="5" color="#FF00FF">AVS City -- ����C�L(Excel)</font></i> </DIV>
<DIV align=Center><i><font face="�з���" size="3" color="#FF00FF">���ک��Ӫ�(AVS+ET)(2007/7/17 Updated) </font></i> </DIV>

<P></P>

<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>
  <tr><td ALIGN="RIGHT"><font face="�з���">�п�J���ڤ�_���G</font></td>
	<td><input type="text" size="10" maxlength="10" name="search1" align=right class=dataListEntry value="<%=datevalue(now())%>" readonly ID="Text1">
		<input type="button" id="B1" name="B1" height=100% width=100% style="Z-INDEX: 1" value="...."></td></tr>

  <tr><td>&nbsp;</td>
	<td><input type="text" size="10" maxlength="10" name="search2" align=right class=dataListEntry value="<%=datevalue(now())%>" readonly ID="Text2">
		<input type="button" id="B2" name="B2" height=100% width=100% style="Z-INDEX: 1" value="...."></td></tr>
		
</table> 

<p><center>
 <INPUT TYPE="button" VALUE="�e�X" ID="cmdSure" style="font-family: �з���; color: #FF0000;cursor:hand"> 
  <INPUT TYPE="button" VALUE="����" ID="cmdcancel" style="font-family: �з���; color: #FF0000;cursor:hand">
 </center>
  <HR>
</P>
</BODY> 
</HTML>
