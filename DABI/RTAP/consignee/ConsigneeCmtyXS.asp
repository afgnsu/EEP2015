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
  ConsigneeID = document.all("hidden1").value

  t =" RTSparqAdslCmtyX.Consignee ='" &Cstr(ConsigneeID)& "' "
  
  '----���ϦW��
  r=document.all("search1").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &" and (RTSparqAdslCmtyX.Comn <> '*') "
  Else
     s=s &"  ���ϦW��:" &r & " "
     t=t &" and (RTSparqAdslCmtyX.ComN LIKE '%" &r &"%') " 
  End If
  
  '----�i�ת��p
  arystr=split(document.all("search2").value,";")
  s=s &"  �i�ת��p:" & aryStr(1)
  if aryStr(0)="" then
     t=t & " and (rtsparqadslcustX.dropdat is null and rtsparqadslcustX.agree <>'N' ) "
  elseif aryStr(0)="1" then
     t=t & ""     
  elseif aryStr(0)="2" then
     t=t & " and (RTSparqAdslCmtyX.AGREE ='Y') "
  elseif aryStr(0)="3" then
     t=t & " and (RTSparqAdslCmtyX.AGREE = 'N') "
  elseif aryStr(0)="4" then
     t=t & " and (RTSparqAdslCmtyX.SURVYDAT is null) "     
  end if
  
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
  <tr class=dataListTitle align=center>ADSL���e����ϸ�Ʒj�M����</td><tr>
</table>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead width="40%">���ϦW��</td>
    <td width="60%" bgcolor="silver">
      <input type="text" size="20" name="search1" class=dataListEntry> 
    </td></tr>    
<tr><td class=dataListHead width="40%">�i�ת��p</td>
    <td width="60%"  bgcolor="silver">
      <select name="search2" size="1" class=dataListEntry>
   <!--
        <option value=";����(���t�M�P�B�h���B���i�ظm��)" selected>����(���t�M�P�B�h���B���i�ظm��)</option>
        -->
        <option value="1;����" selected>����</option>
        <option value="2;�P�N�ظm">�P�N�ظm</option>
        <option value="3;���P�N�ظm">���P�N�ظm</option>
        <option value="4;�|������">�|������</option>
      </select>
     </td>
</tr>
</table>
<table width="100%" align=right><tr><TD><input type="hidden" name ="hidden1" value="<%=Session("UserID")%>"></td><td align="right">
  <input type="submit" value=" �d�� " class=dataListButton name="btn" style="cursor:hand" onsubmit="btn_onclick">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>