
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
  '-----------------------------------------------------------------------------------
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " rtobj.cusnc like '%" & s2 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " rtcust.cusid <>'*'"
  end if  
  '-----------------------------------------------------------------------------------  
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s="  HN�p�渹�X�G�t('" & s3 & "')�r��"  
     t=t & " and rtCUST.cusno like '%" & s3 & "%'"
  else
     s=s & "  HN�p�渹�X�G����  "
     t=t & " and rtcust.cusNO <>'*'"
  end if  
  '-----------------------------------------------------------------------------------  
  s4=document.all("search4").value
  if len(trim(s4)) > 0 then
     s="  �Ȥ�a�}�G�t('" & s4 & "')�r��"  
     t=t & " and (rtcounty.cutnc + rtcust.township1 + rtcust.raddr1 )  like '%" & s4 & "%'"
  end if      
  '-----------------------------------------------------------------------------------  
  s5=document.all("search5").value
  S5ARY=SPLIT(S5,";")
  if len(trim(s5ARY(0))) > 0 then
     s="  �s���覡�G" & s5ARY(1) 
     IF S5ARY(0)="1" THEN '�p�q+����p
        t=t & " and (rtCUST.USEKIND IN ('�p�q��','�����p�q')) "
     ELSEIF S5ARY(0)="2" THEN '����p
        t=t & " and  (rtCUST.USEKIND IN ('�����p�q')) "
     ELSEIF S5ARY(0)="3" THEN '�p�q
        t=t & " and (rtCUST.USEKIND IN ('�p�q��')) "
     ELSEIF S5ARY(0)="4" THEN '��
        t=t & " and (rtCUST.USEKIND IN ('�����')) "
     END IF
  end if    
  '-----------------------------------------------------------------------------------
  s6=document.all("search6").value
  S6ARY=SPLIT(S6,";")
  if len(trim(s6ARY(0))) > 0 then
     s="  �Ȥ�O�_�w�M�P�h���G" & s6ARY(1) 
     IF S6ARY(0)="1" THEN		'����
        t=t 
     ELSEIF S6ARY(0)="2" THEN	'���M�P
        t=t & " and (rtCUST.DROPDAT is null or (rtCUST.DROPDAT is not null and OVERDUE ='Y')) "
     ELSEIF S6ARY(0)="3" THEN	'�w�M�P
        t=t & " and (rtCUST.DROPDAT is not null and OVERDUE <>'Y') "
     END IF
  end if    
  '=======================================================================================      
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
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">HN�p�渹�X</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="40%">�Ȥ�a�}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search4" size="40" maxlength="60" class=dataListEntry>
    </td></tr>        
<tr><td class=dataListHead width="40%">�s���覡</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�p�q+�����p�q">�p�q+�����p�q</option>
        <option value="2;�����p�q">�����p�q</option>
        <option value="3;�p�q��">�p�q��</option>        
        <option value="4;�����">�����</option>
      </select>
    </td></tr>        
<tr><td class=dataListHead width="40%">�O�_�w�M�P�h��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search6" size="1" class=dataListEntry>
        <option value="1;����" selected>����</option>
        <option value="2;���M�P">���M�P</option>
        <option value="3;�w�M�P">�w�M�P</option>        
      </select>
    </td></tr>        
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>