<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�D���ظm�覡
    S19=""
    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='H8'",CONN
    s19="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s19=s19 &"<option value=""" &rs("CODE") & ";" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
    
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
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
     t=t &" and (RTSparq499CmtyH.ComN<> '*' )" 
  Else
     s=s &"  ���ϦW�١J�]�t('" &S1 & "'�r��)"
     t=t &" and (RTSparq499CmtyH.ComN LIKE '%" &S1 &"%')" 
  End If
  '----�D�u�˾��a�}
 ' S2=document.all("search2").value  
 ' If Len(s2)=0 Or s2="" Then
 ' Else
 '    s=s &"  �D�u�˾���}:�]�t('" &S2 & "'�r��) "
 '    t=t &" AND (RTCounty.CUTNC+RTSparq499CmtyLine.Township+RTSparq499CmtyLine.Raddr LIKE '%" &S2 &"%')" 
 ' End If
  '----�D�uIP
  s3=document.all("search3").value
  IF LEN(TRIM(S3)) > 0 THEN
     s=s &"  �D�uIP�J�]�t('" &s3 & "'�r��) "
     t=t &" AND (RTSparq499CmtyLine.LINEIPSTR1+'.'+RTSparq499CmtyLine.LINEIPSTR2+'.'+RTSparq499CmtyLine.LINEIPSTR3+'.'+RTSparq499CmtyLine.LINEIPSTR4 LIKE '%" & S3 & "%') "
  END IF
  '----�D�u�p��s��
  s4=document.all("search4").value
  If Len(trim(s4)) > 0 Then
     s=s &"  �p��s���J�]�t('" &s4 & "'�r��) "
     t=t &" AND (RTSparq499CmtyLine.CHTWORKINGNO LIKE '%" & S4 & "%') "
  End If    
  '----�D�u�����q��
  s5=document.all("search5").value
  If Len(trim(s5)) > 0 Then
     s=s &"  �����q�ܡJ�]�t('" &s5 & "'�r��) "
     t=t &" AND (RTSparq499CmtyLine.LINETEL LIKE '%" & S5 & "%') "
  End If      
  '----�D�u�i�ת��p
  s7ary=split(document.all("search7").value,";")  
  If Len(trim(s7ary(0)))=0 Or s7ary(0)="" Then
  Elseif s7ary(0)="1" then
  '�w�ɹ�i�ظm(�ɹ��<>�ť� and �ӽФ�=�ť�)
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.INSPECTDAT is NOT null AND RTSparq499CmtyLine.AGREE='Y' AND RTSparq499CmtyLine.adslapplyDAT is null) "
  Elseif s7ary(0)="1" then
  '�w�ӽ�(�ӽФ�<>�ť� and ip =�ť� )
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslapplyDAT is not null) AND RTSparq499CmtyLine.LINEIPSTR1='' "     
  elseif s7ary(0)="2" then
  '�w�ֵoip(ip <>�ť� and ����=�ť�)
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.LINEIPSTR1 <> '' AND RTSparq499CmtyLine.LINEtel =''  )  " 
  elseif s7ary(0)="3" then
  '�w���o����(����<>�ť� and ���q��=�ť�)
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.LINEtel <> '' AND RTSparq499CmtyLine.adslopendat IS NULL ) " 
  elseif s7ary(0)="4" then
  '�D�u�w���q(adslopendat <> �ť� and �h���� = �ť� and �@�o�� = �ť�)
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslopendat  is not null AND RTSparq499CmtyLine.dropdat is null ) " 
  elseif s7ary(0)="5" then
  '�D�u�w�h��(adslopendat <> �ť� and �h���� <> �ť� )
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.adslopendat  is not null AND RTSparq499CmtyLine.dropdat is not null ) "      
  elseif s7ary(0)="6" then
  '�D�u�w�@�o(�@�o�� <> �ť� )
     s=s &"  �i�ת��p�J" &s7ary(1)
     t=t &" AND (RTSparq499CmtyLine.canceldat  is not null ) "           
 End If        
  '----�O�_�i�ظm
  s8ary=split(document.all("search8").value,";")  
  If Len(trim(s8ary(0)))=0 Or s8ary(0)="" Then
  Elseif s8ary(0)="Y" then
     s=s &"  �O�_�i�ظm�J" &s8ary(1)
     t=t &" AND (RTSparq499CmtyLine.agree='Y') "
  elseif s8ary(0)="N" then
     s=s &"  �O�_�i�ظm�J" &s8ary(1)
     t=t &" AND (RTSparq499CmtyLine.agree='N') " 
  elseif s8ary(0)="B" then
      s=s &"  �O�_�i�ظm�J" &s8ary(1)
     t=t &" AND (RTSparq499CmtyLine.agree='') "  
  End If      
  '�Τ�W��
  s9=document.all("search9").value 
  if  Len(trim(s9))=0 Or s9="" then
  else
     s=s & " �Τ�W�١J�]�t('" & s9 & "')�r�� "
     t=t & " and (RTSparq499Cust.cusnc like '%" & s9 & "%') "
  end if
  '----avsú�ڤ覡
  s11ary=split(document.all("search11").value,";")  
  If Len(trim(s11ary(0)))=0 Or s11ary(0)="" Then
  Else
     s=s &"  ú�ڤ覡�J" &s11ary(1)
     t=t &" AND (RTSparq499Cust.paytype='" & s11ary(0) & "') "
  End If 
  '�p���q��
  s12=document.all("search12").value 
  if  Len(trim(s12))=0 Or s12="" then
  else
     s=s & " �p���q�ܡJ�]�t('" & s12 & "')�r�� "
     t=t & " and (RTSparq499Cust.contacttel + RTSparq499Cust.mobile like '%" & s12 & "%') "
  end if   
  '������/�νs
  s13=document.all("search13").value 
  if  Len(trim(s13))=0 Or s13="" then
  else
     s=s & " ������/�νs�J�]�t('" & s13 & "')�r�� "
     t=t & " and (RTSparq499Cust.socialid like '%" & s13 & "%') "
  end if     
  '----���ϧǸ�
  s16=document.all("search16").value
  If Len(trim(s16)) > 0 Then
     s=s &"  ���ϧǸ��J('" &s16 & "') "
     t=t &" AND (RTSparq499Cust.COMQ1=" & S16 & ") "
  End If   
  '----�D�u�Ǹ�
  s17=document.all("search17").value
  If Len(trim(s17)) > 0 Then
     s=s &"  �D�u�Ǹ��J('" &s17 & "') "
     t=t &" AND (RTSparq499Cust.LINEQ1=" & S17 & ") "
  End If            
  '----�Τ�i�ת��p
  s18ary=split(document.all("search18").value,";")  
  If Len(trim(s18ARY(0))) = 0 Then
  '�|�����oIP(���@�o�ΰh��)
  ELSEIF s18ARY(0) = "1" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND (RTSparq499Cust.CUSTIP1 ='' ) AND RTSparq499Cust.CANCELDAT IS NULL AND RTSparq499Cust.DROPDAT IS NULL "
  '�w���oIP�A�|�����u
  ELSEIF s18ARY(0) = "2" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND (RTSparq499Cust.CUSTIP1 <>'' ) AND RTSparq499Cust.FINISHDAT IS NULL "     
  '�w���u�A�|������
  ELSEIF s18ARY(0) = "3" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND RTSparq499Cust.FINISHDAT IS NOT NULL AND  RTSparq499Cust.DOCKETDAT IS NULL "      
  '�w�����A�|������
  ELSEIF s18ARY(0) = "4" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND RTSparq499Cust.DOCKETDAT IS NOT NULL AND  RTSparq499Cust.TRANSDAT IS NULL "               
  '�w�h��
  ELSEIF s18ARY(0) = "5" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND  RTSparq499Cust.dropdat IS NOT NULL AND RTSparq499Cust.docketdat IS not NULL "       
  '�w�@�o
  ELSEIF s18ARY(0) = "6" THEN
     s=s &"  �Τ�i�סJ('" &s18ARY(1) & "') "
     t=t &" AND  RTSparq499Cust.CANCELDAT IS NOT NULL "                 
  End If              
  '----�Τ�IP
  s19=document.all("search19").value
  If Len(trim(s19)) > 0 Then
     s=s &"  �Τ�IP�J�]�t('" &s19 & "') "
     t=t &" AND (RTSparq499Cust.CUSTIP1+'.'+RTSparq499Cust.CUSTIP2+'.'+RTSparq499Cust.CUSTIP3+'.'+RTSparq499Cust.CUSTIP4 LIKE '%" & S19 & "%') "
  End If            


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
<tr><td class=dataListHead width="40%">����/�D�u�Ǹ�</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="5" name="search16" class=dataListEntry ID="Text5"> 
      <font size=2>-</font>
      <input type="text" size="5" name="search17" class=dataListEntry ID="Text6"> 
    </td></tr>  
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search9" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�Τ�IP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="15" name="search19"  class=dataListEntry ID="Text4"> 
    </td></tr>
<tr><td class=dataListHead width="40%">�Τ�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search18" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�|�����oIP">�|�����oIP</option>
        <option value="2;�w���oIP�A�|�����u">�w���oIP�A�|�����u</option>
        <option value="3;�w���u�A�|������">�w���u�A�|������</option>
        <option value="4;�w�����A�|������">�w�����A������</option>      
        <option value="5;�w�h��">�w�h��</option>      
        <option value="6;�w�@�o">�w�@�o</option>                     
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="40%">ú�ڤ覡</td>
    <td width="60%" bgcolor="silver">
     <select name="search11" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="01;�~���~ú�A�K�]�w�O�ί��O�E��">�~���~ú�A�K�]�w�O�ί��O�E��</option>
        <option value="02;�~����ú�A�K�]�w�O">�~����ú�A�K�]�w�O</option>
        <option value="03;�@���ú">�@���ú</option>                
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
<tr><td class=dataListHead width="40%">�D�u�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="0;�w�ɬd���i�ظm">�w�ɬd���i�ظm</option>
        <option value="1;�w�ӽ�">�w�ӽ�</option>
        <option value="2;�w�ֵoIP">�w�ֵoIP</option>
        <option value="3;�w���o�����q��">�w���o�����q��</option>                
        <option value="4;�D�u�w���q">�D�u�w���q</option>    
        <option value="5;�D�u�w�h��">�D�u�w�h��</option>  
        <option value="6;�D�u�w�@�o">�D�u�w�@�o</option>      
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