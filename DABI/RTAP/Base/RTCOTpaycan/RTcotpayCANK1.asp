<%
  Dim search1,parm,vk,debug36,search2
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="COT�ظm�ۥI�B�f�ֺM�P"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���ϩ���"
  functionOptPrompt="N"
  functionOptProgram="RTcotpayCANk.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="�I�ڪ�帹;�C�L�H��;�C�L���;���ϵ���;�����`�B;�зǫظm�B;�ۥI�`�B;�|�p�f�֤�;�|�p�f�֭�"
  sqlDelete="SELECT RTCmty.PAYPRTSEQ, RTObj1.CUSNC, RTCmty.PAYPRTD,  " _
           &"COUNT(RTCmty.COMQ1), SUM(RTCmty.ASSESS), SUM(RTSysParm.PVALUEN), " _
           &"SUM(RTCmty.ASSESS) - SUM(RTSysParm.PVALUEN), RTCmty.ACCOUNTCFM, " _
           &"RTObj1.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
           &"RTCmty ON RTEmployee.EMPLY = RTCmty.ACCOUNTUSR ON  " _
           &"RTEmployee1.EMPLY = RTCmty.PAYPRTUSR, RTSysParm " _
           &"WHERE (RTCmty.PAYPRTSEQ = '*') "
  'response.write "sql=" &sqldelete
  dataTable="b"
  numberOfKey=1
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20  
 
  searchProg="RTCOTpaysearch.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and rtcmty.accountcfm is NOT null "
     searchShow="���f��"
  End If   
  sqlList="SELECT RTCmty.PAYPRTSEQ, RTObj1.CUSNC, RTCmty.PAYPRTD,  " _
           &"COUNT(RTCmty.COMQ1), SUM(RTCmty.ASSESS), SUM(RTSysParm.PVALUEN), " _
           &"SUM(RTCmty.ASSESS) - SUM(RTSysParm.PVALUEN), RTCmty.ACCOUNTCFM, " _
           &"RTObj1.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
           &"RTCmty ON RTEmployee.EMPLY = RTCmty.ACCOUNTUSR ON  " _
           &"RTEmployee1.EMPLY = RTCmty.PAYPRTUSR, RTSysParm " _
           &"WHERE (RTCmty.PAYPRTSEQ <> '') AND (RTCmty.ACCOUNTCFM IS NOT NULL) AND " _
           &"RTSYSPARM.PARMID = 'A0' AND RTSYSPARM.EXPDAT IS NULL AND " _
           &"RTCMTY.ASSESS > RTSYSPARM.PVALUEN "  & searchqry _
           &"GROUP BY RTCmty.PAYPRTSEQ, RTObj1.CUSNC, RTCmty.PAYPRTD, " _
           &"RTCmty.ACCOUNTCFM, RTObj1.CUSNC, RTSysParm.PVALUEN " _
           &"ORDER BY RTCmty.PAYPRTSEQ DESC " 
' Response.Write "SQL=" & SQllist
End Sub
%>