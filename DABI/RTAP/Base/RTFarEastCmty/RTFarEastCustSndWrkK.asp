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
  Dim detailwindowFeature,rscount,searchqry2,EMAILFIELDNO,EMAILFIELDFLAG
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
  'parmkey=aryParmKey(2) & ";"
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
       '�ק�G
'       if accessMode ="A" then 
'		  prog="<%=dataProg%>?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &"&parm="&key&"&<%=dataProgParm%>"
'       else
'		  prog="<%=dataProg%>?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
'       end if

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
    Set diagWindow=Window.open(prog,"search",StrFeature)
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
<body onLoad="runSearchOpt()" ID="Form1">
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
<!-- �ק�@ -->
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
	system="���Ǥj�e�W���ϫ��޲z�t��"
	title="���Ǥj�e�W���ϫ����u�@�~"
	buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
	V=split(SrAccessPermit,";")
	AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
	ButtonEnable=V(0) & ";N;Y;Y;Y;Y"
	functionOptName="�C �L;�� ��;���ת���;�@ �o;�@�o����"
	functionOptProgram="/RTAP/REPORT/fareast/RTfareastCustSndWrkPV.asp;RTfareastCustSndWrkClose.asp;RTfareastCustSndWrkCloseRtn.asp;RTfareastCustSndWrkCancel.asp;RTfareastCustSndWrkCancelRtn.asp"
	functionOptPrompt="N;Y;Y;Y;Y"
	functionoptopen= "1;1;1;1;1"
	If V(1)="Y" then
		accessMode="U"
	Else
		accessMode="I"
	End IF
	DSN="DSN=RTLib"
	formatName="���u�渹;none;none;none;���u�O;�D�u;���ϦW��;�Ȥ�W��;FTP���<BR>�פJ��;���u��;�w�w<BR>�I�u�H;�w�w<BR>�I�u��;���u�H;���u��;���פH;���פ�;�@�o��"
	sqlDelete="SELECT c_varchar,i_smallint,i_tinyint,c_varchar,c_varchar,c_varchar,c_varchar,c_varchar,d_datetime,d_datetime," &_
			"c_varchar,d_datetime,c_varchar,d_datetime,c_varchar,d_datetime,d_datetime from RTTemplate"
	dataTable="RTfareastSndWrk"
	userDefineDelete="Yes"
	numberOfKey=4

	'if FrGetUserEmply(Request.ServerVariables("LOGON_USER")) ="T89039" then
    '	dataProg="RTFaqD_test.asp"
    'else
    	dataProg="RTfareastCustSndWrkD.asp"
    'end if        	

	datawindowFeature=""
	searchWindowFeature="width=500,height=350,scrollbars=yes"
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
	searchProg="self"
	searchFirst=FALSE
	If searchQry="" Then
		 searchQry=" a.wrkno <>'' "
		 searchShow="����"
	'ELSE
	'	 SEARCHFIRST=FALSE
	End If

	if ARYPARMKEY(0) <>"" then 
		searchQry = searchQry & " and a.comq1=" & aryparmkey(0)
	end if
	if ARYPARMKEY(1) <>"" then 
		searchQry = searchQry & " and a.lineq1=" & aryparmkey(1)
	end if
	if ARYPARMKEY(2) <>"" then 
		searchQry = searchQry & " and a.cusid='" & aryparmkey(2) &"' "
	end if

	'�ק�T
	'if len(trim(ParmKey))>2 then
	'    searchQry = " and a.canceldat is null and a.comtype=" &aryParmKey(0)& " and a.comq1=" &aryParmKey(1)& " and a.lineq1='" &aryParmKey(2)& "' and a.cusid='" &aryParmKey(3)& "' and a.entryno=" &aryParmKey(4)
'		searchShow="�D�u�Ǹ��J"& aryParmKey(1) &"-" & aryParmKey(2) & ",�Ȥ�N���J" & aryParmKey(3) & ",�Ȥᶵ���J" & aryParmKey(4)
	'end if

	'If searchQry="" Then
	'	searchQry=" and a.closedat is null and a.canceldat is null "
		'searchShow="�D�u�Ǹ��J"& comq1xx &"-" & lineq1xx & ",���ϦW�١J" & COMN & ",�Τ�W�١J" & cusnc & ",�D�u��}�J" & COMADDR
	'ELSE
	'   SEARCHFIRST=FALSE
	'End If

	'Ū���n�J�b�����s�ո��
	'-------------------------------------------------------------------------------------------
  	sqlList="select a.wrkno, a.comq1, a.lineq1, a.cusid, b.codenc, convert(varchar(6), a.comq1) +'-'+ convert(varchar(3),a.lineq1), " &_
  			"c.comn, n.cusnc, impdat, a.sndwrkdat, isnull(f.shortnc, h.cusnc), a.assigndat, isnull(i.shortnc, k.cusnc), " &_
  			"a.finishdat, m.cusnc, a.closedat, a.canceldat " &_
			"from RTfareastSndWrk a " &_
			"	left outer join RTCode b on a.wrktyp = b.code and b.kind ='P6' " &_
			"	left outer join RTfareastCmtyH c on c.comq1 = a.comq1 " &_
			"	left outer join RTObj f on f.cusid = a.assigncons " &_
			"	left outer join RTEmployee g inner join RTObj h on h.cusid = g.cusid on g.emply = a.assigneng " &_
			"	left outer join RTObj i on i.cusid = a.finishcons " &_
			"	left outer join RTEmployee j inner join RTObj k on k.cusid = j.cusid on j.emply = a.finisheng " &_
			"	left outer join RTEmployee l inner join RTObj m on m.cusid = l.cusid on l.emply = a.closeusr " &_
			"	left outer join RTfareastCust n on n.comq1 = a.comq1 and n.lineq1 = a.lineq1 and n.cusid = a.cusid " &_
			"where " & searchqry 
	'response.Write "SQL=" & SQLlist

End Sub
Sub SrRunUserDefineDelete()

End Sub
%>