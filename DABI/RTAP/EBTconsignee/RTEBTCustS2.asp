<%
 '   Dim rs,i,conn
 '   Dim search1Opt,search2Opt,search6Opt, search12pt
 '   Set conn=Server.CreateObject("ADODB.Connection")
 '   conn.open "DSN=RTLib"
    
'    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�D���ظm�覡
'    S9=""
'    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='G4'",CONN
'    s9="<option value="";����"" selected>����</option>" &vbCrLf    
'    Do While Not rs.Eof
'       s9=s9 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
'       rs.MoveNext
'    Loop
'    rs.Close
'    
'    conn.Close
'    Set rs=Nothing
'    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '----���ϦW��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (RTEBTCmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW��:�]�t('" &S1 & "'�r��)"
     t=t &" (RTEBTCmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�u�˾��a�}
 ' S2=document.all("search2").value  
 ' If Len(s2)=0 Or s2="" Then
 ' Else
 '    s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
 '    t=t &" AND (RTCounty.CUTNC+RTEBTCmtyLINE.Township+rtEBTcmtyLINE.Raddr LIKE '%" &S2 &"%')" 
 ' End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP:�]�t('" &s3 & "'�r��) "
     t=t &" AND (RTEBTCMTYLINE.LINEIP LIKE '%" & S3 & "%') "
  END IF
  '----�D�u�p��s��
  s4=document.all("search4").value
  If Len(trim(s4)) > 0 Then
     s=s &"  �p��s��:�]�t('" &s4 & "'�r��) "
     t=t &" AND (RTEBTCMTYLINE.APPLYNO LIKE '%" & S4 & "%') "
  End If    
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q��:�]�t('" &s5 & "'�r��) "
     t=t &" AND (RTEBTCMTYLINE.LINETEL LIKE '%" & S5 & "%') "
  End If      
  '----�D�u�ӽЦC�L�渹
  s6=document.all("search6").value
  If Len(trim(s6)) > 0 Then
     s=s &"  �ӽЦC�L�渹:�]�t('" &s6 & "'�r��) "
     t=t &" AND (RTEBTCMTYLINE.APPLYPRTNO LIKE '%" & S6 & "%') "
  End If       
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")  
  If Len(trim(s7ary(0)))=0 Or s7ary(0)="" Then
  Elseif s7ary(0)="1" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTEBTCMTYLINE.UPDEBTCHKDAT is not null) "
  elseif s7ary(0)="2" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTEBTCMTYLINE.UPDEBTCHKDAT  is not null AND RTEBTCMTYLINE.LINEIP <>'' AND RTEBTCMTYLINE.LINETEL <>'' ) " 
  elseif s7ary(0)="3" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTEBTCMTYLINE.UPDEBTCHKDAT  is not null AND RTEBTCMTYLINE.LINEIP <>'' AND RTEBTCMTYLINE.LINETEL <>'' ) " 
  elseif s7ary(0)="4" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTEBTCMTYLINE.UPDEBTCHKDAT  is not null AND RTEBTCMTYLINE.LINEIP <>'' AND RTEBTCMTYLINE.LINETEL <>'' AND RTEBTCMTYLINE.HINETNOTIFYDAT IS NOT NULL) " 
  elseif s7ary(0)="5" then
     s=s &"  �i�ת��p:" &s7ary(1)
     t=t &" AND (RTEBTCMTYLINE.UPDEBTCHKDAT  is not null AND RTEBTCMTYLINE.LINEIP <>'' AND RTEBTCMTYLINE.LINETEL <>'' AND RTEBTCMTYLINE.HINETNOTIFYDAT IS NOT NULL AND RTEBTCMTYLINE.ADSLAPPLYDAT IS NOT NULL) " 
 End If        
  '----�O�_�i�ظm
  s8ary=split(document.all("search8").value,";")  
  If Len(trim(s8ary(0)))=0 Or s8ary(0)="" Then
  Elseif s8ary(0)="Y" then
     s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (RTEBTCMTYLINE.agree='Y') "
  elseif s8ary(0)="N" then
     s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (RTEBTCMTYLINE.agree='N') " 
  elseif s8ary(0)="B" then
      s=s &"  �O�_�i�ظm:" &s8ary(1)
     t=t &" AND (RTEBTCMTYLINE.agree='') "  
  End If      
  '�Τ�W��
  s9=document.all("search9").value 
  if  Len(trim(s9))=0 Or s9="" then
  else
     s=s & " �Τ�W�١J�]�t('" & s9 & "')�r�� "
     t=t & " and (rtebtcust.cusnc like '%" & s9 & "%') "
  end if
  '�Τ�X���s��
  s10=document.all("search10").value 
  if  Len(trim(s10))=0 Or s10="" then
  else
     s=s & " �X���s���J�]�t('" & s10 & "')�r�� "
     t=t & " and (rtebtcust.cusid like '%" & s10 & "%') "
  end if  
  '----avsú�ڤ覡
  s11ary=split(document.all("search11").value,";")  
  If Len(trim(s11ary(0)))=0 Or s11ary(0)="" Then
  Elseif s11ary(0)="1" then
     s=s &"  ú�ڤ覡:" &s11ary(1)
     t=t &" AND (RTEBTCust.paytype='Y') "
  elseif s11ary(0)="2" then
     s=s &"  ú�ڤ覡:" &s11ary(1)
     t=t &" AND (RTEBTCust.paytype='H') " 
  elseif s11ary(0)="3" then
     s=s &"  ú�ڤ覡:" &s11ary(1)
     t=t &" AND (RTEBTCust.paytype='M') "  
  End If 
  '�p���q��
  s12=document.all("search12").value 
  if  Len(trim(s12))=0 Or s12="" then
  else
     s=s & " �p���q�ܡJ�]�t('" & s12 & "')�r�� "
  '   t=t & " and (rtebtcust.contacttel + rtebtcust.mobile like '%" & s12 & "%') "
  end if   
  '������/�νs
  s13=document.all("search13").value 
  if  Len(trim(s13))=0 Or s13="" then
  else
     s=s & " ������/�νs�J�]�t('" & s13 & "')�r�� "
     t=t & " and (rtebtcust.socialid like '%" & s13 & "%') "
  end if     
  '�ªA�Ȩ����
  s14=document.all("search14").value 
  s15=document.all("search15").value   
  if  (Len(trim(s14))=0 Or s14="") and (Len(trim(s15))=0 Or s15="") then
  else
     if  (Len(trim(s14))=0 Or s14="") then s14="1900/01/01"
     if  (Len(trim(s15))=0 Or s15="") then s15="9999/12/31"
     s=s & " �ªA�Ȱ_����J��('" & s14 & "') �� ('" & s15 & "') "
     t=t & " and rtebtcust.oldservicecutdat >= '" & s14 & " 00:00.000' and rtebtcust.oldservicecutdat  <= '" & s15 & " 23:59.997' "
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
  <tr class=dataListTitle align=center>AVS�Τ��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search9" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�Τ�X���s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search10" class=dataListEntry> 
    </td></tr>  
<tr><td class=dataListHead width="40%">AVSú�ڤ覡</td>
    <td width="60%" bgcolor="silver">
     <select name="search11" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;�~���~ú">�~���~ú</option>
        <option value="2;�~����ú">�~����ú</option>
        <option value="3;��ú(��ñ��)">��ú(��ñ��)</option>                
     </select>
    </td></tr>        
<tr><td class=dataListHead width="40%">�p���q��(�Φ��)</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search12" class=dataListEntry> 
    </td></tr>   
<tr><td class=dataListHead width="40%">�Τᨭ����/�νs</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search13" class=dataListEntry> 
    </td></tr>          
<tr><td class=dataListHead width="40%">�ªA�Ȩ����</td>
    <td width="60%" bgcolor="silver"><font size=2>��</font>
      <input type="text" size="10" name="search14" class=dataListEntry> 
<input type="button" id="B14"  name="B14" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">      
      <font size=2>��</font>
      <input type="text" size="10" name="search15" class=dataListEntry> 
<input type="button" id="B15"  name="B15" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">            
    </td></tr>              
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
    <!--
<tr><td class=dataListHead width="40%">�D�u�˾���}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search2" class=dataListEntry> 
    </td></tr> -->
<tr><td class=dataListHead width="40%">�D�uIP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�D�u�p��s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="12" name="search4" class=dataListEntry ID="Text3"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�����q��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry ID="Text2"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�D�u�ӽЦC�L�渹</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search6" class=dataListEntry ID="Text4"> 
    </td></tr>       
<tr><td class=dataListHead width="40%">�D�u�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;�w�ӽ�">�w�ӽ�</option>
        <option value="2;�w�ֵoIP">�w�ֵoIP</option>
        <option value="3;�w���o�����q��">�w���o�����q��</option>                
        <option value="4;INET�w�q�����q">HINET�w�q�����q</option>
        <option value="5;�D�u�w���q">�D�u�w���q</option>      
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�O�_�i�ظm</td>
    <td width="60%"  bgcolor="silver">
      <select name="search8" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="Y;�i�ظm">�i�ظm</option>
        <option value="N;���i�ظm">���i�ظm</option>
        <option value="B;�|���ɹ�">�|���ɹ�</option>
      </select>
     </td>
</tr>
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>