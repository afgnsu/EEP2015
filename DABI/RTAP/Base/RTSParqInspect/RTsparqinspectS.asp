<%
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open "DSN=RTLib"
'--------- �^�Ъ��A
    rs.Open "SELECT code,codenc from rtcode where kind='F1' " _
           &"ORDER BY CODE ",conn
    sX1="<option value=""*;�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       sX1= sX1 & "<option value=""" & rs("CODE") & ";" & "�G" &  rs("CODENC") & """>" & rs("CODENC") & "</option>" & vbcrlf
    rs.movenext
    Loop
    rs.Close
'--------- ���d�u�{�v
    rs.Open "SELECT RTObj.SHORTNC, RTEmployee.EMPLY, RTSalesGroup.GROUPNC " _
           &"FROM RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
           &"RTSalesGroupREF ON RTEmployee.EMPLY = RTSalesGroupREF.EMPLY AND " _
           &"RTSalesGroupREF.EDATE IS NULL INNER JOIN RTSalesGroup ON RTSalesGroupREF.AREAID = RTSalesGroup.AREAID AND " _
           &"RTSalesGroupREF.GROUPID = RTSalesGroup.GROUPID " _
           &"WHERE (RTEmployee.TRAN1 <> '10') " _
           &"ORDER BY  RTSALESGROUP.GROUPNC,RTObj.SHORTNC ",conn
    sX2="<option value=""*;�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       sX2= sX2 & "<option value=""" & rs("EMPLY") & ";" & "�G" & RS("GROUPNC") &"-" & rs("SHORTNC") & """>"  & RS("GROUPNC") &"-" & rs("SHORTNC") & "</option>" & vbcrlf
    rs.movenext
    Loop
    rs.Close    
'--------- ���d�g�P��
    rs.Open "SELECT RTConsignee.CUSID , RTObj.SHORTNC FROM RTConsignee INNER JOIN RTObj ON RTConsignee.CUSID = RTObj.CUSID " _
           &"ORDER BY RTConsignee.CUSID ",conn
    sX3="<option value=""*;�G����"" selected>����</option>" &vbCrLf           
    Do while not rs.EOF
       sX3= sX3 & "<option value=""" & rs("CUSID") & ";" & "�G" &  rs("SHORTNC") & """>" & rs("SHORTNC") & "</option>" & vbcrlf
    rs.movenext
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
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<script language="VBScript">
<!--
Sub btn_onclick()
  dim s,t
  t=""
  s=""
  s1=document.all("search1").value
  IF LEN(TRIM(s1)) <> 0 THEN
     s=s &" �Τ�W�١J�]�t('" & S1 & "') "
     t=t & " AND (RTSparqADSLINSPECT.CUSNC like '%" & s1 & "%') " 
  ELSE
     t=t & " AND (RTSparqADSLINSPECT.CUSNC <> '*') " 
  end if
  s2=document.all("search2").value
  IF LEN(TRIM(s2)) <> 0 THEN
     s=s &" ���ϦW�١J�]�t('" & S2 & "') "
     t=t & " and (RTSparqADSLINSPECT.COMN like '%" & s2 & "%') " 
  end if  
  s3=document.all("search3").value  
  IF LEN(TRIM(s3)) <> 0 THEN
     s=s &" �˾��a�}�J�]�t('" & S3 & "') "
     t=t & " and (RTCounty.CUTNC + RTSparqADSLINSPECT.TOWNSHIP + RTSparqADSLINSPECT.ADDRESS  like '%" & s3 & "%') " 
  end if    
  s4ary=split(document.all("search4").value,";")
  if s4ary(0)="2" then
     s=s &" �O���ץ�J" & s4ary(1)
     t=t & " and (( RTSparqADSLINSPECT.REPLYDAT is not null and RTSparqADSLINSPECT.INSPECTDAT is not null and datediff(d,RTSparqADSLINSPECT.INSPECTDAT,RTSparqADSLINSPECT.REPLYDAT) > 7 ) or " _
         &" ( RTSparqADSLINSPECT.REPLYDAT is null and RTSparqADSLINSPECT.INSPECTDAT is not null and datediff(d,RTSparqADSLINSPECT.inspectDAT,getdate()) > 7 )) "      
  end if  
  s5ary=split(document.all("search5").value,";")  
  if s5ary(0) <> "*" then
     S=s & " ���d���G" & s5ary(1) 
     't=t & " and RTCode_1.CODENC ='" & s5ary(1) & "' " 
     t=t & " and RTSparqADSLINSPECT.INSEPCTRESULT ='" & s5ary(0) & "' " 
  END IF
  s6ary=split(document.all("search6").value,";")  
  if s6ary(0) <> "1" then
     S=s & " �@�o���A='" & s6ary(1) & "' "
     if s6ary(0)="2" then
        t=t & " and RTSparqADSLINSPECT.DROPDAT is not null "
     else
        t=t & " and RTSparqADSLINSPECT.DROPDAT is null "
     end if
  END IF  
  s7=Document.all("search7").value    
  s8=Document.all("search8").value    
  s9=Document.all("search9").value    
 s10=Document.all("search10").value      
  if len(trim(s7))>0 or len(trim(s8))>0 then
     if len(trim(s7))=0 then S7="1911/01/01"
     if len(trim(s8))=0 then S8="9999/12/31"
     S=S & " �����_���J" & s7 & "-" & s8
     t=t & " and RTSparqADSLINSPECT.RCVDAT >='" & S7 & "' and RTSparqADSLINSPECT.RCVDAT <='" & S8 & "' " 
  end if
  if len(trim(s9))>0 or len(trim(s10))>0 then
     if len(trim(s9))=0 then S9="1911/01/01"
     if len(trim(s10))=0 then S10="9999/12/31"  
     S=S & " ������_���J" & s9 & "-" & s10
     t=t & " and RTSparqADSLINSPECT.INSPECTDAT >='" & S9 & "' and RTSparqADSLINSPECT.INSPECTDAT <='" & S10 & "' "      
  End if
   
  s11ary=split(document.all("search11").value,";")  
  if s11ary(0) <> "1" then
     S=s & " �^�Ъ��A='" & s11ary(1) & "' "
     if s11ary(0)="2" then
        t=t & " and RTSparqADSLINSPECT.replyDAT is not null "
     else
        t=t & " and RTSparqADSLINSPECT.replyDAT is null "
     end if
  END IF    
  s12ary=split(document.all("search12").value,";")  
  if s12ary(0) <> "*" then
     S=s & " ���d�u�{�v='" & s12ary(1) & "' "
     t=t & " and RTSparqADSLINSPECT.INSPECTMAN='" & s12ary(0) & "' "
  END IF      
  s13ary=split(document.all("search13").value,";")    
  if s13ary(0) <> "*" then
     S=s & " ���d�g�P��='" & s13ary(1) & "' "
     t=t & " and RTSparqADSLINSPECT.INSPECTCONSIGNEE='" & S13ARY(0) & "' "
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
Sub btn1_onclick()
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
-->
</script>
</head>
<body>
<center>
<table width="90%" >
  <tr><td class=dataListTitle align=center>�t�ե��e���Ʒj�M����</td></tr>
</table>
<table width="90%" border=1 cellPadding=0 cellSpacing=0 >
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor=silver>
     <input class=dataListEntry name="search1" maxlength=30 size=30 style="TEXT-ALIGN: left" ID="search1">
    </td></tr>
<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%"  bgcolor=silver>
      <input class=dataListEntry name="search2" maxlength=30 size=30 style="TEXT-ALIGN: left" ID="search2"></td></tr>
<tr><td class=dataListHead width="40%">�a�}</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListEntry name="search3" maxlength=50 size=30 style="TEXT-ALIGN: left" ID="search3"></td></tr>
<tr><td class=dataListHead width="40%">�O���ץ�</td>
    <td width="60%"  bgcolor=silver>
      <select name="search4" size="1" class=dataListEntry ID="search4">
        <option value="1;����" selected>����</option>
        <option value="2;�u�D�O����">�u�D�O����</option>
      </select></td></tr>      
<tr><td class=dataListHead width="40%">���d���G</td>
    <td width="60%"  bgcolor=silver>
      <select name="search5" size="1" class=dataListEntry ID="search5">
        <%=SX1%>
      </select></td></tr>   
<tr><td class=dataListHead width="40%">�@�o���A</td>
    <td width="60%"  bgcolor=silver>
      <select name="search6" size="1" class=dataListEntry ID="search6">
        <option value="1;����" selected>����</option>
        <option value="2;�u�D�w�@�o">�u�D�w�@�o</option>
        <option value="3;�u�D���@�o">�u�D���@�o</option>
      </select></td></tr>  
<tr><td class=dataListHead width="40%">�����_��</td>
    <td width="60%"  bgcolor=silver>
    <input class=dataListDATA name="search7" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button"  id="B7" name="B7" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"  name="C7"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">��
     <input class=dataListDATA name="search8" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY >
    <input type="button" id="B8" name="B8" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"   name="C8"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
     </td></tr>     
<tr><td class=dataListHead width="40%">������_��</td>
    <td width="60%"  bgcolor=silver>
     <input class=dataListDATA name="search9" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY  >
         <input type="button" id="B9" name="B9" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"   name="C9"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">��
    <input class=dataListDATA name="search10" maxlength=10 size=10 style="TEXT-ALIGN: left" READONLY  >
    <input type="button" id="B10"  name="B10" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��"   name="C10"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
     </td></tr>  
<tr><td class=dataListHead width="40%">�^�Ъ��A</td>
    <td width="60%"  bgcolor=silver>
      <select name="search11" size="1" class=dataListEntry ID="search11">
        <option value="1;����" selected>����</option>
        <option value="2;�u�D�w�@�o">�u�D�w�^��</option>
        <option value="3;�u�D���@�o">�u�D���^��</option>
      </select></td></tr>     
<tr><td class=dataListHead width="40%">���d�u�{�v</td>
    <td width="60%"  bgcolor=silver>
      <select name="search12" size="1" class=dataListEntry ID="Search12">
        <%=SX2%>
      </select></td></tr>      
<tr><td class=dataListHead width="40%">���d�g�P��</td>
    <td width="60%"  bgcolor=silver>
      <select name="search13" size="1" class=dataListEntry ID="Search13">
        <%=SX3%>
      </select></td></tr>                                   
</table>
<table width="50%" align=right ><tr><td></td>
<td align=right>
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand" ID="btn">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand" ID="btn1">
</td>
</tr></table>
</body>
</html>