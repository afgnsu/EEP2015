 <% Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
'----------�g�P��
    S6=""
    rs.Open "SELECT  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE RTCODE.CODENC END AS shortnc " _
           &"FROM  rtCUSTADSLcmty LEFT OUTER JOIN RTcode ON rtCUSTADSLcmty.comtype = RTcode.code AND rtcode.kind = 'B3' " _
           &"GROUP BY  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE RTCODE.CODENC END " _
           &"ORDER BY  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE RTCODE.CODENC END",CONN
    s6="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s6=s6 &"<option value=""" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------��B�I
    S3=""
    rs.Open "SELECT OPERATIONID, OPERATIONNAME FROM RTCtyTown WHERE (OPERATIONNAME <> '') GROUP BY  OPERATIONID, OPERATIONNAME ORDER BY  OPERATIONID ",CONN
    s3="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s3=s3 &"<option value=""" & rs("OPERATIONNAME") & """>" &rs("OPERATIONNAME") &"</option>"
       rs.MoveNext
    Loop
    s3=s3 &"<option value=""�L�k�k��"">�L�k�k��</option>"
    rs.Close    
'----------�������O
    S11=""
    rs.Open "SELECT CODE,CODENC FROM RTCODE WHERE KIND='B3' ",CONN
    s11="<option value=""<>'*';����"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s11=s11 &"<option value=""='" &rs("CODE") & "';" & rs("CODENC") & """>" &rs("CODENC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close    
    conn.close       
    set rs=nothing
    set conn=nothing
 %>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub search3_OnChange()
    <%=s%>
    document.all("search6TD").innerHTML=arygroup(document.all("search3").selectedIndex)
End Sub
Sub btn_onClick()
  '----���ϦW��
  r=document.all("search1").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &"  (RTCUSTADSLcmty.ComN <> '*') "
  Else
     s=s &"  ���ϦW��:" &r & " "
     t=t &"  (RTCUSTADSLcmty.ComN LIKE '%" &r &"%') " 
  End If
  '----���ϸ��X
  r=document.all("search5").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ����HB���X:���� "  
     t=t &" and (RTCUSTADSLcmty.HBNO <> '*') "
  Else
     s=s &"  ����HB���X:" &r & " "
     t=t &" and (RTCUSTADSLcmty.hbno LIKE '%" &r &"%') " 
  End If
  '----�]�Ʀa�}
  r=document.all("search9").value  
  If Len(r)=0 Or r="" Then
     s=s &"  �]�Ʀa�}:���� "  
  Else
     s=s &"  �]�Ʀa�}:" &r & " "
     t=t &" and (RTCUSTADSLcmty.EQUIPADDR LIKE '%" &trim(r) &"%') " 
  End If
  '----�i�ת��p
  arystr=split(document.all("search2").value,";")
  s=s &"  �i�ת��p:" & aryStr(1)
  
 '----�������O
  arystr=split(document.all("search11").value,";")  
  s=s &"  �������O: " & arystr(1)
  t=t & " and rtcustadslcmty.comtype" & arystr(0) 
  if aryStr(0)="" then
     t=t & " and (rtCUSTADSL.dropdat is null and rtcustadsl.agree <>'N' ) "
  elseif aryStr(0)="1" then
     t=t & ""     
  elseif aryStr(0)="2" then
     t=t & " and (rtCUSTADSLcmty.ADSLapply is not null ) "
  elseif aryStr(0)="3" then
     t=t & " and (rtCUSTADSLcmty.LINEARRIVE is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) "
  elseif aryStr(0)="4" then
     t=t & " and (rtCUSTADSLcmty.SNDWRKPLACE is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) " _
         & " AND (rtCUSTADSLcmty.LINEARRIVE is null)  "     
  elseif aryStr(0)="5" then
     t=t & " and (rtCUSTADSLcmty.EQUIPARRIVE is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) " _
         & " AND (rtCUSTADSLcmty.LINEARRIVE is null) AND (RTCUSTADSLCMTY.SNDWRKPLACE IS NULL) "     
  elseif aryStr(0)="6" then
     t=t & " and (rtCUSTADSLcmty.CASESNDWRK is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) " _
         & " AND (rtCUSTADSLcmty.LINEARRIVE is null) AND (RTCUSTADSLCMTY.SNDWRKPLACE IS NULL) " _
         & " AND (RTCUSTADSLCMTY.EQUIPARRIVE IS NULL ) "
  elseif aryStr(0)="7" then
     t=t & " and (rtCUSTADSLcmty.rcvd is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) " _
         & " AND (rtCUSTADSLcmty.LINEARRIVE is null) AND (RTCUSTADSLCMTY.SNDWRKPLACE IS NULL) " _
         & " AND (RTCUSTADSLCMTY.EQUIPARRIVE IS NULL ) AND (RTCUSTADSLCMTY.CASESNDWRK IS NULL) " 
  elseif aryStr(0)="8" then
     t=t & " and (rtCUSTADSLcmty.SURVYDAT is NOT null) AND (RTCUSTADSLCMTY.ADSLAPPLY IS NULL) " _
         & " AND (rtCUSTADSLcmty.LINEARRIVE is null) AND (RTCUSTADSLCMTY.SNDWRKPLACE IS NULL) " _
         & " AND (RTCUSTADSLCMTY.EQUIPARRIVE IS NULL ) AND (RTCUSTADSLCMTY.CASESNDWRK IS NULL) " _
         & " AND (RTCUSTADSLCMTY.RCVD IS NULL ) "        
  end if
  s3=document.all("search3").value
  if S3 <> "*" and s3<>"�L�k�k��" then
     t=t &" AND (RTCTYTOWN.OPERATIONNAME='" & S3 & "') AND rtcode.parm1='AA' "
  elseif s3="�L�k�k��" then
     t=t &" AND (RTCTYTOWN.OPERATIONNAME='') and rtcode.parm1='AA' "
  end if
  s4=document.all("search4").value
  s4ary=split(s4,";")
  t1=""
  if s4ary(0)="" then
     S=S & "  ���`���:���z��  "
  else
     s=s & "  ���`���:" & s4ary(1) & "  "
     t1=t1 & "  having (SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.cusid <> '' THEN 1 ELSE 0 END)- " _
         &"SUM(CASE WHEN rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '' THEN 1 ELSE 0 END)- " _
         &"SUM(CASE WHEN rtcustadsl.dropdat   IS NOT NULL OR rtcustadsl.dropdat <> ''   THEN 1 ELSE 0 END)) > 0 " 

  end if  
  s6=document.all("search6").value
  s=S & "�g�P��:" &S6 &"  "
  if S6 <> "*" AND S6 <> "���P" then
     t=t &" AND (RTCODE.CODENC='" & S6 & "') "
  ELSEIF S6="���P" THEN 
     t=t &" AND (RTCODE.PARM1='AA') "
  end if
  
  s7=document.all("search7").value    
  if isdate(s7) then
     s=s & "�ӽФ�ۡJ" & s7 & " �H�ӡA"
     t=t & " and rtcustadsl.rcvd >= '" & s7 & "' "
  end if
  s8=document.all("search8").value  
  iF Isnumeric(S8) then
     s=s & "�˾��ɶ��W�L�J" & s8 & " �� "
     t=t & " and (( datediff(dd,rtcustadsl.rcvd,rtcustadsl.finishdat) > " & S8 & " and rtcustadsl.rcvd is not null) or ( datediff(dd,rtcustadsl.rcvd,getdate()) > " & S8 & " and rtcustadsl.finishdat is null)) "
  end if  
  s10=document.all("search10").value  
  if len(trim(s10)) <> "" then
     s=s & "  �����q�ܥ]�t�J" & s10 &  "  "
     t=t & " and (rtcustadslcmty.cmtytel like '%" & s10 & "%') "
  end if
  s12=document.all("search12").value  
  if len(trim(s12)) <> "" then
     s=s & "  ���Ͻu��IP�t�J(" & s12 &  ")  "
     t=t & " and (rtcustadslcmty.IPADDR like '%" & s12 & "%') "
  end if  
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchQry2").value=t1
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
<table width="100%">
  <tr class=dataListTitle align=center>ADSL���ϰ򥻸�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">��B�I</td>
    <td width="60%" bgcolor="silver">
      <select name="search3" size="1" class=dataListEntry ID="Select1">
        <%=S3%>
    </select>      
    </td></tr>        
<tr><td class=dataListHead width="40%">�g�P��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search6" size="1" class=dataListEntry ID="Select1">
        <%=S6%>
    </select>      
    </td>
</tr>    
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr> 
<tr><td class=dataListHead width="40%">����HB���X</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry> 
    </td></tr> 
<tr><td class=dataListHead width="40%">���Ͻu��IP</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search12" class=dataListEntry ID="Text2"> 
    </td></tr>     
<tr><td class=dataListHead width="40%">�������O</td>
    <td width="60%" bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry>
        <%=s11%>
      </select>
    </td></tr>     
<tr><td class=dataListHead width="40%">�����q�ܸ��X</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search10" class=dataListEntry ID="Text1"> 
    </td></tr>     
<tr><td class=dataListHead width="40%">�]�Ʀa�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search9" class=dataListEntry> 
    </td></tr> 
<tr><td class=dataListHead width="40%">���`���</td>
    <td width="60%" bgcolor="silver">
      <select name="search4" size="1" class=dataListEntry>
        <option value=";���z��">���z��</option>
        <option value="1;�u�D�靈���`�Ȥᤧ����">�u�D�靈���`�Ȥᤧ����</option>
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
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>