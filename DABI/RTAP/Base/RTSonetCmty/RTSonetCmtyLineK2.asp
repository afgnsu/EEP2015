<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="So-net�޲z�t��"
  title="So-net�D�u��ƺ��@"
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
  functionOptName="�D�u�y�q;����(ping);�Τ���@;�D�u���u;�@�@�@�o;�@�o����"
  functionOptProgram="RTSonetCmtyLineMrtg.asp;RTSonetCmtyLineTool.asp;RTSonetCustK2.asp;RTSonetCmtyLineSndWrkK.asp;RTSonetCmtyLineCancel.asp;RTSonetCmtyLineCancelRtn.asp"
  functionOptPrompt="N;N;N;N;Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�~��<br>�Ұ�;�u��<br>�Ұ�;���ϦW��;�D�u<br>�Ǹ�;����;�m��;�M�u�s��;�D�uIP;IP<br>����;�D�u�t�v;�D�u<br>����;�M�u��;�@�o��;�w����<br>���"
  sqlDelete="select i_smallint, i.tinyint, c_varchar, c_varchar, c_varchar, c_varchar, c_varchar,c_varchar, c_varchar, c_varchar, " &_
  			"c_varchar, c_varchar, d_datetime, d_datetime, d_datetime, i_smallint " &_
  			"from RTTemplate "
  dataTable="RTSonetCmtyLine"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTSonetCmtyLineD.asp"
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
  searchProg="RTSonetCmtyLineS2.asp"

  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.comq1<>0 "
     searchShow="����"
  End If

    if ARYPARMKEY(0) <>"" then 
		searchQry = searchQry & " and a.ComQ1=" & aryparmkey(0)
	end if

  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
    sqlList="select  a.comq1, a.lineq1, isnull(m.cusnc,''), isnull(d.shortnc, f.cusnc), c.comn, convert(varchar(6), a.comq1) +'-'+ convert(varchar(3),a.lineq1), " &_
			"g.cutnc, a.township, a.linetel, a.lineip, i.codenc, j.codenc, a.hardwaredat, a.dropdat, a.canceldat, isnull(k.custnum, 0) " &_
			"from RTSonetCmtyLine a " &_
			"inner join RTSonetCmtyH c on c.comq1 = a.comq1 " &_
			"left outer join RTObj d on c.consignee = d.cusid " &_
			"left outer join RTEmployee e inner join RTObj f on e.cusid = f.cusid on c.engid = e.emply " &_
			"left outer join RTEmployee l inner join RTObj m on l.cusid = m.cusid on c.salesid = l.emply " &_
			"left outer join RTCounty g on a.cutid=g.cutid " &_
			"left outer join RTCode i on a.lineiptype = i.code and i.kind = 'm5' " &_
			"left outer join RTCode j on a.linerate = j.code and j.kind = 'd3' " &_
			"left outer join (select y.comq1, y.lineq1, count(*) as custnum from RTSonetCust x inner join RTSonetCmtyLine y " &_
			"	on x.comq1 = y.comq1 and x.lineq1 = y.lineq1 where x.dropdat is null and x.canceldat is null " &_
			"	and x.docketdat is not null group by  y.comq1, y.lineq1) k on k.comq1 = a.comq1 and k.lineq1 = a.lineq1 " &_
			"where " & searchqry &_
			" ORDER BY a.comq1, a.lineq1 "
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>