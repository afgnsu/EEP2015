<!-- #include virtual="/webap/include/lockright.inc" -->
<%
    Dim rs,i,conn
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �����O
    rs.Open "SELECT cutid,cutnc from rtcounty " _
           &"ORDER BY cutid ",conn
    s1="<option value=""<>'*';�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       s1= s1 & "<option value=""='" & rs("cutid") & "';" & "�G" &  rs("cutnc") & """>" & rs("CUTNC") & "</option>" & vbcrlf
    rs.movenext
    Loop
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV2/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  s=""

  s4ary=" AREAID like '" & document.all("search4").value &"' "	  

  s1ary = document.all("search1").value
  if s1ary ="��" then 
	s1ary= " and healthins+laborins >0"
  elseif s1ary ="�L" then 
	s1ary= " and healthins+laborins =0"
  else 
	s1ary= "" 
  end if

  s2ary=Split(document.all("search2").value,";")
  s3ary=" and TRAN2 like '" & document.all("search3").value &"' "	
  
  s="���L�O�O�G" & s1ary & "�@���u�m�W�G�t('" & document.all("search2").value & "')�r��"
  t=t & s4ary &" AND (c.cusnc like '%" & document.all("search2").value & "%')" & s3ary & s1ary
  
  'ALARM T
  
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
  window.close
End Sub  
-->
</script>
</head>
<body>
<center>
<table width="50%">
  <tr class=dataListTitle align=center>���u��Ʒj�M����</td><tr>
</table>
<table width="50%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���L�Ұ��O</td>
	<td bgcolor=silver>
		<select name="search1" size="1" class=dataListEntry ID="Select1">
	   		<option value="��">��</option>
			<option value="�L">�L</option>
			<option value="����" selected>����</option>
		</select>
	</td></tr>
<tr><td class=dataListHead width="40%">�m�W</td>
    <td width="60%" bgcolor=silver>
    <input class=dataListEntry name="search2" maxlength=10 size=10 style="TEXT-ALIGN: left">   </td></tr>
    
<tr><td class=dataListHead width="40%">��¾�_</td>
		<td bgcolor=silver><select name="search3" size="1" class=dataListEntry>
	   		<option value="">����¾</option>
			<option value="10">�w��¾</option>
			<option value="%" selected>����</option>
		</select></td></tr>

<tr><td class=dataListHead width="40%">�ҰϧO</td>
		<td bgcolor=silver><select name="search4" size="1" class=dataListEntry>
	   		<option value="%" selected>����</option>
			<option value="C1">�x�_</option>
			<option value="C2">���</option>
			<option value="C3">�x��</option>
			<option value="C4">����</option>
		</select></td></tr>

</table>
<table width="50%" align=right><tr><td></td><td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">  
</td></tr></table>
</body>
</html>