<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HiBuilding�޲z�t��"
  title="����ADS399L���ϤΫȤ��ƺ��@"
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
  formatName="none;none;none;���ϦW��;�Τ�W��;�˾��a�};���u��;������;�h����;�s���q��;�g�P��" 
  sqlDelete="SELECT a.cutyid,isnull(b.cusid,''),isnull(b.entryno,''),a.comn,isnull(c.cusnc,'')," _
       &"isnull(d.cutnc+b.township2+b.raddr2,'') as rrr,isnull(b.finishdat,''),isnull(b.docketdat,''),b.dropdat,isnull(b.home,'')," _
       &"CASE WHEN ( e.CODENC = '' or e.CODENC is null ) THEN CASE WHEN  a.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND a.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN a.cutid IN ('05', '06', '07', '08') OR " _
       &"( a.cutid = '03' AND  a.township IN ('�T�l��', '�a�q��')) THEN '���' WHEN  a.cutid IN ('09', '10', '11', '12', '13') " _
       &"THEN '�x��' WHEN  a.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE e.CODENC END " _
       &"FROM " _
       &"(SELECT RTcustadslcmty.CUTYID, RTcustadslcmty.COMN, RTcustadslcmty.cmtytel, RTcustadslcmty.HBNO, RTcustadslcmty.IPADDR, " _
       &"IsNull(RTCounty.CUTNC,'')+RTcustadslcmty.TOWNSHIP+RTcustadslcmty.ADDR as bbb, RTcustadslcmty.ADSLAPPLY," _
       &"RTcustadslcmty.RCOMDROP, SUM(CASE WHEN RTcustadsl.cusid IS NOT NULL OR RTcustadsl.cusid <> '' THEN 1 ELSE 0 END) as aaa, " _
       &"SUM(CASE WHEN RTcustadsl.finishdat IS NOT NULL AND RTcustadsl.DROPDAT IS NULL THEN 1 ELSE 0 END) as cnt1, " _
       &"SUM(CASE WHEN RTcustadsl.docketdat IS NOT NULL AND RTcustadsl.DROPDAT IS NULL THEN 1 ELSE 0 END) as cnt2," _
       &"RTcustadslcmty.COMTYPE,RTcustadslcmty.cutid,RTcustadslcmty.township " _
       &"FROM RTcustadslcmty LEFT OUTER JOIN RTcustadsl ON RTcustadslcmty.CUTYID = RTcustadsl.COMQ1 " _
       &"LEFT OUTER JOIN RTCounty ON RTcustadslcmty.CUTID = RTCounty.CUTID " _
       &"WHERE RTcustadslcmty.CUTYID<>0 AND RTcustadslcmty.ADSLAPPLY IS NOT NULL AND RTcustadslcmty.RCOMDROP IS NULL AND " _
       &"RTcustadslcmty.CUTYID<>0 AND RTcustadslcmty.ADSLAPPLY IS NOT NULL AND RTcustadslcmty.RCOMDROP IS NULL " _
       &"GROUP BY RTcustadslcmty.CUTYID, RTcustadslcmty.COMN, RTcustadslcmty.cmtytel, RTcustadslcmty.HBNO, RTcustadslcmty.IPADDR, " _
       &"IsNull(RTCounty.CUTNC,'')+RTcustadslcmty.TOWNSHIP+RTcustadslcmty.ADDR, RTcustadslcmty.ADSLAPPLY," _
       &"RTcustadslcmty.RCOMDROP,RTcustadslcmty.COMTYPE,RTcustadslcmty.cutid,RTcustadslcmty.township " _
       &" " & SEARCHQRY5 &") a " _
       &"left outer join RTcustadsl b on a.cutyid=b.comq1 left outer join rtobj c on b.cusid=c.cusid left outer join " _
       &"rtcounty d on b.cutid2=d.cutid left outer join rtcode e on a.comtype = e.code and e.kind='B3' " _
       &"where b.docketdat is not null and b.dropdat is null AND " & SEARCHQRY & " " _
       &"order by a.comn,c.cusnc "
  dataTable="RTcustAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="/webap/rtap/base/rtadslcmty/rtcustd.asp"
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
  searchProg="RTCMTYCHTCUST399s.asp"
  searchFirst=FALSE
  'Ū���ȦsKEY
  KEYXX=SPLIT(SESSION("search5"),";")
  If searchQry="" Then
    searchQry=" B.cusid <> '*' "
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  if len(trim(keyxx(0)))> 0 then
     searchQry5=" HAVING SUM(CASE WHEN rtcustADSL.docketdat IS NOT NULL AND rtcustADSL.DROPDAT IS NULL THEN 1 ELSE 0 END) " & KEYXX(0) & " " & KEYXX(1)
  else
     SEARCHQRY5=""
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
       &"isnull(d.cutnc+b.township2+b.raddr2,'') as rrr,isnull(b.finishdat,''),isnull(b.docketdat,''),b.dropdat,isnull(b.home,'')," _
       &"CASE WHEN ( e.CODENC = '' or e.CODENC is null ) THEN CASE WHEN  a.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND a.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN a.cutid IN ('05', '06', '07', '08') OR " _
       &"( a.cutid = '03' AND  a.township IN ('�T�l��', '�a�q��')) THEN '���' WHEN  a.cutid IN ('09', '10', '11', '12', '13') " _
       &"THEN '�x��' WHEN  a.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE e.CODENC END " _
       &"FROM " _
       &"(SELECT RTcustadslcmty.CUTYID, RTcustadslcmty.COMN, RTcustadslcmty.cmtytel, RTcustadslcmty.HBNO, RTcustadslcmty.IPADDR, " _
       &"IsNull(RTCounty.CUTNC,'')+RTcustadslcmty.TOWNSHIP+RTcustadslcmty.ADDR as bbb, RTcustadslcmty.ADSLAPPLY," _
       &"RTcustadslcmty.RCOMDROP, SUM(CASE WHEN RTcustadsl.cusid IS NOT NULL OR RTcustadsl.cusid <> '' THEN 1 ELSE 0 END) as aaa, " _
       &"SUM(CASE WHEN RTcustadsl.finishdat IS NOT NULL AND RTcustadsl.DROPDAT IS NULL THEN 1 ELSE 0 END) as cnt1, " _
       &"SUM(CASE WHEN RTcustadsl.docketdat IS NOT NULL AND RTcustadsl.DROPDAT IS NULL THEN 1 ELSE 0 END) as cnt2," _
       &"RTcustadslcmty.COMTYPE,RTcustadslcmty.cutid,RTcustadslcmty.township " _
       &"FROM RTcustadslcmty LEFT OUTER JOIN RTcustadsl ON RTcustadslcmty.CUTYID = RTcustadsl.COMQ1 " _
       &"LEFT OUTER JOIN RTCounty ON RTcustadslcmty.CUTID = RTCounty.CUTID " _
       &"WHERE RTcustadslcmty.CUTYID<>0 AND RTcustadslcmty.ADSLAPPLY IS NOT NULL AND RTcustadslcmty.RCOMDROP IS NULL AND " _
       &"RTcustadslcmty.CUTYID<>0 AND RTcustadslcmty.ADSLAPPLY IS NOT NULL AND RTcustadslcmty.RCOMDROP IS NULL " _
       &"GROUP BY RTcustadslcmty.CUTYID, RTcustadslcmty.COMN, RTcustadslcmty.cmtytel, RTcustadslcmty.HBNO, RTcustadslcmty.IPADDR, " _
       &"IsNull(RTCounty.CUTNC,'')+RTcustadslcmty.TOWNSHIP+RTcustadslcmty.ADDR, RTcustadslcmty.ADSLAPPLY," _
       &"RTcustadslcmty.RCOMDROP,RTcustadslcmty.COMTYPE,RTcustadslcmty.cutid,RTcustadslcmty.township " _
       &" " & SEARCHQRY5 &") a " _
       &"left outer join RTcustadsl b on a.cutyid=b.comq1 left outer join rtobj c on b.cusid=c.cusid left outer join " _
       &"rtcounty d on b.cutid2=d.cutid left outer join rtcode e on a.comtype = e.code and e.kind='B3' " _
       &"where b.docketdat is not null and b.dropdat is null AND " & SEARCHQRY & " " _
       &"order by a.comn,c.cusnc "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>