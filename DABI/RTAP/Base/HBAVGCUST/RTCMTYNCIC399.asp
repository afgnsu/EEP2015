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
  functionOptName="�ȡ@��"
  functionOptProgram="/WEBAP/RTAP/BASE/RTSPARQADSLCMTY/RTCustK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Ǹ�;���ϦW��;�����q��;none;IP;�]�Ʀ�m;���u�渹;���q��;�M�P��;�ӽ�;���u;���m;�g�P��" 
  sqlDelete="SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
           &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR, " _
           &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
           &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL OR rtsparqadslcust.finishdat <> '' THEN 1 ELSE 0 END), " _           
           &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END), " _
           &"CASE WHEN ( rtobj.shortnc = '' or rtobj.shortnc is null ) THEN CASE WHEN  RTSparqAdslCmty.CUTID IN ('01', '02', '03', '04', '21', '22') " _
           &"AND RTSparqAdslCmty.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN RTSparqAdslCmty.cutid IN ('05', '06', '07', '08') OR " _
           &"( RTSparqAdslCmty.cutid = '03' AND  RTSparqAdslCmty.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  RTSparqAdslCmty.cutid IN ('09', '10', '11', '12', '13') " _ 
           &"THEN '�x��' WHEN  RTSparqAdslCmty.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE rtobj.shortnc END " _
           &"FROM RTSparqAdslCmty LEFT OUTER JOIN rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
           &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
           &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL " _
           &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _
           &"left outer join rtobj on RTSparqAdslCmty.consignee = rtobj.cusid " _
           &"WHERE (RTSparqAdslCmty.COMN <> '*') " _
           &"GROUP BY  RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
           &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR,rtsparqadslcmtysndwork.prtno, " _
           &"RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
           &"CASE WHEN ( rtobj.shortnc = '' or rtobj.shortnc is null ) THEN CASE WHEN  RTSparqAdslCmty.CUTID IN ('01', '02', '03', '04', '21', '22') " _
           &"AND RTSparqAdslCmty.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN RTSparqAdslCmty.cutid IN ('05', '06', '07', '08') OR " _
           &"( RTSparqAdslCmty.cutid = '03' AND  RTSparqAdslCmty.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  RTSparqAdslCmty.cutid IN ('09', '10', '11', '12', '13') " _ 
           &"THEN '�x��' WHEN  RTSparqAdslCmty.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE rtobj.shortnc END " _
           &"ORDER BY  RTSparqAdslCmty.equipaddr "
  dataTable="RTSparqAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="/WEBAP/RTAP/BASE/RTSPARQADSLCMTY/RTCMTYD.ASP"
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
  searchProg="RTCMTYNCIC399s.asp"
  searchFirst=FALSE
  'Ū���ȦsKEY
  KEYXX=SPLIT(SESSION("search7"),";")
  If searchQry="" Then
    searchQry=" RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL "
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
sqllist="SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR, " _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
       &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END), " _ 
       &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL AND rtsparqadslcust.DROPDAT IS NULL THEN 1 ELSE 0 END), " _           
       &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL  AND rtsparqadslcust.DROPDAT IS NULL THEN 1 ELSE 0 END), " _   
       &"CASE WHEN ( rtobj.shortnc = '' or rtobj.shortnc is null ) THEN CASE WHEN  RTSparqAdslCmty.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND RTSparqAdslCmty.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN RTSparqAdslCmty.cutid IN ('05', '06', '07', '08') OR " _
       &"( RTSparqAdslCmty.cutid = '03' AND  RTSparqAdslCmty.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  RTSparqAdslCmty.cutid IN ('09', '10', '11', '12', '13') " _ 
       &"THEN '�x��' WHEN  RTSparqAdslCmty.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE rtobj.shortnc END " _  
       &"FROM RTSparqAdslCmty LEFT OUTER JOIN rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
       &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
       &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL " _
       &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _     
       &"left outer join rtobj on RTSparqAdslCmty.consignee = rtobj.cusid " _  
       &"WHERE RTSparqAdslCmty.CUTYID<>0 AND RTSPARQADSLCMTY.ADSLAPPLY IS NOT NULL AND RTSPARQADSLCMTY.RCOMDROP IS NULL AND " &  searchqry  & " " _
       &"GROUP BY  RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR,rtsparqadslcmtysndwork.prtno, " _
       &"RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
       &"CASE WHEN ( rtobj.shortnc = '' or rtobj.shortnc is null ) THEN CASE WHEN  RTSparqAdslCmty.CUTID IN ('01', '02', '03', '04', '21', '22') " _
       &"AND RTSparqAdslCmty.township NOT IN ('�T�l��', '�a�q��') THEN '�x�_' WHEN RTSparqAdslCmty.cutid IN ('05', '06', '07', '08') OR " _
       &"( RTSparqAdslCmty.cutid = '03' AND  RTSparqAdslCmty.township IN ('�T�l��','�a�q��')) THEN '���' WHEN  RTSparqAdslCmty.cutid IN ('09', '10', '11', '12', '13') " _ 
       &"THEN '�x��' WHEN  RTSparqAdslCmty.cutid IN ('14', '15', '16', '17', '18', '19', '20') THEN '����' ELSE '' END ELSE rtobj.shortnc END " _
       & SEARCHQRY7 & " " _
       &"ORDER BY  RTSparqAdslCmty.comn " 
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>