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

  t =" RTSparqAdslCmty.Consignee ='" &Cstr(ConsigneeID)& "' "
  
  '----���ϦW��
  r=document.all("search1").value  
  If Len(r)=0 Or r="" Then
     s=s &"  ���ϦW��:���� "  
     t=t &" and (RTSparqAdslCmty.Comn <> '*') "
  Else
     s=s &"  ���ϦW��:" &r & " "
     t=t &" and (RTSparqAdslCmty.ComN LIKE '%" &r &"%') " 
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
  <tr class=dataListTitle align=center>ADSL���ϰ򥻸�Ʒj�M����</td><tr>
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
</table>
<table width="100%" align=right><tr><TD><input type="hidden" name ="hidden1" value="<%=Session("UserID")%>"></td><td align="right">
  <input type="SUBMIT" value=" �d�� " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>