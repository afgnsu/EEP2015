
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"    codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  t=""
  T2=""
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s=" ���ϦW�١G�t('" & s1 & "')�r��"  
     t=t & " RTCMTY.comn like '%" & s1 & "%' "
     T2=T2 & " RTCUSTADSLCMTY.comn like '%" & s1 & "%' "
  else
     t=t & " RTCMTY.comq1 <> 0 "
     t2=t2 & " RTCUSTADSLCMTY.CUTYID <> 0 "
  end if
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s=" �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " and hbCUSTDROP.cusnc like '%" & s2 & "%'"
     t2=t2 & " and hbCUSTDROP.cusnc like '%" & s2 & "%'"
  end if  
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s=S & " �˾��a�}�G�t('" & s3 & "')�r��"  
     t=t & " and hbCUSTDROP.addr  like '%" & s3 & "%'"
     t2=t2 & " and hbCUSTDROP.addr  like '%" & s3 & "%'"     
  end if        
  s4=document.all("search4").value
  if len(trim(s4)) > 0 then
     s=S & " ����渹�G�t('" & s4 & "')�r��"  
     t=t & " and prtno  like '%" & s4 & "%'"
     t2=t2 & " and prtno  like '%" & s4 & "%'"
  end if      
  s5=document.all("search5").value
  if s5 <> "" then
     s=s & " ��סG" & s5
     t=t & " and hbCUSTDROP.casetype " & s5 & " "
     t2=t2 & " and hbCUSTDROP.casetype " & s5 & " "
  end if        
  s6=document.all("search6").value
  if s6 <> "" then
     s=s & " ���A�G" & s6
     t=t & " and hbCUSTDROP.status " & s6 & " "
     t2=t2 & " and hbCUSTDROP.status " & s6 & " "
  end if          
  s7=document.all("search7").value    
  s8=document.all("search8").value
  if isdate(s7) then
    if s7="" then s7="1911/1/1"
    if s8="" then s8="9999/12/31"      
     s=s & " �h��(�_��)��ۡJ" & s7 & " �� " & s8
     t=t & " and hbCUSTDROP.applydat >= '" & s7 & "' and applydat <='" & s8 & "' "
     t2=t2 & " and hbCUSTDROP.applydat >= '" & s7 & "' and applydat <='" & s8 & "' "
  end if
  s9=document.all("search9").value  
  iF s9 ="1" then
     s=s & " ������檬�p�J�w��� "
     t=t & " and hbCUSTDROP.actdrop is not null "
     t2=t2 & " and hbCUSTDROP.actdrop is not null "
  elseif s9 ="2" then
     s=s & " ������檬�p�J����� "
     t=t & " and hbCUSTDROP.actdrop is  null "
     t2=t2 & " and hbCUSTDROP.actdrop is  null "
  end if
  s10=document.all("search10").value  
  iF s10 ="1" then
     s=s & " MIS��s���p�J�w��s "
     t=t & " and hbCUSTDROP.UPDDATABASE ='Y' "
     t2=t2 & " and hbCUSTDROP.UPDDATABASE ='Y' "
  elseif s10 ="2" then
     s=s & " MIS��s���p�J����s "
     t=t & " and hbCUSTDROP.UPDDATABASE <>'Y' "
     t2=t2 & " and hbCUSTDROP.UPDDATABASE <>'Y'  "
  end if  
  s12=document.all("search12").value  
  iF s12 ="1" then
     s=s & " �������d�ߡJ�P�Nú�ڡB�|��ú�� "
     t=t & " and hbCUSTDROP.AGREEPAYDAT IS NOT NULL AND  hbCUSTDROP.ACTPAYDAT IS NULL "
     t2=t2 & " and hbCUSTDROP.AGREEPAYDAT IS NOT NULL AND  hbCUSTDROP.ACTPAYDAT IS NULL "
  elseif s12 ="2" then
     s=s & " �������d�ߡJ�����h���Ȥ� "
     t=t & " and hbCUSTDROP.OVERDUEDROP ='Y' "
     t2=t2 & " and hbCUSTDROP.OVERDUEDROP = 'Y'  "
  end if      
  s13=document.all("search13").value    
  s14=document.all("search14").value
  if isdate(s13) then
     if s13="" then s13="1911/1/1"
     if s14="" then s14="9999/12/31"      
     s=s & " ��ک�_��ۡJ" & s13 & " �� " & s14
     t=t & " and hbCUSTDROP.actdrop >= '" & s13 & "' and actdrop <='" & s14 & "' "
     t2=t2 & " and hbCUSTDROP.actdrop >= '" & s13 & "' and actdrop <='" & s14 & "' "
  end if  
  s15=document.all("search15").value  
  iF s10 ="1" then
     s=s & " �^��hinet���A�J�w�^�� "
     t=t & " and hbCUSTDROP.reportback is not null "
     t2=t2 & " and hbCUSTDROP.reportback is not null "
  elseif s10 ="2" then
     s=s & " �^��hinet���A�J���^�� "
     t=t & " and hbCUSTDROP.reportback is null  "
     t2=t2 & " and hbCUSTDROP.reportback is null  "
  end if    
   s11=document.all("search11").value  
  iF s11 ="1" then
     s=s & " �ȪACALLOUT���p�J�w���� "
     t=t & ";" & " having SUM(CASE WHEN HBCUSTDROPCALLOUT.SERNO IS NOT NULL THEN 1 ELSE 0 END) > 0 "
     t2=t2 & ";" & " having SUM(CASE WHEN HBCUSTDROPCALLOUT.SERNO IS NOT NULL THEN 1 ELSE 0 END) > 0 "
  elseif s11 ="2" then
     s=s & " �ȪACALLOUT���p�J������ "
     t=t & ";" & " having SUM(CASE WHEN HBCUSTDROPCALLOUT.SERNO IS NOT NULL THEN 1 ELSE 0 END) = 0 "
     t2=t2 & ";" & " having SUM(CASE WHEN HBCUSTDROPCALLOUT.SERNO IS NOT NULL THEN 1 ELSE 0 END) = 0 "
  else
     t=t & ";"
     t2=t2 & ";"
  end if    
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=t2
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
Sub btn1_onClick()
  window.close
End Sub
Sub Srbtnonclick()
    Dim ClickID
    ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
    clickkey="SEARCH" & clickid
    if isdate(document.all(clickkey).value) then
	   objEF2KDT.varDefaultDateTime=document.all(clickkey).value
    end if
    call objEF2KDT.show(1)
    if objEF2KDT.strDateTime <> "" then
       document.all(clickkey).value = objEF2KDT.strDateTime
    end if
END SUB
Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="SEARCH" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
       end if
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
-->
</script>
</head>
<body>
<center>
<table width="90%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="90%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="30" maxlength="30" class=dataListEntry >
    </td></tr>     
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="30" maxlength="60" class=dataListEntry >
    </td></tr>         
<tr><td class=dataListHead width="40%">�˾��a�}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="50" maxlength="60" class=dataListEntry >
    </td></tr>             
<tr><td class=dataListHead width="40%">����渹</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search4" size="11" maxlength="11" class=dataListEntry >
    </td></tr>             
<tr><td class=dataListHead width="40%">���</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry >
        <option value="" selected>����</option>
        <option value="='1'">����599</option>
        <option value="='2'">����399</option>
        <option value="='3'">�t��399</option>
      </select>
     </td>
     </tr>       
<tr><td class=dataListHead width="40%">���A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search6" size="1" class=dataListEntry>
        <option value="" selected>����</option>
        <option value="='�h��'">�h��</option>
        <option value="='���'">���</option>
        <option value="='�_��'">�_��</option>
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="40%">�h��(�_��)���</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search7" size="10" maxlength="60" class=dataListdata readonly>
    <input type="button" id="B7"  name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C7"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>            
<tr><td class=dataListHead width="40%">�h��(�_��)���</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search8" size="10" maxlength="60" class=dataListdata readonly >
    <input type="button" id="B8"  name="B8" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C8"  name="C8"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>        
<tr><td class=dataListHead width="40%">������檬�p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search9" size="1" class=dataListEntry >
        <option value="" selected>����</option>
        <option value="1">�w���(�_��)</option>
        <option value="2">�����(�_��)</option>
      </select>
     </td>
     </tr>           
<tr><td class=dataListHead width="40%">MIS��s���p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search10" size="1" class=dataListEntry >
        <option value="" selected>����</option>
        <option value="1">�w��s</option>
        <option value="2">����s</option>
      </select>
     </td>
     </tr>                
<tr><td class=dataListHead width="40%">���CALLOUT���p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry >
        <option value="" selected>����</option>
        <option value="1">�wCALLOUT</option>
        <option value="2">��CALLOUT</option>
      </select>
     </td>
     </tr>              
<tr><td class=dataListHead width="40%">�������d��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search12" size="1" class=dataListEntry ID="Select5">
        <option value="" selected>����</option>
        <option value="1">�P�Nú�ک|��ú��</option>
        <option value="2">�����h���Ȥ�</option>
      </select>
     </td>
     </tr>               
<tr><td class=dataListHead width="40%">�^�����A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search15" size="1" class=dataListEntry ID="Select1">
        <option value="" >����</option>
        <option value="1" selected>�w�^��</option>
        <option value="2">���^��</option>
      </select>
     </td>
     </tr>                   
<tr><td class=dataListHead width="40%">��ک�_���</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search13" size="10" maxlength="60" class=dataListdata readonly>
    <input type="button" id="B13"  name="B13" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C13"  name="C13"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>            
<tr><td class=dataListHead width="40%">��ک�_���</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search14" size="10" maxlength="60" class=dataListdata readonly >
    <input type="button" id="B14"  name="B14" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>             
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>