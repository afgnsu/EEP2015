<%
 '   Dim rs,i,conn
 '   Dim search1Opt,search2Opt,search6Opt, search12pt
 '   Set conn=Server.CreateObject("ADODB.Connection")
 '   conn.open "DSN=RTLib"
    
'    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�D���ظm�覡
'    S9=""
'    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='G4'",CONN
'    s9="<option value="";����"" selected>����</option>" &vbCrLf    
'    Do While Not rs.Eof
'       s9=s9 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
'       rs.MoveNext
'    Loop
'    rs.Close
'    
'    conn.Close
'    Set rs=Nothing
'    Set conn=Nothing
%>
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
     t=t &" (RTCmty.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (RTCmty.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�u�˾��a�}
 ' S2=document.all("search2").value  
 ' If Len(s2)=0 Or s2="" Then
 ' Else
 '    s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
 '    t=t &" AND (RTCounty.CUTNC+RTEBTCmtyLINE.Township+rtEBTcmtyLINE.Raddr LIKE '%" &S2 &"%')" 
 ' End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND (RTCMTY.NETIP LIKE '%" & S3 & "%') "
  END IF
  '----�D�u�p��s��
 ' s4=document.all("search4").value
 ' If Len(trim(s4)) > 0 Then
 '    s=s &"  �p��s��:�]�t('" &s4 & "'�r��) "
 '    t=t &" AND (RTEBTCMTYLINE.APPLYNO LIKE '%" & S4 & "%') "
 ' End If    
  '----�D�u�����q��
 ' s5=document.all("search5").value
 ' If Len(trim(s5)) > 0 Then
 '    s=s &"  �����q��:�]�t('" &s5 & "'�r��) "
 '    t=t &" AND (RTEBTCMTYLINE.LINETEL LIKE '%" & S5 & "%') "
 ' End If      
  '----�D�u�ӽЦC�L�渹
 ' s6=document.all("search6").value
 ' If Len(trim(s6)) > 0 Then
 '    s=s &"  �ӽЦC�L�渹:�]�t('" &s6 & "'�r��) "
 '    t=t &" AND (RTEBTCMTYLINE.APPLYPRTNO LIKE '%" & S6 & "%') "
 ' End If       
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")  
  If Len(trim(s7ary(0)))=0 Or s7ary(0)="" Then
  Elseif s7ary(0)="1" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND  (RTCMTY.NETIP <> '') AND (RTCMTY.T1APPLY IS NULL) AND (RTCMTY.RCOMDROP IS NULL)  "
  elseif s7ary(0)="2" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (T1apply is NOT null) " 
 End If  
 '���Ϧa�}      
  s11=document.all("search11").value
  If Len(s11)=0 Or s11="" Then
  Else
     s=s &"  ���Ϧa�}:�]�t('" &S11 & "'�r��)"
     t=t &" AND (RTCounty.CUTNC + RTCmty.TOWNSHIP + RTCmty.ADDR LIKE '%" &S11 &"%')" 
  End If
  '----���ϧǸ�
 ' s9=document.all("search9").value
 ' If Len(trim(s9)) > 0 Then
 '    s=s &"  ���ϧǸ�:'" &s9 & "') "
 '    t=t &" AND (RTEBTCMTYLINE.COMQ1=" & S9 & ") "
 ' End If   
  '----�D�u�Ǹ�
 ' s10=document.all("search10").value
 ' If Len(trim(s10)) > 0 Then
 '    s=s &"  �D�u�Ǹ�:'" &s10 & "') "
 '    t=t &" AND (RTEBTCMTYLINE.LINEQ1=" & S10 & ") "
 ' End If          
  
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
  <tr class=dataListTitle align=center>AVS�D�u��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<!--
<tr><td class=dataListHead width="40%">����/�D�u�Ǹ�</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="5" name="search9" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search10" class=dataListEntry ID="Text6"> 
    </td></tr>        
    -->
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">���Ϧa�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search11" class=dataListEntry ID="Text2"> 
    </td></tr>    
    <!--
<tr><td class=dataListHead width="40%">�D�u�˾���}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search2" class=dataListEntry> 
    </td></tr> -->
<tr><td class=dataListHead width="40%">�D�uIP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>    
<!--
<tr><td class=dataListHead width="40%">�D�u�p��s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="12" name="search4" class=dataListEntry ID="Text3"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�����q��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�ӽЦC�L�渹</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search6" class=dataListEntry ID="Text4"> 
    </td></tr>       
    -->
<tr><td class=dataListHead width="40%">�D�u�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;���oIP�A�D�u���}�q">�D�u���}�q</option>            
        <option value="2;�D�u�w�}�q">�D�u�w�}�q</option>        
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