<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �X���ʽ�
    rs.Open "SELECT PROPERTYID , PROPERTYNM from  HBContractTreeH ORDER BY PROPERTYID ",conn
    s1="<option value=""<>'*';����"" selected>����</option>" &vbCrLf         
    Do while not rs.EOF
       s1= s1 & "<option value=""" & rs("PROPERTYID") & ";"  &  rs("PROPERTYNM") & """>" & rs("PROPERTYNM") & "</option>" & vbcrlf
       rs.MoveNext
    Loop
    rs.Close

'--------- �X���j��
	SQLX="select a.PROPERTYID, a.CATEGORY1, a.CATEGORY1NM FROM 	HBCONTRACTTREEL1 a "_
		&"inner join HBContractTreeH b on a.PROPERTYID = b.PROPERTYID order by 	1, 2 "
	rs.OPEN SQLX,CONN,1,1
	cnt=1
	XXS="aryproperty(" & CNT & ") = ""<select class=dataListEntry name=""""search2"""">" 
	propertyid = rs("propertyid")
    Do while not rs.EOF
       if propertyid <> rs("propertyid") then
		  cnt=cnt+1
          XXs=XXs & "</SELECT>""" & vbCrLf & "aryproperty(" & CNT & ") = ""<select class=dataListEntry name=""""search2"""">" 
          propertyid = rs("propertyid")
       end if
       XXs=XXs & "<option value=""""" & rs("CATEGORY1") &  ";"  &  rs("CATEGORY1NM") & """"">" & RS("CATEGORY1NM") & "</OPTION>" 
       rs.MoveNext
    Loop
    xxs="Dim aryproperty(" & CNt & ") " &vbCrLf & xxs & "</SELECT>""" & vbCrLf
    rs.Close

'--------- �X���p��
    rs.Open "SELECT CATEGORY2, CATEGORY2NM FROM HBContractTreeL2 GROUP BY  CATEGORY2, CATEGORY2NM ",conn
    s3="<option value=""<>'*';����"" selected>����</option>" &vbCrLf   
    Do While not rs.eof
      s3= s3 & "<option value=""" & rs("CATEGORY2") &  ";"  &  rs("CATEGORY2NM") & """>" & rs("CATEGORY2NM") & "</option>" & vbcrlf    
      rs.MoveNext
    Loop
    rs.Close
'--------- ���I�O
    rs.Open "SELECT code,codenc from rtcode where kind='F7' " _
           &"ORDER BY code ",conn
    s10="<option value="";�G����"" selected>����</option>" &vbCrLf   
    Do While not rs.eof
      s10= s10 & "<option value=""='" & rs("code") & "';" & "�G" &  rs("codenc") & """>" & rs("codenc") & "</option>" & vbcrlf    
      rs.MoveNext
    Loop
    rs.Close    
'--------- ���I�覡
    rs.Open "SELECT code,codenc from rtcode where kind='F5' " _
           &"ORDER BY code ",conn
    s11="<option value="";�G����"" selected>����</option>" &vbCrLf   
    Do While not rs.eof
      s11= s11 & "<option value=""='" & rs("code") & "';" & "�G" &  rs("codenc") & """>" & rs("codenc") & "</option>" & vbcrlf    
      rs.MoveNext
    Loop
    rs.Close        
'--------- ñ������
    rs.Open  "SELECT DISTINCT HBCONTRACTH.SIGNDEPT, RTDept.DEPTN3 + RTDept.DEPTN4 as deptnm " _
            &"FROM HBCONTRACTH INNER JOIN RTDept ON HBCONTRACTH.SIGNDEPT = RTDept.DEPT " _
            &"GROUP BY  HBCONTRACTH.SIGNDEPT, RTDept.DEPTN3 + RTDept.DEPTN4",conn
    s12="<option value="";�G����"" selected>����</option>" &vbCrLf   
    Do While not rs.eof
      s12= s12 & "<option value=""='" & rs("SIGNDEPT") & "';" & "�G" &  rs("DEPTNm")  & """>" &  rs("DEPTNm")  & "</option>" & vbcrlf    
      rs.MoveNext
    Loop
    rs.Close        
'--------- ñ���H
    rs.Open "SELECT DISTINCT HBCONTRACTH.SIGNPERSON, RTObj.CUSNC FROM HBCONTRACTH INNER JOIN " _
           &"RTEmployee ON HBCONTRACTH.SIGNPERSON = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID GROUP BY  HBCONTRACTH.SIGNDEPT, HBCONTRACTH.SIGNPERSON, RTObj.CUSNC " _
           &"ORDER BY RTObj.CUSNC ",conn
    s13="<option value="";�G����"" selected>����</option>" &vbCrLf   
    Do While not rs.eof
      s13= s13 & "<option value=""='" & rs("SIGNPERSON") & "';" & "�G" &  rs("CUSNC") & """>" & rs("CUSNC") & "</option>" & vbcrlf    
      rs.MoveNext
    Loop
    rs.Close             
       
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
   <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 >
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub search1_OnChange()
    <%=xxs%>
    document.all("search2TD").innerHTML=aryproperty(document.all("search1").selectedIndex)
End Sub
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  s1ary=Split(document.all("search1").value,";")
  s2ary=Split(document.all("search2").value,";")
  s3ary=Split(document.all("search3").value,";")  
  If s1ary(0) <> "<>'*'" then
     s=s & " �X���ʽ�" & s1ary(1) & " "
     t=t & " and HBcontractH.CTproperty='" & S1ARY(0) & "' "
  end if
  If s2ary(0) <> "" then
     s=s & " �X���j��" & s2ary(1) & " "
     t=t & " and HBcontractH.CTTree1 ='" & S2ARY(0) & "' "
  end if
  If s3ary(0) <> "<>'*'" then
     s=s & " �X���p��" & s3ary(1) & " "
     t=t & " and HBcontractH.CTtree2 ='" & S3ARY(0) & "' "
  end if    
  s17=document.all("search17").value
  IF len(trim(s17)) > 0 then
     s=s & " �X����H�W�١J" & s17 & " "
     t=t & " and HBCONTRACTH.CONTRACTNO +'-'+ convert(varchar(4),hbcontracth.volume) +'-'+ convert(varchar(3),hbcontracth.pagecnt) like '%" & S17 & "%' "
  end if   
  s4=document.all("search4").value
  IF len(trim(s4)) > 0 then
     s=s & " �X����H�W�١J" & s4 & " "
     t=t & " and HBcontractH.CTobjname like '%" & S4 & "%' "
  end if   
  s5=document.all("search5").value
  IF len(trim(s5)) > 0 then
     s=s & " �X����H�N���J" & s5 & " "
     t=t & " and HBcontractH.CTobject like '%" & S5 & "%' "
  end if     
  s6=document.all("search6").value
  s7=document.all("search7").value
  if len(trim(s6))>0 or len(trim(s7))>0 then
     if len(trim(s6))=0 then S6="1911/01/01"
     if len(trim(s7))=0 then S7="9999/12/31"
     S=S & " �X���_�l��d��J" & s6 & "-" & s7
     t=t & " and HBcontractH.ctstrdat >='" & S6 & "' and HBcontractH.ctstrdat <='" & S7 & "' " 
  end if  
  s8=document.all("search8").value
  s9=document.all("search9").value  
  if len(trim(s8))>0 or len(trim(s9))>0 then
     if len(trim(s8))=0 then S8="1911/01/01"
     if len(trim(s9))=0 then S9="9999/12/31"
     S=S & " �X���פ��d��J" & s8 & "-" & s9
     t=t & " and HBcontractH.ctenddat >='" & S6 & "' and HBcontractH.ctstrdat <='" & S9 & "' " 
  end if   
  s10ary=split(document.all("search10").value,";")
  s11ary=split(document.all("search11").value,";")
  s12ary=split(document.all("search12").value,";")
  s13ary=split(document.all("search13").value,";")
  If s10ary(0) <> "" then
     s=s & " ���I�O" & s10ary(1) & " "
     t=t & " and HBcontractH.rcvorpay " & S10ARY(0) & " "
  end if
  If s11ary(0) <> "" then
     s=s & " ���I�覡" & s11ary(1) & " "
     t=t & " and HBcontractH.arap " & S11ARY(0) & " "
  end if
  If s12ary(0) <> "" then
     s=s & " ñ������" & s12ary(1) & " "
     t=t & " and HBcontractH.signdept " & S12ARY(0) & " "
  end if
  If s13ary(0) <> "" then
     s=s & " ñ���H" & s13ary(1) & " "
     t=t & " and HBcontractH.signperson " & S13ARY(0) & " "
  end if 
  s14=document.all("search14").value    
  if len(trim(s14)) > 0 then
     S=S & " �����X���d��" & s14 & " �Ѥ����"
     t=t & "  and ( HBcontractH.ctenddat is not null and datediff(d,getdate(),HBcontractH.ctenddat) <= " & s14 & ") "
  end if
  s15=document.all("search15").value    
  s16=document.all("search16").value      
  if len(trim(s15))>0 or len(trim(s16))>0 then
     if len(trim(s15))=0 then S15="1911/01/01"
     if len(trim(s16))=0 then S16="9999/12/31"
     S=S & " �X�������_���J" & s15 & "-" & s16
     t=t & " and HBcontractH.RCVdat >='" & S15 & "' and HBcontractH.RCVdat <='" & S16 & "' " 
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
-->
</script>
</head>
<body>
<center>
<table width="90%">
  <tr class=dataListTitle align=center>�X����Ʒj�M����</td><tr>
</table>
<table width="90%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">�X���ʽ�</td>
    <td width="60%" bgcolor=silver>
      <select name="search1" size="1" class=dataListEntry>
        <%=S1%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">�X���j��</td>
    <td width="60%" ID="search2TD" bgcolor=silver>
      <select name="search2" size="1" class=dataListEntry>
        <option value=";����">����</option>
      </select>    </td></tr>
<tr><td class=dataListHead width="40%">�X���p��</td>
    <td width="60%"  bgcolor=silver>
      <select name="search3" size="1" class=dataListEntry ID="Select1">
        <%=S3%>
      </select>
</td></tr>      
<tr><td class=dataListHead width="40%">�X���s��</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search17" maxlength=12 size=20 style="TEXT-ALIGN: left"></td></tr>
<tr><td class=dataListHead width="40%">�X����H�W��</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search4" maxlength=50 size=30 style="TEXT-ALIGN: left"></td></tr>
<tr><td class=dataListHead width="40%">�X����H�N�X(�νs)(������)</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search5" maxlength=10 size=10 style="TEXT-ALIGN: left" ID="Text1"></td></tr>           
<tr><td class=dataListHead width="40%">�X���_�l��d��</td>
    <td width="60%"  bgcolor=silver>
    <input class=dataListDATA name="search6" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" id="B6"  name="B6" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"  ID="C6" name="C6"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">��
     <input class=dataListDATA name="search7" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" id="B7" name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" ID="C7"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
     </td></tr>  
<tr><td class=dataListHead width="40%">�X���פ��d��</td>
    <td width="60%"  bgcolor=silver>
    <input class=dataListDATA name="search8" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" ID="B8" name="B8" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"  ID="C8"  name="C8"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">��
     <input class=dataListDATA name="search9" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" ID="C9" name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"  ID="C9" name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
     </td></tr>          
<tr><td class=dataListHead width="40%">���I�O</td>
    <td width="60%"  bgcolor=silver>
      <select name="search10" size="1" class=dataListEntry>
        <%=S10%>
      </select></td></tr>         
<tr><td class=dataListHead width="40%">���I�覡</td>
    <td width="60%"  bgcolor=silver>
      <select name="search11" size="1" class=dataListEntry>
        <%=S11%>
      </select></td></tr>               
<tr><td class=dataListHead width="40%">ñ������</td>
    <td width="60%"  bgcolor=silver>
      <select name="search12" size="1" class=dataListEntry>
        <%=S12%>
      </select></td></tr>           
<tr><td class=dataListHead width="40%">ñ���H</td>
    <td width="60%"  bgcolor=silver>
      <select name="search13" size="1" class=dataListEntry>
        <%=S13%>
      </select></td></tr>              
<tr><td class=dataListHead width="40%">�����X���d��</td>
    <td width="60%"  bgcolor=silver>
    <input class=dataListEntry name="search14" maxlength=3 size=5 style="TEXT-ALIGN: left" ID="Text2">�Ѥ����</td></tr>  
<tr><td class=dataListHead width="40%">�������_��</td>
    <td width="60%"  bgcolor=silver>
    <input class=dataListDATA name="search15" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" id="B15"  name="B15" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"  ID="c15" name="C15"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">��
     <input class=dataListDATA name="search16" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" id="B16" name="B16" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" ID="C16"  name="C16"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
     </td></tr>                           
</table>
<table width="50%" align=right><tr><td></td>
<td align=right>
<input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
<input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td>
</tr></table>
</body>
</html>