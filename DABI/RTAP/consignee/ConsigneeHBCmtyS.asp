<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">

<script language="VBScript">

sub btn_onClick()
  
  '----���ϦW��
  r=document.all("search1").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &" and (RTCmty.Comn <> '*') "
  Else
     s=s &"  ���ϦW��:" &r & " "
     t=t &" and (RTCmty.ComN LIKE '%" &r &"%') " 
  End If
  
 
  Dim winP,docP
  Set winP=window.opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End sub

Sub btn1_onClick()  
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub
</script>

</head>
<body>
<table width="100%">
  <tr class=dataListTitle align=center>Hi-Building���ϰ򥻸�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>    
</table>
<table width="100%" align=right><tr><TD><input type="hidden" name ="hidden1" value="<%=Session("UserID")%>"></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" style="cursor:hand" onsubmit="btn_onclick">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>