<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL���ϥD�u���u�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�]�Ƭd��;�Τ�d��;�إ߬��u��"
  functionOptProgram="rtSPARQADSLCMTYHARDWAREK2.asp;rtcustK.asp;rtSPARQADSLCMTYSNDWORKk.asp"
  functionOptPrompt="N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;���ϦW��;�����q��;IP;�q�H�Ǧ�m;none;���g�P;none;none;�]�ƨ��;�u�����;���q��;�M�u��;�ӽФ�;���u��;������;�h����;�M�P��;�ݳB�z" 
  sqlDelete="SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.CMTYTEL, RTSparqAdslCmty.IPADDR, " _
           &"RTSparqAdslCmty.TELEADDR, RTCode.CODENC, " _
           &"CASE WHEN RTObj.SHORTNC IS NOT NULL THEN RTObj.SHORTNC ELSE RTArea.AREANC END, " _
           &"RTSparqAdslCmty.RCVD, RTSparqAdslCmty.CASESNDWRK, RTSparqAdslCmty.EQUIPARRIVE, RTSparqAdslCmty.LINEARRIVE, " _
           &"RTSparqAdslCmty.ADSLAPPLY,RTSparqAdslCmty.rcomdrop,sum(case when rtsparqadslcust.cusid is not null then 1 else 0 end),sum(case when rtsparqadslcust.finishdat is not null then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is not null then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is not null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is  null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.cusid is not null then 1 else 0 end)-sum(case when rtsparqadslcust.docketdat is not null then 1 else 0 end)-sum(case when rtsparqadslcust.docketdat is not null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)-sum(case when rtsparqadslcust.docketdat is  null and rtsparqadslcust.dropdat is not null  then 1 else 0 end) " _
           &"FROM RTObj RIGHT OUTER JOIN RTSparqAdslCmty ON RTObj.CUSID = RTSparqAdslCmty.CONSIGNEE LEFT OUTER JOIN " _
           &"RTCode ON RTSparqAdslCmty.CONNECTTYPE = RTCode.CODE AND RTCode.KIND = 'G5' LEFT OUTER JOIN " _
           &"RTArea INNER JOIN RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
           &"RTSparqAdslCmty.AREAID = RTSalesGroup.AREAID AND RTSparqAdslCmty.GROUPID = RTSalesGroup.GROUPID  LEFT OUTER JOIN RTSPARQADSLCUST ON RTSPARQADSLCMTY.CUTYID=RTSPARQADSLCUST.COMQ1 " _
           &"WHERE (RTSparqAdslCmty.IPADDR <> '') AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) AND (RTSparqAdslCmty.RCOMDROP IS NULL) " _
           &"GROUP BY  RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN,RTSparqAdslCmty.CMTYTEL, RTSparqAdslCmty.IPADDR, " _
           &"RTSparqAdslCmty.EQUIPADDR, RTSparqAdslCmty.TELEADDR, RTCode.CODENC, CASE WHEN RTObj.SHORTNC IS NOT NULL " _
           &"THEN RTObj.SHORTNC ELSE RTArea.AREANC END, RTSparqAdslCmty.RCVD, RTSparqAdslCmty.CASESNDWRK, RTSparqAdslCmty.EQUIPARRIVE, " _
           &"RTSparqAdslCmty.LINEARRIVE, RTSparqAdslCmty.ADSLAPPLY,RTSparqAdslCmty.rcomdrop "
  dataTable="RTSparqAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTCMTYD.ASP"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTsparqadslcmtyschctlS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=true
  If searchQry="" Then
    ' searchQry=" RTCUSTADSLCMTY.CUTYID<>0 and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' "
     searchQry=" (RTSparqAdslCmty.IPADDR <> '') AND (RTSparqAdslCmty.ADSLAPPLY IS NULL) AND (RTSparqAdslCmty.RCOMDROP IS NULL) "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
    searchShow="�ݬ��u�D�u����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��

  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  sqllist="SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.CMTYTEL, RTSparqAdslCmty.IPADDR, " _
           &"RTSparqAdslCmty.TELEADDR, RTCode.CODENC, " _
           &"CASE WHEN RTObj.SHORTNC IS NOT NULL THEN RTObj.SHORTNC ELSE RTArea.AREANC END, " _
           &"RTSparqAdslCmty.RCVD, RTSparqAdslCmty.CASESNDWRK, RTSparqAdslCmty.EQUIPARRIVE, RTSparqAdslCmty.LINEARRIVE, " _
           &"RTSparqAdslCmty.ADSLAPPLY,RTSparqAdslCmty.rcomdrop,sum(case when rtsparqadslcust.cusid is not null then 1 else 0 end),sum(case when rtsparqadslcust.finishdat is not null then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is not null then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is not null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.docketdat is  null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)," _
           &"sum(case when rtsparqadslcust.cusid is not null then 1 else 0 end) -sum(case when rtsparqadslcust.docketdat is not null then 1 else 0 end)-sum(case when rtsparqadslcust.docketdat is not null and rtsparqadslcust.dropdat is not null  then 1 else 0 end)-sum(case when rtsparqadslcust.docketdat is  null and rtsparqadslcust.dropdat is not null  then 1 else 0 end) " _
           &"FROM RTObj RIGHT OUTER JOIN RTSparqAdslCmty ON RTObj.CUSID = RTSparqAdslCmty.CONSIGNEE LEFT OUTER JOIN " _
           &"RTCode ON RTSparqAdslCmty.CONNECTTYPE = RTCode.CODE AND RTCode.KIND = 'G5' LEFT OUTER JOIN " _
           &"RTArea INNER JOIN RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
           &"RTSparqAdslCmty.AREAID = RTSalesGroup.AREAID AND RTSparqAdslCmty.GROUPID = RTSalesGroup.GROUPID  LEFT OUTER JOIN RTSPARQADSLCUST ON RTSPARQADSLCMTY.CUTYID=RTSPARQADSLCUST.COMQ1 " _
           &"WHERE " & searchqry & " " _
           &"GROUP BY  RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN,RTSparqAdslCmty.CMTYTEL, RTSparqAdslCmty.IPADDR, " _
           &"RTSparqAdslCmty.EQUIPADDR, RTSparqAdslCmty.TELEADDR, RTCode.CODENC, CASE WHEN RTObj.SHORTNC IS NOT NULL " _
           &"THEN RTObj.SHORTNC ELSE RTArea.AREANC END, RTSparqAdslCmty.RCVD, RTSparqAdslCmty.CASESNDWRK, RTSparqAdslCmty.EQUIPARRIVE, " _
           &"RTSparqAdslCmty.LINEARRIVE, RTSparqAdslCmty.ADSLAPPLY,RTSparqAdslCmty.rcomdrop "

 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>