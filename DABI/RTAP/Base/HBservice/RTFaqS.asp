<%
    Dim rs,i,conn
    Dim searchRcvusr, searchSales, searchComtype, searchSndwork
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")

    '���z�H�� -----------------------------------------------------
	rs.Open "select b.emply, c.cusnc from RTFaqM a " &_
			"inner join RTEmployee b on b.emply = a.rcvusr and tran2 ='' " &_
			"inner join RTObj c on c.cusid = b.cusid " &_
			"group by b.emply, cusnc order by c.cusnc ", conn
    searchRcvusr="<option value=""0;����"" selected></option>" &vbCrLf
    Do While Not rs.Eof
       searchRcvusr = searchRcvusr &"<option value="""& rs("EMPLY") & ";" & rs("CUSNC") &""">" &_
						 rs("CUSNC") & "</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close

    '�~�ȭ�,  -----------------------------------------------------
    rs.Open "select b.areaid, salesnc from HBAdslCmtyCust a inner join RTEmployee b on a.salesnc = b.name " &_
			"where b.tran2='' group by b.areaid, salesnc order by b.areaid, salesnc "
    searchSales="<option value=""0;����"" selected></option>" &vbCrLf
    'searchSales=searchSales &"<option value="";������"">������</option>" &vbCrLf           
    Do While Not rs.Eof
       searchSales = searchSales &"<option value="""& rs("areaid") & ";" & rs("salesnc") &""">" &_
						 rs("salesnc") & "</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close

    '��קO -----------------------------------------------------
    '20150607����sonet���
    '20150623�[�^sonet
    rs.Open "select code, codenc from RTCode where kind ='P5' and code in('3','6','7','8','9','A','B') "
    'rs.Open "select code, codenc from RTCode where kind ='P5' and code in('3','6','7','8','9','B') "
    searchComtype="<option value=""0;����"" selected></option>" &vbCrLf
    Do While Not rs.Eof
       searchComtype = searchComtype &"<option value="""& rs("code") & ";" & rs("codenc") &""">" &_
						 rs("codenc") & "</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close

    '�ȷ��O -----------------------------------------------------
    rs.Open "select code, codenc from RTCode where kind ='Q3' "
    searchSource="<option value=""0;����"" selected></option>" &vbCrLf
    Do While Not rs.Eof
       searchSource = searchSource &"<option value="""& rs("code") & ";" & rs("codenc") &""">" &_
						 rs("codenc") & "</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close

    '�w�w�I�u�H�� ----------------------------------------------------
    rs.Open "select '���P' as belongnc, c.cusnc " &_
			"from RTAreaSales a " &_
			"inner join RTEmployee b on a.cusid = b.emply " &_
			"inner join RTobj c on b.cusid = c.cusid " &_
			"where b.tran2 <>'10' and a.areaid LIKE 'C%' " &_
			"union " &_
			"select '�g�P' as belongnc, c.shortnc as cusnc " &_
			"from RTConsignee a " &_
			"inner join RTConsigneeCASE b on a.CUSID = b.CUSID " &_
			"inner join RTObj c on c.cusid = a.cusid " &_
			"where	b.caseid ='00' " &_
			"order by 1,2 "
    searchSndwork="<option value=""0;����"" selected></option>" &vbCrLf
    Do While Not rs.Eof
       searchSndwork = searchSndwork &"<option value="""& rs("belongnc") & ";" & rs("cusnc") &""">" &_
						 rs("cusnc") & "</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close


    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="VBScript">
Sub btn_onClick()
  dim aryStr,s,t,r,k1
  s=""	:	t=""	:	t1 =""

  ' ���ϦW�� -------------------------
  aryStr=document.all("search10").value  
  if aryStr <>"" then 
     s= s & "�@���ϦW�١G" &aryStr &"  "  
     t= t & " AND n.comn like '%"& aryStr &"%' "
  end if

  ' �Ȥ�W�� -------------------------
  k1=document.all("search1").value
  if len(trim(k1)) > 0 then
     s=s & "�@�Ȥ�W�١G�t('" & K1 & "')�r��"
     t = t & " and a.FaqMan like '%" & k1 & "%' "
  end if

  ' ���z�ɶ� -----------------------
  s5=document.all("search5").value  
  s6=document.all("search6").value    
  if s5 <>"" and s6 <>"" then   
	 s =s & "  ���z�ɶ��G" & s5 & " �� " & s6
	 t =t & " and a.RCVDAT >= '" & s5 & " 00:00.000' and a.RCVDAT <= '" & s6 & " 23:59.997' "
  end if  

  ' ���׮ɶ� -----------------------
  s12=document.all("search12").value  
  s13=document.all("search13").value    
  if s12 <>"" and s13 <>"" then 
 	 s=s & "  ���׮ɶ��G" & s12 & " �� " & s13
 	 t=t & " and a.closedat >= '" & s12 & " 00:00.000' and a.closedat <= '" & s13 & " 23:59.997' "
  end if

  ' ���z�H�� -------------------------
  aryStr=Split(document.all("search7").value,";")
  if aryStr(0) <>"0" then 
     s=s & "  ���z�H���G" &aryStr(1) &"  "  
	 t = t & " AND a.rcvusr ='" &aryStr(0)& "' "
  end if 

' ���g�P -------------------------
  aryStr=Split(document.all("search11").value,";")  
  IF arystr(0)<>"0" then
     s=s & "  ���g�P�J" & arystr(1)
	 t=t & " AND case n.groupnc when '' then '���P' else '�g�P' end = '"& aryStr(1) &"' "
  end if

  ' �~�ȭ� -------------------------
  aryStr=Split(document.all("search8").value,";")  
  IF arystr(0)<>"0" then
     s=s & "  �~�ȭ��J" & arystr(1)
	 t=t & " AND n.groupnc + n.leader = '"& aryStr(1) &"' "
  end if

  ' ���ת��A -------------------------
  aryStr=Split(document.all("search2").value,";")
  s=s & "�@���ת��A�G" &aryStr(1)
  if arystr(0) = "0" then	 '����
	t =	t & " "
  elseif arystr(0) = "1" then '����
	t =	t & " and a.closedat is null and a.canceldat is null "
  elseif arystr(0) = "2" then '�w��
	t =	t & " and a.closedat is not null and a.canceldat is null "
  elseif arystr(0) = "3" then '�����u
	t1 = t1 & " inner "
  end if

 ' ��קO -------------------------
  aryStr=Split(document.all("search3").value,";")  
  IF arystr(0)<>"0" then
     s=s & "  ��קO�J" & arystr(1)
	 t=t & " AND c.comtypenc = '"& aryStr(1) &"' "
  end if

 ' �ȷ��O -------------------------
  aryStr=Split(document.all("search9").value,";")  
  IF arystr(0)<>"0" then
     s=s & "  �Ȥ�ӷ��J" & arystr(1)
	 t=t & " AND a.custsrc = '"& aryStr(0) &"' "
  end if

  ' �w�w�I�u�H�� -------------------------
  aryStr=Split(document.all("search4").value,";")  
  IF arystr(0)<>"0" then
     s=s & "  �w�w�I�u�H���J" & arystr(1)
	 t=t & " AND isnull(k.shortnc,i.name) = '"& aryStr(1) &"' "
  end if

  
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry1").value=t1
  'docP.all("searchQry2").value=t2
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

-->
</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"      codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>

<body>
<table width="100%">
  <tr class=dataListTitle align=center>�ȶD��Ƭd��</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">���g�P</td>
    <td width="60%"  bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry ID="Select2">
        <option value="0;����"></option>              
        <option value="1;���P">���P</option>
        <option value="2;�g�P">�g�P</option>
      </select></td></tr>

<tr><td class=dataListHead width="40%">�~�ȭ�</td>
    <td width="60%" bgcolor="silver" >
      <select name="search8" size="1" class=dataListEntry ID="Select4">
      <%=searchSales%>
      </select></td></tr>

<tr><td class=dataListHead width="40%">��קO</td>
    <td width="60%"  bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry ID="Select1">
      <%=searchComtype%>
      </select></td></tr>

<tr><td class=dataListHead width="40%">�Ȥ�ӷ�</td>
    <td width="60%"  bgcolor="silver">
      <select name="search9" size="1" class=dataListEntry ID="Select9">
      <%=searchSource%>
      </select></td></tr>

<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search10" class=dataListEntry></td></tr>

<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry></td></tr>
    
<tr><td class=dataListHead width="40%">���z�H��</td>
    <td width="60%" bgcolor="silver" >
      <select name="search7" size="1" class=dataListEntry ID="Select3">
      <%=searchRcvusr%>
      </select></td></tr>

<tr><td class=dataListHead width="40%">���z�ɶ�</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search5" size="10" maxlength="10" class=dataListEntry  value="<%=Sdate%>" ID="Text1">
    <input type="button" id="B5"  name="B5" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">         
    ��
    <input type=text name="search6" size="10" maxlength="10" class=dataListEntry  value="<%=edate%>" ID="Text2">    
    <input type="button" id="B6"  name="B6" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>    

<tr><td class=dataListHead width="40%">���׮ɶ�</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search12" size="10" maxlength="10" class=dataListEntry  value="<%=Sdate%>" ID="Text3">
    <input type="button" id="B12"  name="B12" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">         
    ��
    <input type=text name="search13" size="10" maxlength="10" class=dataListEntry  value="<%=edate%>" ID="Text4">    
    <input type="button" id="B13"  name="B13" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>    

<tr><td class=dataListHead width="40%">���ת��A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search2" size="1" class=dataListEntry>
        <option value="0;����">����</option>        
        <option value="1;������" selected>������</option>
        <option value="2;�w����">�w����</option>
        <option value="3;�����u">�����u</option>
      </select></td></tr>

<tr><td class=dataListHead width="40%">�w�w�I�u�H��</td>
    <td width="60%" bgcolor="silver" >
      <select name="search4" size="1" class=dataListEntry ID="Select5">
      <%=searchSndwork%>
      </select></td></tr>

</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>
