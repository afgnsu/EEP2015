<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq �����q�ܺ޲z�t��"
  title="Sparq �����q�ܥΤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'ButtonEnable="Y;N;Y;Y;Y;Y"

'  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
'	if emply ="T89039" then
	  functionOptName="���u��"
	  functionOptProgram="RTSparqWagalySndWrkK.asp"
	  functionOptPrompt="N"
'	end if
  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Τ�N��;������O;��b��;�Τ�W��;�˾�����;�~�ȭ�;�g�P��;�ӽФ�;���u��;������;�h����;�@�o��;���u��"
  sqlDelete="SELECT	CUSID, CASETYPE, NCICCUSNO, CUSNC, RADDR2, SALESID, consignee, "_
		   &"		APPLYDAT, FINISHDAT, DOCKETDAT, DROPDAT, CANCELDAT, TRANSDAT "_
		   &"FROM	RTSparqWagalyCust "_
		   &"WHERE	CUSID ='' "_
		   &"order by cusid "

  dataTable="RTSparqWagalyCust"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTSparqWagalyCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTSparqWagalyCustS.asp"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.CUSID <>'' "
     searchShow="�����Τ�(���t�@�o)"
  ELSE
     SEARCHFIRST=FALSE
  End If
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  'Domain=Mid(Emply,1,1)
  
  'If searchShow="����" Then
  sqlList=	"SELECT	a.CUSID, f.codenc, a.NCICCUSNO, a.cusnc, isnull(b.cutnc, a.cutid2)+a.township2+a.RADDR2, " &_
			"isnull(e.cusnc, ''), isnull(c.shortnc,''), " &_ 
			"a.APPLYDAT, a.FINISHDAT, a.DOCKETDAT, a.DROPDAT, a.CANCELDAT, g.sndwrkdat " &_
			"FROM RTSparqWagalyCust a " &_
			"left outer join RTCounty b on a.cutid2 = b.cutid " &_
			"left outer join RTObj c on c.cusid = a.consignee " &_
			"left outer join RTEmployee d inner join RTObj e on e.cusid = d.cusid on d.emply = a.salesid " &_
			"left outer join RTCode f on f.code = a.casetype and f.kind ='Q5' " &_
			"left outer join RTSparqWagalySndWrk g inner join (select cusid, max(workno) as maxworkno from RTSparqWagalySndWrk where canceldat is null group by cusid) h " &_
			"		on g.cusid = h.cusid on g.cusid = a.cusid and g.workno = h.maxworkno " &_
			"where " & searchqry &_
			" order by a.cusid "
  
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
