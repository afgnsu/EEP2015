<!-- #include virtual="/WebUtilityV4/DBAUDI/keyList.inc" -->
<!-- #include virtual="/WebUtilityV4/DBAUDI/cType.inc" -->
<%
  Dim company,system,title,buttonName,buttonEnable,DSN,formatName,sqlList,sqlListOrder,numberOfKey,sqlDelete
  Dim dataTable,dataProg,dataWindowFeature,accessMode,dataProgParm
  Dim diaWidth,diaHeight,diaTitle,diaButtonName,extTable,extTableKey,extDeleList(20),userDefineDelete
  Dim aryKeyName,aryKeyType(100),aryKeyNameDB(100)
  Dim goodMorning,goodMorningAns,goodMorningImage,colSplit
  Dim keyListPageSize,keyListPage,totalPage
  Dim functionOptName,functionOptProgram,functionOptPrompt,functionoptopen
  Dim searchProg,searchQry,searchShow,searchFirst
  Dim aryParmKey,parmKey,searchwindowfeature,optionwindowfeature
  Dim detailwindowFeature,rscount,searchqry2
  searchFirst=False
  userDefineDelete="No"
  functionOptPrompt=";;;;;;;;;;;;;;;;;;"
  keyListPageSize=0
  keyListPage=1
  colSplit=1
  searchQry=Request("searchQry")
  searchqry2=request("searchqry2")
  searchShow=Request("searchShow")
  parmKey=Request("Key")
  aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
  Call SrEnvironment
  aryKeyName=Split(formatName,";")
  goodMorningAns=Request("goodMorningAns")
  If goodMorningAns="Yes" Then
     goodMorning=False
  End If
  If goodMorning Then
     Call SrWelcome
  Else
     Call SrNormal
  End If
%>
<%Sub SrNormal%>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="Content-Language" content="zh-tw">
<link REL="stylesheet" HREF="/webUtilityV4/DBAUDI/keyList.css" TYPE="text/css">
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<!-- #include virtual="/WebUtilityV4/DBAUDI/deleteDialogue.inc" -->
<script language="vbscript">
Sub runAUDI(accessMode,key)
    Dim prog,strFeature,msg
    prog="<%=dataProg%>"
    If prog="None" Then
    Else
       Randomize  
       prog="<%=dataProg%>?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
      
       strFeature="<%=detailWindowFeature%>"
       if strfeature="" then
          Scrxx=window.screen.width
          Scryy=window.screen.height - 30
          StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
                    &"location=no,menubar=no,width=" & scrxx & "px" _
                    &",height=" & scryy & "px"
       end if              
       Set diagWindow=Window.Open(prog,"diag",strFeature)
    End If
End Sub
Sub runDelete()
    diawidth="<%=diawidth%>"
    diaheight="<%=diaheight%>"
    if diawidth="" and diaheight="" then
       diawidth=window.screen.width
       diaHeight=window.screen.height - 30
    end if
    Call deleteDialogue(diaWidth,diaHeight,"<%=diaTitle%>","<%=diaButtonName%>",<%=colSplit%>)
End Sub
Sub runOptProg(opt)
    Dim aryOptProg,selItem,prog,diagWindow,sureRun,aryOptPrompt,aryOptName
    aryOptProg=Split("<%=functionOptProgram%>",";")
    aryOptPrompt=Split("<%=functionOptPrompt%>",";")
    aryOptName=Split("<%=functionOptName%>",";")
    '2001/8/30-S
    aryOptOpen=Split("<%=functionOptOpen%>",";")    
    '2001/8/30-E
    StrFeature="<%=optionwindowFeature%>"
    if strfeature="" then
       Scrxx=window.screen.width
       Scryy=window.screen.height - 30
       StrFeature="top=0,left=0,scrollbars=yes,status=yes," _
                 &"location=no,menubar=no,width=" & scrxx & "px" _
                 &",height=" & scryy & "px" 
    end if       
    if DiaWidth="" THEN
       DiaWidth=window.screen.width
    end if
    if DiaHeight="" then
       DiaHeight=window.screen.height - 30
    End if
    selItem=0
    '��"H"��,��������DO ...LOOP�j��,�_�h��]�D�藍��SEL�ȦӤ��_
 '   if aryoptprompt(opt) <> "H" then
    Do
         i=i+1
         sel=""
         sel=document.all("sel" &i).value
         On Error Resume Next
         If sel="T" Then
            selItem=i
         End IF

 '   end if
    sureRun=1
    '��aryoptprompt="H"��,��ܤ��ݬD��@�����,�Ӫ����I�s�{��
      If selItem <> 0 Then
         Randomize  
         prog=aryOptProg(opt) &"?V=" &Rnd() &"&key=" &document.all("key" &selItem).value
      '   If aryOptPrompt(opt)<>"N" Then sureRun=Msgbox("�T�{����\��ﶵ---" &aryOptName(opt),vbOKCancel)    
      '�� functionoptopen(OPT)="1" :��@��window�}��,"2"��dialog�}��
         If sureRun="2" Then 
            Set diagWindow=Window.showmodaldialog(prog,"d2","dialogWidth:" & diawidth & "px;dialogHeight:" & diaheight &"px;")  
         else
            Set diagWindow=Window.open(prog,"",StrFeature)
         end if 
      Else
       '  Msgbox("�b�z����\��ﶵ�e�A�Х��D��@�����")
      End If
      selitem=0
   Loop until i >= 20
End Sub
Sub runSearchOpt()
    Dim prog,sure
<%If  searchProg="" Or searchProg="self" Then
  Else%>
    StrFeature="<%=SearchwindowFeature%>"
    if strfeature="" then
       Scrxx=window.screen.width
       Scryy=window.screen.height - 30
       StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
                 &"location=no,menubar=no,width=" & scrxx & "px" _
                 &",height=" & scryy & "px"
    end if        
    prog="<%=searchProg%>"
    Set diagWindow=Window.Open(prog,"search",StrFeature)
    diagWindow.focus()
<%End If%>
End Sub
Sub Srclose()  
  on error resume next
  Dim winP
  Set winP=window.Opener
  winP.focus()
  window.close  
End Sub
</script>
</head>
<%If searchFirst Then%>
<body onLoad="runSearchOpt()">
<%Else%>
<body bgcolor="C3C9D2">
<%End If%>
<table width="100%" cellPadding=0 cellSpacing=0>
  <tr class=keyListTitle><td width="20%" align=left><%=Request.ServerVariables("LOGON_USER")%></td>
                         <td width="60%" align=center><%=company%></td>
                         <td width="20%" align=right><%=datevalue(Now())%></td></tr>
  <tr class=keyListTitle><td>&nbsp;</td><td align=center><%=system%></td><td>&nbsp;</td></tr>
  <tr class=keyListTitle><td>&nbsp;</td><td align=center><%=title%></td><td>&nbsp;</td></tr>
</table>
<p>
<%
  Dim listKey,sql,list,aryButton,aryButtonEnable,i,aryOptName
' -------------- deleteList(DSN,dataTable,sqlDelete,numberOfKey,extTable) ------------------------------------------------
  list=deleteList(DSN,dataTable,sqlDelete,numberOfKey,extTable)
' ---------------------------------
' sql=sqlList &list &sqlListOrder
' ----------------------------------
  sql=sqlList
' -------------- keyList(DSN,sql,entProgram,accessMode,numberOfKey) -----------------------------
  listKey=keyList(DSN,sql,"runAUDI",accessMode,numberOfKey)
  aryButton=Split(buttonName &";;;;",";")
  aryButtonEnable=Split(buttonEnable &";N;N;N;N;N;N",";")
%>
<table width="100%" cellPadding=0 cellSpacing=0> 
  <tr><td align=right>
<%If aryButtonEnable(0)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(0)%>" onClick="runAUDI 'A','<%=parmKey%>'">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(1)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(1)%>" onClick="runDelete">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(2)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(2)%>" onClick="SrClose()">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(3)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(3)%>" onClick="KeyForm.Submit">
<%End If%>
<div>
<%If aryButtonEnable(4)="Y" Then%>
          <span onMouseOver="" onMouseOut="">
          <input type="button" class=keyListButton 
                 value="<%=aryButton(4) &":" &keyListPage &"/" &TotalPage%>">
          <span id="pageOpt" style="">
             <input type="button" class=keyListButton value="�Ĥ@��" 
                onClick="keyForm.currentPage.Value=1:keyForm.Submit">
             <input type="button" class=keyListButton value="�W�@��" 
                onClick="keyForm.currentPage.Value=keyForm.currentPage.Value-1:keyForm.Submit">
             <input type="button" class=keyListButton value="�U�@��" 
                onClick="keyForm.currentPage.Value=keyForm.currentPage.Value+1:keyForm.Submit">
             <input type="button" class=keyListButton value="�̥���" 
                onClick="keyForm.currentPage.Value=<%=TotalPage%>:keyForm.Submit">
          </span>
          </span>
<%End If%>
<%If aryButtonEnable(5)="Y" Then%>
          <span onMouseOver="" onMouseOut="">
          <input type="button" class=keyListButton 
                 value="<%=aryButton(5)%>">
          <span id="functionOpt" style="">
<%   aryOptName=Split(functionOptName,";")
     For i = 0 To Ubound(aryOptName)%>
             <input type="button" class=keyListButton value="<%=aryOptName(i)%>"
                    onClick="runOptProg('<%=i%>')">
<%   Next%>
          </span>
          </span>
<%End If%>
</div>
  </td></tr>
</table>
<p>
<form method=post name="keyForm">
<%
  If searchProg <> "" Then 
  countshow="  �@��(" & rscount & ")����ƲŦX" %>
<table width="100%" cellPadding=0 cellSpacing=0>
 <tr><td width="10%"><input type="button" value="�j�M����" class=keyListSearch onClick="runSearchOpt"></td>
     <td width="90%" class=keyListSearch2><%=searchShow%><%=countshow%>
         <input type="text" name="searchShow" value="<%=searchShow%>" style="display:none" readonly>
         <input type="text" name="searchQry" value="<%=searchQry%>" style="display:none" readonly>
         <input type="text" name="searchQry2" value="<%=searchQry2%>" style="display:none" readonly></td>
 </tr>
</table>
<p>
<%End If%>
<%=listKey%>
</form>
<p>
</body>
</html>
<%End Sub%>
<%Sub SrWelcome%>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="Content-Language" content="zh-tw">
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<script language=vbscript>
Sub newWindow
    prog="<%=Request.ServerVariables("PATH_INFO")%>?goodMorningAns=Yes"
    strFeature="<%=dataWindowFeature%>"
    if strfeature="" then
       Scrxx=window.screen.width
       Scryy=window.screen.height - 30
       StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
                 &"location=no,menubar=no,width=" & scrxx & "px" _
                 &",height=" & scryy & "px"
    end if    
    Set objWindow=Window.Open(prog,"NewWindow",strFeature)
    objWindow.focus()
End Sub
</script>
</head>
<center>
<body onClick="newWindow" style="cursor:hand" BGCOLOR="lightblue">
<form name="form" method="post">
<table width="100%" cellPadding=0 cellSpacing=0>
  <tr class=keyListTitle><td width="20%" align=left><%=Request.ServerVariables("LOGON_USER")%></td>
                         <td width="60%" align=center><%=company%></td>
                         <td width="20%" align=right><%=Now()%></td><tr>
  <tr class=keyListTitle><td>&nbsp;</td><td align=center><%=title%></td><td>&nbsp;</td><tr>
</table>
<P>�t�Τ��i
<table widtH="100%" border=1 cellPadding=0 cellSpacing=0 bgcolor="lightyellow">
<!--
  <tr><td background="<%=goodMorningImage%>" height="400" width="400">&nbsp;</td></tr>
-->
  <tr bgcolor="darkseagreen"><TD ALIGN="CENTER">���</TD><TD ALIGN="CENTER">���@�i�@�ơ@��</TD></TR>
  <TR bgcolor=lightyellow><td>90/08/15<img src="/webap/image/newicon.gif"></TD><TD>�����q(��ƳB)ADSL�Ȥ��ƫ��ɧ@�~�ק粒��!</TD></tr>  
  <TR bgcolor=silver><td>90/08/13</TD><TD>HI-Building�Ȥ�h���κM�P��Ƭd�ߧ@�~�W�u!</TD></tr>    
  <TR bgcolor=lightyellow><td>90/08/09</TD><TD>ADSL�Ȥ�u�W�ӽи�Ƭd�ߧ@�~�W�u!</TD></tr>      
  <tr><td><input type="text" name="goodMorningAns" value="No" style="display:none;"></td></tr>
</table>
</form>
</body>
</html>
<%End Sub%>
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL�Ȥ�P���ϳs���D��@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
 ' AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
 ' ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  buttonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�T�{�[�J"
  functionOptProgram="RTJOINCUSTCfm.ASP"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�Ȥ�W��;�ӽг渹;���ϦW��;�ӽФ�;�e����;�w�}�q��;���u��;�˾��a�};�p���q��"
   sqlDelete="SELECT rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj.SHORTNC,rtsparqadslcust.orderno,rtsparqadslcust.HOUSENAME, " _
         &"rtsparqadslcust.RCVD,rtsparqadslcust.DELIVERDAT, " _
         &"case when rtsparqadslcust.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) " _
         &"when rtsparqadslcust.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtsparqadslcust.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtsparqadslcust.chtsigndat) " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtsparqadslcust.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtsparqadslcust.deliverdat)  end ," _
         &"rtsparqadslcust.finishdat," _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME " _
         &"FROM rtsparqadslcust INNER JOIN " _
         &"RTObj ON rtsparqadslcust.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE rtsparqadslcust.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj.shortnc "
  dataTable="rtsparqadslcust"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20
  searchFirst=true
  searchProg="RTCustS.asp"
  If searchQry="" Then
     searchShow="�������s�����Ϥ��Ȥ�(���t�M�P�ΰh����)"
     searchQry="rtsparqadslcust.CUSID ='*' AND rtsparqadslcust.comq1=0 "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'USERLEVEL=2�~�ȤH��(�u��ݨ���ݷ~�ȲէO���)
  IF USERLEVEL = 2 THEN
  sqllist="SELECT  rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj.SHORTNC,rtsparqadslcust.orderno,rtsparqadslcust.HOUSENAME, " _
         &"rtsparqadslcust.RCVD,rtsparqadslcust.DELIVERDAT, " _
         &"case when rtsparqadslcust.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) " _
         &"when rtsparqadslcust.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtsparqadslcust.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtsparqadslcust.chtsigndat) " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtsparqadslcust.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtsparqadslcust.deliverdat)  end ," _
         &"rtsparqadslcust.finishdat," _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME " _
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj ON rtsparqadslcust.CUSID = RTObj.CUSID INNER JOIN " _
         &"RTSalesGroupREF ON " _
         &"rtsparqadslcust.BUSSID = RTSalesGroupREF.EMPLY LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " & " AND " _
         &"(RTSalesGroupREF.AREAID + RTSalesGroupREF.GROUPID = " _
         &"(SELECT areaid + groupid " _
         &"FROM RTSalesGroupREF " _
         &"WHERE emply = '" &emply & "')) " _
         &"ORDER BY RTCounty.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2, " _
         &"RTObj.SHORTNC "

  ELSE
  sqllist="SELECT  rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj.SHORTNC,rtsparqadslcust.orderno,rtsparqadslcust.HOUSENAME, " _
         &"rtsparqadslcust.RCVD,rtsparqadslcust.DELIVERDAT, " _
         &"case when rtsparqadslcust.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtsparqadslcust.WORKINGREPLY) " _
         &"when rtsparqadslcust.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtsparqadslcust.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtsparqadslcust.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtsparqadslcust.chtsigndat) " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtsparqadslcust.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtsparqadslcust.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtsparqadslcust.deliverdat)  end ," _
         &"rtsparqadslcust.finishdat," _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME " _
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj ON rtsparqadslcust.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " _
         &"ORDER BY RTCOUNTY.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj.shortnc "
   END IF
  'Response.Write "sql=" & SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
