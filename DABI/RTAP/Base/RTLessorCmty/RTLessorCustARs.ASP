
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  dim aryStr,s,t,r
  '應收應付帳款狀態
  s1ary=split(document.all("search1").value,";")
  if s1ary(0)="" then
     t=t & " RTLessorCustar.cusid <> '' "
     s="全部 "
  elseif s1ary(0)="1" then
     t=t & " RTLessorCustar.canceldat is null and ( RTLessorCustar.amt - RTLessorCustar.realamt = 0 ) "
     s="已結案 "
  elseif s1ary(0)="2" then
     t=t & " RTLessorCustar.canceldat is null and ( RTLessorCustar.amt - RTLessorCustar.realamt <> 0 ) "
     s="未結案 "
  elseif s1ary(0)="3" then
     t=t & " RTLessorCustar.canceldat is not null  "
     s="已作廢 "
  elseif s1ary(0)="4" then
     t=t & " RTLessorCustar.canceldat is null  "
     s="全部(不含作廢) "
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
Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="search" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
End Sub 
Sub btn1_onClick()  
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub
-->
</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"       codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<body>
<table width="100%">
  <tr class=dataListTitle align=center>ET-City用戶應收應付帳款資料搜尋條件</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="40%">應收應付帳款狀態</td>
    <td width="60%"  bgcolor="silver">
      <select name="search1" size="1" class=dataListEntry ID="Select1">
        <option value=";全部" selected>全部</option>
        <option value="1;已沖帳">已沖帳</option>
        <option value="2;未沖帳">未沖帳</option>
        <option value="3;已作廢">已作廢</option>      
        <option value="4;全部(不含作廢)">全部(不含作廢)</option>                     
      </select>
     </td>
</tr>    
</table>
<p>
<table width="100%" align=right><tr><TD></td><td align="right">
  <input type="SUBMIT" value=" 查詢 " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" 結束 " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>