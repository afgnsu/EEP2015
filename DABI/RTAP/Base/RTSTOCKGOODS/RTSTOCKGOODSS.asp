<!-- #include virtual="/webap/include/lockright.inc" -->
<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �����O
    rs.Open "SELECT RTPROVIDER.CUSID, RTObj.CUSNC FROM RTPROVIDER INNER JOIN RTObj ON RTPROVIDER.CUSID = RTObj.CUSID " _
           &"ORDER BY CUSNC ",conn
    s1="<option value=""<>'*';�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       s1= s1 & "<option value=""='" & rs("CUSID") & "';" & "�G" &  rs("CUSNC") & """>" & rs("CUSNC") & "</option>" & vbcrlf
    rs.movenext
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
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  s1ary=Split(document.all("search1").value,";")
  s2ary=Split(document.all("search2").value,";")
  s="�����O" & s1ary(1) & "�@�t��²��" & s2ary(1) & "�@�t�ӦW�١G�t(""" & document.all("search3").value & """)�r��"
  t=t & "(rtobj.cutid1" & s1ary(0) & ") AND (RTObj.CUSID" & S2ARY(0) & ")"
  t=t & " and (rtobj.cusnc like '%" & document.all("search3").value & "%')"
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
  <tr class=dataListTitle align=center>�i�f���Ʒj�M����</td><tr>
</table>
<table width="50%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�i�f�渹</td>
    <td width="60%" bgcolor=silver>
      <select name="search1" size="1" class=dataListEntry>
        <%=S1%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">�i�f�t��</td>
    <td width="60%"  bgcolor=silver>
      <select name="search2" size="1" class=dataListEntry>
        <%=S2%>
      </select>    </td></tr>
</table>
<table width="50%" align=right><tr><td></td>
<td align=right>
<input type="button" value=" �d�� " class=dataListButton name="btn" style="cursor:hand">
<input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td>
</tr></table>
</body>
</html>