<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �~���Ұ�

'--------- �~�ȲէO    

'--------- �����O 

'----------�������O
    S8=""
    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2'",CONN
    s8="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s8=s8 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------�D���ظm�覡
    S9=""
    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='G4'",CONN
    s9="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s9=s9 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
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
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '----���ϦW��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (a.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (a.ComN LIKE '%" &S1 &"%')" 
  End If
  '----���Ϧa�}
  S2=document.all("search2").value  
  If Len(s2)=0 Or s2="" Then
  Else
     s=s &"  ���Ϧa�}:�]�t('" &S2 & "'�r��)"
     t=t &" AND (d.CUTNC+a.Township+a.Raddr LIKE '%" &S2 &"%')" 
  End If
  '----�ɹ�i��
  s4ary=split(document.all("search4").value,";")  
  If Len(trim(s4ary(0)))=0 Or s4ary(0)="" Then
  Elseif s4ary(0)="1" then
     s=s &"  �ɹ�i��:" &s4ary(1)
     t=t &" AND (a.surveydat is not null) "
  elseif s4ary(0)="2" then
      s=s &"  �ɹ�i��:" &s4ary(1)
     t=t &" AND (a.surveydat is null) "
  End If    
  '----�O�_�i�ظm
  s5ary=split(document.all("search5").value,";")  
  If Len(trim(s5ary(0)))=0 Or s5ary(0)="" Then
  Elseif s5ary(0)="1" then
     s=s &"  �O�_�i�ظm:" &s5ary(1)
     t=t &" AND (a.agree='Y') "
  elseif s5ary(0)="2" then
     s=s &"  �O�_�i�ظm:" &s5ary(1)
     t=t &" AND (a.agree='N') " 
  elseif s5ary(0)="3" then
      s=s &"  �O�_�i�ظm:" &s5ary(1)
     t=t &" AND (a.agree='H') "  
  elseif s5ary(0)="4" then
     s=s &"  �O�_�i�ظm:" &s5ary(1)
     t=t &" AND (a.agree='') "          
  End If      
  '----���ϳW�Ҥ��
  s6ary=Split(document.all("search6").value,";")
  s7=document.all("search7").value  
  If Len(s7)=0 Or s7="" Then
  Else
     s=s &"  �W�Ҥ��:" &s6ary(1) &s7 &"��"
     t=t &" AND (a.comCnt" &s6ary(0) &s7 &")"
  End If
  '----�ؿv������
  s8ary=Split(document.all("search8").value,";")
  If Len(s8ary(0))=0 Or s8ary(0)="" Then
  Else
     s=s &"  �ؿv������:" &s8ary(1)
     t=t &" AND (a.buildtype='" &s8ary(0) &"')"
  End If  
  '----�D���ظm�覡
  s9ary=Split(document.all("search9").value,";")
  If Len(s9ary(0))=0 Or s9ary(0)="" Then
  Else
     s=s &"  �D���ظm�覡:" &s9ary(1)
     t=t &" AND (a.setuptype='" &s9ary(0) &"')"
  End If    
  '----ñ�q�P�N��
  s10ary=Split(document.all("search10").value,";")
  If Len(s10ary(0))=0 Or s10ary(0)="" Then
  Elseif s10ary(0)="1" then 
     s=s &"  ñ�q�P�N��:" &s10ary(1)
     t=t &" AND (a.agreedat is not null)"
  Elseif s10ary(0)="2" then 
     s=s &"  ñ�q�P�N��:" &s10ary(1)
     t=t &" AND (a.agreedat is null)"     
  End If      
  '----�����q�H��(�c)
  s11ary=Split(document.all("search11").value,";")
  If Len(s11ary(0))=0 Or s11ary(0)="" Then
  Elseif s11ary(0)="1" then 
     s=s &"  �����q�H��(�c):" &s11ary(1)
     t=t &" AND (a.telcomroom='Y')"
  Elseif s11ary(0)="2" then 
     s=s &"  �����q�H��(�c):" &s11ary(1)
     t=t &" AND (a.telcombox='Y')"     
  Elseif s11ary(0)="3" then 
     s=s &"  �����q�H��(�c):" &s11ary(1)
     t=t &" AND (a.telcomroom='Y') and (a.telcombox='Y')"     
  End If        
  '----�D�u�ӽм�
  TX=""
  TY=""
  s12ary=Split(document.all("search12").value,";")
  s13=document.all("search13").value
  IF LEN(TRIM(S13))=0 THEN S13=0
  if len(trim(S12ARY(0))) <> 0 then
     s=s & " �D�u�ӽмơJ" & s12ary(1) & s13 & " ��"
     if len(trim(TX))=0 then
        TX=" HAVING SUM(CASE WHEN y.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) " & S12ARY(0) & S13 & " "
     ELSE
        TX=TX & " AND SUM(CASE WHEN y.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) " & S12ARY(0) & S13 & " "
     END IF
  end if
  '----�D�u�}�q��
  s14ary=Split(document.all("search14").value,";")
  s15=document.all("search15").value  
  IF LEN(TRIM(S15))=0 THEN S15=0  
  if len(trim(S14ARY(0))) <> 0 then
     s=s & " �D�u�}�q�ơJ" & s14ary(1) & s15 & " ��"
     if len(trim(TX))=0 then
        TX=" HAVING SUM(CASE WHEN y.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END)  " & S14ARY(0) & S15 & " "
     ELSE
        TX=TX & " AND SUM(CASE WHEN y.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END)  " & S14ARY(0) & S15 & " "
     END IF
  end if  
  '----���ϥΤ�ӽм�  
  s16ary=Split(document.all("search16").value,";")
  s17=document.all("search17").value
  IF LEN(TRIM(S17))=0 THEN S17=0  
  if len(trim(S16ARY(0))) <> 0 then
     s=s & " �D�u�ӽмơJ" & s16ary(1) & s17 & " ��"
     if len(trim(TY))=0 then
        TY=" HAVING SUM(CASE WHEN z.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) " & S16ARY(0) & S17 & " "
     ELSE
        TY=TY & " AND SUM(CASE WHEN z.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) " & S16ARY(0) & S17 & " "
     END IF
  end if  
  '----���ϥΤ᧹�u��  
  s18ary=Split(document.all("search18").value,";")
  s19=document.all("search19").value
  IF LEN(TRIM(S19))=0 THEN S19=0  
  if len(trim(S18ARY(0))) <> 0 then
     s=s & " �D�u�ӽмơJ" & s18ary(1) & s19 & " ��"
     if len(trim(TY))=0 then
        TY=" HAVING  SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) " & S18ARY(0) & S19 & " "
     ELSE
        TY=TY & " AND  SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) " & S18ARY(0) & S19 & " "
     END IF
  end if    
  '----���ϥΤ������  
  s20ary=Split(document.all("search20").value,";")
  s21=document.all("search21").value
  IF LEN(TRIM(S21))=0 THEN S21=0  
  if len(trim(S18ARY(0))) <> 0 then
     s=s & " �D�u�ӽмơJ" & s20ary(1) & s21 & " ��"
     if len(trim(TY))=0 then
        TY=" HAVING  SUM(CASE WHEN docketDAT IS NOT NULL THEN 1 ELSE 0 END) " & S20ARY(0) & S21 & " "
     ELSE
        TY=TY & " AND  SUM(CASE WHEN docketDAT IS NOT NULL THEN 1 ELSE 0 END) " & S20ARY(0) & S21 & " "
     END IF
  end if      
  
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=TX 
  docP.all("searchQry3").value=TY   
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
  <tr class=dataListTitle align=center>���ϰ򥻸�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">���Ϧ�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search2" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�D�u�ӽм�</td>
    <td width="60%" bgcolor="silver">
      <select name="search12" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search13" align=right class=dataListEntry ID="Text1"><font size=3>��</font>
    </td></tr>    
<tr><td class=dataListHead width="40%">�D�u�}�q��</td>
    <td width="60%" bgcolor="silver">
      <select name="search14" size="1" class=dataListEntry ID="Select3">
        <option value=";����" selected>����</option>
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search15" align=right class=dataListEntry ID="Text3"><font size=3>��</font>
    </td></tr>        
<tr><td class=dataListHead width="40%">���ϥӽФ��</td>
    <td width="60%" bgcolor="silver">
      <select name="search16" size="1" class=dataListEntry ID="Select2">
        <option value=";����" selected>����</option>      
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search17" align=right class=dataListEntry ID="Text2"><font size=3>��</font>
    </td></tr>        
<tr><td class=dataListHead width="40%">���ϧ��u���</td>
    <td width="60%" bgcolor="silver">
      <select name="search18" size="1" class=dataListEntry ID="Select4">
        <option value=";����" selected>����</option>
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search19" align=right class=dataListEntry ID="Text4"><font size=3>��</font>
    </td></tr>          
<tr><td class=dataListHead width="40%">���ϳ������</td>
    <td width="60%" bgcolor="silver">
      <select name="search20" size="1" class=dataListEntry ID="Select5">
        <option value=";����" selected>����</option>      
        <option value=">;�j��" >�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search21" align=right class=dataListEntry ID="Text5"><font size=3>��</font>
    </td></tr>                
<!--
<tr><td class=dataListHead width="40%">�D�u���p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search12" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;�w���D�u�ӽ�">�w���D�u�ӽ�</option>
        <option value="2;�w���D�u�}�q">�w���D�u�}�q</option>        
      </select>
     </td>
</tr>
-->
<tr><td class=dataListHead width="40%">�ɹ�i��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search4" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="Y;�w�ɹ�">�w�ɹ�</option>
        <option value="N;���ɹ�">���ɹ�</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�O�_�i�ظm</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="Y;�i�ظm">�i�ظm</option>
        <option value="N;���i�ظm">���i�ظm</option>
        <option value="H;���Ϧ^�Ф�">���Ϧ^�Ф�</option>        
        <option value=";�|���ɹ�">�|���ɹ�</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�W�Ҥ��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search6" size="1" class=dataListEntry>
        <option value=">;�j��" selected>�j��</option>
        <option value="<;�p��">�p��</option>
        <option value="=;����">����</option>
      </select>
      <input type="text" size="5" name="search7" align=right class=dataListEntry> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�ؿv������</td>
    <td width="60%"  bgcolor="silver">
      <select name="search8" size="1" class=dataListEntry>
       <%=s8%>
      </select>
    </td></tr>       
<tr><td class=dataListHead width="40%">�D���ظm�覡</td>
    <td width="60%"  bgcolor="silver">
      <select name="search9" size="1" class=dataListEntry>
        <%=s9%>      
      </select>
     </td>
</tr>      
<tr><td class=dataListHead width="40%">ñ�q�P�N��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search10" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;��">��</option>
        <option value="2;�L">�L</option>        
      </select>
     </td>
</tr>      
<tr><td class=dataListHead width="40%">�����q�H��(�c)</td>
    <td width="60%"  bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;�������q�H��">�������q�H��</option>
        <option value="2;�������q�H�c">�������q�H�c</option>     
        <option value="3;�������q�H�Ǥιq�H�c">�������q�H�Ǥιq�H�c</option>        
           
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