<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�g�P��
    S11=""
    rs.Open "SELECT  a.CONSIGNEE,  CASE WHEN a.CONSIGNEE = '' THEN '���P' ELSE RTObj.SHORTNC  END as shortnc FROM  RTlessorCmtyline a LEFT OUTER JOIN RTObj ON a.CONSIGNEE = RTObj.CUSID GROUP BY  a.CONSIGNEE,  CASE WHEN a.CONSIGNEE = '' THEN '���P' ELSE RTObj.SHORTNC  END ",CONN
    s11="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s11=s11 &"<option value=""" &rs("CONSIGNEE") & ";" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'    
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
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
     t=t &" (c.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (c.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�u�˾��a�}
  S2=document.all("search2").value  
  If Len(s2)=0 Or s2="" Then
  Else
     s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
     t=t &" AND ((g.CUTNC + a.TOWNSHIP + CASE WHEN a.VILLAGE " _
         &"<> '' THEN a.VILLAGE + a.COD1 ELSE '' END + " _
         &"CASE WHEN a.NEIGHBOR <> '' THEN a.NEIGHBOR " _
         &"+ a.COD2 ELSE '' END + CASE WHEN a.STREET " _
         &"<> '' THEN a.STREET + a.COD3 ELSE '' END + CASE " _
         &"WHEN a.SEC <> '' THEN a.SEC + a.COD4 " _
         &"ELSE '' END + CASE WHEN a.LANE <> '' THEN a.LANE " _
         &"+ a.COD5 ELSE '' END + CASE WHEN a.TOWN " _
         &"<> '' THEN a.TOWN + a.COD6 ELSE '' END + CASE " _
         &"WHEN a.ALLEYWAY <> '' THEN a.ALLEYWAY + " _
         &"a.COD7 ELSE '' END + CASE WHEN a.NUM <> '' " _
         &"THEN a.NUM + a.COD8 ELSE '' END + CASE WHEN " _
         &"a.FLOOR <> '' THEN a.FLOOR + a.COD9 " _
         &"ELSE '' END + CASE WHEN a.ROOM <> '' THEN a.ROOM " _
         &"+ a.COD10 ELSE '' END ) LIKE '%" &S2 &"%') " 
  End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND (a.LINEIP LIKE '%" & S3 & "%') "
  END IF
  '----PPPoE�����b��
  s4=document.all("search4").value
  If Len(trim(s4)) > 0 Then
     s=s &"  PPPoE�����b��:�]�t('" &s4 & "'�r��) "
     t=t &" AND (a.PPPoEAccount LIKE '%" & S4 & "%') "
  end if
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q��:�]�t('" &s5 & "'�r��) "
     t=t &" AND (a.LINETEL LIKE '%" & S5 & "%') "
  end if
  '----���ָ��X
  s6=document.all("search6").value
  If Len(trim(s6)) > 0 Then
     s=s &"  ���ָ��X:�]�t('" &s6 & "'�r��) "
     t=t &" AND (a.FIBERID LIKE '%" & S6 & "%') "
  end if
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")  
  If Len(trim(s7ary(0)))=0 Or s7ary(0)="" Then
  Elseif s7ary(0)="0" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (a.INSPECTDAT is NOT null AND a.AGREE='Y' and a.HARDWAREDAT is null AND a.adslapplydat is null) "
  Elseif s7ary(0)="1" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (a.INSPECTDAT is NOT null AND a.AGREE='Y' and a.HARDWAREDAT is not null and a.HINETNOTIFYDAT is null AND a.adslapplydat is null) "
  elseif s7ary(0)="2" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (a.INSPECTDAT is NOT null AND a.AGREE='Y' and a.HARDWAREDAT is not null and a.HINETNOTIFYDAT is not null AND a.adslapplydat is null) "
  elseif s7ary(0)="3" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (a.adslapplydat  is not null ) and a.dropdat is null " 
  End If        
  '----�O�_�i�ظm
  s8ary=split(document.all("search8").value,";")  
  If Len(trim(s8ary(0)))=0 Or s8ary(0)="" Then
  Elseif s8ary(0)="Y" then
     s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (a.agree='Y') "
  elseif s8ary(0)="N" then
     s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (a.agree='N') " 
  elseif s8ary(0)="B" then
      s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (a.agree='') "  
  End If      
  '----���ϧǸ�
  s9=document.all("search9").value
  If Len(trim(s9)) > 0 Then
     s=s &"  ���ϧǸ�:'" &s9 & "') "
     t=t &" AND (a.COMQ1=" & S9 & ") "
  End If   
  '----�D�u�Ǹ�
  s10=document.all("search10").value
  If Len(trim(s10)) > 0 Then
     s=s &"  �D�u�Ǹ�:'" &s10 & "') "
     t=t &" AND (a.LINEQ1=" & S10 & ") "
  End If          
  '----�g�P��
  s11=document.all("search11").value
  S11ARY=SPLIT(S11,";")
  If s11ARY(0) <> "*" Then
     s=s &"  �g�P��:" &s11ARY(1) & " "
     t=t &" AND (a.CONSIGNEE='" & S11ARY(0) & "') "
  End If            
  '----�L�ĥD�u
  s12=document.all("search12").value
  S12ARY=SPLIT(S12,";")
  If s12ARY(0) <> "" Then
     s=s &"  �L�ĥD�u:" &s12ARY(1) & " "
     IF S12ARY(0)="1" THEN
        t=t &" AND (a.CANCELDAT IS NOT NULL ) "
     ELSEIF S12ARY(0)="2" THEN
        t=t &" AND (a.DROPDAT IS NOT NULL ) "
     END IF
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
  <tr class=dataListTitle align=center>ET-CITY�D�u��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">����/�D�u�Ǹ�</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="5" name="search9" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search10" class=dataListEntry ID="Text6"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�D�u�˾���}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search2" class=dataListEntry> 
    </td></tr> 
<tr><td class=dataListHead width="40%">�D�uIP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�D�u�����q��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
    </td></tr>
<tr><td class=dataListHead width="40%">���ָ��X</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="15" name="search6" class=dataListEntry ID="Text6"> 
    </td></tr>
<tr><td class=dataListHead width="40%">PPPoE�����b��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="12" name="search4" class=dataListEntry ID="Text2"> 
    </td></tr>
<tr><td class=dataListHead width="40%">�D�u�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="0;�w�ɬd���i�ظm">�w�ɬd���i�ظm</option>
        <option value="1;�D�u�]�Ƥw�w�ˡA���ݳq�����q">�D�u�]�Ƥw�w�ˡA���ݳq�����q</option>        
        <option value="2;HINET�w�q�����q">HINET�w�q�����q</option>
        <option value="3;�D�u�w���q">�D�u�w���q</option>        
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�O�_�i�ظm</td>
    <td width="60%"  bgcolor="silver">
      <select name="search8" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="Y;�i�ظm">�i�ظm</option>
        <option value="N;���i�ظm">���i�ظm</option>
        <option value="B;�|���ɹ�">�|���ɹ�</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�L�ĥD�u</td>
    <td width="60%"  bgcolor="silver">
      <select name="search12" size="1" class=dataListEntry ID="Select2">
        <option value=";�L" selected>�L</option>
        <option value="1;�w�@�o">�w�@�o</option>
        <option value="2;�w�M�P(����)">�w�M�P(����)</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�g�P��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search11" size="1" class=dataListEntry ID="Select1">
        <%=S11%>
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