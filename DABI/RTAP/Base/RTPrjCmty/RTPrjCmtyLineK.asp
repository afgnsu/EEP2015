<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�M�ת��Ϻ޲z�t��"
  title="�M�ת��ϥD�u��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  if len(ARYPARMKEY(0))=0  Then
	buttonEnable="N;N;Y;Y;Y;Y"  
  else
	ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  end if	
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'functionOptName="�D�u���u;�]�Ƭd��;�Τ���@;�ȪA�ץ�;������;�M�u�@�~;�@�@�@�o;�@�o����;���v����"
  'functionOptProgram="RTLessorCmtyLineSNDWORKK.asp;RTLessorCmtylineHardwareK2.asp;RTLessorCustK.asp;RTLessorCmtyLineFAQK.asp;RTLessorCmtyLineContK.asp;RTLessorCmtyLineDROPK.asp;RTLessorCmtyLineCANCEL.asp;RTLessorCmtyLineCANCELRTN.asp;RTLessorCmtyLineLOGK.asp"
  functionOptName="�Τ���@;�@�@�@�o;�@�o����"
  functionOptProgram="RTPrjCustK.asp;RTPrjCmtyLineCancel.asp;RTPrjCmtyLineCancelRTN.asp"
  functionOptPrompt="N;Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�D�u;�D�uIP;�D�u����;�D�u�t�v;�ӽФ�;����;�M�u��;�@�o��;������;�p�O��;�h����"
  sqlDelete="select	a.comq1, a.lineq1, b.comn, convert(varchar(5), a.comq1)+'-'+convert(varchar(5), a.lineq1), " &_
			"		a.lineip, a.linetel, c.codenc, a.applydat, a.arrivedat, a.dropdat, a.canceldat, " &_
			"		isnull(d.validnum,0), isnull(f.billnum,0), isnull(e.dropnum,0) " &_
			"from	RTPrjCmtyLine a " &_
			"inner join RTPrjCmtyH b on a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.linerate and c.kind ='D3' " &_
			"left outer join (select comq1, lineq1, count(*) as validnum from RTPrjCust where freecode <>'Y' " &_
			"			and docketdat is not null and dropdat is null and canceldat is null " &_
			"			group by comq1, lineq1) d on d.comq1 = a.comq1 and d.lineq1 = a.lineq1 " &_
			"left outer join (select comq1, lineq1, count(*) as dropnum from RTPrjCust where freecode <>'Y' " &_
			"			and docketdat is not null and dropdat is not null and canceldat is null " &_
			"			group by comq1, lineq1) e on e.comq1 = a.comq1 and e.lineq1 = a.lineq1 " &_
			"left outer join (select comq1, lineq1, count(*) as billnum from RTPrjCust where freecode <>'Y' " &_
			"			and strbillingdat is not null and dropdat is null and canceldat is null " &_
			"			group by comq1, lineq1) f on d.comq1 = a.comq1 and f.lineq1 = a.lineq1 " &_
			"where a.comq1 =0 "

  dataTable="RTPrjCmtyLine"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTPrjCmtyLineD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
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
' Open search program when first entry this keylist
  searchFirst=FALSE
  If searchQry="" and len(aryparmkey(0))>0 Then
     searchQry=" a.ComQ1=" & aryparmkey(0)
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",���Ϧa�}�J" & COMADDR
  elseIf searchQry="" and len(aryparmkey(0))=0 Then
     searchQry=" a.comq1 >=0 "
  ELSE
     SEARCHFIRST=FALSE
  End If


  if len(aryparmkey(0))>0 Then
		set connYY=server.CreateObject("ADODB.connection")
		set rsYY=server.CreateObject("ADODB.recordset")
		dsnYY="DSN=RTLIB"
		sqlYY="select * from RTPrjCmtyH LEFT OUTER JOIN RTCOUNTY ON RTPrjCmtyH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
		connYY.Open dsnYY
		rsYY.Open sqlYY,connYY
		if not rsYY.EOF then
			COMN=rsYY("COMN")
			COMADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("RADDR")
		else
			COMN=""
			COMADDR=""
		end if
		rsYY.Close
		connYY.Close
		set rsYY=nothing
		set connYY=nothing
   end if

  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and b.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  
  '-------------------------------------------------------------------------------------------
  sqlList=	"select	a.comq1, a.lineq1, b.comn, convert(varchar(5), a.comq1)+'-'+convert(varchar(5), a.lineq1), " &_
			"		a.lineip, a.linetel, c.codenc, a.applydat, a.arrivedat, a.dropdat, a.canceldat, " &_
			"		isnull(d.validnum,0), isnull(f.billnum,0), isnull(e.dropnum,0) " &_
			"from	RTPrjCmtyLine a " &_
			"inner join RTPrjCmtyH b on a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.linerate and c.kind ='D3' " &_
			"left outer join (select comq1, lineq1, count(*) as validnum from RTPrjCust where freecode <>'Y' " &_
			"			and docketdat is not null and dropdat is null and canceldat is null " &_
			"			group by comq1, lineq1) d on d.comq1 = a.comq1 and d.lineq1 = a.lineq1 " &_
			"left outer join (select comq1, lineq1, count(*) as dropnum from RTPrjCust where freecode <>'Y' " &_
			"			and docketdat is not null and dropdat is not null and canceldat is null " &_
			"			group by comq1, lineq1) e on e.comq1 = a.comq1 and e.lineq1 = a.lineq1 " &_
			"left outer join (select comq1, lineq1, count(*) as billnum from RTPrjCust where freecode <>'Y' " &_
			"			and strbillingdat is not null and dropdat is null and canceldat is null " &_
			"			group by comq1, lineq1) f on f.comq1 = a.comq1 and f.lineq1 = a.lineq1 " &_
            "where " & SEARCHQRY & limitemply & " ORDER BY a.comq1, a.lineq1 "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
