<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�g�P��
    S15=""
    rs.Open "SELECT  CASE WHEN RTSparq499CmtyLINE.CONSIGNEE = '' THEN '���P' ELSE RTOBJ.SHORTNC END AS shortnc " _
           &"FROM  RTSparq499CmtyLINE LEFT OUTER JOIN RTOBJ ON RTSparq499CmtyLINE.CONSIGNEE= RTOBJ.CUSID " _
           &"GROUP BY  CASE WHEN RTSparq499CmtyLINE.CONSIGNEE = '' THEN '���P' ELSE RTOBJ.SHORTNC END " _
           &"ORDER BY  CASE WHEN RTSparq499CmtyLINE.CONSIGNEE = '' THEN '���P' ELSE RTOBJ.SHORTNC END",CONN
    s15="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s15=s15 &"<option value=""" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------�u�{�v
    S14=""
    rs.Open " select a.salesid, c.cusnc from rtsparq499cmtyline a inner join rtemployee b on a.salesid = b.emply inner join rtobj c on c.cusid = b.cusid group by a.salesid, c.cusnc order by 1,2 ",CONN
    s14="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s14=s14 &"<option value=""" & rs("salesid") & """>" &rs("cusnc") &"</option>"
       rs.MoveNext
    Loop
    's14=s14 &"<option value=""�L�k�k��"">�L�k�k��</option>"
    rs.Close
'----------�s���覡
    S8=""
    rs.Open "SELECT code, codenc FROM rtcode WHERE kind='G5' and code not in ('01','02','03')",CONN
    S8="<option value="""" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s8=s8 &"<option value=""" & rs("code") & """>" &rs("codenc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
      
'---------------------    
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
     t=t &" (RTSparq499CmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (RTSparq499CmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�u�˾��a�}
  S2=document.all("search2").value  
  If Len(s2)=0 Or s2="" Then
  Else
     s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
     t=t &" AND ((RTCounty.CUTNC + RTSparq499CmtyLine.TOWNSHIP + RTSparq499CmtyLine.raddr ) LIKE '%" &S2 &"%') " 
  End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND (convert(varchar(3),RTSparq499CmtyLine.LINEIPSTR1)+'.'+convert(varchar(3),RTSparq499CmtyLine.LINEIPSTR2)+'.'+convert(varchar(3),RTSparq499CmtyLine.LINEIPSTR3)+'.'+convert(varchar(3),RTSparq499CmtyLine.LINEIPSTR4) LIKE '%" & S3 & "%') "
  END IF
  '----�D�u�p��s��
  s4=document.all("search4").value
  If Len(trim(s4)) > 0 Then
     s=s &"  �p��s��:�]�t('" &s4 & "'�r��) "
     t=t &" AND (RTSparq499CmtyLine.CHTWORKINGNO LIKE '%" & S4 & "%') "
  End If    
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q��:�]�t('" &s5 & "'�r��) "
     t=t &" AND (RTSparq499CmtyLine.LINETEL LIKE '%" & S5 & "%') "
  End If      
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")  
  If Len(trim(s7ary(0)))=0 Or s7ary(0)="" Then
  Elseif s7ary(0)="0" then
  '�w�ɹ�i�ظm(�ɹ��<>�ť� and �ӽФ�=�ť�)
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.INSPECTDAT is NOT null AND RTSparq499CmtyLine.AGREE='Y' AND RTSparq499CmtyLine.adslapplyDAT is null) "
  Elseif s7ary(0)="1" then
  '�w�ӽ�(�ӽФ�<>�ť� and ip =�ť� )
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslapplyDAT is not null) AND RTSparq499CmtyLine.LINEIPSTR1='' "     
  elseif s7ary(0)="2" then
  '�w�ֵoip(ip <>�ť� and ����=�ť�)
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.LINEIPSTR1 <> '' AND RTSparq499CmtyLine.LINEtel =''  )  " 
  elseif s7ary(0)="3" then
  '�w���o����(����<>�ť� and ���q��=�ť�)
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.LINEtel <> '' AND RTSparq499CmtyLine.adslopendat IS NULL ) " 
  elseif s7ary(0)="4" then
  '�D�u�w���q(adslopendat <> �ť� and �h���� = �ť� and �@�o�� = �ť�)
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslopendat  is not null AND RTSparq499CmtyLine.dropdat is null ) " 
  elseif s7ary(0)="5" then
  '�D�u�w�h��(adslopendat <> �ť� and �h���� <> �ť� )
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslopendat  is not null AND RTSparq499CmtyLine.dropdat is not null ) "      
  elseif s7ary(0)="6" then
  '�D�u�w�@�o(�@�o�� <> �ť� )
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.canceldat  is not null ) "           
 End If        
  '----�s���覡
  s8=document.all("search8").value
  If Len(trim(s8)) > 0 Then
     s=s &"  �s���覡:" &s8 & " "
     t=t &" AND (RTSparq499CmtyLine.connecttype='" & S8 & "') "
  End If      
  '----���ϧǸ�
  s9=document.all("search9").value
  If Len(trim(s9)) > 0 Then
     s=s &"  ���ϧǸ�:'" &s9 & "') "
     t=t &" AND (RTSparq499CmtyLine.COMQ1=" & S9 & ") "
  End If   
  '----�D�u�Ǹ�
  s10=document.all("search10").value
  If Len(trim(s10)) > 0 Then
     s=s &"  �D�u�Ǹ�:'" &s10 & "') "
     t=t &" AND (RTSparq499CmtyLine.LINEQ1=" & S10 & ") "
  End If          
  
  s14=document.all("search14").value
  if S14 <> "*" then
       s=s &"  �u�{�v:'" &s14 & "') "
     t=t &" AND (RTSparq499CmtyLINE.salesid='" & S14 & "') "
  end if
  s15=document.all("search15").value
  s=S & "�g�P��:" &S15 &"  "
  if S15 <> "*" AND S15 <> "���P" then
     t=t &" AND (rtobj.shortnc='" & S15 & "') "
  ELSEIF S15="���P" THEN 
     t=t &" AND (RTSparq499CmtyLINE.consignee='') "
  end if  
  
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
  <tr class=dataListTitle align=center>�t��499�D�u��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�u�{�v</td>
    <td width="60%" bgcolor="silver">
      <select name="search14" size="1" class=dataListEntry ID="Select1">
        <%=S14%>
    </select>      
    </td></tr>        
<tr><td class=dataListHead width="40%">�g�P��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search15" size="1" class=dataListEntry ID="Select1">
        <%=S15%>
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
<tr><td class=dataListHead width="40%">�D�u�p��s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="12" name="search4" class=dataListEntry ID="Text3"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�����q��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="0;�w�ɬd���i�ظm">�w�ɬd���i�ظm</option>
        <option value="1;�w�ӽ�">�w�ӽ�</option>
        <option value="2;�w�ֵoIP">�w�ֵoIP</option>
        <option value="3;�w���o�����q��">�w���o�����q��</option>                
        <option value="4;�D�u�w���q">�D�u�w���q</option>    
        <option value="5;�D�u�w�h��">�D�u�w�h��</option>  
        <option value="6;�D�u�w�@�o">�D�u�w�@�o</option>      
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�s���覡</td>
    <td width="60%"  bgcolor="silver">
      <select name="search8" size="1" class=dataListEntry>
        <%=S8%>
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