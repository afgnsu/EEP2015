<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�j�L�g�P��
    S6=""
    SQLXX="SELECT RTConsignee.CUSID, RTObj.SHORTNC FROM RTConsignee INNER JOIN  RTConsigneeISP ON " _
          &"RTConsignee.CUSID = RTConsigneeISP.CUSID INNER JOIN RTObj ON RTConsignee.CUSID = RTObj.CUSID " _
          &"WHERE (RTConsigneeISP.ISP = '03') ORDER BY  RTObj.SHORTNC "
    rs.Open SQLXX,CONN
    s6="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s6=s6 &"<option value=""" &rs("CUSID") & ";" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'-----------�}�o�~��
    S7=""
    SQLXX="SELECT RTEmployee.EMPLY, RTObj.CUSNC FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
          &"WHERE (RTEmployee.DEPT IN ('B100', 'B106', 'B107', 'B200', 'B300', 'B401','B600')) AND (RTEmployee.TRAN2 <> '10') AND " _
          &"(RTEmployee.AUTHLEVEL = '2') ORDER BY  RTObj.CUSNC "
    rs.Open SQLXX,CONN
    s7="<option value="";����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s7=s7 &"<option value=""" &rs("EMPLY") & ";" & rs("CUSNC") & """>" &rs("CUSNC") &"</option>"
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
  '---�Τ�W��
  S1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     t=t &" (KTSwantgoCUST.CUSNC<> '*' )" 
  Else
     s=s &"  �Τ�W��:�]�t('" &S1 & "'�r��)"
     t=t &" (KTSwantgoCUST.CUSNC LIKE '%" &S1 &"%')" 
  End If
  '---NCIC�Τ�s��
  S2=document.all("search2").value  
  If Len(TRIM(s2)) > 0 Then
     s=s &"  NCIC�Τ�s��:�]�t('" &S2 & "'�r��)"
     t=t &" AND (KTSwantgoCUST.NCICCUSID LIKE '%" &S2 &"%')" 
  End If
  '---�Τ�νs
  S3=document.all("search3").value  
  If Len(TRIM(s3)) > 0 Then
     s=s &"  �Τ�νs:�]�t('" &S3 & "'�r��)"
     t=t &" AND (KTSwantgoCUST.SOCIALID LIKE '%" &S3 &"%')" 
  End If
  '---�w�˦a�}
  S4=document.all("search4").value  
  If Len(TRIM(s3)) > 0 Then
     s=s &"  �w�˦a�}:�]�t('" &S4 & "'�r��)"
     t=t &" AND (RTCOUNTY.CUTNC + KTSwantgoCUST.TOWNSHIP3+KTSwantgoCUST.RADDR3 LIKE '%" &S4 &"%')" 
  End If  
  '---�q��(�]�t���q�q�ܡB���q�ǯu�B�p���H�q�ܡB�p���H��ʹq�ܡB�p���H�ǯu)
  S5=document.all("search5").value  
  If Len(TRIM(s5)) > 0 Then
     s=s &"  �q��:�]�t('" &S5 & "'�r��)"
     t=t &" AND ( (KTSwantgoCUST.COTEL11 + KTSwantgoCUST.COTEL12 LIKE '%" &S5 &"%') OR (KTSwantgoCUST.COFAX11 + KTSwantgoCUST.COFAX12 LIKE '%" &S5 &"%') OR " _
         &"   (KTSwantgoCUST.COCONTACTTEL11 + KTSwantgoCUST.COCONTACTTEL12+COCONTACTTEL13 LIKE '%" &S5 &"%') OR (KTSwantgoCUST.COCONTACTFAX11 + KTSwantgoCUST.COCONTACTFAX12 LIKE '%" &S5 &"%' ) OR " _
         &"   (KTSwantgoCUST.COCONTACTMOBILE  LIKE '%" &S5 &"%') )" 
  End If    
  '---�j�L�g�P��
  S6=SPLIT(document.all("search6").value,";")
  If Len(TRIM(s6(0))) > 0 Then
     s=s &"  �j�L�g�P��:�]�t('" &S6(1) & "'�r��)"
     t=t &" AND ( KTSwantgoCUST.CONSIGNEE1 LIKE '%" &S6(0) &"%')" 
  End If    
  '---�p�L�g�P��
  S7=SPLIT(document.all("search7").value,";")
  If Len(TRIM(s7(0))) > 0 Then
     s=s &"  �p�L�g�P��:�]�t('" &S7(1) & "'�r��)"
     t=t &" AND ( KTSwantgoCUST.CONSIGNEE2 LIKE '%" &S7(0) &"%')" 
  End If      
  '---�}�o�~��
  S8=SPLIT(document.all("search8").value,";")
  If Len(TRIM(s8(0))) > 0 Then
     s=s &"  �}�o�~�ȭ�:�]�t('" &S8(1) & "'�r��)"
     t=t &" AND ( KTSwantgoCUST.EMPLY LIKE '%" &S8(0) &"%')" 
  End If        
  '---�X���_���
  S9=document.all("search9").value
  S10=document.all("search10").value
  IF LEN(TRIM(S9)) > 0 OR LEN(TRIM(S9)) > 0 THEN
     IF LEN(TRIM(S9))=0 THEN
        S9="1900/01/01 00:00:00"
     END IF
     IF LEN(TRIM(S10))=0 THEN
        S10="9999/12/31 11:59:59"
     END IF
     s=s &"  �X���_���:��( " &S9 & " �� " & S10 & " )"
     t=t &" AND ( KTSwantgoCUST.CONTRACTSTRDAT >= '" &S9 &"' AND KTSwantgoCUST.CONTRACTSTRDAT <='" & S10 & "' )" 
  END IF
  '---�Τ�ӽжi��
  S11=SPLIT(document.all("search11").value,";")
  IF LEN(TRIM(S11(0))) > 0 THEN
     '�|���e��ӽ�
     IF S11(0)="1" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NULL AND KTSwantgoCUST.DROPDAT IS NULL AND KTSwantgoCUST.APPLYDAT IS NULL )" 
     '�w�ӽЩ|�����oNCIC�Τ�s��
     ELSEIF S11(0)="2" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NULL AND KTSwantgoCUST.DROPDAT IS NULL AND KTSwantgoCUST.APPLYDAT IS NOT NULL )" 
     '�w���oNCIC�Τ�s���|�����u
     ELSEIF S11(0)="3" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NULL AND KTSwantgoCUST.DROPDAT IS NULL AND KTSwantgoCUST.NCICCUSID <>'' AND KTSwantgoCUST.FINISHDAT IS NULL )" 
     '�w���u������
     ELSEIF S11(0)="4" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NULL AND KTSwantgoCUST.DROPDAT IS NULL  AND KTSwantgoCUST.FINISHDAT IS NOT NULL AND KTSwantgoCUST.FINISHDAT IS  NULL )"  
     '�w����������
     ELSEIF S11(0)="5" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NULL AND KTSwantgoCUST.DROPDAT IS NULL  AND KTSwantgoCUST.FINISHDAT IS NOT NULL AND KTSwantgoCUST.TRANSDAT IS  NULL )"  
     '�w�h��
     ELSEIF S11(0)="6" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.DROPDAT IS NOT NULL )"  
     '�w�@�o
     ELSEIF S11(0)="7" THEN
        s=s &"  �ӽжi��:" &S11(1) & "  "
        t=t &" AND ( KTSwantgoCUST.CANCELDAT IS NOT NULL )"  
     END IF
  END IF
  '---���T�Գ檬�p
  S12=SPLIT(document.all("search12").value,";")
  IF LEN(TRIM(S12(0))) > 0 THEN
    '�w�Գ�
     IF S12(0)="1" THEN
        s=s &"  ���T�Գ檬�p:" &S12(1) & "  "
        t=t &" AND ( KTSwantgoCUST.cbbnpulldat IS not NULL  )" 
     '���Գ�
     ELSEIF S12(0)="2" THEN
        s=s &"  ���T�Գ檬�p:" &S12(1) & "  "
        t=t &" AND ( KTSwantgoCUST.cbbnpulldat IS NULL )" 
     end if
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
   Sub ImageIconOver()
       self.event.srcElement.style.borderBottom = "black 1px solid"
       self.event.srcElement.style.borderLeft="white 1px solid"
       self.event.srcElement.style.borderRight="black 1px solid"
       self.event.srcElement.style.borderTop="white 1px solid"   
   End Sub
   
   Sub ImageIconOut()
       self.event.srcElement.style.borderBottom = ""
       self.event.srcElement.style.borderLeft=""
       self.event.srcElement.style.borderRight=""
       self.event.srcElement.style.borderTop=""
   End Sub       
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="search" & clickid    
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
       end if
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
  <tr class=dataListTitle align=center>KTS�Τ��Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="30" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">NCIC�Τ�s��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="15" name="search2" class=dataListEntry> 
    </td></tr>  
<tr><td class=dataListHead width="40%">�Τ�νs</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search3" class=dataListEntry ID="Text1"> 
    </td></tr>      
<tr><td class=dataListHead width="40%">�w�˦a�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search4" class=dataListEntry ID="Text2"> 
    </td></tr>      
<tr><td class=dataListHead width="40%">�q��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="10" name="search5" class=dataListEntry ID="Text3"> 
    </td></tr>   
<tr><td class=dataListHead width="40%">�j�L�g�P��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search6" size="1" class=dataListEntry ID="Select2">
       <%=S6%>
      </select>
     </td>
</tr>       
<tr><td class=dataListHead width="40%">�p�L�g�P��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search7" size="1" class=dataListEntry ID="Select3">
       <%=S6%>
      </select>
     </td>
</tr>        
<tr><td class=dataListHead width="40%">�}�o�~�ȭ�</td>
    <td width="60%"  bgcolor="silver">
      <select name="search8" size="1" class=dataListEntry ID="Select4">
       <%=S7%>
      </select>
     </td>
</tr>        
<tr><td class=dataListHead width="40%">�X���_���</td>
    <td width="60%"  bgcolor="silver">
      <input type="text" name="search9" size="10"  class="dataListentry" ID="Text56">
         <input type="button" id="B9"  name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C9"  name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
        <font size=3>-</font>
         <input type="text" name="search10" size="10"  class="dataListentry" ID="Text4">
         <input type="button" id="B10"  name="B10" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
        <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">     
     </td>
</tr>        
<tr><td class=dataListHead width="40%">�Τ�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="1;�|���e��ӽ�">�|���e��ӽ�</option>
        <option value="2;�w�ӽЩ|�����oNCIC�Τ�s��">�w�ӽЩ|�����oNCIC�Τ�s��</option>
        <option value="3;�w���oNCIC�Τ�s���|�����u">�w���oNCIC�Τ�s���|�����u</option>                
        <option value="4;�w���u������">�w���u������</option>
        <option value="5;�w����������">�w����������</option>      
        <option value="6;�w�h��">�w�h��</option>      
        <option value="7;�w�@�o">�w�@�o</option>                     
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="40%">���T�Գ檬�p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search12" size="1" class=dataListEntry ID="Select5">
        <option value=";����" selected>����</option>
        <option value="1;�w�Գ�">�w�Գ�</option>
        <option value="2;���Գ�">���Գ�</option>
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