
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
  tAvs=""
  tET=""
  t2=""
  t3=""
  t4=""
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="���ϦW�١G�t('" & s1 & "')�r��"  
     t=t & " hbadslcmtycust.comn like '%" & s1 & "%' "
     tAvs=t
     tET=t
  else
     s="���ϦW�١G����  "
     t=t & " hbadslcmtycust.comq1 <> 0 "
     tAvs=t
     tET=t
  end if
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " and hbadslcmtycust.cusnc like '%" & s2 & "%'"
     tAvs=t     
     tET=t
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " and hbadslcmtycust.cusid <>'*'"
     tAvs=t
     tET=t
  end if  
  s12=document.all("search12").value
  if len(trim(s12)) > 0 then
     s="  �ư��H���G�t('" & s12 & "')�r��"  
     t=t & " and rtobj.cusnc like '%" & s12 & "%'"
     tAvs=t
     tET=t
  end if  
  s13=document.all("search13").value
  if len(trim(s13)) > 0 then
     s="  �ư��t�ӡG�t('" & s13 & "')�r��"  
     t=t & " and rtobj_1.cusnc like '%" & s13 & "%'"
     tAvs=t
     tET=t
  end if  
  s4=document.all("search4").value
  if len(trim(s4)) > 0 then
     s=S & "  �˾��a�}�G�t('" & s4 & "')�r��"  
     t=t & " and raddr  like '%" & s4 & "%'"
     tAvs=t
     tET=t
  end if
  s5=document.all("search5").value
  s5ary=split(s5,";")
  if s5ary(0) <> "" then
     s=s & " ��סG" & s5ary(1)
     t=t & " and hbadslcmtycust.comtype ='" & s5ary(0) & "' "
     tAvs=t
     tET=t
  else
     S=S & " ��סJ���� "
  end if
  s7=document.all("search7").value    
  s9=document.all("search9").value    
  if isdate(s7) then
     s=s & "�ӽФ�����J" & s7 & " �� " & s9
     t=t & " and hbadslcmtycust.rcvdat between '" & s7 & "' and '" & s9 &"' "
     tAvs=t
     tET=t
  end if
  s6=document.all("search6").value  
  iF Isnumeric(S6) then
     s=s & "�˾��ɶ��W�L�J" & s6 & " �� "
     t=t & " and (( datediff(dd,hbadslcmtycust.rcvdat,hbadslcmtycust.finishdat) > " & S6 & " and hbadslcmtycust.rcvdat is not null) or ( datediff(dd,hbadslcmtycust.rcvdat,getdate()) > " & S6 & " and hbadslcmtycust.finishdat is null)) "
     tAvs=t
     tET=t
  end if
  s10=document.all("search10").value    
  s11=document.all("search11").value
  if isdate(s10) then
     s=s & "���z������J" & s10 & " �� " & s11
     t=t & " and rtfaqh.rcvdate between '" & s10 & "' and '" & s11 &"' "
     tAvs=tAvs & " and RTLessorAVSCustFaqH.rcvdat between '" & s10 & "' and '" & s11 &"' "
     tET=tET & " and RTLessorCustFaqH.rcvdat between '" & s10 & "' and '" & s11 &"' "
  end if

  s3=document.all("search3").value
  s3ary=split(s3,";")
  s=s & " �B�z���A�G" & s3ary(1)  
  if s3ary(0) = "1" then
     t2=t2 & " HAVING SUM(CASE WHEN RTFAQH.CASENO IS NOT NULL and RTFAQH.finishdate IS NULL and RTFAQH.dropdate is null THEN 1 ELSE 0 END)>0 "
	 t3=t3 & " HAVING SUM(CASE WHEN RTLessorCustFaqH.FAQNO IS NOT NULL and RTLessorCustFaqH.finishdat IS NULL and RTLessorCustFaqH.canceldat is null THEN 1 ELSE 0 END)>0 "     	 
	 t4=t4 & " HAVING SUM(CASE WHEN RTLessorAVSCustFaqH.FAQNO IS NOT NULL and RTLessorAVSCustFaqH.finishdat IS NULL and RTLessorAVSCustFaqH.canceldat is null THEN 1 ELSE 0 END)>0 "     
  elseif s3ary(0) = "2" then
     t2=t2 & " HAVING SUM(CASE WHEN RTFAQH.CASENO IS NOT NULL and RTFAQH.finishdate IS NULL and RTFAQH.dropdate is null THEN 1 ELSE 0 END)=0 "
	 t3=t3 & " HAVING SUM(CASE WHEN RTLessorCustFaqH.FAQNO IS NOT NULL and RTLessorCustFaqH.finishdat IS NULL and RTLessorCustFaqH.canceldat is null THEN 1 ELSE 0 END)=0 "     	 
	 t4=t4 & " HAVING SUM(CASE WHEN RTLessorAVSCustFaqH.FAQNO IS NOT NULL and RTLessorAVSCustFaqH.finishdat IS NULL and RTLessorAVSCustFaqH.canceldat is null THEN 1 ELSE 0 END)=0 "     
  else
	 t2=t2 & " HAVING HBADSLCMTYcust.comq1>=0  "
	 t3=t2
	 t4=t2
  end if

  s8=document.all("search8").value  
  iF Isnumeric(S8) then
     s=s & "�ȶD�ץ�W�L�J" & s8 & " �� "
     t2=t2 & " and SUM(CASE WHEN RTFAQH.CASENO IS NOT NULL THEN 1 ELSE 0 END) >= " & s8 
     t3=t3 & " and SUM(CASE WHEN RTLessorCustFaqH.FAQNO IS NOT NULL THEN 1 ELSE 0 END) >= " & s8 
     t4=t4 & " and SUM(CASE WHEN RTLessorAVSCustFaqH.FAQNO IS NOT NULL THEN 1 ELSE 0 END) >= " & s8 
  end if  
  
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQryAvs").value=tAVS
  docP.all("searchQryET").value=tET
  docP.all("searchQry2").value=t2
  docP.all("searchQry3").value=t3
  docP.all("searchQry4").value=t4
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
<table width="70%">
  <tr class=dataListTitle align=center>�п�J(���)�Ȥ��Ʒj�M����</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="15" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�B�z���A</td>
    <td width="60%"  bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry ID="Select1">
        <option value="0;����">����</option>        
        <option value="1;������">������</option>
        <option value="2;�w����">�w����</option>
      </select></td>
</tr>
<tr><td class=dataListHead width="40%">��קO</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="1;���T599">���T599</option>
        <option value="4;�F�T599">�F�T599</option>
        <option value="2;����399">����399</option>
        <option value="3;�t��399">�t��399</option>
     	<option value="5;�F��499">�F��499</option> 
		<option value="6;�t��499">�t��499</option>      
		<option value="7;AVSCity">AVS-City</option>
		<option value="8;ETCity">ET-City</option>     
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�˾��a�}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search4" size="40" maxlength="60" class=dataListEntry>
    </td></tr>        
<tr><td class=dataListHead width="40%">�ӽФ��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search7" size="10" maxlength="60" class=dataListdata readonly>
    <input type="button" id="B7"  name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C7"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
	��
    <input type=text name="search9" size="10" maxlength="60" class=dataListdata readonly>
	<input type="button" id="B9"  name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
	<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C9"  name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>

<tr><td class=dataListHead width="40%">���z�ɶ�</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search10" size="10" maxlength="60" class=dataListdata readonly>
    <input type="button" id="B10"  name="B10" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10" style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
	��
    <input type=text name="search11" size="10" maxlength="60" class=dataListdata readonly>
	<input type="button" id="B11"  name="B11" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
	<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C11"  name="C11"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>
<tr><td class=dataListHead width="40%">�ư��H��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search12" size="15" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�ư��t��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search13" size="15" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�˾��ɶ��W�L�J</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search6" size="3" maxlength="60" class=dataListEntry>
    ��</td></tr>        
<tr><td class=dataListHead width="40%">�ȶD�ץ�W�L�J</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search8" size="3" maxlength="60" class=dataListEntry ID="Text1">
    ��</td></tr>            
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>