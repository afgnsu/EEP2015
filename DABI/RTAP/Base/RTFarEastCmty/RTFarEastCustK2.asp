<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="���Ǥj�e�W���ϫ��޲z�t��"
  title="���Ǥj�e�W���ϫ��Τ��ƺ��@"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  functionOptName="���צ���;���u�@�~;�]�ƫO�ަ��ڦC�L;�@�@�@�o;�@�o����"
  functionOptProgram="RTFareastCustRepairK.asp;RTfareastCustSndWrkK.asp;/RTAP/REPORT/Common/RTStorageReceiptfareast.asp;RTfareastCustCANCEL.asp;RTfareastCustCANCELRTN.asp"
  functionOptPrompt="N;N;N;Y;Y"
  functionoptopen=  "1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�~��<br>�Ұ�;�D<br>�u;����;�Τ�;��<br>��;�t�v;�g��;�Τ�IP;�ӽФ�;���u��;������;So-net<br>�ҥΤ�;So-net����<br>ú�ڤ�;�h����;�@�o��"
  sqlDelete="SELECT i_smallint, i_tinyint, c_varchar, c_varchar, c_varchar,c_varchar,c_varchar,c_varchar,c_varchar,c_varchar, " &_
  			"c_varchar,d_datetime,d_datetime,d_datetime,d_datetime,d_datetime,d_datetime,d_datetime from RTTemplate"
  dataTable="RTfareastCust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTfareastCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=500,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="400"
  diaHeight="250"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTfareastCustS2.asp"
  searchFirst=False
  If searchQry="" Then
     searchQry=" a.COMQ1 <>0 "
     SEATCHQRY2=""
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If

    if ARYPARMKEY(0) <>"" then 
		searchQry = searchQry & " and a.comq1=" & aryparmkey(0)
	end if

    if ARYPARMKEY(1) <>"" then 
		searchQry = searchQry & " and a.lineq1=" & aryparmkey(1)
	end if

  '-------------------------------------------------------------------------------------------
	sqlList="select a.comq1, a.lineq1, a.cusid, isnull(f.shortnc, e.cusnc), convert(varchar(6), a.comq1) +'-'+ convert(varchar(3),a.lineq1), c.comn, " &_
			"a.cusnc, a.freecode, g.codenc, h.codenc, " &_
			"case when a.dropdat is not null or a.canceldat is not null then '<font color=""red"">' end + a.ip11 + case when a.dropdat is not null or a.canceldat is not null then '</font>' end, " &_
			"a.applydat, a.finishdat, a.docketdat, a.activatedat, a.strbillingdat, a.dropdat, a.canceldat " &_
			"from RTfareastCust a " &_
			"	inner join RTfareastCmtyLine b on a.comq1 = b.comq1 and a.lineq1= b.lineq1 " &_
			"	inner join RTfareastCmtyH c on b.comq1 = c.comq1 " &_
			"	left outer join RTEmployee d inner join RTObj e on e.cusid = d.cusid on d.emply = c.salesid " &_
			"	left outer join RTObj f on f.cusid = c.consignee " &_
			"	left outer join RTCode g on g.code = a.userrate and g.kind ='R6' " &_
			"	left outer join RTCode h on h.code = a.paycycle and h.kind ='M8' " &_
			"where " & searchqry &_
			" order by a.comq1,  case when a.dropdat is null and a.canceldat is null then 0 else 1 end, case a.ip11 when '' then 0 else convert(tinyint,right(a.ip11,len(a.ip11)-charindex('.', a.ip11, charindex('.', a.ip11, charindex('.', a.ip11)+1)+1))) end "
'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>