<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="���ϥD�u�޲z�t��"
  title="����Reset�O���@��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  functionOptName="ping�^���T��"
  functionOptProgram="RTResetSubLogK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���Ϥ��;�D�u�Ǹ�;���ϦW��;Reset�q��;�D�uIP;iDslam IP;�D�u�^��;�D�u�t��(ms);iDslam�^��;iDslam�t��(ms);���漷��;ping���"
  sqlDelete="select f.resetno, f.rtbatch, m.codenc as cmtytype, " &_
			"	convert(varchar(5), a.comq1)+ case a.lineq1 when 0 then '' else ' - '+ convert(varchar(2), a.lineq1) end as comq, " &_
			"	case a.cmtytype when '03' then b.comn " &_
			"		when '05' then h.comn " &_
			"		when '06' then i.comn " &_
			"		when '07' then j.comn else '' end as comn, a.tel, " &_
			"	case a.cmtytype when '03' then replace(b.ipaddr, ' ', '') " &_
			"		when '05' then replace(c.gateway, ' ', '') " &_
			"		when '06' then replace(d.lineip, ' ', '') " &_
			"		when '07' then replace(e.lineip, ' ', '') else '' end as ip1, " &_
			"		isnull(c.idslamip, '') as ip2, " &_
			"	isnull(k.codenc, '') as ping1, f.pingms1, " &_
			"	isnull(l.codenc, '') as ping2, f.pingms2, " &_
			"	case when f.dialaction='alarm' then '<font color=red>'+isnull(f.dialaction, '')+'</font>' " &_
			"		when f.dialaction like 'reset%' then '<font color=Maroon>'+isnull(f.dialaction, '')+'</font>' " &_
			"		else '' end as dialaction, " &_
			"	convert(varchar(20), f.pingdat, 20) as pingdat " &_
			"from RTReset a " &_
			"left outer join RTSparqAdslCmty b on a.comq1 = b.cutyid and a.cmtytype ='03' " &_
			"left outer join RTSparq499CmtyLine c inner join RTSparq499CmtyH h on h.comq1 = c.comq1 on a.comq1 = c.comq1 and a.lineq1 = c.lineq1 and a.cmtytype ='05' " &_
			"left outer join RTLessorCmtyLine d inner join RTLessorCmtyH i on i.comq1 = d.comq1 on a.comq1 = d.comq1 and a.lineq1 = d.lineq1 and a.cmtytype ='06' " &_
			"left outer join RTLessorAvsCmtyLine e inner join RTLessorAvsCmtyH j on j.comq1 = e.comq1 on a.comq1 = e.comq1 and a.lineq1 = e.lineq1 and a.cmtytype ='07' " &_
			"left outer join RTResetSub f on f.resetno = a.resetno " &_
			"left outer join RTCode k on k.code = f.pingresult1 and k.kind ='P3' " &_
			"left outer join RTCode l on l.code = f.pingresult2 and l.kind ='P3' " &_
			"left outer join RTCode m on m.code = a.cmtytype and m.kind ='L5' " &_
			"WHERE a.resetno ='*'  "
  'dataTable="HBADSLCMTYFIXSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTResetSubLogK.asp"
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
  keyListPageSize=70
  searchProg="self"
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
     searchQry=" a.resetno='" & aryparmkey(0) & "' "
     searchShow="���ɳ渹�J"& aryparmkey(0) 
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  'Domain=Mid(Emply,1,1)
  
  sqlList=	"select f.resetno, f.rtbatch, m.codenc as cmtytype, " &_
			"	convert(varchar(5), a.comq1)+ case a.lineq1 when 0 then '' else ' - '+ convert(varchar(2), a.lineq1) end as comq, " &_
			"	case a.cmtytype when '03' then b.comn " &_
			"		when '05' then h.comn " &_
			"		when '06' then i.comn " &_
			"		when '07' then j.comn else '' end as comn, a.tel, " &_
			"	case a.cmtytype when '03' then replace(b.ipaddr, ' ', '') " &_
			"		when '05' then replace(c.gateway, ' ', '') " &_
			"		when '06' then replace(d.lineip, ' ', '') " &_
			"		when '07' then replace(e.lineip, ' ', '') else '' end as ip1, " &_
			"		isnull(c.idslamip, '') as ip2, " &_
			"	isnull(k.codenc, '') as ping1, f.pingms1, " &_
			"	isnull(l.codenc, '') as ping2, f.pingms2, " &_
			"	case when f.dialaction='alarm' then '<font color=red>'+isnull(f.dialaction, '')+'</font>' " &_
			"		when f.dialaction like 'reset%' then '<font color=Maroon>'+isnull(f.dialaction, '')+'</font>' " &_
			"		else '' end as dialaction, " &_
			"	convert(varchar(20), f.pingdat, 20) as pingdat " &_
			"from RTReset a " &_
			"left outer join RTSparqAdslCmty b on a.comq1 = b.cutyid and a.cmtytype ='03' " &_
			"left outer join RTSparq499CmtyLine c inner join RTSparq499CmtyH h on h.comq1 = c.comq1 on a.comq1 = c.comq1 and a.lineq1 = c.lineq1 and a.cmtytype ='05' " &_
			"left outer join RTLessorCmtyLine d inner join RTLessorCmtyH i on i.comq1 = d.comq1 on a.comq1 = d.comq1 and a.lineq1 = d.lineq1 and a.cmtytype ='06' " &_
			"left outer join RTLessorAvsCmtyLine e inner join RTLessorAvsCmtyH j on j.comq1 = e.comq1 on a.comq1 = e.comq1 and a.lineq1 = e.lineq1 and a.cmtytype ='07' " &_
			"left outer join RTResetSub f on f.resetno = a.resetno " &_
			"left outer join RTCode k on k.code = f.pingresult1 and k.kind ='P3' " &_
			"left outer join RTCode l on l.code = f.pingresult2 and l.kind ='P3' " &_
			"left outer join RTCode m on m.code = a.cmtytype and m.kind ='L5' " &_
			"where " & searchqry & " order by pingdat desc"
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>