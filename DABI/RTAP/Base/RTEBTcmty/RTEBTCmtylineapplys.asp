
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r,t2
  '----���ϦW��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (RTEBTCmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (RTEBTCmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----���ϧǸ�
  s2=document.all("search2").value
  If Len(trim(s2)) > 0 Then
     s=s &"  ���ϧǸ�:'" &s2 & "') "
     t=t &" AND (RTEBTCMTYLINE.COMQ1=" & S2 & ") "
  End If   
  '----�D�u�Ǹ�
  s3=document.all("search3").value
  If Len(trim(s10)) > 0 Then
     s=s &"  �D�u�Ǹ�:'" &s3 & "') "
     t=t &" AND (RTEBTCMTYLINE.LINEQ1=" & S3 & ") "
  End If          
  s4ary=split(document.all("search4").value,";")
  s5=document.all("search5").value
  s6ary=split(document.all("search6").value,";")
  s7=document.all("search7").value
  s8ary=split(document.all("search8").value,";")
  s9=document.all("search9").value
  s10ary=split(document.all("search10").value,";")
  s11=document.all("search11").value
  '-----���u��������(�j��/�p��/����) ? ��
  if len(trim(s5)) > 0 then
     t2=t2 & " ( SUM(CASE WHEN RTEBTCUST.FINISHDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND " _
       &"RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) " _
       &"- SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL " _
       &"AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) " & s4ary(0) & "" & s5 & " ) "
     s=s & "  ���u��������J" & s4ary(1) & " " & s5 & " ��   "
  end if
  '------�I�u�����(�j��/�p��/����) ? ��
  if len(trim(s7)) > 0 then
     if len(trim(t2)) > 0 then
        t2=t2 & " or "
     end if
     t2=t2 & " ( SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO <> '' AND " _
       &"RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL " _
       &"THEN 1 ELSE 0 END)  " & s6ary(0) & "" & s7 & " ) "
     s=s & " �I�u����ơJ" &  s6ary(1) & " " &  s7 & " ��   "
  end if
  '------�ӽФ����(�j��/�p��/����) ? ��
  if len(trim(s9)) > 0 then
     if len(trim(t2)) > 0 then
        t2=t2 & " or "
     end if
     t2=t2 & " ( SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND " _
       &"RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND " _
       &"RTEBTCUST.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END) " & s8ary(0) & "" & s9 & " ) "
     s=s & " �ӽФ���ơJ" &  s8ary(1) & " " &  s9 & " ��   "
  end if
  '------�ݥӽФ��(�j��/�p��/����) ? ��
  if len(trim(s11)) > 0 then
     if len(trim(t2)) > 0 then
        t2=t2 & " or "
     end if
     t2=t2 & " ( SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND " _
       &"RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND " _
       &"RTEBTCUST.APPLYDAT IS NULL THEN 1 ELSE 0 END)  " & s10ary(0) & "" & s11 & " ) "
     s=s & " �ݥӽФ�ơJ" &  s10ary(1) & " " &  s11 & " ��   "
  end if
  if len(trim(t2)) > 0 then
     t2=" having " & t2
  end if
  
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=t2
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
<center>
<table width="80%" >
  <tr class=dataListTitle align=center>AVS�D�u��Ʒj�M����</td><tr>
</table>
<table width="80%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="20%">����/�D�u�Ǹ�</td>
    <td width="80%" bgcolor="silver">
      <input type="text" size="5" name="search2" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search3" class=dataListEntry ID="Text6"> 
    </td></tr>        
<tr><td class=dataListHead >���ϦW��</td>
    <td  bgcolor="silver">
      <input type="text" size="30" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead >�Τ����(�p��)</td>
    <td  bgcolor="silver">
    <font size=2>���u������</font>
    <select name="search4" size="1" class=dataListEntry ID="Select1">
        <option value=">;�j��">�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
    </select>
    <input type="text" size="5" name="search5" class=dataListEntry ID="Text1"><font size=2>��</font>
    <br><font size=2>�I�u�����</font>
     <select name="search6" size="1" class=dataListEntry ID="Select2">
        <option value=">;�j��" selected>�j��</option>
        <option value="<;�p��" >�p��</option>
        <option value="=;����" >����</option>
    </select>
    <input type="text" size="5" name="search7" class=dataListEntry ID="Text2"><font size=2>��</font>
    <br><font size=2>�ӽФ����</font>
     <select name="search8" size="1" class=dataListEntry ID="Select3">
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��" >�p��</option>
        <option value="=;����" >����</option>
    </select>
    <input type="text" size="5" name="search9" class=dataListEntry ID="Text3"><font size=2>��</font>
    <br><font size=2>�ݥӽФ��</font>
     <select name="search10" size="1" class=dataListEntry ID="Select4">
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��" >�p��</option>
        <option value="=;����">����</option>
    </select>
    <input type="text" size="5" name="search11" class=dataListEntry ID="Text4"><font size=2>��</font>
     </td>
</tr>
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</center>
</body>
</html>