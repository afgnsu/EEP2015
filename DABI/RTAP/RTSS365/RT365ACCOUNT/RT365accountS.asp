
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
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="  �Ȥ�W�١G�t('" & s1 & "')�r��"  
     t=t & " and rtobj.cusnc like '%" & s1 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
'     t=t & " and rtcustadsl.cusid <>''"
  end if  
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �����Ҧr���G�t('" & s2 & "')�r��"  
     t=t & " and rtCUSTadsl.socialid like '%" & s2 & "%'"
  else
     s=s & "  �����Ҧr���G����  "
 '    t=t & " and rtcustadsl.socialid <>'*'"
  end if    
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s="  �b���G�t('" & s3 & "')�r��"  
     t=t & " and rt365account.ss365account like '%" & s3 & "%'"
  else
     s=s & "  �b���G����  "
 '    t=t & " and rtcustadsl.socialid <>'*'"
  end if      
  s4=document.all("search4").value
  s4ary=split(s4,";")
  s=s & "  �b�����O�G'" & s4ary(1) & "'  "
  if s4ary(0)="*" then
     t=t & " and rt365ACCOUNT.TYPE<>'*' "
  else
     t=t & " and rt365ACCOUNT.TYPE='" & S4ARY(1) & "' "
  end if        
  s5=document.all("search5").value
  s5ary=split(s5,";")
  s=s & "  �b�����A�G'" & s5ary(1) & "'  "
  if s5ary(0)="*" then
  elseif s5ary(0)="Y" then
     t=t & " and rt365account.usedate iS not null "
  elseif s5ary(0)="H" then
     t=t & " and rt365account.usedate iS null "
  elseif s5ary(0)="D" then
     t=t & " and rt365account.dropdat iS not null "     
  end if        
  '�������
  s6=document.all("search6").value
  s7=document.all("search7").value  
  if len(trim(s6)) > 0 or len(trim(s7)) > 0 then 
     if len(trim(s6))= 0 then
        s6="2000/01/01"
     end if
     if len(trim(s7))=0 then
        s7="9999/12/31"
     end if
  t=t & " and rt365account.usedate >='" & s6 & "' and rt365account.usedate <= '" & s7 & "' "
  s=s & "  ������� : �� " & s6 & " �� " & s7      
  end if
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
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
  <tr class=dataListTitle align=center>�п�J(���)�b����Ʒj�M����</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="30%">�Ȥ�W��</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="30%">�����Ҧr��</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search2" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="30%">�b��</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
    </td></tr>        
<tr><td class=dataListHead width="30%">�b�����O</td>
    <td width="70%" bgcolor="silver" >
      <select name="search4" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="1;399">399</option>
        <option value="2;599">599</option>
        <option value="3;1199">1199</option>        
      </select>
    </td></tr>        
<tr><td class=dataListHead width="30%">�b�����A</td>
    <td width="70%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="Y;�w�ϥ�">�w�ϥ�</option>
        <option value="H;���ϥ�">���ϥ�</option>        
        <option value="D;�w���P">�w���P</option>
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="30%">�������</TD>
    <td width="70%"  bgcolor="silver">
    <input type=text name="search6" size="10" maxlength="10" class=dataListEntry>
    <input type="button" id="B6"  name="B6" height="70%" width="70%" style="Z-INDEX: 1" value="..." onclick="SrBtnOnclick"> 
        <font size="2">��
     <input type=text name="search7" size="10" maxlength="10" class=dataListEntry>
    <input type="button" id="B7"  name="B7" height="70%" width="70%" style="Z-INDEX: 1" value="..." onclick="SrBtnOnclick">      
     
     </td>
</tr>           
</table>
<table width="80%" align=right><tr><td></td><td align=right>
  <input type="button" value=" �d�� " class=dataListButton name="btn" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>