<%
srt1=""
srt1=srt1 &"<option value=""""></option>"
srt1=srt1 &"<option value=""RTLessorCMTYH.comn"">���ϦW��</option>"
srt1=srt1 &"<option value=""RTLessorCust.cusnc"">�Τ�W��</option>"
srt1=srt1 &"<option value=""addr"">�Τ�a�}</option>"
srt1=srt1 &"<option value=""RTLessorCust.duedat"">�����</option>"
srt1=srt1 &"<option value=""validdat"">�i�Τ��</option>"
srt2=""
srt2=srt2 &"<option value=""""></option>"
srt2=srt2 &"<option value=""RTLessorCMTYH.comn"">���ϦW��</option>"
srt2=srt2 &"<option value=""RTLessorCust.cusnc"">�Τ�W��</option>"
srt2=srt2 &"<option value=""addr"">�Τ�a�}</option>"
srt2=srt2 &"<option value=""RTLessorCust.duedat"">�����</option>"
srt2=srt2 &"<option value=""validdat"">�i�Τ��</option>"
srt3=""
srt3=srt3 &"<option value=""""></option>"
srt3=srt3 &"<option value=""RTLessorCMTYH.comn"">���ϦW��</option>"
srt3=srt3 &"<option value=""RTLessorCust.cusnc"">�Τ�W��</option>"
srt3=srt3 &"<option value=""addr"">�Τ�a�}</option>"
srt3=srt3 &"<option value=""RTLessorCust.duedat"">�����</option>"
srt3=srt3 &"<option value=""validdat"">�i�Τ��</option>"
srt4=""
srt4=srt4 &"<option value=""""></option>"
srt4=srt4 &"<option value=""RTLessorCMTYH.comn"">���ϦW��</option>"
srt4=srt4 &"<option value=""RTLessorCust.cusnc"">�Τ�W��</option>"
srt4=srt4 &"<option value=""addr"">�Τ�a�}</option>"
srt4=srt4 &"<option value=""RTLessorCust.duedat"">�����</option>"
srt4=srt4 &"<option value=""validdat"">�i�Τ��</option>"
srt5=""
srt5=srt5 &"<option value=""""></option>"
srt5=srt5 &"<option value=""RTLessorCMTYH.comn"">���ϦW��</option>"
srt5=srt5 &"<option value=""RTLessorCust.cusnc"">�Τ�W��</option>"
srt5=srt5 &"<option value=""addr"">�Τ�a�}</option>"
srt5=srt5 &"<option value=""RTLessorCust.duedat"">�����</option>"
srt5=srt5 &"<option value=""validdat"">�i�Τ��</option>"
srt99=""
srt99=srt99 &"<option value=""A"">�Ѥp��j�Ƨ�</option>"
srt99=srt99 &"<option value=""D"">�Ѥj��p�Ƨ�</option>"
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '----���ϦW��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (RTLessorCmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (RTLessorCmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND (RTLessorCmtyLINE.LINEIP LIKE '%" & S3 & "%') "
  end if
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q��:�]�t('" &s5 & "'�r��) "
     t=t &" AND (RTLessorCmtyLINE.LINETEL LIKE '%" & S5 & "%') "
  End If      
  '�Τ�W��
  s9=document.all("search9").value 
  if  Len(trim(s9))=0 Or s9="" then
  else
     s=s & " �Τ�W�١J�]�t('" & s9 & "')�r�� "
     t=t & " and (RTLessorCust.cusnc like '%" & s9 & "%') "
  end if
  '----ú�ڶg��
  s10ary=split(document.all("search10").value,";")  
  If Len(trim(s10ary(0)))=0 Or s10ary(0)="" Then
  Else
     s=s &"  ú�ڶg��:" &s10ary(1)
     t=t &" AND (RTLessorCust.paycycle='" & s10ary(0) & "') "
  End If   
  '----ú�ڤ覡
  s11ary=split(document.all("search11").value,";")  
  If Len(trim(s11ary(0)))=0 Or s11ary(0)="" Then
  Else
     s=s &"  ú�ڤ覡:" &s11ary(1)
     t=t &" AND (RTLessorCust.paytype='" & s11ary(0) & "') "
  End If 
  '�p���q��
  s12=document.all("search12").value 
  if  Len(trim(s12))=0 Or s12="" then
  else
     s=s & " �p���q�ܡJ�]�t('" & s12 & "')�r�� "
     t=t & " and ((RTLessorCust.contacttel like '%" & s12 & "%') OR (RTLessorCust.mobile like '%" & s12 & "%')) "
  end if   
  '������/�νs
  s13=document.all("search13").value 
  if  Len(trim(s13))=0 Or s13="" then
  else
     s=s & " ������/�νs�J�]�t('" & s13 & "')�r�� "
     t=t & " and (RTLessorCust.socialid like '%" & s13 & "%') "
  end if     
  '�����_��
  s14=document.all("search14").value 
  s15=document.all("search15").value   
  if  (Len(trim(s14))=0 Or s14="") and (Len(trim(s15))=0 Or s15="") then
  else
     if  (Len(trim(s14))=0 Or s14="") then s14="1900/01/01"
     if  (Len(trim(s15))=0 Or s15="") then s15="9999/12/31"
     s=s & " �Τ�����_���J��('" & s14 & "') �� ('" & s15 & "') "
     t=t & " and RTLessorCust.duedat >= '" & s14 & " 00:00.000' and RTLessorCust.duedat  <= '" & s15 & " 23:59.997' "
  end if               
  '----���ϧǸ�
  s16=document.all("search16").value
  If Len(trim(s16)) > 0 Then
     s=s &"  ���ϧǸ�:('" &s16 & "') "
     t=t &" AND (RTLessorCust.COMQ1=" & S16 & ") "
  End If   
  '----�D�u�Ǹ�
  s17=document.all("search17").value
  If Len(trim(s17)) > 0 Then
     s=s &"  �D�u�Ǹ�:('" &s17 & "') "
     t=t &" AND (RTLessorCust.LINEQ1=" & S17 & ") "
  End If            
  '----�Τ�i�ת��p
  s18ary=split(document.all("search18").value,";")  
  If Len(trim(s18ARY(0))) = 0 Then
 '�����u
  ELSEIF s18ARY(0) = "1" THEN
     s=s &"  �Τ�i��:('" &s18ARY(1) & "') "
     t=t &" AND (RTLessorCust.FINISHDAT IS NULL and RTLessorCust.dropdat is null and RTLessorCust.canceldat is null) "      
  '�w���u�L�p�O��
  ELSEIF s18ARY(0) = "2" THEN
     s=s &"  �Τ�i��:('" &s18ARY(1) & "') "
     t=t &" AND RTLessorCust.FINISHDAT IS NOT NULL AND  RTLessorCust.strbillingdat IS NULL "               
  '�w�h��
  ELSEIF s18ARY(0) = "3" THEN
     s=s &"  �Τ�i��:('" &s18ARY(1) & "') "
     t=t &" AND  RTLessorCust.dropdat IS NOT NULL AND RTLessorCust.strbillingdat IS not NULL "       
  '�w�@�o
  ELSEIF s18ARY(0) = "4" THEN
     s=s &"  �Τ�i��:('" &s18ARY(1) & "') "
     t=t &" AND  RTLessorCust.CANCELDAT IS NOT NULL AND RTLessorCust.finishdat IS NULL "                 
  End If              
  '�Ƨ�
  SRT1 =document.all("srt1X").value
  SRT2 =document.all("srt2X").value
  SRT3 =document.all("srt3X").value
  SRT4 =document.all("srt4X").value
  SRT5 =document.all("srt5X").value
  SRT99=document.all("srt99X").value
  srtx=""
  if Len(trim(srt1))> 0 then
     srtx=srtx & " order by " & srt1
  ELSE
     srtx=srtx & " order by RTLESSORCUST.COMQ1 "
  end if
  if Len(trim(srt2))> 0 then
     srtx=srtx & "," & srt2
  end if
  if Len(trim(srt3))> 0 then
     srtx=srtx & "," & srt3
  end if
  if Len(trim(srt4))> 0 then
     srtx=srtx & "," & srt4
  end if
  if Len(trim(srt5))> 0 then
     srtx=srtx & "," & srt5
  end if
  if srt99="D" THEN
     SRTX=SRTX & " DESC "
  END IF

  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=SRTX
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
  <tr class=dataListTitle align=center>ET-City�Τ��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="25%">����/�D�u�Ǹ�</td>
    <td width="75%" bgcolor="silver">
      <input type="text" size="5" name="search16" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search17" class=dataListEntry ID="Text6"> 
    </td></tr>  
<tr><td class=dataListHead >�Τ�W��</td>
    <td  bgcolor="silver">
      <input type="text" size="20" name="search9" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead >�Τ�i�ת��p</td>
    <td  bgcolor="silver">
      <select name="search18" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�����u">�����u</option>
        <option value="2;�w���u�L�p�O��">�w���u�L�p�O��</option>
        <option value="3;�w�h��">�w�h��</option>      
        <option value="4;�w�@�o">�w�@�o</option>                     
      </select>
     </td>
</tr>    
<tr><td class=dataListHead >ú�ڶg��</td>
    <td  bgcolor="silver">
     <select name="search10" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="05;�uú">�uú</option>
        <option value="01;�b�~ú">�b�~ú</option>
        <option value="02;�@�~ú">�@�~ú</option>     
        <option value="03;��~ú">��~ú</option> 
        <option value="04;�T�~ú">�T�~ú</option>            
     </select>
    </td></tr>        
<tr><td class=dataListHead >ú�ڤ覡</td>
    <td  bgcolor="silver">
     <select name="search11" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="02;�{��">�{��</option>
        <option value="01;�H�Υd">�H�Υd</option>
        <option value="03;ATM��b">ATM��b</option>                
     </select>
    </td></tr>            
<tr><td class=dataListHead >�p���q��(�Φ��)</td>
    <td bgcolor="silver">
      <input type="text" size="10" name="search12" class=dataListEntry> 
    </td></tr>   
<tr><td class=dataListHead >�Τᨭ����/�νs</td>
    <td  bgcolor="silver">
      <input type="text" size="10" name="search13" class=dataListEntry> 
    </td></tr>          
<tr><td class=dataListHead >�Τ�����</td>
    <td  bgcolor="silver"><font size=2>��</font>
      <input type="text" size="10" name="search14" class=dataListEntry> 
<input type="button" id="B14"  name="B14" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">      
      <font size=2>��</font>
      <input type="text" size="10" name="search15" class=dataListEntry> 
<input type="button" id="B15"  name="B15" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">            
    </td></tr>        
<tr><td class=dataListHead >���ϦW��</td>
    <td  bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead >�D�uIP</td>
    <td  bgcolor="silver">
      <input type="text" size="20" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>    
<tr><td class=dataListHead >�D�u�����q��</td>
    <td bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
    </td></tr>        
<tr><td class=dataListHead >��ƱƧ�</td>
    <td  bgcolor="silver">
    <select name="srt1X" size="1" class=dataListEntry>
        <%=srt1%>
    </select>
    <select name="srt2X" size="1" class=dataListEntry>
        <%=srt2%>
    </select>
    <select name="srt3X" size="1" class=dataListEntry>
        <%=srt3%>
    </select>
    <select name="srt4X" size="1" class=dataListEntry>
        <%=srt4%>
    </select>
    <select name="srt5X" size="1" class=dataListEntry>
        <%=srt5%>
    </select>
    <select name="srt99X" size="1" class=dataListEntry>
        <%=srt99%>
    </select>
    </td></tr>           
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>