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
  ConsigneeID = document.all("hidden1").value
    t =" rtsparqaDslCmtyx.Consignee ='" &Cstr(ConsigneeID)& "' "
  s=""
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="�Ȥ�W�١G�t('" & s1 & "')�r��"  
     t=t & " and RTObj_1.cusnc like '%" & s1 & "%' "
  else
     s="�Ȥ�W�١G����  "
     t=t & " and rtsparqaDslCustx.cusid <> '*' "
  end if
  's2=document.all("search2").value
  's2ary=split(s2,";")
  
  's=S & "�ȪA�^�Ъ��p�G" & s2ary(1)  
  'if s2ary(0) <> "" then
  '   t=t & " and rtsparqaDslCustx.REPLYDATE IS " & s2ary(0) 
  'end if
  
  's3=document.all("search3").value
  's4=document.all("search4").value
  's5=document.all("search5").value
  'if len(trim(s3))>0 then
  '   t=t & " and singlecustadsl.stockid='" & s3 & "' "
  'end if
  'if len(trim(s4))>0 then
  '   t=t & " and singlecustadsl.branch='" & s4 & "' "
  'end if  
  'if len(trim(s5))>0 then
  '   t=t & " and singlecustadsl.bussman='" & s5 & "' "
  'end if    
  s6=document.all("search6").value
  if len(trim(s6))>0 then
     t=t & " and RTCOUNTY.CUTNC + rtsparqaDslCustx.TOWNSHIP2 + rtsparqaDslCustx.RADDR2 like '%" & s6 & "%' "
     s=S & "�@�˾��a�}�G�t('" & s6 & "')�r��"
  end if  
  s7=document.all("search7").value
  if len(trim(s7))>0 then
     t=t & " and rtsparqaDslCmtyx.comn like '%" & s7 & "%' "
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
							<input type="button" value=" �d�� " class="dataListButton" name="btn" style="cursor:hand">
							<input type="button" value=" ���� " class="dataListButton" name="btn1" style="cursor:hand">
							<input type="hidden" name ="hidden1" value="<%=Session("UserID")%>" ID="Hidden1">
		</form>
	</body>
</html>