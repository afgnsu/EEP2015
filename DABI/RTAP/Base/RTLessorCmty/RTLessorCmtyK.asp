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
       Scrxx=window.screen.width -7 
       Scryy=window.screen.height - 74
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
  <tr bgcolor="darkseagreen"><TD ALIGN="CENTER">����</TD><TD ALIGN="CENTER">���</TD><TD ALIGN="CENTER">�t�@�Ρ@�T�@��</TD></TR>
<%
 Set conn=Server.CreateObject("ADODB.Connection")
 Set rs=Server.CreateObject("ADODB.Recordset")
 DSN="DSN=RTLib"
 conn.open DSN
 SQL="SELECT MSGID, TOPIC, CONTENT, MSGDAT, APPEAR, UPDAT, DOWNDAT, IMG FROM RTSYSMSG where appear='Y' and ( UPDAT <= GETDATE() OR UPDAT IS NULL ) AND ( DOWNDAT IS NULL OR DOWNDAT > GETDATE() ) order by msgdat desc"
 RS.Open SQL,CONN
 cnt=0
 do while not rs.eof
    cnt=cnt+1
    K=cnt mod 2
    if k=1 then
       response.Write "<TR bgcolor=lightyellow>"
    else
       response.Write "<TR bgcolor=silver>"
    end if
    response.Write "<TD align=center>" & RS("MSGID") & "</TD>" & "<TD>" & RS("MSGDAT") & "</TD>" & "<TD>" & RS("TOPIC") & "</TD></TR>"
    RS.movenext
  LOOP
rs.Close
conn.Close
set rs=nothing
set conn=nothing
%>  
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
  system="ET-City�޲z�t��"
  title="ET-City���ϰ򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�D�u���@;���ϥΤ�;�]�Ƭd��;�X�����@"
  functionOptProgram="RTLessorCmtyLineK.asp;rtLESSORCUSTK1.ASP;RTLessorCmtyHARDWAREK.asp;RTLessorCmtyContractk.asp"
  functionOptPrompt="N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="���ϧǸ�;���ϦW��;����;�m��;�W�Ҥ��;�������ɤ�;�D�u��;�}�q�u��;none;�ӽ�;�M�P;�h��;���u;����;�t��"
  sqlDelete="SELECT * FROM (SELECT        RTLessorCmtyH.COMQ1, RTLessorCmtyH.COMN, " _
           &"RTCounty.CUTNC , RTLessorCmtyH.TOWNSHIP  " _
           &", RTLessorCmtyH.COMCNT, " _
           &"RTLessorCmtyH.UPDEBTDAT,SUM(CASE WHEN RTLessorCmtyLine.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS LINECNT,SUM(CASE WHEN RTLessorCmtyLine.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT " _
           &"FROM RTLessorCust INNER JOIN  RTLessorCmtyLine ON RTLessorCust.COMQ1 = RTLessorCmtyLine.COMQ1 AND " _
           &"RTLessorCust.LINEQ1 = RTLessorCmtyLine.LINEQ1 RIGHT OUTER JOIN RTLessorCmtyH ON RTLessorCmtyLine.COMQ1 = RTLessorCmtyH.COMQ1 LEFT OUTER JOIN " _
           &"RTCounty ON RTLessorCmtyH.CUTID = RTCounty.CUTID GROUP BY  RTLessorCmtyH.COMQ1,RTLessorCmtyH.COMN, " _
           &"RTCounty.CUTNC, RTLessorCmtyH.TOWNSHIP , RTLessorCmtyH.COMCNT, RTLessorCmtyH.AGREEDAT, " _
           &"RTLessorCmtyH.UPDEBTDAT) a, " _
           &"(SELECT RTLessorCmtyH.COMQ1,SUM(CASE WHEN RTLessorCust.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS cuscnt, SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) AS cancelCNT, " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) AS dropCNT, " _
           &"SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FINISHCNT, " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DOCKETCNT, " _
           &"SUM(CASE WHEN RTLessorCust.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) - SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DIFFCNT " _
           &"FROM RTLessorCmtyH LEFT OUTER JOIN RTLessorCust ON RTLessorCmtyH.COMQ1=RTLessorCust.COMQ1 " _
           &"GROUP BY RTLessorCmtyH.COMQ1) B " _
           &"WHERE A.COMQ1 =B.COMQ1 "            
  dataTable="RTLessorCmtyH"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTLessorCmtyD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=550,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorCmtyS.asp"
  searchFirst=FALSE
  If searchQry="" AND searchQry2="" AND searchQry3="" Then
     searchQry=" RTLessorCmtyH.ComQ1<>0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
  '	 Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
  '	 Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  'if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
 if userlevel=31 then DAreaID="<>'*'"  
         sqlList="SELECT  a.comq1,a.comn,a.cutnc,a.township,a.comcnt,a.UPDEBTDAT,b.linecnt,b.applycnt,c.comq1,c.cuscnt,c.cancelcnt,c.dropcnt,c.finishcnt,c.docketcnt,c.diffcnt " _
           &"FROM (SELECT RTLessorCmtyH.COMQ1, RTLessorCmtyH.COMN, RTCounty.CUTNC, " _
           &"RTLessorCmtyH.TOWNSHIP, RTLessorCmtyH.COMCNT, RTLessorCmtyH.UPDEBTDAT " _
           &"from RTLessorCmtyLine RIGHT OUTER JOIN RTLessorCmtyH ON RTLessorCmtyLine.COMQ1 = RTLessorCmtyH.COMQ1 LEFT OUTER JOIN " _
           &"RTCounty ON RTLessorCmtyH.CUTID = RTCounty.CUTID INNER JOIN RTAREATOWNSHIP ON RTLessorCmtyH.CUTID=RTAREATOWNSHIP.CUTID AND " _
           &"RTLessorCmtyH.TOWNSHIP=RTAREATOWNSHiP.TOWNSHIP WHERE " & searchqry & " AND RTAREATOWNSHIP.AREAID " & DAREAID & " GROUP BY   RTLessorCmtyH.COMQ1, " _
           &"RTLessorCmtyH.COMN, RTCounty.CUTNC, RTLessorCmtyH.TOWNSHIP, RTLessorCmtyH.COMCNT, " _
           &"RTLessorCmtyH.AGREEDAT, RTLessorCmtyH.UPDEBTDAT " & SEARCHQRY2 & " ) a LEFT OUTER JOIN " _
           &"(SELECT RTLessorCmtyH.COMQ1, RTLessorCmtyH.COMN, RTCounty.CUTNC, " _
           &"RTLessorCmtyH.TOWNSHIP, RTLessorCmtyH.COMCNT, RTLessorCmtyH.UPDEBTDAT, " _
           &"SUM(CASE WHEN RTLessorCmtyLine.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) AS LINECNT, " _
           &"SUM(CASE WHEN RTLessorCmtyLine.ADSLAPPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT " _
           &"from RTLessorCmtyLine RIGHT OUTER JOIN RTLessorCmtyH ON RTLessorCmtyLine.COMQ1 = RTLessorCmtyH.COMQ1 LEFT OUTER JOIN " _
           &"RTCounty ON RTLessorCmtyH.CUTID = RTCounty.CUTID  WHERE " & searchqry & " GROUP BY   RTLessorCmtyH.COMQ1, " _
           &"RTLessorCmtyH.COMN, RTCounty.CUTNC, RTLessorCmtyH.TOWNSHIP, RTLessorCmtyH.COMCNT, " _
           &"RTLessorCmtyH.AGREEDAT, RTLessorCmtyH.UPDEBTDAT " & SEARCHQRY2 & " ) B ON A.COMQ1=B.COMQ1 LEFT OUTER JOIN " _
           &"(SELECT RTLessorCmtyH.COMQ1,SUM(CASE WHEN RTLessorCust.COMQ1 IS NOT NULL " _
           &"THEN 1 ELSE 0 END) AS cuscnt, SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) AS cancelCNT, " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END) AS dropCNT, " _
           &"SUM(CASE WHEN FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FINISHCNT, " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DOCKETCNT, " _
           &"SUM(CASE WHEN RTLessorCust.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN dropdat IS NOT NULL and docketdat is null THEN 1 ELSE 0 END) - " _
           &"SUM(CASE WHEN dropdat IS NOT NULL and docketdat is not null THEN 1 ELSE 0 END)  - " _
           &"SUM(CASE WHEN DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DIFFCNT " _
           &"FROM RTLessorCmtyH LEFT OUTER JOIN RTLessorCust ON RTLessorCmtyH.COMQ1=RTLessorCust.COMQ1 " _
           &"GROUP BY RTLessorCmtyH.COMQ1 " & SEARCHQRY3 & " ) C ON A.COMQ1=C.COMQ1 " _
           &"ORDER BY A.COMQ1 "        
  '  End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>