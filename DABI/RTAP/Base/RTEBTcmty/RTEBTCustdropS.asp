
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '----���ϧǸ�
  s1=document.all("search1").value
  If Len(trim(s1)) > 0 Then
     s=s &"  ���ϧǸ�:('" &s1 & "') "
     t=t &" (RTEBTCUSTdrop.COMQ1=" & S1 & ") "
  ELSE
     t=t &" (RTEBTCUSTdrop.COMQ1 <> 0 ) "
  End If   
  '----�D�u�Ǹ�
  s2=document.all("search2").value
  If Len(trim(s2)) > 0 Then
     s=s &"  �D�u�Ǹ�:('" &s2 & "') "
     t=t &" AND (RTEBTCUSTdrop.LINEQ1=" & S2 & ") "
  End If              
  '----���ϦW��
  S3=document.all("search3").value  
  If Len(s3)=0 Or s3="" Then
  Else
     s=s &"  ���ϦW��:�]�t('" &S3 & "'�r��)"
     t=t &" AND (RTEBTCmtyH.ComN LIKE '%" &S3 &"%')" 
  End If
  '�Τ�W��
  s4=document.all("search4").value 
  if  Len(trim(s4))=0 Or s4="" then
  else
     s=s & " �Τ�W�١J�]�t('" & s4 & "')�r�� "
     t=t & " and (rtebtcust.cusnc like '%" & s4 & "%') "
  end if
  '�Τ�X���s��
  s5=document.all("search5").value 
  if  Len(trim(s5))=0 Or s5="" then
  else
     s=s & " �X���s���J�]�t('" & s5 & "')�r�� "
     t=t & " and (rtebtcust.avsno like '%" & s5 & "%') "
  end if  
 '�p���q��
  s6=document.all("search6").value 
  if  Len(trim(s6))=0 Or s6="" then
  else
     s=s & " �p���q�ܡJ�]�t('" & s6 & "')�r�� "
     t=t & " and (rtebtcust.contacttel + rtebtcust.mobile like '%" & s6 & "%') "
  end if   
  '������/�νs
  s7=document.all("search7").value 
  if  Len(trim(s7))=0 Or s7="" then
  else
     s=s & " ������/�νs�J�]�t('" & s7 & "')�r�� "
     t=t & " and (rtebtcust.socialid like '%" & s7 & "%') "
  end if     
  '����u�渹
  s9=document.all("search9").value 
  if  Len(trim(s9))=0 Or s9="" then
  else
     s=s & " ����u�渹�J�]�t('" & s9 & "')�r�� "
     t=t & " and (rtebtcustdropsndwork.prtno like '%" & s9 & "%') "
  end if   
  '-����i��
  s10ary=split(document.all("search10").value,";")  
  If Len(trim(s10ARY(0))) = 0 Then
  '�w���
  ELSEIF s10ARY(0) = "1" THEN
     s=s &"  ����i��:('" &s10aRY(1) & "') "
     t=t &" AND (RTEBTCUSTdrop.FINISHCHKDAT is not null ) "    
  '�w���u�|�����
  ELSEIF s10ARY(0) = "2" THEN
     s=s &"  ����i��:('" &s10aRY(1) & "') "
     t=t &" AND (RTEBTCUSTdropsndwork.prtno <> '' ) AND (RTEBTCUSTdrop.FINISHCHKDAT is null ) "         
  '�|�����u
  ELSEIF s10ARY(0) = "3" THEN
     s=s &"  ����i��:('" &s10aRY(1) & "') "
     t=t &" AND (RTEBTCUSTdropsndwork.prtno = '' ) "              
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
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub
-->
</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"       codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<body>
<table width="100%">
  <tr class=dataListTitle align=center>AVS�Τ�h����Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">����/�D�u�Ǹ�</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="5" name="search1" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search2" class=dataListEntry ID="Text6"> 
    </td></tr>  
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search4" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�Τ�X���s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry> 
    </td></tr>  
<tr><td class=dataListHead width="40%">�p���q��(�Φ��)</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search6" class=dataListEntry> 
    </td></tr>   
<tr><td class=dataListHead width="40%">�Τᨭ����/�νs</td>
    <td width="60%" bgcolor="silver">
      <input type="password" size="10" name="search7" class=dataListEntry> 
    </td></tr>          
<tr><td class=dataListHead width="40%">����u�渹</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="15" name="search9" class=dataListEntry ID="Text2"> 
    </td></tr>       
<tr><td class=dataListHead width="40%">�h������i��</td>
    <td width="60%" bgcolor="silver">
     <select name="search10" size="1" class=dataListEntry ID="Select2">
        <option value=";����" selected>����</option>
        <option value="1;�w���">�w���</option>
        <option value="2;�w���u�|�����">�w���u�|�����</option>
        <option value="3;�|�����u">�|�����u</option>
     </select>
    </td></tr>            

</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>