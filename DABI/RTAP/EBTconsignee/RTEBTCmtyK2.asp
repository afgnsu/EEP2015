<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/keyList.inc" -->
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/cType.inc" -->
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
  Dim detailwindowFeature,rscount,searchqry2,searchqry3
  searchFirst=False
  userDefineDelete="No"
  functionOptPrompt=";;;;;;;;;;;;;;;;;;"
  keyListPageSize=0
  keyListPage=1
  colSplit=1
  searchQry=Request("searchQry")
  searchqry2=request("searchqry2")
  searchqry3=request("searchqry3")  
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
<link REL="stylesheet" HREF="/webUtilityV4EBT/DBAUDI/keyList.css" TYPE="text/css">
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/deleteDialogue.inc" -->
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
          Scrxx=window.screen.width -7
          Scryy=window.screen.height - 74
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
       Scrxx=window.screen.width -7 
       Scryy=window.screen.height - 74
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
       Scrxx=(window.screen.width -7) /1.5
       Scryy=(window.screen.height - 74)/1.5
       scrxx2=(window.screen.width - scrXX)/2
       scryy2=(window.screen.height - scryy)/2
       features="top=" & scrxx2 & ",left=" & scryy2 & ",status=yes,location=no,menubar=no,scrollbars=yes" & ",height=" & scryy & ",width=" & scrxx       
     '  StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
     '            &"location=no,menubar=no,width=" & scrxx & "px" _
     '            &",height=" & scryy & "px"
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
<table width="100%" cellPadding=0 cellSpacing=0 ID="Table1">
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
<table width="100%" cellPadding=0 cellSpacing=0 ID="Table2"> 
  <tr><td align=right>
<%If aryButtonEnable(0)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(0)%>" onClick="runAUDI 'A','<%=parmKey%>'" ID="Button1" NAME="Button1">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(1)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(1)%>" onClick="runDelete" ID="Button2" NAME="Button2">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(2)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(2)%>" onClick="SrClose()" ID="Button3" NAME="Button3">&nbsp;&nbsp;
<%End If%>
<%If aryButtonEnable(3)="Y" Then%>
          <input type="button" class=keyListButton value="<%=aryButton(3)%>" onClick="KeyForm.Submit" ID="Button4" NAME="Button4">
<%End If%>
<div>
<%If aryButtonEnable(4)="Y" Then%>
          <span onMouseOver="" onMouseOut="">
          <input type="button" class=keyListButton 
                 value="<%=aryButton(4) &":" &keyListPage &"/" &TotalPage%>" ID="Button5" NAME="Button5">
          <span id="pageOpt" style="">
             <input type="button" class=keyListButton value="�Ĥ@��" 
                onClick="keyForm.currentPage.Value=1:keyForm.Submit" ID="Button6" NAME="Button6">
             <input type="button" class=keyListButton value="�W�@��" 
                onClick="keyForm.currentPage.Value=keyForm.currentPage.Value-1:keyForm.Submit" ID="Button7" NAME="Button7">
             <input type="button" class=keyListButton value="�U�@��" 
                onClick="keyForm.currentPage.Value=keyForm.currentPage.Value+1:keyForm.Submit" ID="Button8" NAME="Button8">
             <input type="button" class=keyListButton value="�̥���" 
                onClick="keyForm.currentPage.Value=<%=TotalPage%>:keyForm.Submit" ID="Button9" NAME="Button9">
          </span>
          </span>
<%End If%>
<%If aryButtonEnable(5)="Y" Then%>
          <span onMouseOver="" onMouseOut="">
          <input type="button" class=keyListButton 
                 value="<%=aryButton(5)%>" ID="Button10" NAME="Button10">
          <span id="functionOpt" style="">
<%   aryOptName=Split(functionOptName,";")
     For i = 0 To Ubound(aryOptName)%>
             <input type="button" class=keyListButton value="<%=aryOptName(i)%>"
                    onClick="runOptProg('<%=i%>')" ID="Button11" NAME="Button11">
<%   Next%>
          </span>
          </span>
<%End If%>
</div>
  </td></tr>
</table>
<p>
<form method=post name="keyForm" ID="Form1">
<%
  If searchProg <> "" Then 
  countshow="  �@��(" & rscount & ")����ƲŦX" %>
<table width="100%" cellPadding=0 cellSpacing=0 ID="Table3">
 <tr><td width="10%"><input type="button" value="�j�M����" class=keyListSearch onClick="runSearchOpt" ID="Button12" NAME="Button12"></td>
     <td width="90%" class=keyListSearch2><%=searchShow%><%=countshow%>
         <input type="text" name="searchShow" value="<%=searchShow%>" style="display:none" readonly ID="Text1">
         <input type="text" name="searchQry" value="<%=searchQry%>" style="display:none" readonly ID="Text2">
         <input type="text" name="searchQry2" value="<%=searchQry2%>" style="display:none" readonly ID="Text3">
         <input type="text" name="searchQry3" value="<%=searchQry3%>" style="display:none" readonly ID="Text5"></td>
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
       Scrxx=window.screen.width -7
       Scryy=window.screen.height - 74
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
<form name="form" method="post" ID="Form2">
<table width="100%" cellPadding=0 cellSpacing=0 ID="Table4">
  <tr class=keyListTitle><td width="20%" align=left><%=Request.ServerVariables("LOGON_USER")%></td>
                         <td width="60%" align=center><%=company%></td>
                         <td width="20%" align=right><%=Now()%></td><tr>
  <tr class=keyListTitle><td>&nbsp;</td><td align=center><%=title%></td><td>&nbsp;</td><tr>
</table>
<P>�t�Τ��i
<table widtH="100%" border=1 cellPadding=0 cellSpacing=0 bgcolor="lightyellow" ID="Table5">
<!--
  <tr><td background="<%=goodMorningImage%>" height="400" width="400">&nbsp;</td></tr>
-->
  <tr bgcolor="darkseagreen"><TD ALIGN="CENTER">���</TD><TD ALIGN="CENTER">���@�i�@�ơ@��</TD></TR>
  <TR bgcolor=lightyellow><td>90/08/15<img src="/webap/image/newicon.gif"></TD><TD>�����q(��ƳB)ADSL�Ȥ��ƫ��ɧ@�~�ק粒��!</TD></tr>  
  <TR bgcolor=silver><td>90/08/13</TD><TD>HI-Building�Ȥ�h���κM�P��Ƭd�ߧ@�~�W�u!</TD></tr>    
  <TR bgcolor=lightyellow><td>90/08/09</TD><TD>ADSL�Ȥ�u�W�ӽи�Ƭd�ߧ@�~�W�u!</TD></tr>      
  <tr><td><input type="text" name="goodMorningAns" value="No" style="display:none;" ID="Text4"></td></tr>
</table>
</form>
</body>
</html>
<%End Sub%>
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS���ϰ򥻸�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
 ' functionOptName="�D�u���@;���v����"
 ' functionOptProgram="rtebtcmtylineK.asp;rtEBTcmtyLOGK.asp"
  functionOptName="�D�u�d��"
  functionOptProgram="rtebtcmtylineK.asp" 
  functionOptPrompt="N"
  accessMode="I"
  DSN="DSN=RTLib"
  formatName="���ϧǸ�;���ϦW��;����;�m��;�W�Ҥ��;�������ɤ�;�ӽнu��;�}�q�u��;none;�ӽ�;�M�P;�h��;���u;����;�t��"
 ' sqlDelete="SELECT * FROM (SELECT        RTEBTCMTYH.COMQ1, RTEBTCMTYH.COMN, " _
 '          &"RTCounty.CUTNC + RTEBTCMTYH.TOWNSHIP + RTEBTCMTYH.VILLAGE + RTEBTCMTYH.NEIGHBOR " _
 '          &"+ RTEBTCMTYH.STREET + RTEBTCMTYH.SEC + RTEBTCMTYH.LANE + RTEBTCMTYH.TOWN " _
 '          &"+ RTEBTCMTYH.ALLEYWAY + RTEBTCMTYH.NUM + RTEBTCMTYH.FLOOR + RTEBTCMTYH.ROOM " _
 '          &"AS raddr, RTEBTCMTYH.COMCNT, " _
 ''          &"RTEBTCMTYH.CONTACT, RTEBTCMTYH.CONTACTRANK, " _
  '         &"RTEBTCMTYH.COMTEL, RTEBTCMTYH.UPDEBTDAT,COUNT(*) as linecnt,SUM(CASE WHEN RTEBTCMTYLINE.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT " _
  '         &"FROM RTEBTCUST INNER JOIN  RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
  '         &"RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 RIGHT OUTER JOIN RTEBTCMTYH ON RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1 LEFT OUTER JOIN " _
  '         &"RTCounty ON RTEBTCMTYH.CUTID = RTCounty.CUTID GROUP BY  RTEBTCMTYH.COMQ1,RTEBTCMTYH.COMN, " _
  ''         &"RTCounty.CUTNC + RTEBTCMTYH.TOWNSHIP + RTEBTCMTYH.VILLAGE + RTEBTCMTYH.NEIGHBOR " _
  '         &"+ RTEBTCMTYH.STREET + RTEBTCMTYH.SEC + RTEBTCMTYH.LANE + RTEBTCMTYH.TOWN " _
   '        &"+ RTEBTCMTYH.ALLEYWAY + RTEBTCMTYH.NUM + RTEBTCMTYH.FLOOR + RTEBTCMTYH.ROOM, RTEBTCMTYH.COMCNT, RTEBTCMTYH.AGREEDAT, " _
   '        &"RTEBTCMTYH.CONTACT, RTEBTCMTYH.CONTACTRANK, RTEBTCMTYH.COMTEL, RTEBTCMTYH.UPDEBTDAT) a, " _
   '        &"(SELECT A.COMQ1,COUNT(*) as cuscnt, SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FINISHCNT,SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DOCKETCNT " _
   '        &"FROM RTEBTCMTYH A,RTEBTCUST B WHERE A.COMQ1=B.COMQ1 GROUP BY A.COMQ1) B " _
   '        &"WHERE A.COMQ1=B.COMQ1 " 
  sqlDelete="SELECT * FROM (SELECT        RTEBTCMTYH.COMQ1, RTEBTCMTYH.COMN, " _
           &"RTCounty.CUTNC , RTEBTCMTYH.TOWNSHIP  " _
           &", RTEBTCMTYH.COMCNT, " _
           &"RTEBTCMTYH.UPDEBTDAT,SUM(CASE WHEN RTEBTCMTYLINE.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS LINECNT,SUM(CASE WHEN RTEBTCMTYLINE.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT " _
           &"FROM RTEBTCUST INNER JOIN  RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
           &"RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 RIGHT OUTER JOIN RTEBTCMTYH ON RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1 LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYH.CUTID = RTCounty.CUTID GROUP BY  RTEBTCMTYH.COMQ1,RTEBTCMTYH.COMN, " _
           &"RTCounty.CUTNC, RTEBTCMTYH.TOWNSHIP , RTEBTCMTYH.COMCNT, RTEBTCMTYH.AGREEDAT, " _
           &"RTEBTCMTYH.UPDEBTDAT) a, " _
           &"(SELECT RTEBTCMTYH.COMQ1,SUM(CASE WHEN RTEBTCUST.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS cuscnt, SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) AS cancelCNT, " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) AS dropCNT, " _
           &"SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FINISHCNT, " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DOCKETCNT, " _
           &"SUM(CASE WHEN RTEBTCUST.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) - SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DIFFCNT " _
           &"FROM RTEBTCMTYH LEFT OUTER JOIN RTEBTCUST ON RTEBTCMTYH.COMQ1=RTEBTCUST.COMQ1 " _
           &"GROUP BY RTEBTCMTYH.COMQ1) B " _
           &"WHERE A.COMQ1 =B.COMQ1 "            
  dataTable="rtebtcmtyh"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTebtCmtyD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=550,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTebtCmtyS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=FALSE
  If searchQry="" AND searchQry2="" AND searchQry3="" Then
     searchQry=" RTEBTCmtyH.ComQ1<>0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  sqlList="SELECT * FROM (SELECT RTEBTCMTYH.COMQ1, RTEBTCMTYH.COMN, RTCounty.CUTNC, " _
           &"RTEBTCMTYH.TOWNSHIP, RTEBTCMTYH.COMCNT, RTEBTCMTYH.UPDEBTDAT, " _
           &"SUM(CASE WHEN RTEBTCMTYLINE.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) AS LINECNT, " _
           &"SUM(CASE WHEN RTEBTCMTYLINE.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT " _
           &"from RTEBTCMTYLINE RIGHT OUTER JOIN RTEBTCMTYH ON RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1 LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYH.CUTID = RTCounty.CUTID WHERE " & searchqry & " GROUP BY   RTEBTCMTYH.COMQ1, " _
           &"RTEBTCMTYH.COMN, RTCounty.CUTNC, RTEBTCMTYH.TOWNSHIP, RTEBTCMTYH.COMCNT, " _
           &"RTEBTCMTYH.AGREEDAT, RTEBTCMTYH.UPDEBTDAT " & SEARCHQRY2 & " ) a, " _
           &"(SELECT RTEBTCMTYH.COMQ1,SUM(CASE WHEN RTEBTCUST.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS cuscnt, SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) AS cancelCNT, " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) AS dropCNT, " _
           &"SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FINISHCNT, " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DOCKETCNT, " _
           &"SUM(CASE WHEN RTEBTCUST.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) - SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END)  - " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DIFFCNT " _
           &"FROM RTEBTCMTYH LEFT OUTER JOIN RTEBTCUST ON RTEBTCMTYH.COMQ1=RTEBTCUST.COMQ1 " _
           &"GROUP BY RTEBTCMTYH.COMQ1 " & SEARCHQRY3 & " ) B " _
           &"WHERE A.COMQ1 =B.COMQ1 "       
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>