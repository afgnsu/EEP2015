<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�Ȥ�򥻸�ƺ��@(�����q�M��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=N & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�o�]�q��;�M�P�q��;�ȶD�B�z"
  functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP"
  functionOptPrompt ="Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�Ȥ�W��;HN���X;���ϦW��;�ӽФ�;�e���;���u��;������;�h����;�˾��a�};�p���q�� "  
   sqlDelete="SELECT RTCustADSL.CUSID, RTCustADSL.ENTRYNO, RTObj.SHORTNC,rtcustadsl.CUSNO,rtcustadsl.HOUSENAME, " _
         &"RTCustADSL.RCVD,RTCUSTADSL.DELIVERDAT, " _
         &"RTCustAdsl.FINISHDAT, RTCustAdsl.DOCKETDAT, RTCustAdsl.DROPDAT," _
         &"RTCOUNTY.CUTNC + RTCUSTADSL.TOWNSHIP2 + RTCUSTADSL.RADDR2, " _         
         &"RTCustADSL.HOME " _
         &"FROM RTCustADSL INNER JOIN " _
         &"RTObj ON RTCustADSL.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON RTCustADSL.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON RTCustADSL.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE rtcustadsl.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, RTCUSTADSL.TOWNSHIP2, RTCUSTADSL.RADDR2,rtobj.shortnc "
  dataTable="RTCUSTADSL"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20
  searchProg="RTCustS.asp"
  searchFirst=true
  If searchQry="" Then
     searchShow="����(���t�M�P�ΰh����)"
     searchQry="RTCUSTADSL.CUSID ='*' "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'USERLEVEL=2�~�ȤH��(�u��ݨ���ݷ~�ȲէO���)
  'IF USERLEVEL = 2 THEN
  'sqllist="SELECT  RTCustADSL.CUSID, RTCustADSL.ENTRYNO, RTObj.SHORTNC,rtcustadsl.CUSNO,rtcustadsl.HOUSENAME, " _
  '       &"RTCustADSL.RCVD,RTCUSTADSL.DELIVERDAT, " _
  '       &"RTCustAdsl.FINISHDAT, RTCustAdsl.DOCKETDAT, RTCustAdsl.DROPDAT," _
  '       &"RTCOUNTY.CUTNC + RTCUSTADSL.TOWNSHIP2 + RTCUSTADSL.RADDR2, " _         
  '       &"RTCustADSL.HOME " _
  '       &"FROM RTCustADSL INNER JOIN " _
  '       &"RTObj ON RTCustADSL.CUSID = RTObj.CUSID INNER JOIN " _
  '       &"RTSalesGroupREF ON " _
  '       &"RTCustADSL.BUSSID = RTSalesGroupREF.EMPLY LEFT OUTER JOIN " _
  '       &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
  '       &"RTCode RTCode1 ON RTCustADSL.ISP = RTCode1.CODE AND " _
  '       &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
  '       &"RTCode ON RTCustADSL.SETTYPE = RTCode1.CODE AND " _
  '       &"RTCode1.KIND = 'A7' " _
  '       &"WHERE " & searchqry & " " & " AND " _
  '       &"(RTSalesGroupREF.AREAID + RTSalesGroupREF.GROUPID = " _
  '       &"(SELECT areaid + groupid " _
  '       &"FROM RTSalesGroupREF " _
  '       &"WHERE emply = '" &emply & "' and edate is null)) " _
  '       &"ORDER BY RTCounty.CUTNC, RTCustADSL.TOWNSHIP2, RTCustADSL.RADDR2, " _
  '       &"RTObj.SHORTNC "

  'ELSE
  sqllist="SELECT  RTCustADSL.CUSID, RTCustADSL.ENTRYNO, RTObj.SHORTNC,rtcustadsl.CUSNO,rtcustadsl.HOUSENAME, " _
         &"RTCustADSL.RCVD,RTCUSTADSL.DELIVERDAT, " _
         &"RTCustAdsl.FINISHDAT, RTCustAdsl.DOCKETDAT, RTCustAdsl.DROPDAT," _
         &"RTCOUNTY.CUTNC + RTCUSTADSL.TOWNSHIP2 + RTCUSTADSL.RADDR2, " _         
         &"RTCustADSL.HOME " _
         &"FROM RTCustADSL INNER JOIN " _
         &"RTObj ON RTCustADSL.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON RTCustADSL.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON RTCustADSL.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON RTCustADSL.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " _
         &"ORDER BY RTCOUNTY.CUTNC, RTCUSTADSL.TOWNSHIP2, RTCUSTADSL.RADDR2,rtobj.shortnc "
   'END IF
 ' Response.Write "sql=" & SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
