<%
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�~���Ұ�
    S2=""
	sqlstr="select  a.salesid, c.cusnc " &_
		   "from RTfareastCmtyH a " &_
		   "inner join RTEmployee b on a.salesid = b.emply " &_
		   "inner join RTObj c on c.CUSID = b.CUSID " &_
		   "group by a.salesid, c.cusnc " 
    rs.Open sqlstr,CONN
    S2="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       S2=S2 &"<option value=""" &rs("salesid") & ";" & rs("CUSNC") & """>" &rs("CUSNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------�g�P��
    S7=""
    rs.Open "select a.consignee, b.shortnc from RTfareastCmtyH a inner join RTObj b on a.consignee = b.cusid group by a.consignee, b.shortnc ",CONN
    s7="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s7=s7 &"<option value=""" &rs("CONSIGNEE") & ";" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------�Τ�t�v
    S3=""
    rs.Open "select code, codenc from RTCode where kind ='R3' ",CONN
    s3="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s3=s3 &"<option value=""" &rs("code") & ";" & rs("codenc") & """>" &rs("codenc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close     
'----------ú�ڶg��
    S10=""
    rs.Open "select code, codenc from RTCode where kind ='M8' ",CONN
    s10="<option value=""*;����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s10=s10 &"<option value=""" &rs("code") & ";" & rs("codenc") & """>" &rs("codenc") &"</option>"
       rs.MoveNext
    Loop
    rs.Close     
'-------------------------------
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
Sub btn_onClick()
  dim aryStr,s,t,r

  s2=document.all("search2").value
  S2ARY=SPLIT(S2,";")
  If s2ARY(0) = "*" Then
     t=t &" a.COMQ1 <>0 "
  else
     s=s &"  �~���Ұ�:" &s2ARY(1) & " "
     t=t &" c.SALESID='" & S2ARY(0) & "' "
  End If            

  s7=document.all("search7").value
  S7ARY=SPLIT(S7,";")
  If s7ARY(0) <> "*" Then
     s=s &"  �g�P��:" &s7ARY(1) & " "
     t=t &" AND c.CONSIGNEE='" & S7ARY(0) & "' "
  End If

  S1=document.all("search1").value  
  If Len(TRIM(s1)) >0  Then
     s=s &"  ���ϦW��:�]�t('"& S1 &"'�r��)"
     t=t &" AND c.ComN LIKE '%" &S1& "%' " 
  End If

  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q��/�M�u�s��:�]�t('"& s5 &"'�r��) "
     t=t &" AND b.LINETEL LIKE '%"& S5 &"%' "
  End If

  s9=document.all("search9").value 
  if  Len(trim(s9)) >0 then
     s=s & " �Τ�W�١J�]�t('"& s9 &"')�r�� "
     t=t & " and a.cusnc like '%"& s9 &"%' "
  end if

  s13=document.all("search13").value 
  if  Len(trim(s13)) >0 then
     s=s & " ������/�νs�J�]�t('" & s13 & "')�r�� "
     t=t & " and (a.socialid like '%"& s13 &"%' or a.secondno like '%"& s13 &"%') "
  end if

  s12=document.all("search12").value 
  if  Len(trim(s12)) >0 then
     s=s & " �p���q�ܡJ�]�t('" & s12 & "')�r�� "
     t=t & " and (a.contacttel like '%"& s12 &"%' OR a.mobile like '%"& s12 &"%') "
  end if   

  s3ary=split(document.all("search3").value,";")  
  If s3ARY(0) <>"*" Then
     s=s &"  �Τ�t�v:" &s3ary(1)
     t=t &" AND a.userrate='" & s3ary(0) & "' "
  End If

  s10ary=split(document.all("search10").value,";")  
  If s10ARY(0) <>"*" Then
     s=s &"  ú�ڶg��:" &s10ary(1)
     t=t &" AND a.paycycle='" & s10ary(0) & "' "
  End If

  s18ary=split(document.all("search18").value,";")  
  If s10ARY(0) <>"*" Then 
  	s=s &"  �Τ�i��:('" &s18ARY(1) & "') "
  end if
  '�����u
  If s18ARY(0) = "1" THEN
     t=t &" AND a.FINISHDAT IS NULL and a.dropdat is null and a.canceldat is null "
  '�w���u������
  ELSEIF s18ARY(0) = "2" THEN
     t=t &" AND a.FINISHDAT IS NOT NULL AND a.docketdat IS NULL and a.dropdat is null and a.canceldat is null "
  '�w���u
  ELSEIf s18ARY(0) = "3" THEN
     t=t &" AND a.FINISHDAT IS NOT NULL and a.dropdat is null and a.canceldat is null "
  '�w���u�L�p�O��
  ELSEIF s18ARY(0) = "4" THEN
     t=t &" AND a.FINISHDAT IS NOT NULL AND a.strbillingdat IS NULL and a.dropdat is null and a.canceldat is null "
  '�w�h��
  ELSEIF s18ARY(0) = "5" THEN
     t=t &" AND a.dropdat IS NOT NULL and a.canceldat is null "
  '�w�@�o
  ELSEIF s18ARY(0) = "6" THEN
     t=t &" AND a.CANCELDAT IS NOT NULL "
  End If   

  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=SRTX
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="search" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
End Sub 
Sub btn1_onClick()  
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub

</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"       codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<body>
<table width="100%">
  <tr class=dataListTitle align=center>���Ǥj�e�W���ϫ��Τ��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%" >�~���Ұ�</td>
    <td bgcolor="silver" width="60%">
    	<select name="search2" size="1" class=dataListEntry ID="Select2"><%=S2%></select>
    </td>
</tr>
<tr><td class=dataListHead >�g�P��</td>
    <td bgcolor="silver"><select name="search7" size="1" class=dataListEntry><%=S7%></select></td>
</tr>
<tr><td class=dataListHead >���ϦW��</td>
    <td bgcolor="silver"><input type="text" size="20" name="search1" class=dataListEntry></td>
</tr>
<tr><td class=dataListHead >�D�u�����q��/�M�u�s��</td>
    <td bgcolor="silver"><input type="text" size="20" name="search5" class=dataListEntry></td>
</tr>
<tr><td class=dataListHead >�Τ�W��</td>
    <td bgcolor="silver"><input type="text" size="20" name="search9" class=dataListEntry></td>
</tr>
<tr><td class=dataListHead >�Τᨭ����/�νs</td>
    <td bgcolor="silver"><input type="text" size="10" name="search13" class=dataListEntry></td>
</tr>
<tr><td class=dataListHead >�p���q��(�Φ��)</td>
    <td bgcolor="silver"><input type="text" size="10" name="search12" class=dataListEntry></td>
</tr>
<tr><td class=dataListHead>�Τ�t�v</td>
    <td bgcolor="silver"><select name="search3" size="1" class=dataListEntry><%=S3%></select></td>
</tr>
<tr><td class=dataListHead>ú�ڶg��</td>
    <td bgcolor="silver"><select name="search10" size="1" class=dataListEntry><%=S10%></select></td>
</tr>
<tr><td class=dataListHead >�Τ�i�ת��p</td>
    <td bgcolor="silver">
      <select name="search18" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�����u">�����u</option>
		<option value="2;�w���u������">�w���u������</option>
		<option value="3;�w���u">�w���u</option>
        <option value="4;�w���u�L�p�O��">�w���u�L�p�O��</option>
        <option value="5;�w�h��">�w�h��</option>
        <option value="6;�w�@�o">�w�@�o</option>
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