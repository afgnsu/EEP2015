
<%
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    
    Set rs=Server.CreateObject("ADODB.Recordset")
'----------�g�P��
    S11=""
    rs.Open "SELECT  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE rtcode.CODENC END AS shortnc " _
           &"FROM  rtcmty LEFT OUTER JOIN RTcode ON rtcmty.comtype = RTcode.code AND rtcode.kind = 'B3' " _
           &"GROUP BY  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE RTCODE.CODENC END " _
           &"ORDER BY  CASE WHEN rtcode.parm1 = 'AA' THEN '���P' ELSE RTCODE.CODENC END",CONN
    s11="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s11=s11 &"<option value=""" & rs("SHORTNC") & """>" &rs("SHORTNC") &"</option>"
       rs.MoveNext
    Loop
    rs.Close
'----------��B�I
    S10=""
    rs.Open "SELECT OPERATIONID, OPERATIONNAME FROM RTCtyTown WHERE (OPERATIONNAME <> '') GROUP BY  OPERATIONID, OPERATIONNAME ORDER BY  OPERATIONID ",CONN
    s10="<option value=""*"" selected>����</option>" &vbCrLf    
    Do While Not rs.Eof
       s10=s10 &"<option value=""" & rs("OPERATIONNAME") & """>" &rs("OPERATIONNAME") &"</option>"
       rs.MoveNext
    Loop
    s10=s10 &"<option value=""�L�k�k��"">�L�k�k��</option>"
    rs.Close    
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
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
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="���ϦW�١G�t('" & s1 & "')�r��"  
     t=t & " rtcmty.comn like '%" & s1 & "%' "
  else
     s="���ϦW�١G����  "
     t=t & " rtcust.comq1 <> 0 "
  end if
  s2=document.all("search2").value
  if len(trim(s2)) > 0 then
     s="  �Ȥ�W�١G�t('" & s2 & "')�r��"  
     t=t & " and rtobj.cusnc like '%" & s2 & "%'"
  else
     s=s & "  �Ȥ�W�١G����  "
     t=t & " and rtcust.cusid <>'*'"
  end if  
  s3=document.all("search3").value
  if len(trim(s3)) > 0 then
     s="  HN�p�渹�X�G�t('" & s3 & "')�r��"  
     t=t & " and rtCUST.cusno like '%" & s3 & "%'"
  else
     s=s & "  HN�p�渹�X�G����  "
     t=t & " and rtcust.cusNO <>'*'"
  end if  
  s8=document.all("search8").value
  if len(trim(s8)) > 0 then
     s="  HN�p�渹�X�G�t('" & s8 & "')�r��"  
     t=t & " and rtCUST.idnumber like '%" & s8 & "%'"
  else
  end if  
  s9=document.all("search9").value
  if len(trim(s9)) > 0 then
     s="  IP��}�G�t('" & s9 & "')�r��"  
     t=t & " and rtCUST.IP like '%" & s9 & "%'"
  else
  end if  
  s4=document.all("search4").value
  if len(trim(s4)) > 0 then
     s=S & "  �˾��a�}�G�t('" & s4 & "')�r��"  
     t=t & " and (rtcounty.cutnc + rtcust.township1 + rtcust.raddr1 )  like '%" & s4 & "%'"
  end if      
  s5=document.all("search5").value
  s5ary=split(s5,";")
  if s5ary(0) = "01" then
     s=s & " �Ȥ�s�����A�G" & s5ary(1)
     t=t & " and rtcust.usekind ='�����' "
  elseif s5ary(0) = "02" then
     s=s & "  �Ȥ�s�����A�G" & s5ary(1)    
     t=t & " and rtcust.usekind ='�p�q��' "  
  else
     S=S & " �Ȥ�s�����A�J���� "
  end if        
  s7=document.all("search7").value    
  if isdate(s7) then
     s=s & "�ӽФ�ۡJ" & s7 & " �H�ӡA"
     t=t & " and rtcust.rcvd >= '" & s7 & "' "
  end if
  s6=document.all("search6").value  
  iF Isnumeric(S6) then
     s=s & "�˾��ɶ��W�L�J" & s6 & " �� "
     t=t & " and (( datediff(dd,rtcust.rcvd,rtcust.finishdat) > " & S6 & " and rtcust.rcvd is not null) or ( datediff(dd,rtcust.rcvd,getdate()) > " & S6 & " and rtcust.finishdat is null)) "
  end if
 '----��B�I
  S10=document.all("search10").value
  s="��B�I:" &S10 &"  "
  if S10 <> "*" and s10<>"�L�k�k��" then
     t=t &" AND (RTCTYTOWN.OPERATIONNAME='" & S10 & "') AND rtcode_A.parm1='AA' "
  elseif s10="�L�k�k��" then
     t=t &" AND (RTCTYTOWN.OPERATIONNAME='') and rtcode_A.parm1='AA' "
  end if
  '----�g�P��
  S11=document.all("search11").value
  s=S & "�g�P��:" &S11 &"  "
  if S11 <> "*" AND S11 <> "���P" then
     t=t &" AND (RTCODE_A.CODENC='" & S11 & "') "
  ELSEIF S11="���P" THEN 
     t=t &" AND (RTCODE_A.PARM1='AA') "
  end if  
  s12=document.all("search12").value
  s12ary=split(s12,";")
  if s12ary(0) = "01" then
     s=s & " �Ȥ᪬�A�G" & s12ary(1)
     t=t & " and rtcust.DOCKETDAT IS NOT NULL AND rtcust.DROPDAT IS NULL "
  elseif s12ary(0) = "02" then
     s=s & "  �Ȥ᪬�A�G" & s12ary(1)    
     t=t & " and rtcust.DOCKETDAT IS NOT NULL AND rtcust.DROPDAT IS NOT NULL "
  elseif s12ary(0) = "03" then
     S=S & " �Ȥ᪬�A�G" & s12ary(1)    
     t=t & " and rtcust.DOCKETDAT IS NULL AND rtcust.DROPDAT IS NULL AND rtcust.CANCELDAT IS NULL"
  elseif s12ary(0) = "04" then
     S=S & " �Ȥ᪬�A�G" & s12ary(1)    
     t=t & " and rtcust.CANCELDAT IS NULL"     
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
<tr><td class=dataListHead width="40%">��B�I</td>
    <td width="60%" bgcolor="silver">
      <select name="search10" size="1" class=dataListEntry ID="Select1">
        <%=S10%>
    </select>      
    </td></tr>        
<tr><td class=dataListHead width="40%">�g�P��</td>
    <td width="60%"  bgcolor="silver">
    <select name="search11" size="1" class=dataListEntry ID="Select1">
        <%=S11%>
    </select>      
    </td>
</tr>    
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="15" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�Ȥ�s���覡</td>
    <td width="60%"  bgcolor="silver">
      <select name="search5" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="01;�����">�����</option>
        <option value="02;�p�q��">�p�q��</option>
      </select>
     </td>
</tr>    
<tr><td class=dataListHead width="40%">�����Ҧr��</td>
    <td width="60%" bgcolor="silver" >
    <input type=password name="search8" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="40%">�Ȥ�W��</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search2" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">HN�p�渹�X</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search3" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="40%">IP��}</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search9" size="20" maxlength="15" class=dataListEntry>
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
    </td></tr>            
<tr><td class=dataListHead width="40%">�˾��ɶ��W�L�J</td>
    <td width="60%" bgcolor="silver" >
    <input type=text name="search6" size="3" maxlength="60" class=dataListEntry>
    ��</td></tr>      
<tr><td class=dataListHead width="40%">�Τ᪬�A</td>
    <td width="60%" bgcolor="silver" >
    <select name="search12" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="01;���Ĥ�">���Ĥ�</option>
        <option value="02;�h����">�h����</option>
        <option value="03;�����u��">�����u��</option>
        <option value="04;�@�o��">�@�o��</option>
      </select>
    </td></tr>            
</table>
<table width="70%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</body>
</html>