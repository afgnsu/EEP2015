<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="Seednet�C�����ɤγ{8�����ɬd��"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����ɶפJ;�C�LSeednet����������"
  functionOptProgram="RTLessorAvsBillReckonImport.asp;RTLessorAvsBillNoReckonXls.asp"
  functionOptPrompt="H;H"
  functionoptopen="1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�b��s��;�Τ�s��;�C�b�~��;�Τ�W��;��ú<br>���B;�Τ���;ú�O�W��;�Τ�ܶW<br>��ú�ڤ�;�W��<br>�B�z��;Seednet<br>���ڤ�;Seednet<br>�R�P��;Seednet<br>�����"
  sqlDelete="select  a.csnoticeid, a.cscusid, a.accountym, a.cusnc, a.amt, a.memo, a.csname, a.cspaydat, a.csseednetdat, b.rcvdat, b.abatedat, b.closedat " &_
			"from RTBillSeednetTrade a " &_
			"left outer join RTBillSeednetReckon b on a.csnoticeid = b.csnoticeid and a.cscusid = b.cscusid " &_
			"where a.csnoticeid ='' " &_
  dataTable="RTBillSeednetTrade"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=300,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=50
  searchProg="self"

  If searchQry="" Then
     searchFirst=FALSE
     searchQry=	" a.accountym in ( select  a.accountym from RTBillSeednetTrade a " &_
				"				left outer join RTBillSeednetReckon b on a.csnoticeid = b.csnoticeid and a.cscusid = b.cscusid " &_
				"				where b.closedat is null group by a.accountym ) " 
     searchShow="����"
  Else
     searchFirst=False
  End If


  '----------------------------------------------------------------------------------------------
  'set connXX=server.CreateObject("ADODB.connection")
  'set rsXX=server.CreateObject("ADODB.recordset")
  'dsnxx="DSN=XXLIB"
  'sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  'connxx.Open dsnxx
  'rsxx.Open sqlxx,connxx
  'if not rsxx.EOF then
  '   usergroup=rsxx("group")
  'else
  '   usergroup=""
  'end if
  'rsxx.Close
  'connxx.Close
  'set rsxx=nothing
  'set connxx=nothing
  '----------------------------------------------------------------------------------------------
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  

  sqlList="select  a.csnoticeid, a.cscusid, a.accountym, a.cusnc, a.amt, a.memo, a.csname, a.cspaydat, a.csseednetdat, b.rcvdat, b.abatedat, b.closedat " &_
			"from RTBillSeednetTrade a " &_
			"left outer join RTBillSeednetReckon b on a.csnoticeid = b.csnoticeid and a.cscusid = b.cscusid " &_
			"where " & SEARCHQRY &_
			" order by a.csseednetdat "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>