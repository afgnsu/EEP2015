<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"      codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub btn_onClick()
  '----���ϦW��
  r=document.all("search1").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &"  (RTSparqAdslCmty.ComN <> '*') "
  Else
     s=s &"  ���ϦW��:" &r & " "
     t=t &"  (RTSparqAdslCmty.ComN LIKE '%" &r &"%') " 
  End If
  '----�i�ת��p
  arystr=split(document.all("search2").value,";")
  s=s &"  �i�ת��p:" & aryStr(1)
  if aryStr(0)="" then
     t=t & " and (rtsparqadslcust.dropdat is null and rtsparqadslcust.agree <>'N' ) "
  elseif aryStr(0)="1" then
     t=t & ""     
  elseif aryStr(0)="2" then
     t=t & " and (RTSparqAdslCmty.ADSLapply is not null ) "
  elseif aryStr(0)="3" then
     t=t & " and (RTSparqAdslCmty.LINEARRIVE is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) "
  elseif aryStr(0)="4" then
     t=t & " and (RTSparqAdslCmty.SNDWRKPLACE is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) " _
         & " AND (RTSparqAdslCmty.LINEARRIVE is null)  "     
  elseif aryStr(0)="5" then
     t=t & " and (RTSparqAdslCmty.EQUIPARRIVE is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) " _
         & " AND (RTSparqAdslCmty.LINEARRIVE is null) AND (RTSparqAdslCmty.SNDWRKPLACE IS NULL) "     
  elseif aryStr(0)="6" then
     t=t & " and (RTSparqAdslCmty.CASESNDWRK is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) " _
         & " AND (RTSparqAdslCmty.LINEARRIVE is null) AND (RTSparqAdslCmty.SNDWRKPLACE IS NULL) " _
         & " AND (RTSparqAdslCmty.EQUIPARRIVE IS NULL ) "
  elseif aryStr(0)="7" then
     t=t & " and (RTSparqAdslCmty.rcvd is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) " _
         & " AND (RTSparqAdslCmty.LINEARRIVE is null) AND (RTSparqAdslCmty.SNDWRKPLACE IS NULL) " _
         & " AND (RTSparqAdslCmty.EQUIPARRIVE IS NULL ) AND (RTSparqAdslCmty.CASESNDWRK IS NULL) " 
  elseif aryStr(0)="8" then
     t=t & " and (RTSparqAdslCmty.SURVYDAT is NOT null) AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) " _
         & " AND (RTSparqAdslCmty.LINEARRIVE is null) AND (RTSparqAdslCmty.SNDWRKPLACE IS NULL) " _
         & " AND (RTSparqAdslCmty.EQUIPARRIVE IS NULL ) AND (RTSparqAdslCmty.CASESNDWRK IS NULL) " _
         & " AND (RTSparqAdslCmty.RCVD IS NULL ) "        
  end if
  s3=document.all("search3").value
  s3ary=split(s3,";")
  if s3ary(0)="" then
     S=S & "  �~�ȲէO:����  "
  else
     s=s & "  �~�ȲէO:" & s3ary(1) & "  "
     t=t & " and (RTSparqAdslCmty.GROUPID='" & s3ary(0) & "') "
  end if
  s4=document.all("search4").value
  s4ary=split(s4,";")
  IF S4ARY(0) <> "" THEN
     s=s & "��סJ" & s4ary(1) & " "
     t=t & " and rtsparqadslcmty.connecttype='" & s4ary(0) & "' "
  END IF
  s7=document.all("search7").value    
  if isdate(s7) then
     s=s & "�ӽФ�ۡJ" & s7 & " �H�ӡA"
     t=t & " and rtsparqadslcust.formaldat >= '" & s7 & "' "
  end if
  s8=document.all("search8").value  
  iF Isnumeric(S8) then
     s=s & "�˾��ɶ��W�L�J" & s8 & " �� "
     t=t & " and (( datediff(dd,rtsparqadslcust..formaldat,rtsparqadslcust.finishdat) > " & S8 & " and rtsparqadslcust..formaldat is not null) or ( datediff(dd,rtsparqadslcust..formaldat,getdate()) > " & S8 & " and rtsparqadslcust.finishdat is null)) "
  end if    
    '----�]�Ʀa�}
  r=document.all("search9").value  
  If Len(r)=0 Or r="" Then
     s=s &"  �]�Ʀa�}:���� "  
  Else
     s=s &"  �]�Ʀa�}:" &r & " "
     t=t &" and (IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR LIKE '%" &trim(r) &"%') " 
  End If
  s10=document.all("search10").value  
  if len(trim(s10)) <> "" then
     s=s & "  �����q�ܥ]�t�J" & s10 &  "  "
     t=t & " and (rtsparqadslcmty.cmtytel like '%" & s10 & "%') "
  end if
  s11=document.all("search11").value  
  if len(trim(s11)) <> "" then
     s=s & "  ���ϥD�uIP�t�J(" & s11 &  ")  "
     t=t & " and (rtsparqadslcmty.IPADDR like '%" & s11 & "%') "
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
  Dim winP
  Set winP=window.Opener
  winP.focus()
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
          '���B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
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
<table width="100%">
  <tr class=dataListTitle align=center>ADSL���ϰ򥻸�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">�~�ȲէO</td>
    <td width="60%" bgcolor="silver">
 <% Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT GROUPID, GROUPNC FROM RTSALESGROUP order by groupnc "
    s="<option value="";"" >(����)</option>"   
    rs.Open sql,conn
    If rs.Eof Then s="<option value="";"" >(����)</option>"
    sx=""
    Do While Not rs.Eof
       s=s &"<option value=""" &rs("GROUPID") & ";" & rs("GROUPnc") &"""" &sx &">" &rs("GROUPnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close    
    conn.close       
    set rs=nothing
    set conn=nothing
 %>
      <select name="search3" size="1" class=dataListEntry>
        <%=s%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�����q�ܸ��X</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search10" class=dataListEntry ID="Text1"> 
    </td></tr>   
<tr><td class=dataListHead width="40%">���ϥD�uIP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search11" class=dataListEntry ID="Text3"> 
    </td></tr>       
<tr><td class=dataListHead width="40%">�]�Ʀa�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search9" class=dataListEntry ID="Text2"> 
    </td></tr>         
<tr><td class=dataListHead width="40%">���</td>
    <td width="60%" bgcolor="silver">    
     <% Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT code,CODENC FROM RTCODE WHERE KIND='G5' order by CODE "
    s="<option value="";"" >(����)</option>"   
    rs.Open sql,conn
    If rs.Eof Then s="<option value="";"" >(����)</option>"
    sx=""
    Do While Not rs.Eof
       s=s &"<option value=""" &rs("CODE") & ";" & rs("CODENC") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close    
    conn.close       
    set rs=nothing
    set conn=nothing
 %>
       <select name="search4" size="1" class=dataListEntry ID="Select1">
        <%=s%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search2" size="1" class=dataListEntry>
   <!--
        <option value=";����(���t�M�P�B�h���B���i�ظm��)" selected>����(���t�M�P�B�h���B���i�ظm��)</option>
        -->
        <option value="1;����" selected>����</option>
        <option value="2;�w���q">�w���q</option>
        <option value="3;�u���w���">�u���w���</option>
        <option value="4;�w�e����B�B">�w�e����B�B</option>
        <option value="5;�]�Ƥw���">�]�Ƥw���</option>
        <option value="6;���d�w���u">���d�w���u</option>
        <option value="7;�w���X�ӽ�">�w���X�ӽ�</option>
        <option value="8;���Ϥw����">���Ϥw����</option>
      </select>
     </td>
</tr>
<tr><td class=dataListHead width="40%">�ӽФ��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search7" size="10" maxlength="60" class=dataListdata readonly>
    <input type="button" id="B7"  name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C7"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
    </td></tr>            
<tr><td class=dataListHead width="40%">�˾��ɶ��W�L�J</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search8" size="3" maxlength="60" class=dataListEntry>
    ��</td></tr>        
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>