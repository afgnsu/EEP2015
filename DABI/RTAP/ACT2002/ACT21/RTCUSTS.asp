
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
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " HB2002ACT21.name like '%" & s2 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " HB2002ACT21.name <>'' "
  end if  
  s3=document.all("search3").value
  s4=document.all("search4").value  
  if len(trim(s3))= 0 then
     s3="2002/02/01"
  end if
  if len(trim(s4))=0 then
     s4="9999/12/31"
  end if  
  s=s & "  �ӽФ���J��('" & s3 & "')-('" & s4 & "')"  
  t=t & " and hb2002act21.edat >= '" & s3 & "' and hb2002act21.edat <='" & S4 & "' "
  
  s5=document.all("search5").value
  s5ary=split(s5,";")
  s=s & "  ��ƪ��A�G'" & s5ary(1) & "' "  
  '---�w�T�{
  if s5ary(0)="Y" then
     t=t & " and hb2002ACT21.cfmdat is not null and hb2002act21.dropdat is null "
  end if
  '---���T�{
  if s5ary(0)="Y" then
     t=t & " and hb2002ACT21.cfmdat is null and hb2002act21.dropdat is null "
  end if  
  '---�w�@�o
  if s5ary(0)="Y" then
     t=t & " and hb2002ACT21.dropdat is not null "
  end if  
  
  s6=document.all("search6").value
  if len(trim(s6)) > 0 then
     s=s & "  �Ȥ�a�}�G�t('" & s6 & "')�r��"  
     t=t & " and (RTCounty.CUTNC + HB2002ACT21.TOWNSHIP + HB2002ACT21.RADDR )  like '%" & s6 & "%'"
  end if      
  s7=document.all("search7").value  
  s7ary=split(s7,";")
  s=s & "  �ӽгt�v�G" & s7ary(1) & " " 
  if s7ary(0) <> "*" then
     t=t & " and (HB2002ACT21.casetype = '" & s7ary(0) & "') "
  end if
     
  s8=document.all("search8").value  
  s8ary=split(s8,";")
  s=s & "  �ӽ�IP�G" & s8ary(1) & " "      
  if s8ary(0) <> "*" then
     t=t & " and (HB2002ACT21.IPtype = '" & s8ary(0) & "') "
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
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�ӽФ��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
     <input type="button" id="B3"  name="B3" height="70%" width="70%" style="Z-INDEX: 1" value="..." onclick="SrBtnOnclick"> 
     <font size="2">��
    <input type=text name="search4" size="10" maxlength="10" class=dataListEntry>
     <input type="button" id="B4"  name="B4" height="70%" width="70%" style="Z-INDEX: 1" value="..." onclick="SrBtnOnclick"> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�ӽФ��</td>
    <td width="60%" bgcolor="silver" >
      <select name="search7" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="01;512K/64K">512K/64K</option>
        <option value="02;768K/128K">768K/128K</option>        
        <option value="03;1.5M/384K">1.5M/384K</option>    
        <option value="04;512K/512K">512K/512K</option>            
      </SELECT>  
      <select name="search8" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="01;1 IP">1 IP</option>
        <option value="02;8 IP">8 IP</option>        
        <option value="03;�ʺAIP">�ʺAIP</option>    
      </SELECT>        
    </td></tr>        
<tr><td class=dataListHead width="40%">��ƪ��A</td>
    <td width="60%" bgcolor="silver" >
      <select name="search5" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="Y;�w�T�{">�w�T�{</option>
        <option value="N;���T�{">���T�{</option>        
        <option value="D;�w�@�o">�w�@�o</option>    
      </SELECT>
    </td></tr>   
<tr><td class=dataListHead width="40%">�Ȥ�a�}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search6" size="40" maxlength="50" class=dataListEntry>
    </td></tr>         
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="button" value=" �d�� " class=dataListButton name="btn" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>