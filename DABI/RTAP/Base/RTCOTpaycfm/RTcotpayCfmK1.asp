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
  title="COT�ظm�ۥI�B�f�ֽT�{"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���ϩ���"
  functionOptPrompt="N"
  functionOptProgram="RTcotpaycfmkeylist.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="�I�ڪ�帹;�C�L�H��;�C�L���;���ϵ���;�����`�B;�зǫظm�B;�ۥI�`�B;�|�p�f�֤�;�|�p�f�֭�"
  sqlDelete="SELECT RTCmty.PAYPRTSEQ, RTObj1.CUSNC AS Expr5, RTCmty.PAYPRTD, COUNT(RTCmty.COMQ1) AS Expr1, " _
           &"SUM(RTCmty.ASSESS) AS Expr2, SUM(RTSysParm.PVALUEN) AS Expr3, " _
           &"SUM(RTCmty.ASSESS) - SUM(RTSysParm.PVALUEN) AS Expr4, " _
           &"RTCmty.ACCOUNTCFM, RTObj.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTSysParm INNER JOIN " _
           &"RTCmty ON RTSysParm.PVALUEN < RTCmty.ASSESS AND  " _
           &"RTSysParm.PVALUEN < RTCmty.ASSESS ON  " _
           &"RTEmployee1.EMPLY = RTCmty.PAYPRTUSR LEFT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
           &"RTCmty.ACCOUNTUSR = RTEmployee.EMPLY " _
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
     searchQry=" and rtcmty.accountcfm is null "
     searchShow="���f��"
  End If   
  sqlList="SELECT RTCmty.PAYPRTSEQ, RTObj1.CUSNC AS Expr5, RTCmty.PAYPRTD, COUNT(RTCmty.COMQ1) AS Expr1, " _
           &"SUM(RTCmty.ASSESS) AS Expr2, SUM(RTSysParm.PVALUEN) AS Expr3, " _
           &"SUM(RTCmty.ASSESS) - SUM(RTSysParm.PVALUEN) AS Expr4, " _
           &"RTCmty.ACCOUNTCFM, RTObj.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTSysParm INNER JOIN " _
           &"RTCmty ON RTSysParm.PVALUEN < RTCmty.ASSESS AND  " _
           &"RTSysParm.PVALUEN < RTCmty.ASSESS ON  " _
           &"RTEmployee1.EMPLY = RTCmty.PAYPRTUSR LEFT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
           &"RTCmty.ACCOUNTUSR = RTEmployee.EMPLY " _
           &"WHERE (RTCmty.PAYPRTSEQ <> '') AND (RTCmty.ACCOUNTCFM IS NULL) AND " _
           &"(RTSysParm.PARMID = 'A0') AND (RTSysParm.EXPDAT IS NULL) AND " _
           &"(RTCmty.ACCOUNTCFM IS NULL) " & searchqry _
           &"GROUP BY RTCmty.PAYPRTSEQ, RTCmty.PAYPRTD, RTCmty.ACCOUNTCFM, " _
           &"RTSysParm.PVALUEN, RTObj.CUSNC, RTObj1.CUSNC " _
           &"ORDER BY RTCmty.PAYPRTSEQ DESC " 
 'Response.Write "SQL=" & SQllist
End Sub
%>