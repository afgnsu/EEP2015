<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
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
  s1=document.all("search1").value  
  If Len(s1)=0 Or s1="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &"  (A.ComN <> '*') "
  Else
     s=s &"  ���ϦW��:�]�t('" &s1 & "')�r�� "
     t=t &"  (A.ComN LIKE '%" &s1 &"%') " 
  End If
  '----�Τ�W��
  s2=document.all("search2").value  
  If Len(trim(s2)) > 0  Then
     s=s &"  �Τ�W��:�]�t('" &s2 & "')�r�� "
     t=t &" and (c.cusnc LIKE '%" &s2 &"%') " 
  End If
  '----�Τ�˾��a�}
  s3=document.all("search3").value  
  If Len(trim(s3)) > 0  Then
     s=s &"  �Τ�˾��a�}:�]�t('" &s3 & "')�r�� "
     t=t &" and (d.cutnc+b.township2+b.raddr2 LIKE '%" &s3 &"%') " 
  End If
  
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
  <tr class=dataListTitle align=center>ADSL���ϰ򥻸�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�Τ�W��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search2" class=dataListEntry ID="Text1"> 
    </td></tr>        
<tr><td class=dataListHead width="40%">�Τ�a�}</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="40" name="search3" class=dataListEntry ID="Text2"> 
    </td></tr>         
</table>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="submit" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>