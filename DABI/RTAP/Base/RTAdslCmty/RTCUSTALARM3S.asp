
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
     s="  ���ϦW�١G�t('" & s1 & "')�r��"  
     t=t & " AND rtcustadslcmty.cOMN like '%" & s1 & "%'"
  else
     s=s & "  ���ϦW�١G����  "
     t=t & " AND rtcustadslcmty.COMN <>'*'"
  end if    
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " AND rtobj.cusnc like '%" & s2 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " AND rtcustADSL.cusid <>'*'"
  end if  
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s="  HN�p�渹�X�G�t('" & s3 & "')�r��"  
     t=t & " and rtCUSTADSL.cusno like '%" & s3 & "%'"
  else
     s=s & "  HN�p�渹�X�G����  "
     t=t & " and rtcustADSL.cusNO <>'*'"
  end if  
  s4=document.all("search4").value
  if len(trim(s4)) > 0 then
     s="  �˾��a�}�G�t('" & s4 & "')�r��"  
     t=t & " and (rtcounty.cutnc + rtcustADSL.township2 + rtcustADSL.raddr2 )  like '%" & s4 & "%'"
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
Sub btn1_onClick()
  window.close
End Sub
-->
</script>
</head>
<body>
<center>
<table width="70%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry ID="Text1">
    </td></tr>    
<tr><td class=dataListHead width="40%">HN�p�渹�X</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="40%">�˾��a�}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search4" size="40" maxlength="60" class=dataListEntry>
    </td></tr>        
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>