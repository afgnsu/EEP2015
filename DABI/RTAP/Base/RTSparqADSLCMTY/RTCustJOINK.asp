<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�t��ADSL�Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N" & ";" & V(2) & ";Y;Y;Y;Y" 
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�o�]�q��;�M�P�q��;�ȶD�B�z;�T�{�[�J"
  functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP;RTJOINCUSTCfm.ASP"
  functionOptPrompt ="Y;Y;N;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�Ȥ�;��b�N�X;�ӽг渹;�ӽФ�;���u��;������;�M�P��;�˾��a�};�p���q��;�g�P��"  
   sqlDelete="SELECT rtsparqadslcust.COMQ1,rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj_1.SHORTNC, rtsparqadslcust.EXTTEL+'-'+rtsparqadslcust.SPHNNO,rtsparqadslcust.orderno, " _
         &"rtsparqadslcust.formaldat, " _
         &"rtsparqadslcust.finishdat,rtsparqadslcust.Docketdat, " _
         &"rtsparqadslcust.dropdat, " _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME,RTObj_2.SHORTNC   " _
         &"FROM rtsparqadslcust INNER JOIN " _
         &"RTObj ON rtsparqadslcust.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE rtsparqadslcust.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj.shortnc "
  dataTable="rtsparqadslcust"
  userDefineDelete=""
  extTable=""
  numberOfKey=3
  dataProg="RTCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  searchProg="RTCustjoinS.asp"
  searchFirst=true
  If searchQry="" Then
     searchShow="����"
     searchQry="rtsparqadslcust.CUSID ='*' "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'USERLEVEL=2�~�ȤH��(�u��ݨ���ݷ~�ȲէO���)
  IF USERLEVEL = 2 THEN
  sqllist="SELECT  rtsparqadslcust.COMQ1,rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj_1.SHORTNC, rtsparqadslcust.EXTTEL+'-'+rtsparqadslcust.SPHNNO,rtsparqadslcust.orderno, " _
         &"rtsparqadslcust.formaldat, " _
         &"rtsparqadslcust.finishdat,rtsparqadslcust.Docketdat, " _
         &"rtsparqadslcust.dropdat, " _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME,RTObj_2.SHORTNC   " _
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj RTObj_3 ON rtsparqadslcust.BUSSMAN = RTObj_3.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON rtsparqadslcust.CUSID = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_2 ON rtsparqadslcust.consignee = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode RTCode_1 ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " & " AND " _
         &"(RTSalesGroupREF.AREAID + RTSalesGroupREF.GROUPID = " _
         &"(SELECT areaid + groupid " _
         &"FROM RTSalesGroupREF " _
         &"WHERE emply = '" &emply & "')) " _
         &"ORDER BY rtcounty.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj_1.shortnc "

  ELSE
  sqllist="SELECT  rtsparqadslcust.COMQ1,rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTObj_1.SHORTNC, rtsparqadslcust.EXTTEL+'-'+rtsparqadslcust.SPHNNO,rtsparqadslcust.orderno, " _
         &"rtsparqadslcust.formaldat, " _
         &"rtsparqadslcust.finishdat,rtsparqadslcust.Docketdat, " _
         &"rtsparqadslcust.dropdat, " _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME,RTObj_2.SHORTNC   " _
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj RTObj_3 ON rtsparqadslcust.BUSSMAN = RTObj_3.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON rtsparqadslcust.CUSID = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_2 ON rtsparqadslcust.consignee = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode RTCode_1 ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " _
         &"ORDER BY rtcounty.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj_1.shortnc "
   END IF
  'Response.Write "sql=" & SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
