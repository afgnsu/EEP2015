<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;�Τ�W��;��b�Ǹ�;�˾��a�};���u��;������;�h����;�s���q��;�g�P��" 
  sqlDelete="SELECT a.cutyid,b.cusid,b.entryno,a.comn,c.cusnc,b.exttel+'-'+b.sphnno,d.cutnc+b.township2+b.raddr2,b.finishdat," _
       &"b.docketdat,b.dropdat,b.home," _
       &"CASE WHEN ( e.shortnc = '' or e.shortnc is null ) THEN CASE WHEN  a.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND a.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN a.cutid IN ('05', '06', '07', '08') OR " _
       &"( a.cutid = '03' AND  a.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  a.cutid IN ('09', '10', '11', '12', '13') " _ 
       &"THEN '�x��' WHEN  a.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE e.shortnc END " _
       &"FROM " _
       &"(SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR as bbb, " _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP," _
       &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END) as aaa, " _
       &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL AND rtsparqadslcust.FREECODE <> 'Y' THEN 1 ELSE 0 END) as cnt1, " _
       &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL AND rtsparqadslcust.FREECODE <> 'Y' THEN 1 ELSE 0 END) as cnt2," _
       &"rtsparqadslcmty.consignee,rtsparqadslcmty.cutid,rtsparqadslcmty.township " _
       &"FROM RTSparqAdslCmty LEFT OUTER JOIN rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
       &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
       &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL LEFT OUTER JOIN " _
       &"RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _
       &"WHERE RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL AND " _
       &"RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL " _
       &"GROUP BY RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR," _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP,rtsparqadslcmty.consignee," _
       &"rtsparqadslcmty.cutid,rtsparqadslcmty.township " _
       &"having SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL THEN 1 ELSE 0 END) < 3 ) a " _
       &"left outer join rtsparqadslcust b on a.cutyid=b.comq1 left outer join rtobj c on b.cusid=c.cusid left outer join " _
       &"rtcounty d on b.cutid2=d.cutid left outer join rtobj e on a.consignee = e.cusid order by a.comn,c.cusnc " 
  dataTable="RTSparqAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="/webap/rtap/base/rtsparqadslcmty/rtcustd.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTCMTYNCICCUST399s.asp"
  searchFirst=FALSE
  'Ū���ȦsKEY
  KEYXX=SPLIT(SESSION("search7"),";")
  If searchQry="" Then
    searchQry=" B.cusid <> '*' "
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  if len(trim(keyxx(0)))> 0 then
     searchQry7=" HAVING SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL THEN 1 ELSE 0 END) " & KEYXX(0) & " " & KEYXX(1)
  else
     SEARCHQRY7=""
  END IF
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select areaid,groupid from RTsalesgroupref where emply='" & emply & "' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  areaid=""
  groupid=""
  DO while not rsxx.eof
     leadingA=","
     leadingB=","  
     if len(trim(areaid))=0 then leadingA=""
     if len(trim(groupid))=0 then leadingB=""
     areaid=areaid & leadingA & "'" &  rsxx("areaid") & "' "
     groupid=groupid & leadingB & "'" & rsxx("groupid") & "' "
     rsxx.movenext 
  loop
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
sqllist="SELECT a.cutyid,isnull(b.cusid,''),isnull(b.entryno,''),a.comn,isnull(c.cusnc,'')," _
       &"isnull(b.exttel+'-'+b.sphnno,'') as ccc,isnull(d.cutnc+b.township2+b.raddr2,'') as rrr," _
       &"b.finishdat,b.docketdat,b.dropdat,isnull(b.home,'')," _
       &"CASE WHEN ( e.shortnc = '' or e.shortnc is null ) THEN CASE WHEN  a.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND a.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN a.cutid IN ('05', '06', '07', '08') OR " _
       &"( a.cutid = '03' AND  a.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  a.cutid IN ('09', '10', '11', '12', '13') " _ 
       &"THEN '�x��' WHEN  a.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE e.shortnc END " _
       &"FROM " _
       &"(SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR as bbb, " _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP," _
       &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END) as aaa, " _
       &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL AND rtsparqadslcust.FREECODE <> 'Y' THEN 1 ELSE 0 END) as cnt1, " _
       &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL AND rtsparqadslcust.FREECODE <> 'Y' THEN 1 ELSE 0 END) as cnt2," _
       &"rtsparqadslcmty.consignee,rtsparqadslcmty.cutid,rtsparqadslcmty.township " _
       &"FROM RTSparqAdslCmty LEFT OUTER JOIN rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
       &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
       &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL LEFT OUTER JOIN " _
       &"RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _
       &"WHERE RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL AND " _
       &"RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL " _
       &"GROUP BY RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR," _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP,rtsparqadslcmty.consignee," _
       &"rtsparqadslcmty.cutid,rtsparqadslcmty.township " _
       &" " & SEARCHQRY7 &") a " _
       &"left outer join rtsparqadslcust b on a.cutyid=b.comq1 left outer join rtobj c on b.cusid=c.cusid left outer join " _
       &"rtcounty d on b.cutid2=d.cutid left outer join rtobj e on a.consignee = e.cusid " _
       &"where b.docketdat is not null and b.dropdat is null AND " & SEARCHQRY & " " _
       &"order by a.comn,c.cusnc " 

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>