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
    progary=split(prog,";")
    keyary=split(key,";")    
    key=keyary(0) & ";" & keyary(2) & ";" & keyary(3)
    If prog="None" Then
    Else
       Randomize  
       if keyary(1)="1" then
          prog=progary(1) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
       elseIF keyary(1)="2" then
          prog=progary(0) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
       elseIF keyary(1)="3" then
          prog=progary(2) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"          
       elseIF keyary(1)="4" then
          prog=progary(3) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"                   
       end if       
      
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
       if keyary(1)="1" then
          Prog=aryOptProg(2)
       elseIF keyary(1)="2" then
          Prog=aryOptProg(1)
       elseIF keyary(1)="3" then
          Prog=aryOptProg(3)    
       elseIF keyary(1)="4" then
          Prog=aryOptProg(4)       
       end if                   
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
         keyary=split(document.all("key" &selItem).value,";")    
         key=keyary(0) & ";" & keyary(2) & ";" & keyary(3)         
       if keyary(1)="1" then
          Prog=aryOptProg(2)
       elseIF keyary(1)="2" then
          Prog=aryOptProg(1)
       elseIF keyary(1)="3" then
          Prog=aryOptProg(3)       
       elseIF keyary(1)="4" then
          Prog=aryOptProg(4)       
       end if                   
         prog=Prog &"?V=" &Rnd() &"&key=" & KEY
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
         <input type="text" name="searchQry2" value="<%=searchQry2%>" style="display:none" readonly ID="Text3"></td>
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
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�Ȥ�ú�ڰO���d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
   functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="HN���X;��ú���;��ú���B;��b���;���ϦW��;����HB;�[�ȪA��;�u�f�O;�g�P��;��b�O;���u��;������;�h����;���A"
 ' sqlDelete="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.shortnc, RTCust.CUSTYPE, " _
 '          &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME," _
 '          &"RTCust.OFFICE + ' ' + RTCust.EXTENSION  AS Office,RTCust.SNDINFODAT ,rtcust.reqdat " _
 '          &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
 '          &"WHERE RTCust.COMQ1=0 " _
 '          &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
   sqlDelete="SELECT HBMonthlyAccountSRC.HNNO, HBMonthlyAccountSRC.YM, " _
            &"HBMonthlyAccountSRC.AMT, HBMonthlyAccountSRC.RYM, RTCmty.COMN,  HBMonthlyAccountSRC.HBNO, " _
            &"CASE WHEN HBMonthlyAccountSRC.SS365='1' THEN '���ݥ�Ĺ' ELSE '' END, CASE WHEN HBMonthlyAccountSRC.TRADE='1' THEN '�@�T�M��' ELSE '' END, " _
            &"HBMonthlyAccountSRC.CONSIGNEE, CASE WHEN HBMonthlyAccountSRC.FLAG='1' THEN '�w��b' ELSE '' END, " _
            &"RTCust.FINISHDAT, RTCust.DOCKETDAT, RTCust.DROPDAT,CASE WHEN  rtcust.dropdat is not null and RTCust.OVERDUE='Y' then '���'  when RTCUST.DROPDAT IS NOT NULL AND RTCUST.OVERDUE <> 'Y' THEN '�h��' else '' end AS STAT " _
            &"FROM RTCmty INNER JOIN " _
            &"RTCust ON RTCmty.COMQ1 = RTCust.COMQ1 RIGHT OUTER JOIN " _
            &"HBMonthlyAccountSRC ON RTCust.CUSID = HBMonthlyAccountSRC.CUSID AND " _
            &"RTCust.ENTRYNO = HBMonthlyAccountSRC.ENTRYNO " _
            &"WHERE         (HBMonthlyAccountSRC.SCHEME IN ('1', '4')) " _
            &"UNION " _
            &"SELECT         HBMonthlyAccountSRC.HNNO, HBMonthlyAccountSRC.YM, " _
            &"HBMonthlyAccountSRC.AMT, HBMonthlyAccountSRC.RYM, RTCUSTADSLCmty.COMN,  HBMonthlyAccountSRC.HBNO , " _
            &"CASE WHEN HBMonthlyAccountSRC.SS365='1' THEN '���ݥ�Ĺ' ELSE '' END, CASE WHEN HBMonthlyAccountSRC.TRADE='1' THEN '�@�T�M��' ELSE '' END, " _
            &"HBMonthlyAccountSRC.CONSIGNEE, CASE WHEN HBMonthlyAccountSRC.FLAG='1' THEN '�w��b' END, " _
            &"RTCustADSL.FINISHDAT, RTCustADSL.DOCKETDAT, RTCustADSL.DROPDAT,CASE WHEN  rtcustADSL.dropdat is not null and RTCustADSL.OVERDUE='Y' then '���'  when RTCUSTADSL.DROPDAT IS NOT NULL AND RTCUSTADSL.OVERDUE <> 'Y' THEN '�h��' else '' end AS STAT " _
            &"FROM             RTCUSTADSLCmty INNER JOIN " _
            &"RTCustADSL ON RTCUSTADSLCmty.CUTYID = RTCustADSL.COMQ1 RIGHT OUTER JOIN " _
            &"HBMonthlyAccountSRC ON RTCustADSL.CUSID = HBMonthlyAccountSRC.CUSID AND " _
            &"RTCustADSL.ENTRYNO = HBMonthlyAccountSRC.ENTRYNO " _
            &"WHERE         (HBMonthlyAccountSRC.SCHEME IN ('2')) " 
  dataTable="HBMonthlyAccountSRC"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=3
  dataProg="/webap/rtap/base/rtadslcmty/rtcustd.asp;/webap/rtap/base/rtcmty/rtcustd.asp;/webap/rtap/base/rtsparqadslcmty/rtcustd.asp;/webap/rtap/base/rtcmty/rtcustd.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" and HBMonthlyAccountSRC.CUSID='" & aryparmkey(0) & "' and HBMonthlyAccountSRC.entryno=" & aryparmkey(1)
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="='A1'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="='*'"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89008" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"  
  'sqlList="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.shortnc, RTCust.CUSTYPE, " _
  '         &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME, " _
  '         &"RTCust.OFFICE+' '+ RTCust.EXTENSION  AS Office,RTCust.SNDINFODAT,rtcust.reqdat " _
  '         &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
  '         &"WHERE " &searchQry &" " _
  '         &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
  sqllist="SELECT HBMonthlyAccountSRC.HNNO, HBMonthlyAccountSRC.YM, " _
            &"HBMonthlyAccountSRC.AMT, HBMonthlyAccountSRC.RYM, RTCmty.COMN,  HBMonthlyAccountSRC.HBNO, " _
            &"CASE WHEN HBMonthlyAccountSRC.SS365='1' THEN '���ݥ�Ĺ' ELSE '' END, CASE WHEN HBMonthlyAccountSRC.TRADE='1' THEN '�@�T�M��' ELSE '' END, " _
            &"HBMonthlyAccountSRC.CONSIGNEE, CASE WHEN HBMonthlyAccountSRC.FLAG='1' THEN '�w��b' ELSE '' END, " _
            &"RTCust.FINISHDAT, RTCust.DOCKETDAT, RTCust.DROPDAT,CASE WHEN  rtcust.dropdat is not null and RTCust.OVERDUE='Y' then '���'  when RTCUST.DROPDAT IS NOT NULL AND RTCUST.OVERDUE <> 'Y' THEN '�h��' else '' end AS STAT " _
            &"FROM RTCmty INNER JOIN " _
            &"RTCust ON RTCmty.COMQ1 = RTCust.COMQ1 RIGHT OUTER JOIN " _
            &"HBMonthlyAccountSRC ON RTCust.CUSID = HBMonthlyAccountSRC.CUSID AND " _
            &"RTCust.ENTRYNO = HBMonthlyAccountSRC.ENTRYNO " _
            &"WHERE         (HBMonthlyAccountSRC.SCHEME IN ('1', '4')) " & searchqry  _
            &"UNION " _
            &"SELECT         HBMonthlyAccountSRC.HNNO, HBMonthlyAccountSRC.YM, " _
            &"HBMonthlyAccountSRC.AMT, HBMonthlyAccountSRC.RYM, RTCUSTADSLCmty.COMN,  HBMonthlyAccountSRC.HBNO , " _
            &"CASE WHEN HBMonthlyAccountSRC.SS365='1' THEN '���ݥ�Ĺ' ELSE '' END, CASE WHEN HBMonthlyAccountSRC.TRADE='1' THEN '�@�T�M��' ELSE '' END, " _
            &"HBMonthlyAccountSRC.CONSIGNEE, CASE WHEN HBMonthlyAccountSRC.FLAG='1' THEN '�w��b' END, " _
            &"RTCustADSL.FINISHDAT, RTCustADSL.DOCKETDAT, RTCustADSL.DROPDAT,CASE WHEN  rtcustADSL.dropdat is not null and RTCustADSL.OVERDUE='Y' then '���'  when RTCUSTADSL.DROPDAT IS NOT NULL AND RTCUSTADSL.OVERDUE <> 'Y' THEN '�h��' else '' end AS STAT " _
            &"FROM             RTCUSTADSLCmty INNER JOIN " _
            &"RTCustADSL ON RTCUSTADSLCmty.CUTYID = RTCustADSL.COMQ1 RIGHT OUTER JOIN " _
            &"HBMonthlyAccountSRC ON RTCustADSL.CUSID = HBMonthlyAccountSRC.CUSID AND " _
            &"RTCustADSL.ENTRYNO = HBMonthlyAccountSRC.ENTRYNO " _
            &"WHERE         (HBMonthlyAccountSRC.SCHEME IN ('2')) " & searchqry 
 ' Response.Write "sql=" & SQLLIST
End Sub
%>
