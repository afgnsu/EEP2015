<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�M�ת��Ϻ޲z�t��"
  title="�M�ץΤ��ƺ��@"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  if len(ARYPARMKEY(0))=0 or len(ARYPARMKEY(1))=0 Then
	buttonEnable="N;N;Y;Y;Y;Y"  
  else
	ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  end if	
  functionOptName="���צ���;�]�ƫO�ަ��ڦC�L;�@�@�@�o;�@�o����"
  functionOptProgram="RTPrjCustRepairK.asp;/RTAP/REPORT/Common/RTStorageReceiptPrj.asp;RTPrjCustCANCEL.asp;RTPrjCustCANCELRTN.asp"
  functionOptPrompt="N;Y;Y;Y"
  functionoptopen=  "1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�W;�q��;IP��};����;���u��;������;�}�l�p�O;�����;�����;�h����;�@�o��;�a�}"
  sqlDelete="select	a.comq1, a.lineq1, a.cusid, convert(varchar(5), a.comq1)+'-'+convert(varchar(5), a.lineq1), " &_
			"c.comn, a.cusnc, a.contacttel, IP11, a.freecode, " &_
			"a.finishdat, a.docketdat, a.strbillingdat, a.newbillingdat, a.duedat, a.dropdat, a.canceldat, a.raddr2 " &_
			"from	RTPrjCust a " &_
			"inner join RTPrjCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
			"inner join RTPrjCmtyH c on c.comq1 = b.comq1 " &_
			"where a.cusid ='' "
  dataTable="RTPrjCust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTPrjCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=300,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="400"
  diaHeight="250"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=30
  searchProg="RTPrjCustS.asp"
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
  If searchQry="" and len(ARYPARMKEY(1))>0 Then
     searchQry=" a.COMQ1=" & ARYPARMKEY(0) & " AND a.LINEQ1=" & ARYPARMKEY(1)
     searchShow="����"
  elseIf searchQry="" and len(ARYPARMKEY(0))>0 and len(ARYPARMKEY(1))=0 Then
	 searchQry=" a.COMQ1=" & ARYPARMKEY(0) 
  elseIf searchQry="" and len(ARYPARMKEY(0))=0 and len(ARYPARMKEY(1))=0 Then
	 searchQry=" a.COMQ1 >=0 "
  ELSE
     SEARCHFIRST=FALSE
  End If

  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and c.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing

  'Ū���n�J�b�����s�ո��
    sqlList="select	a.comq1, a.lineq1, a.cusid, convert(varchar(5), a.comq1)+'-'+convert(varchar(5), a.lineq1), " &_
			"c.comn, a.cusnc, a.contacttel, IP11, a.freecode, " &_
			"a.finishdat, a.docketdat, a.strbillingdat, a.newbillingdat, a.duedat, a.dropdat, a.canceldat, a.raddr2 " &_
			"from	RTPrjCust a " &_
			"inner join RTPrjCmtyLine b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
			"inner join RTPrjCmtyH c on c.comq1 = b.comq1 " &_
            "where " & searchqry & " " & limitemply  &_
            " order by case when isnull(a.dropdat,a.canceldat) is null then '' else 'Y' end, right('00'+replace(a.IP11,'192.168.168.',''),3) "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>