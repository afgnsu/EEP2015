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
  Dim detailwindowFeature,rscount,EMAILFIELDNO,EMAILFIELDFLAG
  searchFirst=False
  EMAILFIELDFLAG="N"
  userDefineDelete="No"
  functionOptPrompt=";;;;;;;;;;;;;;;;;;"
  keyListPageSize=0
  keyListPage=1
  colSplit=1
  searchQry=Request("searchQry")
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
<link REL="stylesheet" HREF="/webUtilityV4EBT/DBAUDI/keyList.css" TYPE="text/css">
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
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
    '����"H"��,��������DO ...LOOP�j��,�_�h���]�D�藍��SEL�ȦӤ��_
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
    '��aryoptprompt="H"��,���ܤ��ݬD��@�����,�Ӫ����I�s�{��
    if  aryoptprompt(opt)="H" then
        Randomize  
        prog=aryOptProg(opt)
      '�� aryoptopen(OPT)="1" :���@��window�}��,"2"��dialog�}��
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
      '�� functionoptopen(OPT)="1" :���@��window�}��,"2"��dialog�}��
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
<body bgcolor="C3C9D2" background="/WEBAP/IMAGE/bg.gif">
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
          <input type="button" class=keyListButton value="<%=aryButton(0)%>" onClick="runAUDI 'A',';<%=parmKey%>'">&nbsp;&nbsp;
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
                 value="<%=aryButton(5)%>" style="display:none">
          <span id="functionOpt" style="">
<%   aryOptName=Split(functionOptName,";")
     For i = 0 To Ubound(aryOptName)%>
             <input type="button" class=keyListButton value="<%=aryOptName(i)%>"
                    onClick="runOptProg('<%=i%>')" style="background-color:blue;">
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
         <input type="text" name="EMAILFIELDNO" value="<%=EMAILFIELDNO%>" style="display:none" readonly></td>
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
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
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
  <tr bgcolor="darkseagreen"><TD ALIGN="CENTER">����</TD><TD ALIGN="CENTER">���</TD><TD ALIGN="CENTER">�t�@�Ρ@�T�@��</TD></TR>
<%
 Set conn=Server.CreateObject("ADODB.Connection")
 Set rs=Server.CreateObject("ADODB.Recordset")
 DSN="DSN=RTLib"
 conn.open DSN
 SQL="SELECT comq1, lineq1, comtype FROM RTFaqM where caseno='" & aryparmkey(0) & "' "
 RS.Open SQL,CONN
 if not rs.eof then
    comq1_wrk = rs("comq1")
    lineq1_wrk = rs("lineq1")
    comtype_wrk = rs("comtype")
 end if
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
	system="�ȪA�޲z�t��"
	title="�ȶD�D�����u���v�O��"
	buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
	V=split(SrAccessPermit,";")
	AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
	ButtonEnable=V(0) & ";N;Y;Y;Y;Y"
	if V(0)="Y" then
		functionOptName="�@ �o;�C �L;�� �u;���u����"
		functionOptProgram="RTFaqSndWrkDrop.asp;RTFaqSndWrkPV.asp;RTFaqSndWrkDialog.asp;RTFaqSndWrkFR.asp"
		functionOptPrompt="Y;N;N;Y"
	elseif V(3)="Y" then	'�u�� only
		functionOptName="�C �L;�� �u;���u����"
		functionOptProgram="RTFaqSndWrkPV.asp;RTFaqSndWrkDialog.asp;RTFaqSndWrkFR.asp"
		functionOptPrompt="N;N;Y"
	else
		functionOptName="�C �L"
		functionOptProgram="RTFaqSndWrkPV.asp"
		functionOptPrompt="N"
	end if

	Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
	if emply ="T89039" then
		functionOptName="�@ �o;�C �L;�� �u;���u����;���N�׽լd"
		functionOptProgram="RTFaqSndWrkDrop.asp;RTFaqSndWrkPV.asp;RTFaqSndWrkDialog.asp;RTFaqSndWrkFR.asp;RTFaqSndWrkCallK.asp"
		functionOptPrompt="Y;N;N;Y;N"
	end if

	If V(1)="Y" then
		accessMode="U"
	Else
		accessMode="I"
	End IF
	DSN="DSN=RTLib"
	formatName="���u�渹;�ȶD�渹;none;���u�O;�w�w<br>�I�u�H;���<br>�I�u�H;��קO;���ϦW��;�p���H;�a�};���u�H;���u��;���u�H;���u��;���u<br>�覡;�@�o��"
	sqlDelete=	"select a.workno, a.linkno, g.comtype, b.codenc as worktype, isnull(c.shortnc, d.name) as assigneng, finisheng, " &_
				"l.codenc, h.comn, g.faqman, h.raddr, " &_
				"e.name as sndwrkusr, replace(left(convert(varchar(30),a.sndwrkdat, 120), 16), ' ', '�@'), f.name as finishusr, a.finishdat, a.finishtyp, a.canceldat " &_
				"from	RTSndWork a " &_
				"left outer join RTCode b on b.code = a.worktype and b.kind ='P6' " &_
				"left outer join RTObj c on c.cusid = a.assigncons " &_
				"left outer join RTEmployee d on d.emply = a.assigneng " &_
				"left outer join RTEmployee e on e.emply = a.sndwrkusr " &_
				"left outer join RTEmployee f on f.emply = a.finishusr " &_
				"left outer join RTFaqM g on g.caseno = a.linkno and (a.worktype ='01' or a.worktype ='09') " &_
				"left outer join HBAdslCmtyCust h on g.comtype = h.comtype and g.comq1 = h.comq1 and g.lineq1 = h.lineq1 and g.cusid = h.cusid and g.entryno=h.entryno " &_				
				"where a.workno='' "
	dataTable="RTSndWork"
	userDefineDelete="Yes"
	numberOfKey=3
	dataProg="RTFaqSndWrkD.asp"
	datawindowFeature=""
	searchWindowFeature="width=350,height=160,scrollbars=yes"
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

	' Open search program when first entry this keylist
	searchProg="RTFaqLineSndWrkS.asp"
	searchFirst=FALSE
	If searchQry="" Then
         Set conn=Server.CreateObject("ADODB.Connection")
         Set rs=Server.CreateObject("ADODB.Recordset")
         DSN="DSN=RTLib"
         conn.open DSN
         SQL="SELECT comq1, lineq1, comtype FROM RTFaqM where caseno='" & aryparmkey(0) & "' "
         RS.Open SQL,CONN
         if not rs.eof then
            searchQry=" and g.comq1='" & rs("comq1") & "' and g.lineq1='" & rs("lineq1") & "' and g.comtype='" & rs("comtype") & "'  "
         else
            searchQry=" and a.workno='' "
         end if
         rs.Close
         conn.Close
         set rs=nothing
         set conn=nothing
	
		searchShow="�ȶD�渹�J"& aryparmkey(0) 
	ELSE
	   SEARCHFIRST=FALSE
	End If

	'Ū���n�J�b�����s�ո��
	'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
	'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
	'Domain=Mid(Emply,1,1)
	'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
	'Response.Write "GP=" & usergroup
	'-------------------------------------------------------------------------------------------
	'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
 
	sqlList="select a.workno, a.linkno, g.comtype, b.codenc as worktype, isnull(c.shortnc, d.name) as assigneng, " &_
			"isnull(i.shortnc, f.name) as finisheng, l.codenc, h.comn, g.faqman, h.raddr, " &_
			"e.name as sndwrkusr, replace(left(convert(varchar(30),a.sndwrkdat, 120), 16), ' ', '�@'), j.name as finishsur, a.finishdat, k.codenc, a.canceldat " &_
			"from	RTSndWork a " &_
			"left outer join RTCode b on b.code = a.worktype and b.kind ='P6' " &_
			"left outer join RTObj c on c.cusid = a.assigncons " &_
			"left outer join RTEmployee d on d.emply = a.assigneng " &_
			"left outer join RTEmployee e on e.emply = a.sndwrkusr " &_
			"left outer join RTEmployee j on j.emply = a.finishusr " &_
			"left outer join RTEmployee f on f.emply = a.finisheng " &_
			"left outer join RTObj i on i.cusid = a.finishcons " &_
			"inner join RTFaqM g on g.caseno = a.linkno  " &_
			"inner join HBAdslCmtyCust h on g.comtype = h.comtype and g.comq1 = h.comq1 and g.lineq1 = h.lineq1 and g.cusid = h.cusid and g.entryno=h.entryno " &_
			"left outer join RTCode k on k.code = a.finishtyp and k.kind ='P9' " &_
			"left outer join RTCode l on l.code = h.comtype and l.kind ='P5' " &_
			"where a.worktype ='09' " & searchQry &_
			" order by a.sndwrkdat "
	'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>