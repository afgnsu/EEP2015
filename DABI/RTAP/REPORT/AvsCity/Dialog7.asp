<HTML>
<HEAD>
	<meta http-equiv=Content-Type content="text/html; charset=Big5">
	<TITLE>���禳��+���+�h���W��</TITLE>
</HEAD>

<BODY style="background:lightblue">

<DIV align=Center><i><font face="�з���" size="5" color="#FF00FF">������� -- ����C�L(Excel)</font></i> </DIV>
<DIV align=Center><i><font face="�з���" size="3" color="#FF00FF">���禳��+���+�h���W��(2010/06/02 Updated) </font></i> </DIV>

<P></P>


<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>

  <tr><td ALIGN="RIGHT"><font face="�з���">�п�J�I���G</font></td>
	<td><input type="text" size="10" maxlength="10" name="search1" align=right class=dataListEntry value="<%=Sdate%>" readonly ID="Text1">
		<input type="button" onmousedown="Cal('search1')" height=100% width=100% style="Z-INDEX: 1" value="....">(����п�ܤ멳)
	</td>
  </tr>
<!--
  <tr><td>&nbsp;</td>
	<td><input type="text" size="10" maxlength="10" name="search2" align=right class=dataListEntry value="<%=Edate%>" readonly ID="Text2">
		<input type="button" onmousedown="Cal('search2')" height=100% width=100% style="Z-INDEX: 1" value="....">
	</td>
  </tr>
-->
</table> 

<p><center>
 <INPUT TYPE="button" VALUE="�e�X" ID="cmdSure" style="font-family: �з���; color: #FF0000;cursor:hand"> 
  <INPUT TYPE="button" VALUE="����" ID="cmdcancel" style="font-family: �з���; color: #FF0000;cursor:hand">
 </center>
  <HR>
</P>

<Script Language=vbscript>
	Sub cmdSure_onClick
		PGM="/report/AvsCity/Report7.asp?parm=" 
		symd=document.all("search1").value
		'eymd=document.all("search2").value
		IF LEN(TRIM(SYMD))=0 THEN SYMD="1900/01/01"
		'IF LEN(TRIM(EYMD))=0 THEN SYMD="2070/12/31"
		window.open pgm & symd &";"'& eymd
		window.close
	End Sub

	Sub cmdcancel_onClick
		window.close
	End Sub
</Script>
<!-- #include virtual="/webap/include/Calendar.asp" -->

</BODY> 
</HTML>
