<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���ϥD�u���u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�]�Ƭd��;�Τ�d��;�إ߬��u��"
  functionOptProgram="rtCMTYHARDWAREK2.asp;rtcustK.asp;rtCMTYSNDWORKk.asp"
  functionOptPrompt="N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;���ϦW��;IP;���Ϧ�m;�g�P��;���d���;COT���;���q��;�M�u��;�ӽ�;���u;����;�h��;�M�P;���Ĥ�;�ݳB�z" 
  sqlDelete="SELECT RTCmty.COMQ1, RTCmty.COMN, RTCmty.NETIP,RTCounty.CUTNC + RTCmty.TOWNSHIP + RTCmty.ADDR AS Expr1, " _
         &"RTCode.CODENC, RTCmty.RACKARRIVE, RTCmty.COTARRIVE,RTCmty.T1APPLY, RTCmty.RCOMDROP, " _
         &"SUM(CASE WHEN RTCUST.CUSID IS NOT NULL THEN 1 ELSE 0 END) AS CUSTCNT, " _
         &"SUM(CASE WHEN RTCUST.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FCNT, " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DCNT, " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS RCNT, " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NULL THEN 1 ELSE 0 END) AS CCNT, " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL AND DROPDAT IS NULL THEN 1 ELSE 0 END) AS UCNT, " _
         &"SUM(CASE WHEN RTCUST.CUSID IS NOT NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL AND DROPDAT IS NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NULL THEN 1 ELSE 0 END) AS PCNT " _
         &"FROM RTCmty LEFT OUTER JOIN  RTCust ON RTCmty.COMQ1 = RTCust.COMQ1 LEFT OUTER JOIN RTCode ON " _
         &"RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' LEFT OUTER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
         &"where " & searchqry & " " _
         &"GROUP BY  RTCmty.COMQ1, RTCmty.COMN, RTCmty.NETIP, RTCounty.CUTNC + RTCmty.TOWNSHIP + RTCmty.ADDR, RTCode.CODENC, " _
         &"RTCmty.RACKARRIVE, RTCmty.COTARRIVE, RTCmty.T1APPLY, RTCmty.RCOMDROP "
  dataTable="RTCMTY"
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
  searchProg="RTCMTYLINEschctlS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=true
  If searchQry="" Then
    ' searchQry=" RTCUSTADSLCMTY.COMQ1<>0 and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' "
     searchQry=" (RTCMTY.NETIP <> '') AND (RTCMTY.T1APPLY IS NULL) AND (RTCMTY.RCOMDROP IS NULL) "
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
  sqllist="SELECT RTCmty.COMQ1, RTCmty.COMN, RTCmty.NETIP,RTCounty.CUTNC + RTCmty.TOWNSHIP + RTCmty.ADDR AS Expr1, " _
         &"RTCode.CODENC, RTCmty.RACKARRIVE, RTCmty.COTARRIVE,RTCmty.T1APPLY, RTCmty.RCOMDROP, " _
         &"SUM(CASE WHEN RTCUST.CUSID IS NOT NULL THEN 1 ELSE 0 END) AS CUSTCNT, " _
         &"SUM(CASE WHEN RTCUST.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) AS FCNT, " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS DCNT, " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS RCNT, " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NULL THEN 1 ELSE 0 END) AS CCNT, " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL AND DROPDAT IS NULL THEN 1 ELSE 0 END) AS UCNT, " _
         &"SUM(CASE WHEN RTCUST.CUSID IS NOT NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DOCKETDAT IS NOT NULL AND DROPDAT IS NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) - " _
         &"SUM(CASE WHEN RTCUST.DROPDAT IS NOT NULL AND DOCKETDAT IS NULL THEN 1 ELSE 0 END) AS PCNT " _
         &"FROM RTCmty LEFT OUTER JOIN  RTCust ON RTCmty.COMQ1 = RTCust.COMQ1 LEFT OUTER JOIN RTCode ON " _
         &"RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' LEFT OUTER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
         &"where " & searchqry & " " _
         &"GROUP BY  RTCmty.COMQ1, RTCmty.COMN, RTCmty.NETIP, RTCounty.CUTNC + RTCmty.TOWNSHIP + RTCmty.ADDR, RTCode.CODENC, " _
         &"RTCmty.RACKARRIVE, RTCmty.COTARRIVE, RTCmty.T1APPLY, RTCmty.RCOMDROP "

 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>