<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"
		    codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 >
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub btn_onClick()
  '----���ϦW�� -------------------------------------------------------------------
  r=document.all("search1").value  
  If Len(r) <>0 Or r <>"" Then
     s=s &"  ���ϦW��:" &r & " "
     t=t &"  and b.comn LIKE '%" &r &"%' " 
  End If
  '----���ϦW�� -------------------------------------------------------------------
  r=document.all("search2").value  
  If Len(r) <>0 Or r <>"" Then
     s=s &"  �䲼���Y:" &r & " "
     t=t &" and a.CHECKTITLE LIKE '%" &r &"%' " 
  End If
  '�p��覡 --------------------------------------------------------------------
  s3=document.all("search3").value
  s3ary=split(s3,";")
  IF S3ARY(0) <> "" THEN
     s=s & "�p��覡�J" & s3ary(1) & " "
     if s3ary(0) ="�q��" then
     	t=t & " and x.counttype in ('08','09','10') "
     elseif s3ary(0) ="�D�q��" then
     	t=t & " and x.counttype not in ('08','09','10') "
     else
     	t=t & " and x.counttype='" & s3ary(0) & "' "
	 end if 
  END IF
  '----�_��~�� -------------------------------------------------------------------
  r=document.all("search5").value  
  If Len(r) <>0 Or r <>"" Then
     s=s &"  �_��~��:" &r & " "
     t=t &" and x.strym LIKE '%" &r &"%' " 
  End If
  '----�I��~�� -------------------------------------------------------------------
  r=document.all("search6").value  
  If Len(r) <>0 Or r <>"" Then
     s=s &"  �I��~��:" &r & " "
     t=t &" and x.endym LIKE '%" &r &"%' " 
  End If
  '��קO --------------------------------------------------------------------
  s4=document.all("search4").value
  s4ary=split(s4,";")
  IF S4ARY(0) <> "" THEN
     s=s & "��סJ" & s4ary(1) & " "
     t=t & " and a.CASETYPE='" & s4ary(0) & "' "
  END IF

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
  <tr class=dataListTitle align=center>�q�O�򥻸�Ƭd�߷j�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�䲼���Y</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search2" class=dataListEntry> 
    </td></tr>
<tr><td class=dataListHead width="40%">�ɧU�_���~��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search5" class=dataListEntry> ��
      <input type="text" size="20" name="search6" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="40%">�p��覡</td>
    <td width="60%" bgcolor="silver">    
  <%Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT code,CODENC FROM RTCODE WHERE KIND='R4' order by CODE "
    s="<option value="";"" >(����)</option>" &_
      "<option value=""�q��;�q��"" >(�q��)</option>" &_
      "<option value=""�D�q��;�D�q��"" >(�D�q��)</option>"
    rs.Open sql,conn
    'If rs.Eof Then s="<option value="";"" >(����)</option>"
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
       <select name="search3" size="1" class=dataListEntry>
        <%=s%>
      </select>
    </td>
</tr>
<tr><td class=dataListHead width="40%">���</td>
    <td width="60%" bgcolor="silver">    
  <%Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT code,CODENC FROM RTCODE WHERE KIND='P5' order by CODE "
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
       <select name="search4" size="1" class=dataListEntry>
        <%=s%>
      </select>
    </td></tr>
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>