<%
    Dim rs,i,conn
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �g�P��
    rs.Open "SELECT GROUPNC " _
           &"FROM HBADSLCMTY " _
           &"GROUP BY GROUPNC ",conn
    S4="<option value="";"" selected>����</option>" &vbCrLf
    Do While Not rs.Eof
       S4=S4 &"<option value=""='" &rs("GROUPNC") &"';" &rs("GROUPNC") &""">" _
                             &rs("GROUPNC") &"</option>" &vbCrLf
       rs.MoveNext
    Loop 
    rs.Close
'--------- �u�{�v 
    rs.Open "SELECT leader " _
           &"FROM HBADSLCMTY " _
           &"GROUP BY leader ",conn
    S3="<option value="";"" selected>����</option>" &vbCrLf
    Do While Not rs.Eof
       S3=S3 &"<option value=""='" &rs("leader") &"';" &rs("leader") &""">" _
                             &rs("leader") &"</option>" &vbCrLf
       rs.MoveNext
    Loop 
    rs.Close
'----------
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
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
     t=t & " and hbadslcmty.comn like '%" & s1 & "%' "
  else
     s="���ϦW�١G����  "
    ' t=t & " and hbadslcmty.comQ1 <> 0 "
  end if
  
  s2=document.all("search2").value
  s2ary=split(s2,";")
  if s2 <>"" then
     s=s & "  ���Ϩӷ��G" & s2ary(1) & " " 
     t=t & " and hbadslcmty.comtype ='" &  s2ary(0) & "' "
  else
     s=s & "  ���Ϩӷ��G����  "
  end if  

  s3=document.all("search3").value
  s3ary=split(s3,";")  
  if s3ary(1) <>"" then
     s=s & "  �u�v�v�G" & s3ary(1)
     t=t & " and hbadslcmty.LEADER='" & s3ary(1) & "' "
  end if

  s4=document.all("search4").value
  s4ary=split(s4,";")  
  if s4ary(1) <>"" then
     s=s & "  �g�P�ӡG" & s4ary(1) 
     t=t & " and hbadslcmty.groupnc='" & s4ary(1) & "' "
  end if      
  
  s5=document.all("search5").value
  s6=document.all("search6").value
  if len(trim(s5))= 0 and len(trim(s6))=0 then
     S=s & "  �u���}�q����J����  "
  else
     if len(trim(s5))=0 then s5="1900/01/01"
     if len(trim(s6))=0 then s6="9999/12/31"
     s=s & "  �u���}�q����J��" & s5 & " �� " & S6 & " "
     t=t & " and hbadslcmty.t1applydat >='" & s5 & "' and t1applydat <='" & s6 & "' "
  end if
  s7=document.all("search7").value  
  s7ary=split(s7,";")
  if len(trim(s7)) > 0 then
     s=s & "  �ظm�P�N�ѡJ" & s7ary(1)
     t=t & " and hbadslcmty.comagree" & S7ary(0) & "'' "
  end if    
  s8=document.all("search8").value  
  s8ary=split(s8,";")
  if len(trim(s8)) > 0 then
     s=s & "  �X�@�����ѡJ" & s8ary(1)
     t=t & " and hbadslcmty.contract" & S8ary(0) & "'' "
  end if    
  s9=document.all("search9").value
  s9ary=split(s9,";")
  s10=document.all("search10").value  
  if len(trim(s9)) > 0 then
     s=s & "  �e�W�ϥΤ�J" & s9ary(1) & s10 & "��"
     t=t & " and hbadslcmty.usercnt" & S9ary(0) & s10 & " "
  end if      
  s11=document.all("search11").value
  s11ary=split(s11,";")
  s12=document.all("search12").value  
  if len(trim(s11)) > 0 then
     s=s & "  �����`��ơJ" & s11ary(1) & s12 & "��"
     t=t & " and hbadslcmty.comcnt" & S11ary(0) & s12 & " "
  end if            
  S13=document.all("search13").value
  IF LEN(TRIM(S13))=0 THEN
     xxx=""
  ELSE
     S13ARY=split(s13,";")
     xxx=" AND convert(varchar, HBADSLCMTY.comq1)+  HBADSLCMTY.comtype " _
     &" IN  (SELECT Convert(varchar,comq1)+kind FROM rtcmtymsg WHERE RTCmtyMSG.EVENTID = '" & s13ary(0) &"') "
     t=t & xxx
     s=s & "���ϭ��j�T���ƥ�J" & s13ary(1)
  END IF
  s14=document.all("search14").value    
  s14ary=split(s14,";")
  if S14ARY(0) <> "" then
     s=s & "��u�i�סJ" & S14ARY(1)
  end if
  IF S14ARY(0) = "2" THEN
     t=t & " and hbcmtyarrangesndwork.prtno IS NOT NULL AND hbcmtyarrangesndwork.dropdat IS NULL AND hbcmtyarrangesndwork.closedat IS NULL "
  ELSEIF S14ARY(0) = "1" THEN
     t=t & " and hbcmtyarrangesndwork.prtno IS NOT NULL AND hbcmtyarrangesndwork.dropdat IS NULL AND hbcmtyarrangesndwork.closedat IS not NULL AND hbcmtyarrangesndwork.AUDITdat IS  NULL"
  ELSEIF S14ARY(0) = "0" THEN
     t=t & " and hbcmtyarrangesndwork.prtno IS NOT NULL AND hbcmtyarrangesndwork.dropdat IS NULL AND hbcmtyarrangesndwork.closedat IS not NULL AND hbcmtyarrangesndwork.AUDITdat IS NOT NULL"
  ELSEIF S14ARY(0) = "3" THEN
     t=t & " and hbcmtyarrangesndwork.prtno IS NULL "
  END IF    
  
  's14ARY=SPLIT(document.all("search14").value,";")
  'if S14ARY(0) ="1" then
  '   t=t & " AND ( HBADSLCMTY.RCOMDROP <> '' OR hbadslcmty.rcomdrop IS NOT NULL ) " 
  '   s=s & " �M�u���p�J�u��w�M�u���� "
  'elseif S14ARY(0)="2" then
  '   t=t & " and ( hbadslcmty.rcomdrop ='' OR hbadslcmty.rcomdrop IS NULL) "
  '   S=S & " �M�u���p�J�u�良�M�u���� "
  'end if
  s15=document.all("search15").value      
  if len(trim(s15))= 0 then
  else
     s=s & "  ���ϥD�uIP�t�J(" & s15 & ") "
     t=t & " and hbadslcmty.IPADDR LIKE '%" & s15 & "%' "
  end if
  s16=document.all("search16").value
  if len(trim(s16))= 0 then
  else
     s=s & "  ���ϥD�u�����t�J(" & s16 & ") "
     t=t & " and hbadslcmty.LINETEL LIKE '%" & s16 & "%' "
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
End Sub 
Sub SrClear()
    Dim ClickID
    ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
    clickkey="C" & clickid
    clearkey="SEARCH" & clickid       
    if len(trim(document.all(clearkey).value)) <> 0 then
       document.all(clearkey).value =  ""
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
<OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
       height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
       width=60 >
      <PARAM NAME="_ExtentX" VALUE="1270">
      <PARAM NAME="_ExtentY" VALUE="1270">
</OBJECT>
<body>
<center>
<table width="85%">
  <tr class=dataListTitle align=center>�п�J(���)���ϸ�Ʒj�M����</td><tr>
</table>
<table width="85%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="30" maxlength="200" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�����q��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search16" size="30" maxlength="200" class=dataListEntry ID="Text2">
    </td></tr>
<tr><td class=dataListHead width="40%">���ϥD�uIP</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search15" size="20" maxlength="20" class=dataListEntry ID="Text1">
    </td></tr>    
<tr><td class=dataListHead width="40%">���Ϩӷ�</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search2" >
       <option value="">(����)</option>
       <option value="1;���T599">���T599</option>
       <option value="2;����399">����399</option>
       <option value="3;�t��399">�t��399</option>
       <option value="4;�F�T599">�F�T599</option>
       <option value="5;�F��499">�F��499</option>
	   <option value="6;�t��499">�t��499</option>       
    </select>        
    </td></tr>
<tr><td class=dataListHead width="40%">��u�i��</td>
    <td width="60%"  bgcolor="silver">
      <select name="search14" size="1" class=dataListEntry ID="Select1">
        <option value=";����" selected>����</option>
        <option value="0;�f�֧���">�f�֧���</option>
        <option value="1;�w��u�|���f�֧���">�w��u�|���f�֧���</option>
        <option value="2;�w���u�|����u����">�w���u�|����u����</option>
        <option value="3;�����u">�����u</option>
      </select>
     </td>
</tr>        
<tr><td class=dataListHead width="40%">���j�T���ƥ�</td>
    <td width="60%" bgcolor="silver" >
 <% Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT CODE,codenc FROM RTcode where kind='C9' order by CODENC "
    s="<option value="""" >(����)</option>"   
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(����)</option>"
    sx=""
    Do While Not rs.Eof
       s=s &"<option value=""" &rs("CODE") & ";" & rs("CODEnc") &"""" &sx &">" &rs("CODEnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close    
    conn.close       
    set rs=nothing
    set conn=nothing
 %>    
    <select class=dataListEntry name="search13">
       <%=S%>
    </select>        
    </td></tr>        

<tr><td class=dataListHead width="40%">�g�P��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search4" size="1" class=dataListEntry ID="Select2">
        <%=S4%>
    </select>
    </td>
</tr>

<tr><td class=dataListHead width="40%">�u�{�v</td>
    <td width="60%"  bgcolor="silver">
    <select name="search3" size="1" class=dataListEntry ID="Select3">
        <%=S3%>
    </select>
    </td>
</tr>

<tr><td class=dataListHead width="40%">�}�q���</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search5" size="10" maxlength="10" class=dataListEntry>
             <input type="button" id="B5"  name="B5"   width="100%" style="Z-INDEX: 1"  value="..." ONCLICK="Srbtnonclick">        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C5"  name="C5"   style="Z-INDEX: 1"  ONCLICK="Srclear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
          ��
    <input type=text name="search6" size="10" maxlength="10" class=dataListEntry>
             <input type="button" id="B6"  name="B6"   width="100%" style="Z-INDEX: 1"  value="..." ONCLICK="Srbtnonclick" >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C6"  name="C6"   style="Z-INDEX: 1"  ONCLICK="Srclear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
    </td></tr>         
    <!--
<tr><td class=dataListHead width="40%">�t�w�M�u����</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search14" >
       <option value="">(����)</option>
       <option value="1;�w�M�u����">�u��w�M�u</option>
       <option value="2;���M�u����">�u�良�M�u</option>
    </select>
    </td></tr>                   
    -->
<tr><td class=dataListHead width="40%">�ظm�P�N��</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search7">
       <option value="">(����)</option>
       <option value="<>;��">��</option>
       <option value="=;�K">�K</option>
    </select>
    </td></tr>            
<tr><td class=dataListHead width="40%">�X��������</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search8">
       <option value="">(����)</option>
       <option value="<>;��">��</option>
       <option value="=;�L">�L</option>
    </select>
    </td></tr>          
<tr><td class=dataListHead width="40%">�e�W�ϥΤ�</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search9">
       <option value="">(����)</option>
       <option value=">;�j��">�j��</option>
       <option value="=;����">����</option>
       <option value="<;�p��">�p��</option>
    </select>
    <input type=text name="search10" size="5" maxlength="5" class=dataListEntry>��
    </td></tr>                 
<tr><td class=dataListHead width="40%">�����`���</td>
    <td width="60%" bgcolor="silver" >
    <select class=dataListEntry name="search11">
       <option value="">(����)</option>    
       <option value=">;�j��">�j��</option>
       <option value="=;����">����</option>
       <option value="<;�p��">�p��</option>
    </select>    
    <input type=text name="search12" size="5" maxlength="5" class=dataListEntry>��
    </td></tr>                         
</table>
<table width="85%" align=right><tr><td></td><td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>