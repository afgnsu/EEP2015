
<!-- #include virtual="/Webap/include/RTGetUserlevel.inc" -->
<%
    Dim fieldRole
    fieldRole=FrGetUserlevel(Request.ServerVariables("LOGON_USER")) 
    Dim rs,i,conn ,s1
    Dim search1Opt,search2Opt,search6Opt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--- ���⬰:�~�ȧU�z(�ȪA����)
'    if fieldrole="1" then
'------ �~�Ȥu�{�v
'       rs.open "SELECT RTEmployee.emply, RTObj.CUSNC " _
'              &"FROM RTEmployee INNER JOIN " _
'              &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
'              &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
'              &"and rtemployee.authlevel in ('2') ",conn   
'       s1="<option value=""<>'*';�G����"" selected>����</option>" &vbCrLf           
'       Do while not rs.EOF
'          s1= s1 & "<option value=""='" & rs("emply") & "';" & "�G" &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
'       rs.movenext
'       Loop                    
'--- ���⬰:�޳N��    
'    else
'------ �t��
       rs.Open "SELECT RTObj.CUSID, RTObj.CUSNC " _
              &"FROM RTObj INNER JOIN " _
              &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
              &"WHERE (RTObjLink.CUSTYID = '04') ",conn
       s1="<option value=""<>'*';�G����"" selected>����</option>" &vbCrLf           
       Do while not rs.EOF
          s1= s1 & "<option value=""='" & rs("cusid") & "';" & "�G" &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
       rs.movenext
       Loop
       rs.Close       
'-------�޳N���H��
       rs.open "SELECT RTEmployee.emply, RTObj.CUSNC " _
              &"FROM RTEmployee INNER JOIN " _
              &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
              &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
              &"and rtemployee.authlevel in ('4') ",conn   
       Do while not rs.EOF
          s1= s1 & "<option value=""='" & rs("emply") & "';" & "�G" &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
       rs.movenext
       Loop        
'    end if
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  s1ary=Split(document.all("search1").value,";")
  s2ary=Split(document.all("search2").value,";")
  if s2ary(0) = "=''" then
     s2ary(0) = " (a.paydtldat is null) and "
  elseif s2ary(0) = "<>''" then
     s2ary(0) = " (a.paydtldat is not null) and "
  elseif s2ary(0) = "<>'*'" then
     s2ary(0) = ""
  end if
  if len(trim(document.all("search3").value)) < 1 then
     s3="<>'*'"
     SPRTNO=""
  else
     S3="=" & document.all("search3").value & ""
      SPRTNO=document.all("search3").value
  end if 
  s4ary=Split(document.all("search4").value,";")
  if len(trim(document.all("search5").value)) < 1 then
     S4ary(1)="=����"
  else
     S5= document.all("search5").value
  end if 
  s6ary=split(document.all("search6").value,";")
  if s6ary(0) = "=''" then
     s6ary(0) = " and (a.docketdat is null)  "
  elseif s6ary(0) = "<>''" then
     s6ary(0) = " and (a.docketdat is not null)  "
  elseif s6ary(0) = "<>'*'" then
     s6ary(0) = ""
  end if  
  s7ary=split(document.all("search7").value,";")
  if s7ary(0) = "=''" then
     s7ary(0) = " and (a.acccfmdat is null)  "
  elseif s7ary(0) = "<>''" then
     s7ary(0) = " and (a.acccfmdat is not null)  "
  elseif s7ary(0) = "<>'*'" then
     s7ary(0) = ""
  end if  
  s8ary=split(document.all("search8").value,";")
  if s8ary(0) = "=''" then
     s8ary(0) = " and (a.incomedat is null)  "
  elseif s8ary(0) = "<>''" then
     s8ary(0) = " and (a.incomedat is not null)  "
  elseif s8ary(0) = "<>'*'" then
     s8ary(0) = ""
  end if  
  s="�I�u�t��" & s1ary(1) & "  " & "�C�L���p" & s2ary(1) & "  " & "�C�L�帹�G" & s3 & "  " &"�m�u��"& s6ary(1) & "  " & "�I�u���B " & s4ary(1) & S5
  s=s &"  " &"�|�p�f��"& s7ary(1) & "  " & "���ڤJ�b"& s8ary(1)
  t=t & "(a.PROFAC " & s1ary(0) & ") AND " & s2ary(0) & " (a.paydtlprtno" & S3 & ") and (a.setfee + a.setfeediff " & s4ary(0) & s5 & ") "
  t=t & s6ary(0) & s7ary(0) & s8ary(0)
  t=t & ";" & s2ary(1) & ";" & SPRTNO & ";" & s1ary(0) & ";" & s8ary(1)
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
<table width="70%">
  <tr class=dataListTitle align=center>�п�J(���)�I�u�O��I���Ӫ��Ʒj�M����</td><tr>
</table>
<table width="50%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�I�u�t��</td>
    <td width="60%" bgcolor="silver" >
      <select name="search1" size="1" class=dataListEntry>
        <%=S1%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">��I��C�L���p</td>
    <td width="60%" bgcolor="silver">
      <select name="search2" size="1" class=dataListEntry >
        <option value="='';�G���C�L" selected>���C�L</option>
        <option value="<>'';�G�w�C�L">�w�C�L</option>
        <option value="<>'*';�G����">����</option>
      </select>    </td></tr>
<tr><td class=dataListHead width="40%">�C�L�帹</td>
    <td width="60%" bgcolor="silver">
    <INPUT TYPE=TEXT NAME="search3" maxlength=9 size=9 class=dataListEntry >
    </td></tr>      
<tr><td class=dataListHead width="40%">�m�u�榬�󪬪p</td>
    <td width="60%" bgcolor="silver" >
    <select name="search6" size="1"  class=dataListEntry>
        <option value="<>'';�G�w����">�w����</option>
        <option value="='';�G������">������</option>
        <option value="<>'*';�G����">����</option>        
    </select>  
    </td></tr>     
<tr><td class=dataListHead width="40%">���ڤJ�b</td>
    <td width="60%"  bgcolor="silver" >
    <select name="search8" size="1"  class=dataListEntry>
        <option value="<>'';�G�w�J�b">�w�J�b</option>
        <option value="='';�G���J�b">���J�b</option>
        <option value="<>'*';�G����">����</option>        
    </select>  
    </td></tr>                      
<tr><td class=dataListHead width="40%">�|�p�f��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search7" size="1"  class=dataListEntry>
        <option value="='';�G���f��">���f��</option>
        <option value="<>'';�G�w�f��">�w�f��</option>
        <option value="<>'*';�G����">����</option>        
    </select>  
    </td></tr>                     
<tr><td class=dataListHead width="40%">�I�u���B</td>
    <td width="60%"  bgcolor="silver">
    <select name="search4" size="1"  class=dataListEntry>
        <option value=">;�G�j��" selected>�j��</option>
        <option value="<;�G�p��">�p��</option>
        <option value="=;�G����">����</option>
    </select>  
    <INPUT TYPE=TEXT NAME="search5" maxlength=5 size=9 value=0  class=dataListEntry>
    </td></tr>         
</table>
<table width="50%" align=right><tr><td></td><td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand"></td></tr></table>
</body>
</html>