<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�C������b��Ȥ���Ӭd��"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�C�L�����;�C�L�H��;�ץX��Excel"
  functionOptProgram="/REPORT/Common/RTLessorAVSCustBillingPrtCtlP2.asp;/Report/AVSCity/RTLessorAVSCustBillingPrtEnvP2.asp;/REPORT/AvsCity/Report4.asp"
  functionOptPrompt="N;N;N"
  functionoptopen="1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="����渹;none;���g�P;�Ұ�;�D�u;���ϦW��;�Τ�W��;�����;�s���q��;�b��a�};�h����;�}�l�p�O��;����p�O��;���;�g��;�w��"
  sqlDelete="SELECT	a.noticeid, a.batch, c.consignee, c.salesid, " &_
			"convert(varchar(5), a.comq1) +'-'+ convert(varchar(2), a.lineq1), d.comn, b.cusnc, a.duedat, " &_
			"b.contacttel + case when b.contacttel<>'' and b.mobile<>'' then ' / ' else '' end + b.mobile, " &_
			"isnull(e.cutnc,'')+b.township3+b.raddr3, " &_
			"b.dropdat, b.strbillingdat, b.newbillingdat, h.codenc, g.codenc, j.codenc " &_
			"FROM	RTLessorAVSCustBillingPrtSub a " &_
			"inner join RTLessorAVSCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 and a.cusid = b.cusid " &_
			"inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1 " &_
			"inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1 " &_
			"left outer join RTCounty e on e.cutid = b.cutid3 " &_
			"left outer join RTCode g on g.code = a.paycycle and g.kind ='M8' " &_
			"left outer join RTCode h on h.code = a.casekind and h.kind ='O9' " &_
			"left outer join RTLessorAVSCustCont i on i.cusid = a.cusid and i.canceldat is null " &_
			"	and i.strbillingdat = dateadd(d, 1, a.duedat) " &_
			"left outer join rtcode j on j.code = i.paytype and j.kind ='M9' " &_
			"WHERE d.comq1=0 " &_
  dataTable="RTLessorAVSCustBillingPrtSub"
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
  keyListPageSize=25
  searchProg="RTLessorAVSCustBillingPrtCtlS.asp"

  searchFirst=FALSE
  If searchQry="" Then
     'searchFirst=True
     'searchQry=" SYY =" & ARYPARMKEY(0) & " AND SMM=" & ARYPARMKEY(1) 
     searchShow="����"
  'Else
     'searchFirst=False
  End If
  
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  
	sqlList="SELECT	a.noticeid, a.batch, case c.consignee when '' then '���P' else '�g�P' end, isnull(k.shortnc, m.cusnc), " &_
			"convert(varchar(5), a.comq1) +'-'+ convert(varchar(2), a.lineq1), d.comn, b.cusnc, a.duedat, " &_
			"b.contacttel + case when b.contacttel<>'' and b.mobile<>'' then '<br>' else '' end + b.mobile, " &_
			"isnull(e.cutnc,'')+b.township3+b.raddr3, " &_
			"b.dropdat, b.strbillingdat, b.newbillingdat, h.codenc, g.codenc, j.codenc " &_
			"FROM	RTLessorAVSCustBillingPrtSub a " &_
			"inner join RTLessorAVSCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 and a.cusid = b.cusid " &_
			"inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1 " &_
			"inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1 " &_
			"left outer join RTCounty e on e.cutid = b.cutid3 " &_
			"left outer join RTCode g on g.code = a.paycycle and g.kind ='M8' " &_
			"left outer join RTCode h on h.code = a.casekind and h.kind ='O9' " &_
			"left outer join RTLessorAVSCustCont i on i.cusid = a.cusid and i.canceldat is null " &_
			"	and i.strbillingdat = dateadd(d, 1, a.duedat) " &_
			"left outer join rtcode j on j.code = i.paytype and j.kind ='M9' " &_
			"left outer join RTObj k on k.cusid = c.consignee " &_
			"left outer join RTEmployee l inner join RTObj m on m.cusid = l.cusid on l.emply = c.salesid " &_			
			"WHERE b.freecode <>'Y' and a.BATCH ='" & ARYPARMKEY(0) &"' "& SEARCHQRY &_
			" ORDER BY d.comn, b.cusnc "
  'Response.Write "SQL=" & SQLlist
End Sub

Sub SrRunUserDefineDelete()

End Sub
%>