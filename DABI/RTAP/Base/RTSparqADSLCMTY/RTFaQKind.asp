<% KEY=REQUEST("KEY") %>
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>�ȶD�]�ƺ������</TITLE>
<SCRIPT language=VBScript>
Sub cmdSure_onClick
  s1ary=document.all("search1").value
  s1=split(s1ary,";")
  key=document.all("keyfield").value
  Scrxx=window.screen.width
  Scryy=window.screen.height - 30
  StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
            &"location=no,menubar=no,width=" & scrxx & "px" _
            &",height=" & scryy & "px"
  prog="RTFaqD.asp?V=" & Rnd() &"&accessMode='A'"  &"&key=" &key & "&opt=" & s1(0)
  msgbox prog
  Set diagWindow=Window.Open(prog,"diag2",strFeature)
 ' window.close
End Sub

</SCRIPT>
</HEAD>

<BODY style="background:lightblue">
<DIV align=Center><i><font face="�з���" size="5" color="#FF00FF">HI-Building �ȶD�]�ƺ������</font></i> </DIV>
<INPUT type="hidden" name="Keyfield" value="<%=key%>">
<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>
  <tr><td><font face="�з���">�п�ܫȶD�]�ƺ��� :</font></td>
<td><font face="�з���">
    <SELECT size="1" name="search1" style="width:200;">
        <option value="1;�F�T�]��" selected>�F�T�]��</option>
        <option value="2;�X�Գ]��">�X�Գ]��</option>
        <option value="3;ADSL�]��">ADSL�]��</option>
    </SELECT>  
 </font></td><tr>
</table> 
<p><font face="�з���">�� <INPUT TYPE="button" VALUE="�d��" ID="cmdSure"
 style="font-family: �з���; color: #FF0000;cursor:hand">  
 �t�αN�̱z������ȶD�����A�e�{�M�ݤ����D�ѱz��ܡC</font></p> 
</BODY> 
</HTML>