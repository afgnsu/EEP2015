<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�g�P��
    S11=""
    rs.Open "SELECT  a.CONSIGNEE,  CASE WHEN a.CONSIGNEE = '' THEN '���P' ELSE RTObj.SHORTNC  END as shortnc FROM RTSonetCmtyH a LEFT OUTER JOIN RTObj ON a.CONSIGNEE = RTObj.CUSID GROUP BY  a.CONSIGNEE,  CASE WHEN a.CONSIGNEE = '' THEN '���P' ELSE RTObj.SHORTNC  END ",CONN
    s11="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s11=s11 &"<option value=""" &rs("CONSIGNEE") & ";" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------�~���Ұ�
    S14=""
	sqlstr="select  a.salesid, c.cusnc " &_
		   "from RTSonetCmtyH a " &_
		   "inner join RTEmployee b on a.salesid = b.emply " &_
		   "inner join RTObj c on c.CUSID = b.CUSID " &_
		   "group by a.salesid, c.cusnc " 
    rs.Open sqlstr,CONN
    S14="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       S14=S14 &"<option value=""" &rs("salesid") & ";" & rs("CUSNC") & """>" &rs("CUSNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5" />
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
     t=t &" c.ComN LIKE '%" &S1 &"%' " 
  End If
  '----�D�u�˾��a�}
  S2=document.all("search2").value  
  If Len(s2)=0 Or s2="" Then
  Else
     s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
     t=t &" AND g.CUTNC + a.TOWNSHIP + a.RADDR LIKE '%" &S2& "%' " 
  End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND a.LINEIP LIKE '%"& S3 &"%' "
  END IF
  '----PPPoE�����b��
  s4=document.all("search4").value
  If Len(trim(s4)) > 0 Then
     s=s &"  PPPoE�����b��:�]�t('" &s4 & "'�r��) "
     t=t &" AND a.PPPoEAccount LIKE '%"& S4 &"%' "
  end if
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �M�u�s��:�]�t('" &s5 & "'�r��) "
     t=t &" AND a.LINETEL LIKE '%" & S5 & "%' "
  end if
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")
  If Len(trim(s7ary(0))) >0 Then t=t &" AND a.dropdat is null AND a.canceldat is null "
  if s7ary(0)="0" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND a.INSPECTDAT is NOT null AND a.AGREE='Y' and a.HARDWAREDAT is null AND a.applydat is null "
  Elseif s7ary(0)="1" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND a.applydat is not null and a.HARDWAREDAT is null "
  elseif s7ary(0)="2" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND a.HARDWAREDAT is not null "
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
     t=t &" AND (c.CONSIGNEE='" & S11ARY(0) & "') "
  End If            
  '---- �~���Ұ�
  s14=document.all("search14").value
  S14ARY=SPLIT(S14,";")
  If s14ARY(0) <> "*" Then
     s=s &"  �~���Ұ�:" &s14ARY(1) & " "
     t=t &" AND (c.SALESID='" & S14ARY(0) & "') "
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
  <tr class=dataListTitle align=center>So-net�D�u��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">�~���Ұ�</td>
    <td width="60%"  bgcolor="silver">
    <select name="search14" size="1" class=dataListEntry ID="Select14">
        <%=S14%>
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
<tr><td class=dataListHead width="40%">�D�u�M�u�s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
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
        <option value="1;�D�u�w�ӽ�">�D�u�w�ӽ�</option>
        <option value="2;�D�u���">�D�u�w���</option>
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
        <option value="2;�w�M�u">�w�M�u</option>
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