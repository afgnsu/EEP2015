<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�t������
    S4=""
    rs.Open "SELECT YYMMDD FROM   SpeechSignUP GROUP BY  YYMMDD ",CONN
    s4="<option value="""" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s4=s4 &"<option value=""" &rs("yymmdd") & """>" &rs("yymmdd") &"</option>"
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
     t=t &" (SpeechSignUP.NAME<> '*' )" 
  Else
     s=s &"  �m�W:�]�t('" &S1 & "'�r��)"
     t=t &" (SpeechSignUP.NAME LIKE '%" &S1 &"%')" 
  End If
  '----EMAIL
  s2=document.all("search2").value
  If S2<>""  Then
     s=s &"  EMAIL:�]�t('" &s2 & "') "
     t=t &" AND (SpeechSignUP.EMAIL LIKE '%" & S2 & "%') "
  End If            
  '----���W����
  s3=document.all("search3").value
  S3ARY=SPLIT(S3,";")
  If s3ARY(0) <> "" Then
     s=s &"  ���W����:" &s3ARY(1) & " "
        t=t &" AND (SpeechSignUP.LIVEORNET ='" & S3ARY(0) & "' ) "
  End If      
  '----���W����
  s4=document.all("search4").value
  If s4 <> "" Then
     s=s &"  ���W����:" &s4 & " "
        t=t &" AND (SpeechSignUP.YYMMDD LIKE '%" & S4 & "%' ) "
  End If                        
  '----�f�֪��A
  s5=document.all("search5").value
  S5ARY=SPLIT(S5,";")
  If s5ARY(0) <> "" Then
     s=s &"  �f�֪��A:" &s5ARY(1) & " "
     IF S5ARY(0)="1" THEN
        t=t &" AND (SpeechSignUP.CONFIRMDAT IS NOT NULL) "
     ELSEIF S5ARY(0)="2" THEN
        t=t &" AND (SpeechSignUP.CANCELDAT IS NOT NULL) "
     ELSEIF S5ARY(0)="3" THEN
        t=t &" AND (SpeechSignUP.CONFIRMDAT IS NULL) AND (SpeechSignUP.CANCELDAT IS NULL) "
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
  <tr class=dataListTitle align=center>�t�����ʳ��W��Ʒj�M����</td><tr>
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
<tr><td class=dataListHead width="40%">���W����</td>
    <td width="60%"  bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="N;�����t��">�����t��</option>
        <option value="L;�{���t��">�{���t��</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">���W����</td>
    <td width="60%"  bgcolor="silver">
      <select name="search4" size="1" class=dataListEntry ID="Select2">
      <%=S4%>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�f�֪��A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�w�f��">�w�f��</option>
        <option value="2;�w�@�o">�w�@�o</option>
        <option value="3;�|���f��">�|���f��</option>
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