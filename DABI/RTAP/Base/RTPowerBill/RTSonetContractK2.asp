<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="So-net�޲z�t��"
  title="�X����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  if ARYPARMKEY(0) ="" then
    ButtonEnable="N;N;Y;Y;Y;Y"
  else
    ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  end if
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="�@�@�o"
  functionOptProgram="RTSonetContractCancel.asp"
  functionOptPrompt="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  dataTable="RTContract"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTSonetContractD.asp"
  datawindowFeature=""
  searchWindowFeature="width=450,height=350,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=30
  searchProg=""

  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.CTNO>=0 "
     searchShow="����"
  End If

    if ARYPARMKEY(0) <>"" then 
		searchQry = searchQry & " and a.ComQ1=" & aryparmkey(0)
	end if

  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  	formatName="����<br>�Ǹ�;�X��<br>�Ǹ�;���ϦW��;�X��<br>�_�l��;�X��<br>�����;�q�O����<br>�g��(��);�p��覡;�X���@�o��"
	'-------------------------------------------------------------------------------------------  
  	sqlDelete="select i_smallint, i_int, c_varchar, d_datetime, d_datetime, i_tinyint, c_varchar, d_datetime " &_
			"from RTTemplate "
    sqlList="select a.COMQ1, a.CTNO, b.comn, a.STRDAT, a.ENDDAT, a.PERIOD, case a.counttype " &_
			"when '01' then convert(varchar(5),a.meterrate)+' ��/�C�׹q' " &_
			"when '02' then convert(varchar(5),a.mpay)+' ��/�C��' " &_
			"when '03' then convert(varchar(5),a.mpay)+' ��/�C��F'+convert(varchar(5),a.custnumup)+'��H�W�G'+ convert(varchar(5),a.mpay2)+' ��/�C��' " &_
			"when '04' then convert(varchar(5),a.mpay)+' ��/�C��F'+convert(varchar(5),a.custnumup)+'��H�W,�C�W�['+convert(varchar(5),a.custnuminc)+'��G�['+ convert(varchar(5),a.mpay2)+' ��/�C��' " &_
			"else 'N/A' end, canceldat " &_
			"from RTContract a " &_
			"inner join RTSonetCmtyH b on a.comq1 = b.comq1 " &_
			"where " & searchqry &_
			" ORDER BY a.CTNO "
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>