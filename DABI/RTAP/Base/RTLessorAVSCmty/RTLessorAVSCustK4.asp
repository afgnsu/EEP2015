<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="���h��������Τ��Ƭd��"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�ȪA�ץ�;���v����"
  functionOptProgram="RTLessorAVSCustfaqK.asp;RTLessorAVSCustLOGK.asp"
  functionOptPrompt="N;N"
  functionoptopen="1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�;�g��;ú��;�s���q��;�ӽФ�;���u��;�}�l�p�O;�̪�<br>�����;�վ�<br>���;�����;����;�h����;�@�o��;����;�i��<BR>���;�̪�<br>�����B"
  sqlDelete="SELECT	a.COMQ1, a.LINEQ1, a.CUSID, " &_
			"RTRIM(LTRIM(CONVERT(char(6), a.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), a.LINEQ1))), " &_
			"c.COMN, case when len(a.CUSNC) > 4 then substring(a.CUSNC,1,4)+'...' else a.CUSNC end, " &_
			"e.CODENC, f.CODENC, " &_
			"a.CONTACTTEL + case when a.CONTACTTEL <>'' and a.MOBILE <>'' then ' / ' else '' end + a.MOBILE, " &_
			"a.APPLYDAT, a.FINISHDAT, a.STRBILLINGDAT, a.newBILLINGDAT, a.adjustday, a.DUEDAT, " &_
			"case when a.freecode='Y' then a.freecode else '' end, a.DROPDAT, a.CANCELDAT, a.PERIOD, " &_
			"isnull(DATEDiFF(d,getdate(),a.DUEDAT), 0) as validdat, a.rcvmoney " &_
			"FROM RTLessorAVSCust a " &_
			"left outer join RTLessorAVScmtyline b on a.comq1=b.comq1 and a.lineq1=b.lineq1 " &_
			"left outer join RTLessorAVSCmtyH c on a.COMQ1 = c.COMQ1 " &_
			"left outer join RTCounty d on a.CUTID1 = d.CUTID " &_
			"left outer join rtcode e on a.paycycle=e.code and e.kind='M8' " &_
			"left outer join rtcode f on a.payTYPE=f.code and f.kind='M9' " &_
			"where a.COMQ1=0 "
  dataTable="RTLessorAVSCust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTLessorAVSCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=400,scrollbars=yes"
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
  searchProg="RTLessorAVSCusts4.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.DUEDAT <= dateadd(m, 1, getdate()) "
     SEATCHQRY2=""
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  '-------------------------------------------------------------------------------------------
         sqlList="SELECT	a.COMQ1, a.LINEQ1, a.CUSID, " &_
			"RTRIM(LTRIM(CONVERT(char(6), a.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), a.LINEQ1))), " &_
			"c.COMN, case when len(a.CUSNC) > 4 then substring(a.CUSNC,1,4)+'...' else a.CUSNC end, " &_
			"e.CODENC, f.CODENC, " &_
			"a.CONTACTTEL + case when a.CONTACTTEL <>'' and a.MOBILE <>'' then ' / ' else '' end + a.MOBILE, " &_
			"a.APPLYDAT, a.FINISHDAT, a.STRBILLINGDAT, a.newBILLINGDAT, a.adjustday, a.DUEDAT, " &_
			"case when a.freecode='Y' then a.freecode else '' end, a.DROPDAT, a.CANCELDAT, a.PERIOD, " &_
			"isnull(DATEDiFF(d,getdate(),a.DUEDAT), 0) as validdat, a.rcvmoney " &_
			"FROM RTLessorAVSCust a " &_
			"left outer join RTLessorAVScmtyline b on a.comq1=b.comq1 and a.lineq1=b.lineq1 " &_
			"left outer join RTLessorAVSCmtyH c on a.COMQ1 = c.COMQ1 " &_
			"left outer join RTCounty d on a.CUTID1 = d.CUTID " &_
			"left outer join rtcode e on a.paycycle=e.code and e.kind='M8' " &_
			"left outer join rtcode f on a.payTYPE=f.code and f.kind='M9' " &_
			"where  a.canceldat is null and	a.dropdat is null " &_
			" and " & searchqry & " " & searchqry2
'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>