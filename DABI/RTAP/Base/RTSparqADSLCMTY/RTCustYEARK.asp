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
  Dim detailwindowFeature,rscount,searchqry2,EMAILFIELDNO,EMAILFIELDFLAG
  searchFirst=False
  EMAILFIELDFLAG="N"
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
    DiaWidth="<%=Diawidth%>"
    DiaHeight="<%=DiaHeight%>"
    if DiaWidth="" THEN
       DiaWidth=window.screen.width
    end if
    if DiaHeight="" then
       DiaHeight=window.screen.height - 30
    End if
    selItem=0
    '��"H"��,��������DO ...LOOP�j��,�_�h��]�D�藍��SEL�ȦӤ��_
    if aryoptprompt(opt) <> "H" then
       Do
         i=i+1
         sel=""
         sel=document.all("sel" &i).value
         On Error Resume Next
         If sel="T" Then
            selItem=i
         End IF
       Loop Until sel<>"T" And sel<>"F" Or selItem<>0
    end if
    sureRun=1
    '��aryoptprompt="H"��,��ܤ��ݬD��@�����,�Ӫ����I�s�{��
    if  aryoptprompt(opt)="H" then
        Randomize  
        prog=aryOptProg(opt)
      '�� aryoptopen(OPT)="1" :��@��window�}��,"2"��dialog�}��
        if sureRun="1" then
           If aryoptopen(OPT)="1" Then 
              Set diagWindow=Window.open(prog,"",StrFeature)
           ELSE
              Set diagWindow=Window.showmodaldialog(prog,"d2","dialogWidth:" & diawidth & "px;dialogHeight:" & diaheight &"px;")  
           end if 
        end if
    else
      If selItem <> 0 Then
         Randomize  
         prog=aryOptProg(opt) &"?V=" &Rnd() &"&key=" &document.all("key" &selItem).value
         If aryOptPrompt(opt)<>"N" Then sureRun=Msgbox("�T�{����\��ﶵ---" &aryOptName(opt),vbOKCancel)    
      '�� functionoptopen(OPT)="1" :��@��window�}��,"2"��dialog�}��
         If sureRun="1" Then 
            If aryoptopen(OPT)="1" Then 
               Set diagWindow=Window.open(prog,"",StrFeature)
            else
               Set diagWindow=Window.showmodaldialog(prog,"d2","dialogWidth:" & diawidth & "px;dialogHeight:" & diaheight &"px;")  
              ' if returnvalue=True then
                  document.all("keyform").Submit
             '  end if
            end if 
         end if
      Else
         Msgbox("�b�z����\��ﶵ�e�A�Х��D��@�����")
      End If
    end if
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
  title="�~���~ú�Τ����d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt =""
  functionoptopen   =""
  'EMAIL���INDEX
  EMAILFIELDNO=13
  EMAILFIELDFLAG="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;�Ȥ�W��;ú�O���O;���u��;������;�~����<BR>�����;���q�q��;����;��a�q��;��ʹq��;E-MAIL;��};�g�P��"
   sqlDelete="SELECT    RTSparqAdslCust.comq1,RTSparqAdslCust.CUSID, RTSparqAdslCust.ENTRYNO , RTSparqAdslCmty.COMN , RTObj.CUSNC, " _
            &"RTCode.CODENC, RTSparqAdslCust.FINISHDAT,RTSparqAdslCust.DOCKETDAT," _
            &"CASE WHEN (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  =  12 THEN 0 ELSE (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  END AS DIFFMONTH,RTSparqAdslCust.OFFICE, RTSparqAdslCust.EXTENSION, " _
            &"RTSparqAdslCust.HOME, RTSparqAdslCust.MOBILE, RTSparqAdslCust.EMAIL, " _
            &"RTCounty.CUTNC+RTSparqAdslCust.TOWNSHIP1+RTSparqAdslCust.RADDR1,RTOBJ_2.CUSNC " _
            &"FROM RTSparqAdslCust INNER JOIN RTCode ON RTSparqAdslCust.PAYTYPE = RTCode.CODE AND RTCode.KIND = 'G6' INNER JOIN " _
            &"RTObj ON RTSparqAdslCust.CUSID = RTObj.CUSID INNER JOIN RTSparqAdslCmty ON RTSparqAdslCust.COMQ1 = RTSparqAdslCmty.CUTYID " _
            &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCust.CUTID1 = RTCounty.CUTID left outer join rtOBJ RTOBJ_2 on rtsparqadslcmty.CONSIGNEE=rtOBJ_2.CUSID  WHERE (RTSparqAdslCust.PAYTYPE = 'Y') AND " _
            &"(RTSparqAdslCust.DOCKETDAT IS NOT NULL) AND (RTSparqAdslCust.DROPDAT IS NULL) ORDER BY  RTSparqAdslCust.DOCKETDAT "
  dataTable="rtsparqadslcust"
  userDefineDelete=""
  extTable=""
  numberOfKey=3
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=500,height=200,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="400"
  diaHeight="260"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  searchFirst=false
  If searchQry="" Then
     searchShow=" ���� "
     searchQry="rtsparqadslcust.comq1 <> 0 "
  ELSE
     SEARCHFIRST=FALSE
  END IF
  searchProg="RTCUSTYEARS.ASP"

  sqllist="SELECT   RTSparqAdslCust.comq1, RTSparqAdslCust.CUSID, RTSparqAdslCust.ENTRYNO , RIGHT(RTSparqAdslCmty.COMN,10) , RIGHT(RTObj.CUSNC,10), " _
            &"RTCode.CODENC, RTSparqAdslCust.FINISHDAT,RTSparqAdslCust.DOCKETDAT," _
            &"CASE WHEN (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  =  12 THEN 0 ELSE (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  END AS DIFFMONTH,RTSparqAdslCust.OFFICE, RTSparqAdslCust.EXTENSION, " _
            &"RTSparqAdslCust.HOME, RTSparqAdslCust.MOBILE, RTSparqAdslCust.EMAIL, " _
            &"left(RTCounty.CUTNC+RTSparqAdslCust.TOWNSHIP1+RTSparqAdslCust.RADDR1,10),RTOBJ_2.SHORTNC " _
            &"FROM RTSparqAdslCust INNER JOIN RTCode ON RTSparqAdslCust.PAYTYPE = RTCode.CODE AND RTCode.KIND = 'G6' INNER JOIN " _
            &"RTObj ON RTSparqAdslCust.CUSID = RTObj.CUSID INNER JOIN RTSparqAdslCmty ON RTSparqAdslCust.COMQ1 = RTSparqAdslCmty.CUTYID " _
            &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCust.CUTID1 = RTCounty.CUTID left outer join rtOBJ RTOBJ_2 on rtsparqadslcmty.CONSIGNEE=rtOBJ_2.CUSID  " _
            &"WHERE (RTSparqAdslCust.PAYTYPE = 'Y') AND " _
            &"(RTSparqAdslCust.DOCKETDAT IS NOT NULL) AND (RTSparqAdslCust.DROPDAT IS NULL) AND " & SEARCHQRY & " " _
            &"ORDER BY  CASE WHEN (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  =  12 THEN 0 ELSE (12 - DATEDIFF(Month,RTSparqAdslCust.DOCKETDAT, GETDATE())  % 12 )  END,RTSparqAdslCust.DOCKETDAT,RTSparqAdslCmty.COMN, RTObj.CUSNC "
  ' RESPONSE.Write SQLLIST
         
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
