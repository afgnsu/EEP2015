
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '----���ϦW��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" AND (RTEBTCmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" AND (RTEBTCmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----���ϧǸ�
  s2=document.all("search2").value
  IF LEN(TRIM(S2)) > 0 THEN
     s=s &"  ���ϧǸ�:" &s2 & " "
     t=t &" AND (RTEBTFtpAvsparaRpl.COMQ1 =" & S2 & ") "
  END IF
 '----�D�u�Ǹ�  
  s3=document.all("search3").value  
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�u�Ǹ�:" &s3 & " "
     t=t &" AND (RTEBTFtpAvsparaRpl.LINEQ1 =" & S3 & ") "
  END IF  
  '----�������O
  s4ary=split(document.all("search4").value,";")  
  If Len(trim(s4ary(0)))=0 Or s4ary(0)="" Then
     s=s &"  �������O:����  "
  Elseif s4ary(0)="A" then
     s=s &"  �������O:" &s4ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.FLAG='" & S4ARY(0) & "') "
  Elseif s4ary(0)="F" then
     s=s &"  �������O:" &s4ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.FLAG='" & S4ARY(0) & "') "
  elseif s4ary(0)="C" then
     s=s &"  �������O:" &s4ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.FLAG='" & S4ARY(0) & "') "
  End If        
  '----�B�z���A
  s5ary=split(document.all("search5").value,";")  
  If Len(trim(s5ary(0)))=0 Or s5ary(0)="" Then
  Elseif s5ary(0)="1" then
     '������
     s=s &"  �B�z���A:" &s5ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.CLOSEDAT IS NULL AND RTEBTFtpAvsparaRpl.DROPDAT IS NULL ) "
  Elseif s5ary(0)="2" then
     '�w�@�o
     s=s &"  �B�z���A:" &s5ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.DROPDAT IS not NULL ) "
  elseif s5ary(0)="3" then
     '�w����
     s=s &"  �B�z���A:" &s5ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.CLOSEDAT IS NOT NULL ) "
  elseif s5ary(0)="4" then
     '�w�M�����ɰO�����|������
     s=s &"  �B�z���A:" &s5ary(1)
     t=t &" AND (RTEBTFtpAvsparaRpl.CLOSEDAT IS NULL AND RTEBTFtpAvsparaRpl.CLRFLAG IS not NULL ) "
  ELSE
      s=s &"  �B�z���A:����"     
  End If        
    
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub

Sub btn1_onClick()  
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub
-->
</script>
</head>
<body>
<table width="100%">
  <tr class=dataListTitle align=center>AVS�Τ��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry ID="Text1"> 
    </td></tr>
<tr><td class=dataListHead width="40%">����/�D�u�Ǹ�</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="5" name="search2" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search3" class=dataListEntry ID="Text6"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�������O</td>
    <td width="60%"  bgcolor="silver">
      <select name="search4" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="A;�ӽ�">�ӽ�</option>
        <option value="F;���q�^��">���q�^��</option>
        <option value="C;����">����</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�B�z���A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry>
        <option value="1;������" selected>������</option>
        <option value="2;�w�@�o">�w�@�o</option>
        <option value="3;�w����">�w����</option>
        <option value="4;�w�M�����ɰO�����|������">�w�M�����ɰO�����|������</option>
        <option value=";����">����</option>
      </select>
     </td>
</tr>
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>