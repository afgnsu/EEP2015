<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�D�u��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="�D�u���u;�]�Ƭd��;�Τ���@;�ȪA�ץ�;������;�M�u�@�~;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCmtyLineSNDWORKK.asp;RTLessorCmtyLINEHardwareK2.asp;RTLessorCustK.asp;RTLessorCmtyLineFAQK.asp;RTLessorCmtyLineContK.asp;RTLessorCmtyLineDROPK.asp;RTLessorCmtyLineCANCEL.asp;RTLessorCmtyLineCANCELRTN.asp;RTLessorCmtyLineLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  'formatName="none;none;���ϦW��;�D�u;�m��;�s��;�D�uIP;none;none;none;�D�u����;�u��ISP;IP����;�D�u�t�v;IP��;Reset�q��;none;none;none;����;none;�M�u��;�@�o��;�Τ�;����;�h��;�p�O"
  formatName="none;none;�Ұ�;���ϦW��;�D�u;����;�m��;none;�D�uIP;none;none;none;none;�u��<br>ISP;IP<br>����;�D�u�t�v;none;Reset�q��;none;none;none;����;none;�M�u��;�@�o��;�Τ�;����;�h��;�p�O"  
    sqlDelete="select a.comq1, a.lineq1, isnull(d.shortnc, f.cusnc), c.comn, convert(varchar(6), a.comq1) +'-'+ convert(varchar(6),a.lineq1), " &_
			"g.cutnc, a.township, a.linegroup,a.lineip,a.gateway, a.pppoeaccount, a.pppoepassword, a.linetel, " &_
			"substring(h.codenc,1,2), i.codenc, j.codenc, a.ipcnt, k.tel, a.rcvdat, a.inspectdat, a.hinetnotifydat, " &_
			"a.hardwaredat, a.adslapplydat, a.dropdat, a.canceldat, " &_
			"sum(case when b.cusid is not null and b.canceldat is null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and b.finishdat is not null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and b.finishdat is not null and b.dropdat is not null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and (b.strbillingdat is not null or b.newbillingdat is not null) and b.dropdat is null then 1 else 0 end) " &_
			"from RTLessorCmtyLine a " &_
			"left outer join RTLessorCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
			"inner join RTLessorCmtyH c on c.comq1 = a.comq1 " &_
			"left outer join RTObj d on a.consignee = d.cusid " &_
			"left outer join RTEmployee e inner join RTObj f on e.cusid = f.cusid on a.salesid = e.emply " &_
			"left outer join RTCounty g on a.cutid=g.cutid " &_
			"left outer join RTCode h on a.lineisp = h.code and h.kind = 'c3' " &_
			"left outer join RTCode i on a.lineiptype = i.code and i.kind = 'm5' " &_
			"left outer join RTCode j on a.linerate = j.code and j.kind = 'd3' " &_
			"left outer join RTReset k on k.comq1 = a.comq1 and k.lineq1 = a.lineq1 and k.cmtytype ='07' and k.canceldat is null " &_
			"where " & searchqry & limitemply &_
			" group by  a.comq1, a.lineq1, isnull(d.shortnc, f.cusnc), c.comn, convert(varchar(6), a.comq1) +'-'+ convert(varchar(6),a.lineq1), " &_
			"g.cutnc, a.township, a.linegroup,a.lineip,a.gateway, a.pppoeaccount, a.pppoepassword, a.linetel, " &_
			"substring(h.codenc,1,2), i.codenc, j.codenc, a.ipcnt, k.tel, a.rcvdat, a.inspectdat, a.hinetnotifydat, " &_
			"a.hardwaredat, a.adslapplydat, a.dropdat, a.canceldat " &_
            "ORDER BY  a.COMQ1, a.LINEQ1 "

  dataTable="RTLessorCmtyLine"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTLessorCmtyLineD.asp"
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
  keyListPageSize=25
  searchProg="RTLessorCmtylineS2.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and a.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close

  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----
 
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" a.ComQ1<>0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
    sqlList="select a.comq1, a.lineq1, isnull(d.shortnc, f.cusnc), c.comn, convert(varchar(6), a.comq1) +'-'+ convert(varchar(6),a.lineq1), " &_
			"g.cutnc, a.township, a.linegroup,a.lineip,a.gateway, a.pppoeaccount, a.pppoepassword, a.linetel, " &_
			"substring(h.codenc,1,2), i.codenc, j.codenc, a.ipcnt, k.tel, a.rcvdat, a.inspectdat, a.hinetnotifydat, " &_
			"a.hardwaredat, a.adslapplydat, a.dropdat, a.canceldat, " &_
			"sum(case when b.cusid is not null and b.canceldat is null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and b.finishdat is not null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and b.finishdat is not null and b.dropdat is not null then 1 else 0 end), " &_
			"sum(case when b.cusid is not null and b.canceldat is null and (b.strbillingdat is not null or b.newbillingdat is not null) and b.dropdat is null then 1 else 0 end) " &_
			"from RTLessorCmtyLine a " &_
			"left outer join RTLessorCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 " &_
			"inner join RTLessorCmtyH c on c.comq1 = a.comq1 " &_
			"left outer join RTObj d on a.consignee = d.cusid " &_
			"left outer join RTEmployee e inner join RTObj f on e.cusid = f.cusid on a.salesid = e.emply " &_
			"left outer join RTCounty g on a.cutid=g.cutid " &_
			"left outer join RTCode h on a.lineisp = h.code and h.kind = 'c3' " &_
			"left outer join RTCode i on a.lineiptype = i.code and i.kind = 'm5' " &_
			"left outer join RTCode j on a.linerate = j.code and j.kind = 'd3' " &_
			"left outer join RTReset k on k.comq1 = a.comq1 and k.lineq1 = a.lineq1 and k.cmtytype ='07' and k.canceldat is null " &_
			"where " & searchqry & limitemply &_
			" group by  a.comq1, a.lineq1, isnull(d.shortnc, f.cusnc), c.comn, convert(varchar(6), a.comq1) +'-'+ convert(varchar(6),a.lineq1), " &_
			"g.cutnc, a.township, a.linegroup,a.lineip,a.gateway, a.pppoeaccount, a.pppoepassword, a.linetel, " &_
			"substring(h.codenc,1,2), i.codenc, j.codenc, a.ipcnt, k.tel, a.rcvdat, a.inspectdat, a.hinetnotifydat, " &_
			"a.hardwaredat, a.adslapplydat, a.dropdat, a.canceldat " &_
            "ORDER BY  a.COMQ1, a.LINEQ1 "

  'end if
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>