<% DFTYEAR = datepart("yyyy",NOW())
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
  s1=document.all("search1").value
  if len(trim(s1)) = 0 then
     msgbox ("�п�J�ؼЦ~��!")
  elseif len(trim(s1)) < 4 then
     msgbox ("�~�׸�Ʀ��~!")
  else
     t=t & " rtteamgoal.nyy =" & s1 & "  "
     s=s & "�~��:" & s1 & "  "
  
     s2=document.all("search2").value
     s2ary=split(s2,";")
     if trim(s2ary(0)) = "" then
        s="  �~�ȲէO�G" & s2ary(2) & "  "
     else
        s=s & "  �~�ȲէO�G" & s2ary(2)
        t=t & " and rtteamgoal.areaid='" & s2ary(0) & "' and rtteamgoal.groupid='" & s2ary(1) & "' "
     end if  
     s3=document.all("search3").value
     s3ary=split(s3,";")
     s=s & "  ��סG" & s3ary(1)
     '399
     if s3ary(0)="1" then
        t=t & " and rtteamgoal.product='001' "
     '599
     elseif s3ary(0)="2" then
        t=t & " and rtteamgoal.product='002' "
     '899
     elseif s3ary(0)="3" then
        t=t & " and rtteamgoal.product='003' "
     end if
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
  window.close
End Sub
-->
</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<body>
<center>
<table width="80%">
  <tr class=dataListTitle align=center>�п�J(���)�~�Z�ؼи�Ʒj�M����</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="30%">�~��(�褸�~)</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search1" size="4" maxlength="15" class=dataListEntry value="<%=DFTYEAR%>">
    </td></tr>
<tr><td class=dataListHead width="30%">�~�ȲէO</td>
    <td width="70%" bgcolor="silver" >
<%
    Dim rs,i,conn,s
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open  "SELECT AREAID, GROUPID, CUSTYID, GROUPNC FROM RTSalesGroup where custyid='02' " _
            &"ORDER BY AREAID,GROUPNC ",conn
    s="<option value="";;����"" selected>����</option>" &vbCrLf
    Do While Not rs.Eof
       s=s &"<option value=""" & rs("areaid") & ";" & rs("groupid") & ";" & rs("groupnc") & """>" _
                             &rs("groupnc") &"</option>" &vbCrLf
       rs.MoveNext
    Loop 
    rs.Close  
    conn.Close
    set rs=nothing
    set conn=nothing  
%>    
      <select name="search2" size="1" class=dataListEntry>
        <%=S%>
      </select>
    </td></tr>        

<tr><td class=dataListHead width="30%">���</td>
    <td width="70%"  bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;399���">399���</option>
        <option value="2;599���">599���</option>
        <option value="3;899���">899���</option>        
      </select>
     </td>
</tr>    
</table>
<table width="80%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>