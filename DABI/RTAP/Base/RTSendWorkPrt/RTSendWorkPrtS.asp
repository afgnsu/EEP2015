<!-- #include virtual="/webap/include/lockright.inc" -->
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
'          s1= s1 & "<option value=""'" & rs("emply") & "';"  &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
'       rs.movenext
'       Loop                    
'--- ���⬰:�޳N��    
'    else
'------ �t��
       rs.Open "SELECT RTObj.CUSID, RTObj.CUSNC " _
              &"FROM RTObj INNER JOIN " _
              &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
              &"WHERE (RTObjLink.CUSTYID = '04') ",conn
       s1="<option value=""<>'*';����"" selected>����</option>" &vbCrLf           
       Do while not rs.EOF
          s1= s1 & "<option value=""'" & rs("cusid") & "';" &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
       rs.movenext
       Loop
       rs.Close       
'-------�޳N���H��
       rs.open "SELECT RTEmployee.emply, RTObj.CUSNC " _
              &"FROM RTEmployee INNER JOIN " _
              &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
              &"RTObjLink ON RTEmployee.CUSID = RTObjLink.CUSID AND rtobjlink.custyid = '08' " _
              &"and rtemployee.authlevel in ('4','5') ",conn   
       Do while not rs.EOF
          s1= s1 & "<option value=""'" & rs("emply") & "';" & "�G" &  rs("cusnc") & """>" & rs("CUsNC") & "</option>" & vbcrlf
       rs.movenext
       Loop        
       s1= s1 & "<option value=""*;�޳N���w��"">�޳N���w��</option>" & vbcrlf
'    end if
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
'�o�]����_��
Sdate=datevalue(now())-1
Edate=datevalue(now())
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  SDate=document.all("search4").value
  Edate=document.all("search5").value
  if Len(Trim(Sdate)) = 0 then
     document.all("search4").value = "2000/01/01"
  End if 
  if Len(Trim(Edate)) = 0 then
     document.all("search5").value = "9999/12/31"
  End if
  If Not IsDate(document.all("search4").value) or Not IsDate(document.all("search5").value) then
     msgbox "�q���o�]�������~�G����榡���~!"
  elseIf Sdate > Edate then
     msgbox "�q���o�]�������~�G�_��(" &Sdate & ")���p�󨴤�(" & EDate & ")!"
  Else  
    dim s,t
    t=""
    s=""
    s1ary=Split(document.all("search1").value,";")
    s="  �I�u�t�ӡG" & s1ary(1) 
  if s1ary(0) <> "<>'*'" and s1ary(0) <> "*" then 
     t=t & " and  a.reqdat is not null AND (a.profac=" & s1ary(0) & " or a.setsales in (" & s1ary(0) & ")) "
  elseif s1ary(0) = "*" then
     t=t & " and  a.reqdat is not null AND  a.settype in ('2') "
  end if  
  s2ary=Split(document.all("search2").value,";")
  s=s & "  ���u�i�ת��p�G" & s2ary(1)  
  '���u�i�ת��p�G�w�o�],���C�L,�����u
  if s2ary(0) ="0" then
     t=t & " and  (a.reqdat is not null and a.insprtdat is null and a.finishdat is null)"   
  '���u�i�ת��p�G�w�o�],���C�L�A�w���u
  elseif s2ary(0) ="1" then
     t=t & " and  (a.reqdat is not null and a.insprtdat is null and a.finishdat is not null)"        
  '���u�i�ת��p�G�w�o�],�w�C�L     
  elseif s2ary(0) = "2" then
     t=t & " and  (a.reqdat is not null and a.insprtdat is not null)"        
  '���u�i�ת��p�G�w�o�],�w�C�L,�����u    
  elseif s2ary(0) = "3" then
     t=t & " and  (a.reqdat is not null and a.insprtdat is not null and a.finishdat is null)"       
  '���u�i�ת��p�G���o�],�w�C�L      
  elseif s2ary(0) = "4" then
     t=t & " and  (a.reqdat is null and a.insprtdat is not null)" 
  '���u�i�ת��p�G���o�],�w���u      
  elseif s2ary(0) = "5" then
     t=t & " and  (a.reqdat is null and a.finishdat is not null)"            
  end if
  if len(trim(document.all("search3").value)) < 1 then
     s3="<>'*'"
     SPRTNO=""
  else
     S3="='" & document.all("search3").value & "'"
     SPRTNO=document.all("search3").value
  end if 
  t=t &" and a.reqdat between '" & document.all("search4").value + " 00:00:00.000 " & "' and '" & document.all("search5").value + " 23:59:59.999 " & "' "  
  s=s & "  ���u�渹�G" & sprtno & "  " & "  �o�]����G��(" & document.all("search4").value & ")��(" & document.all("search5").value & ")"
  t=t & " and a.insprtno" & s3 & ";" & sprtno & ";" & s2ary(0) & ";" & s1ary(0)
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
  end if
End Sub
Sub btn1_onClick()
  window.close
End Sub
-->
</script>
</head>
<body>
<center>
<table width="75%">
  <tr class=dataListTitle align=center>�п�J(���)RT���u��Ʒj�M����</td><tr>
</table>
<table width="75%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�I�u�t��</td>
    <td width="60%" bgcolor="silver">
      <select name="search1" size="1" class=dataListEntry >
        <%=S1%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">���u�i�ת��A</td>
    <td width="60%" bgcolor="silver">
      <select name="search2" size="1"  class=dataListEntry>
        <option value="0;�w�o�],���C�L" selected>�w�o�],���C�L,�����u</option>
        <option value="1;�w�o�],���C�L" >�w�o�],���C�L,�w���u</option>
        <option value="2;�w�o�],�w�C�L">�w�o�],�w�C�L</option>
        <option value="3;�w�o�],�w�C�L,�����u">�w�o�],�w�C�L,�����u</option>  
        <option value="4;���o�],�w�C�L" >���o�],�w�C�L</option>                      
        <option value="5;���o�],�w���u">���o�],�w���u</option>           
        <option value="9;����">����</option>
    </td>
</tr>
<tr><td class=dataListHead width="40%">�C�L�帹</td>
    <td width="60%"  bgcolor="silver">
    <INPUT TYPE=TEXT NAME="search3" maxlength=9 size=9 class=dataListEntry >
    </td></tr>      
<tr><td class=dataListHead width="40%">�o�]���</td>
    <td width="60%"  bgcolor="silver">
    <INPUT TYPE=TEXT NAME="search4" maxlength=10 size=10 class=dataListEntry value="<%=Sdate%>">
    ��
    <INPUT TYPE=TEXT NAME="search5" maxlength=10 size=10 class=dataListEntry value="<%=Edate%>">    
    </td></tr>          
</table>
<table width="75%" align=right><tr><td></td><td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>