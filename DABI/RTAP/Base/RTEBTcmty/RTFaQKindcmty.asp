<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>�ȶD�]�ƺ������</TITLE>
<SCRIPT language=VBScript>
Sub cmdSure_onClick
  If Category.value <> "" Then
     t=" �Ұ� " & Category.Value
  End If
  if Len(trim(search7.value)) = 0 then search7.value="2000/01/01"
  if Len(trim(search8.value)) = 0 then search7.value="9999/12/31"
  if IsDate(Search7.value) and Isdate(Search8.value) then
     t=t & " and  ���u��� >= '" & search7.value + " 00:00:00.000" & "' and ���u��� <= '" & search8.value + " 23:59:59.999" & "'"
  end if
  returnvalue=t
  window.close
End Sub

</SCRIPT>
</HEAD>

<BODY style="background:lightblue">
<DIV align=Center><i><font face="�з���" size="5" color="#FF00FF">HI-Building �ȶD�]�ƺ������</font></i> </DIV>
<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>
  <tr><td><font face="�з���">�п�ܫȶD�]�ƺ��� :</font></td>
<td><font face="�з���">
    <SELECT size="1" name="Category" style="width:200;">
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