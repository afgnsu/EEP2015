<%
 if not Session("passed") then
    Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
 end if

 Dim dspkey(100),DSN
 DSN="DSN=RTLib"
 'dspkey(3)=Request.Form("search3")
 'dspkey(4)=Request.Form("search4")
 'dspkey(5)=Request.Form("search5")
%>
<html>
	<head>
		<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
			<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
				<script language="VBScript">
<!--
Sub btn_onClick()
  dim s,t
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="�Ȥ�W�١G�t('" & s1 & "')�r��"  
     t=t & " and RTObj_1.cusnc like '%" & s1 & "%' "
  else
     s="�Ȥ�W�١G����  "
     t=t & " and rtcust.cusid <> '*' "
  end if

  s6=document.all("search6").value
  if len(trim(s6))>0 then
     t=t & " and RTCOUNTY.CUTNC + rtcust.TOWNSHIP2 + rtcust.RADDR2 like '%" & s6 & "%' "
     s=S & "�@�˾��a�}�G�t('" & s6 & "')�r��"
  end if  
  s7=document.all("search7").value
  if len(trim(s7))>0 then
     t=t & " and RTCmty.comn like '%" & s7 & "%' "
     s=S & "�@���ϦW�١G�t('" & s7 & "')�r��"
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
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  winP.focus()
  window.close
End Sub
Sub SrReNew()
  Window.form.Submit
End Sub
-->
				</script>
	</head>
	<body>
		<form method="post" id="form">
			<center>
				<table width="80%">
					<tr class="dataListTitle" align="center">
					�п�J(���)�Ȥ��Ʒj�M����</td><tr>
				</table>
				<table width="80%" border="1" cellPadding="0" cellSpacing="0">
				
					<tr>
						<td class="dataListHead" width="30%">�Ȥ�W��</td>
						<td width="70%" bgcolor="silver">
							<input type="text" name="search1" size="25" maxlength="25" class="dataListEntry">
						</td>
					</tr>
					<tr>
						<td class="dataListHead" width="30%">�˾��a�}</td>
						<td width="70%" bgcolor="silver">
							<input type="text" name="search6" size="40" maxlength="50" class="dataListEntry">
						</td>
					</tr>
					<tr>
						<td class="dataListHead" width="30%">���ϦW��</td>
						<td width="70%" bgcolor="silver">
							<input type="text" name="search7" size="30" maxlength="60" class="dataListEntry">
						</td>
					</tr>
				</table>
				<table width="80%" align="right">
					<tr>
						<td></td>
						<td align="right">
							<input type="submit" value=" �d�� " class="dataListButton" name="btn" style="cursor:hand" onsubmit="btn_onclick">
							<input type="button" value=" ���� " class="dataListButton" name="btn1" style="cursor:hand">
							<input type="hidden" name ="hidden1" value="<%=Session("UserID")%>" ID="Hidden1">
		</form>
	</body>
</html>
