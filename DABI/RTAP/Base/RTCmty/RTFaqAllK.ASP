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
  Dim detailwindowFeature,rscount,searchqry1,searchqry2
  searchFirst=False
  userDefineDelete="No"
  functionOptPrompt=";;;;;;;;;;;;;;;;;;"
  keyListPageSize=0
  keyListPage=1
  colSplit=1
  searchQry=Request("searchQry")
  searchqry1=request("searchqry1")
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
<link REL="stylesheet" HREF="/webUtilityV4EBT/DBAUDI/keyList.css" TYPE="text/css">
<link REL="stylesheet" HREF="keyList.css" TYPE="text/css">
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/deleteDialogue.inc" -->
<script language="vbscript">
Sub runAUDI(accessMode,key)
    Dim prog,strFeature,msg
    prog="<%=dataProg%>"
    progary=split(prog,";")
    keyary=split(key,";")    
    key=keyary(5)
    keyx=keyary(3) & ";" & keyary(5)
    If prog="None" Then
    Else
       Randomize  
           if keyary(2)="1" then
          prog=progary(1) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
       elseIF keyary(2)="2" then
          prog=progary(0) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
       elseIF keyary(2)="3" then
          prog=progary(2) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"          
       elseIF keyary(2)="4" then
          prog=progary(3) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"                   
       elseIF keyary(2)="5" then
          prog=progary(4) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"                            
       elseIF keyary(2)="6" then
          prog=progary(5) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &key &"&<%=dataProgParm%>"
       elseIF keyary(2)="7" then
          prog=progary(6) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyx &"&<%=dataProgParm%>"      
       elseIF keyary(2)="8" then
          prog=progary(7) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyx &"&<%=dataProgParm%>"                 
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

    i=0
    sel="F"
	while sel="F" 
      i=i+1
      sel=document.all("sel" &i).value
      If sel="T" Then
			keyary=split(document.all("key" &i).value,";")
			select case keyary(2)
				case "1"
					aryOptProg =Split("/webap/rtap/base/rtcmty/RTFaqDropk.asp;/webap/rtap/base/rtcmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtcmty/RTFaqProcessK.asp;/webap/rtap/base/rtcmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtcmty/RTFaqFinishRTNK.asp;/rtap/base/rtcmty/RTFaQV.asp", ";")
				case "2"
					aryOptProg =Split("/webap/rtap/base/rtadslcmty/RTFaqDropk.asp;/webap/rtap/base/rtadslcmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtadslcmty/RTFaqProcessK.asp;/webap/rtap/base/rtadslcmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtadslcmty/RTFaqFinishRTNK.asp;/rtap/base/rtadslcmty/RTFaQV.asp", ";")
				case "3"
					aryOptProg =Split("/webap/rtap/base/rtsparqadslcmty/RTFaqDropk.asp;/webap/rtap/base/rtsparqadslcmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtsparqadslcmty/RTFaqProcessK.asp;/webap/rtap/base/rtsparqadslcmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtsparqadslcmty/RTFaqFinishRTNK.asp;/rtap/base/rtsparqadslcmty/RTFaQV.asp", ";")
				case "4"
					aryOptProg =Split("/webap/rtap/base/rtcmty/RTFaqDropk.asp;/webap/rtap/base/rtcmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtcmty/RTFaqProcessK.asp;/webap/rtap/base/rtcmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtcmty/RTFaqFinishRTNK.asp;/rtap/base/rtcmty/RTFaQV.asp", ";")
				case "5"
					aryOptProg =Split("/webap/rtap/base/rtebtcmty/RTFaqDropk.asp;/webap/rtap/base/rtebtcmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtebtcmty/RTFaqProcessK.asp;/webap/rtap/base/rtebtcmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtebtcmty/RTFaqFinishRTNK.asp;/RTap/Base/RTEBTCmty/RTFaQV.asp", ";")
				case "6"
					aryOptProg =Split("/webap/rtap/base/rtsparq499cmty/RTFaqDropk.asp;/webap/rtap/base/rtsparq499cmty/RTFaqDropRTNk.asp;/webap/rtap/base/rtsparq499cmty/RTFaqProcessK.asp;/webap/rtap/base/rtsparq499cmty/RTFaqFinishUsrK.asp;/webap/rtap/base/rtsparq499cmty/RTFaqFinishRTNK.asp;/RTap/Base/RTSparq499Cmty/RTFaQV.asp", ";")
				case "7"
					aryOptProg =Split("/webap/rtap/base/RTLessorAVSCmty/RTLessorAVSCustFaqDrop.asp;/webap/rtap/base/RTLessorAVSCmty/RTLessorAVSCustFaqDropC.asp; ;/webap/rtap/base/RTLessorAVSCmty/RTLessorAVSCustFaqF.asp;/webap/rtap/base/RTLessorAVSCmty/RTLessorAVSCustFaqFR.asp;�@", ";")
				case "8"
					aryOptProg =Split("/webap/rtap/base/RTLessorCmty/RTLessorCustFaqDrop.asp;/webap/rtap/base/RTLessorCmty/RTLessorCustFaqDropC.asp; ;/webap/rtap/base/RTLessorCmty/RTLessorCustFaqF.asp;/webap/rtap/base/RTLessorCmty/RTLessorCustFaqFR.asp;�@", ";")
				case else
			end select 

      End IF
    wend
    'aryOptProg=Split("<%=functionOptProgram%>",";")
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
    i=0
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
	  If selItem <> 0 Then	'[�\��ﶵ]�s
         Randomize  
         'prog=aryOptProg(opt) &"?V=" &Rnd() &"&key=" &document.all("key" &selItem).value
			select case cstr(keyary(2))
			case "1"	'CHT599
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "2"	'CHT399
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "3"	'Sparq399
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "4"	'CHT599
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "5"	'EBT
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "6"	'Sparq499
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(5) &"&<%=dataProgParm%>"
			case "7"	'AVS �u�Ȥ���key���I(�Ltable), ����L�ȶD��, ���t�����u��
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(3) &";"&keyary(5) &"&<%=dataProgParm%>"
			case "8"	'ET
				prog=aryOptProg(opt) & "?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &keyary(3) &";"&keyary(5) &"&<%=dataProgParm%>"
			case else
			
			end select
         
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
<body background="/WEBAP/IMAGE/bg.gif">
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
         <input type="text" name="searchQry1" value="<%=searchQry1%>" style="display:none" readonly ID="Text3">
         <input type="text" name="searchQry2" value="<%=searchQry2%>" style="display:none" readonly ID="Text5">
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
<%End Sub%><!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%

Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�ȶD�ץ�l�ܧ@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�@�o;�@�o����;�B�z���I;����;���פ���;�C�L"
  functionOptPrompt="Y;Y;N;Y;Y;Y"
  functionOptProgram=""
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))  
  'if userlevel="1" or userlevel="5" or userlevel="31" then 
  '	 functionOptProgram="RTFaqDropk.asp;RTFaqDropRTNk.asp;RTFaqProcessK.asp;RTFaqFinishUsrK.asp;RTFaqFinishRTNK.asp;RTFaQV.asp"
  'else
  '   functionOptProgram=""
  'end if
  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;none;�ȶD�渹;���g�P;�~�ȭ�;��קO;�D�u;���ϦW��;�Ȥ�W��;���u��;������;�h����;�ȶD�O;�p���q��;�Ƶ�;���z�H;���z��;���פ�;�@�o��"
  sqlDelete="select c.comq1, c.lineq1, c.comtype, c.cusid, c.entryno " &_
			"a.faqno, c.belongnc, c.salesnc, c.comtypenc, c.comq, c.comn, a.faqman, " &_
			"c.finishdat, c.docketdat, c.dropdat, b.codenc as servicetypenc, a.contacttel, " &_
			"'�˾�14�ѫO�T���A���p�J���ץ�', f.cusnc, a.rcvdat, a.finishdat, a.canceldat " &_
			"from	RTLessorAVSCustFaqH a " &_
			"left outer join RTCode b on b.code = a.servicetype and b.kind ='N4' " &_
			"left outer join HBAdslCmtyCust c on c.cusid = a.cusid and c.comtype ='7' " &_
			"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.rcvusr " &_
			"where a.cusid ='' "
  dataTable="RTFAQH"
  userDefineDelete=""
  numberOfKey=6
  'dataProg="RTFAQCUSTOPTK.asp"
  dataProg="/webap/rtap/base/rtadslcmty/RTFAQD.asp;/webap/rtap/base/rtcmty/RTFAQD.asp;/webap/rtap/base/rtsparqadslcmty/RTFAQD.asp;/webap/rtap/base/rtcmty/RTFAQD.asp;/webap/rtap/base/rtEBTcmty/RTFAQD.asp;/webap/rtap/base/rtsparq499cmty/RTFAQD.asp;/webap/rtap/base/RTLessorAVSCmty/RTLessorAVSCustFaqD.asp;/webap/rtap/base/RTLessorCmty/RTLessorCustFaqD.asp"
  datawindowFeature=""
  searchWindowFeature="width=500,height=300,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.JPG"
  colSplit=1
  keyListPageSize=30
  searchProg="RTFaQAllS.asp"
  parmkey=""
  First=False
' When first time enter this keylist default query string to RTcmty.CASENO <> '*'
  searchFirst=False
  If searchQry="" Then
     searchQry =" and a.finishdate is null and a.dropdate is null " 
     searchQry1 =" and a.finishdat is null and a.canceldat is null " 
     searchQry2 =searchQry1
     searchShow="�����G�����סA���@�o���"
  End If
  'COMTYPE=1 OR 4:HB599,COMTYPE=2:CHT399,COMTYPE=3:NCIC399,COMTYPE=5:AVS499,COMTYPE=6:NCIC499
sqlList="select isnull(c.comq1, d.comq1), isnull(c.lineq1, d.lineq1), isnull(c.comtype, d.comtype), isnull(c.cusid, d.cusid), isnull(c.entryno, d.entryno), " &_
		"a.caseno, isnull(c.belongnc, d.belongnc), isnull(c.salesnc, d.salesnc), isnull(c.comtypenc, d.comtypenc), isnull(c.comq, d.comq), left(isnull(c.comn, d.comn),10), " & _
		"left(a.faqman,5), isnull(c.finishdat, d.finishdat), isnull(c.docketdat, d.docketdat), isnull(c.dropdat, d.dropdat), " & _
		"b.codenc as servicetypenc, a.tel1+ case when a.tel1='' or a.tel2+a.mobile ='' then '' else '<br>' end + " & _
		"a.tel2+ case when a.tel1 + a.tel2 ='' or a.mobile ='' then '' else '<br>' end + a.mobile, " & _
		"case when c.docketdat is not null and a.rcvdate is not null and Datediff(mi, c.finishdat, a.rcvdate)/1440 between 0 and 14 then '<font color=red>�˾�14�ѫO�T��<br>�A���p�J���ץ�</font>' " & _
		"	when d.docketdat is not null and a.rcvdate is not null and Datediff(mi, d.finishdat, a.rcvdate)/1440 between 0 and 14 then '<font color=red>�˾�14�ѫO�T��<br>�A���p�J���ץ�</font>' " & _
		"else '' end, f.cusnc, a.rcvdate, a.finishdate, a.dropdate " & _
		"from	RTFaqH a " & _
		"left outer join RTCode b on b.code = a.servicetype and b.kind ='E8' " & _
		"left outer join HBAdslCmtyCust c on c.comq1 = a.comq1 and c.cusid = a.cusid and c.entryno = a.entryno " & _
		"	and a.comtype >='1' and a.comtype <='4' and c.comtype >='1' and c.comtype <='4' " & _
		"left outer join HBAdslCmtyCust d on d.comq1 = a.comq1 and d.cusid = a.cusid and d.lineq1  = a.entryno " & _
		"	and a.comtype >='5' and a.comtype <='6' and d.comtype >='5' and d.comtype <='6' " & _
		"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.rcvusr " & _
		"where	a.comtype >'' and isnull(c.comtype, d.comtype) is not null " & searchqry & _
		" UNION " & _

		"select c.comq1, c.lineq1, c.comtype, c.cusid, c.entryno, " &_
		"a.faqno, c.belongnc, c.salesnc, c.comtypenc, c.comq, left(c.comn,10), left(a.faqman,5), c.finishdat, c.docketdat, c.dropdat, " & _
		"b.codenc as servicetypenc, a.contacttel + case when a.contacttel='' or a.mobile='' then '' else '<br>' end + a.mobile, " & _
		"case when c.docketdat is not null and a.rcvdat is not null and Datediff(mi, c.finishdat, a.rcvdat)/1440 between 0 and 14 " & _
		"	then '<font color=red>�˾�14�ѫO�T��<br>�A���p�J���ץ�</font>' else '' end, " & _
		"f.cusnc, a.rcvdat, a.finishdat, a.canceldat " & _
		"from	RTLessorAVSCustFaqH a " & _
		"left outer join RTCode b on b.code = a.servicetype and b.kind ='N4' " & _
		"left outer join HBAdslCmtyCust c on c.cusid = a.cusid and c.comtype ='7' " & _
		"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.rcvusr " & _
		"where c.canceldat is null " & searchqry1 & _
		" UNION " & _

		"select c.comq1, c.lineq1, c.comtype, c.cusid, c.entryno, " &_
		"a.faqno, c.belongnc, c.salesnc, c.comtypenc, c.comq, left(c.comn,10), left(a.faqman,5), c.finishdat, c.docketdat, c.dropdat, " & _
		"b.codenc as servicetypenc, a.contacttel + case when a.contacttel='' or a.mobile='' then '' else '<br>' end + a.mobile, " & _
		"case when c.docketdat is not null and a.rcvdat is not null and Datediff(mi, c.finishdat, a.rcvdat)/1440 between 0 and 14 " & _
		"	then '<font color=red>�˾�14�ѫO�T��<br>�A���p�J���ץ�</font>' else '' end, " & _
		"f.cusnc, a.rcvdat, a.finishdat, a.canceldat " & _
		"from	RTLessorCustFaqH a " & _
		"left outer join RTCode b on b.code = a.servicetype and b.kind ='N4' " & _
		"left outer join HBAdslCmtyCust c on c.cusid = a.cusid and c.comtype ='8' " & _
		"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.rcvusr " & _
		"where c.canceldat is null " & searchqry2 & _
		" order by 20 DESC, 8 "
 'Response.Write "SQL=" & SQLlist
End Sub

%>