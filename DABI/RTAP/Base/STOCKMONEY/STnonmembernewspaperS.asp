<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�D���ظm�覡
    S3=""
    rs.Open "SELECT CODE,CODENC FROM STCODE WHERE KIND='A2'",CONN
    s3="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s3=s3 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
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
  '---�m�W
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (NonMemberNewspaper.CUSNC<> '*' )" 
  Else
     s=s &"  �m�W:�]�t('" &S1 & "'�r��)"
     t=t &" (NonMemberNewspaper.CUSNC LIKE '%" &S1 &"%')" 
  End If
  '----EMAIL
  s2=document.all("search2").value
  If S2<>""  Then
     s=s &"  EMAIL:�]�t('" &s2 & "') "
     t=t &" AND (NonMemberNewspaper.EMAIL LIKE '%" & S2 & "%') "
  End If            
  '----�q�l�����O
  s3=document.all("search3").value
  S3ARY=SPLIT(S3,";")
  If s3ARY(0) <> "" Then
     s=s &"  �q�l�����O:" &s3ARY(1) & " "
     t=t &" AND (NonMemberNewspaper.NEWSPAPERKIND='A2') AND (NonMemberNewspaper.NEWSPAPERCODE='" & S3ARY(0) & "') "
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
  <tr class=dataListTitle align=center>�D�|���q�l���q�\��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�m�W</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry ID="Text5"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">EMAIL</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="30" name="search2" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�q�l�����O</td>
    <td width="60%"  bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry>
      <%=S3%>
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