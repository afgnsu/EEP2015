
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
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="15" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�ӽ����O</td>
    <td width="60%" bgcolor="silver" >
      <select name="search8" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="A1;���ɫ�599">�P�@�N</option>
        <option value="A2;���ɫ�399">���P�N</option>
        <option value="A3;">�ȡ@�w</option>        
        <option value=";���f��">���f��</option>
      </select>
    </td></tr>  
<tr><td class=dataListHead width="40%">�ӽЪ��A</td>
    <td width="60%" bgcolor="silver" >
      <select name="search8" size="1" class=dataListEntry>
        <option value="*;����" selected>����</option>
        <option value="Y;�P�N">�P�@�N</option>
        <option value="N;���P�N">���P�N</option>
        <option value="H;�Ƚw">�ȡ@�w</option>        
        <option value=";���f��">���f��</option>
      </select>
    </td></tr>       
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>