<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HiBuilding �޲z�t��"
  title="�~���p�q��Ȥ᥼���@�~�h������"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="N;N;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  

  functionOptName=""
  functionOptProgram=""
  functionOptPrompt="N"

  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�g�P��;�h���~��;���ϦW��;HN���X;�Ȥ�W��;������;�h����;�ϥΤѼ�;�P�N�ѽs��;���ݥX�f�渹"
  sqlDelete="SELECT a.comq1, a.cusid, a.entryno, case when b.comtype between '01' and '05' or b.comtype ='14' then isnull(g.areanc,i.areanc) else c.codenc end as area, "_
			&"Convert(varchar(3), Datepart(yy, a.DROPDAT)-1911)+ right('0'+Convert(varchar(2),Datepart(mm,a.DROPDAT)),2), "_
			&"b.comn, a.CUSNO, d.cusnc, a.DOCKETDAT, a.DROPDAT,CASE WHEN A.dropdat IS NOT NULL THEN datediff(day, a.docketdat, a.dropdat) ELSE datediff(day, a.docketdat, getdate()) END,A.CONSENTNO,a.consentuseno "_
			&"FROM	RTCust a "_
			&"Inner join RTCmty b on a.COMQ1 = b.COMQ1 "_
			&"Left outer join RTCode c on c.CODE = b.COMTYPE and c.KIND ='B3' "_
			&"left outer join rtctytown f inner join rtarea g on g.areaid = f.areaid on b.cutid = f.cutid and b.township = f.township "_
			&"left outer join (select cutid, areaid from rtctytown where not (cutid ='03' and areaid ='C2') and areaid <> '' group by cutid, areaid) h "_
			&"inner join rtarea i on i.areaid = h.areaid on b.cutid = h.cutid "_
			&"left outer join RTObj d on d.cusid = a.cusid "_
			&"WHERE	a.DOCKETDAT is not Null AND a.DROPDAT is not Null "_
			&"AND	dateadd(yy, 1, DOCKETDAT) > DROPDAT "_
			&"AND	CONSENTNO <>'' "_
			&"ORDER BY case when b.comtype between '01' and '05' or b.comtype ='14' then isnull(g.areanc,i.areanc) else c.codenc end, dropdat "

  'dataTable="rtebtcmtyline"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTCustD.asp"
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
  searchProg="RTConsigneeStatS.asp"

  searchFirst=FALSE
  
' response.Write "searchQry="&searchQry& "<br>"
  
  If searchQry="" Then
     searchQry=" DROPDAT between '1900/1/1' and '2900/12/31' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
  '-------------------------------------------------------------------------------------------
  sqlList="SELECT a.comq1, a.cusid, a.entryno, case when b.comtype between '01' and '05' or b.comtype ='14' then isnull(g.areanc,i.areanc) else c.codenc end as area, "_
			&"Convert(varchar(3), Datepart(yy, a.DROPDAT)-1911)+ right('0'+Convert(varchar(2),Datepart(mm,a.DROPDAT)),2), "_
			&"b.comn, a.CUSNO, d.cusnc, a.DOCKETDAT, a.DROPDAT,CASE WHEN A.dropdat IS NOT NULL THEN datediff(day, a.docketdat, a.dropdat) ELSE datediff(day, a.docketdat, getdate()) END,A.CONSENTNO,a.consentuseno "_
			&"FROM	RTCust a "_
			&"Inner join RTCmty b on a.COMQ1 = b.COMQ1 "_
			&"Left outer join RTCode c on c.CODE = b.COMTYPE and c.KIND ='B3' "_
			&"left outer join rtctytown f inner join rtarea g on g.areaid = f.areaid on b.cutid = f.cutid and b.township = f.township "_
			&"left outer join (select cutid, areaid from rtctytown where not (cutid ='03' and areaid ='C2') and areaid <> '' group by cutid, areaid) h "_
			&"inner join rtarea i on i.areaid = h.areaid on b.cutid = h.cutid "_
			&"left outer join RTObj d on d.cusid = a.cusid "_
			&"WHERE	a.DOCKETDAT is not Null AND a.DROPDAT is not Null "_
			&"AND	dateadd(yy, 1, DOCKETDAT) > DROPDAT "_
			&"AND " & searchQry _         
			&" AND	CONSENTNO <>'' "_
			&"ORDER BY case when b.comtype between '01' and '05' or b.comtype ='14' then isnull(g.areanc,i.areanc) else c.codenc end, dropdat "
  
    'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
