<%
Edate=datevalue(now())
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
  if len(trim(s1)) > 0 then
     s="���ϦW�١G�t('" & s1 & "')�r��"  
     t=t & " rtcmty.comn like '%" & s1 & "%' "
  else
     s="���ϦW�١G����  "
     t=t & " rtcust.comq1 <> 0 "
  end if
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " and rtobj.cusnc like '%" & s2 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " and rtcust.cusid <>'*'"
  end if  
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s="  HN�p�渹�X�G�t('" & s3 & "')�r��"  
     t=t & " and rtCUST.cusno like '%" & s3 & "%'"
  else
     s=s & "  HN�p�渹�X�G����  "
     t=t & " and rtcust.cusNO <>'*'"
  end if    
  s4=document.all("search4").value  
  s4ary=split(s4,";")
  if s4ary(0)="1" then
     s=s & "  ���A�G����  "
  elseif s4ary(0)="2" then
     s=s & "  ���A�G�M�P  "
     t=t & " and rtcust.dropdat is not null and rtcust.finishdat is null "
  elseif s4ary(0)="3" then
     s=s & "  ���A�G�h��  "
     t=t & " and rtcust.dropdat is not null and rtcust.finishdat is NOT null "     
  end if
  s5=document.all("search5").value  
  s6=document.all("search6").value    
  if s5="" then s5="2000/01/01"
  if s6="" then s6="9999/12/31"
  s=s & "  �h��/�M�P����G" & s5 & " �� " & s6
  t=t & " and rtcust.dropdat >= '" & s5 & "' and rtcust.dropdat <= '" & s6 & "' "
  
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
<center>
<table width="70%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="15" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">HN�p�渹�X</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="40%">���A</td>
    <td width="60%" bgcolor="silver" >
      <select name="search4" size="1" class=dataListEntry>
        <option value="1;����" selected>����</option>
        <option value="2;�M�P">�M�P</option>
        <option value="3;�h��">�h��</option>
      </select>    
    </td></tr>     
<tr><td class=dataListHead width="40%">�M�P/�h�����</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search5" size="10" maxlength="10" class=dataListEntry  value="<%=Sdate%>">
    <input type="button" id="B5"  name="B5" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">         
    ��
    <input type=text name="search6" size="10" maxlength="10" class=dataListEntry  value="<%=edate%>">    
    <input type="button" id="B6"  name="B6" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">             
    </td></tr>    
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>