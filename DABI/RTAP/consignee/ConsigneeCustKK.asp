<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if

Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  'V=split(SrAccessPermit,";")
  'AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  buttonEnable="N;N;Y;Y;Y;N"
  'functionOptName="�q���޳N;�M�P�q��;�ȶD�B�z"
  'functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP"
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
  '   accessMode="I"
  'End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�Ȥ�;��b�N�X;�ӽг渹;�ӽФ�;���u��;������;�M�P��;�˾��a�};�p���q��"
   sqlDelete="SELECT rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO, RTSparqAdslCmty.comn, "_
         &"RTObj_1.SHORTNC, rtsparqadslcust.EXTTEL+'-'+rtsparqadslcust.SPHNNO,rtsparqadslcust.orderno, " _
         &"rtsparqadslcust.formaldat, " _
         &"rtsparqadslcust.finishdat,rtsparqadslcust.Docketdat, " _
         &"rtsparqadslcust.dropdat, " _
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME,RTObj_2.SHORTNC   " _ 
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj RTObj_3 ON rtsparqadslcust.BUSSMAN = RTObj_3.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON rtsparqadslcust.CUSID = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode RTCode_1 ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' LEFT OUTER JOIN " _
         &"RTSparqAdslCmty RTSparqAdslCmty ON rtsparqadslcust.COMQ1 = RTSparqAdslCmty.CUTYID " _
         &"WHERE rtsparqadslcust.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj_1.shortnc "
  
'   sqlDelete="SELECT SINGLECustADSL.CUSID, SINGLECustADSL.ENTRYNO, RTObj.SHORTNC,SINGLEcustadsl.orderno,SINGLEcustadsl.HOUSENAME, " _
'         &"SINGLECustADSL.RCVD,SINGLECUSTADSL.DELIVERDAT, " _
'         &"SINGLECUSTADSL.finishdat," _
'         &"RTCOUNTY.CUTNC + SINGLECUSTADSL.TOWNSHIP2 + SINGLECUSTADSL.RADDR2, " _         
 '        &"SINGLECUSTADSL.HOME " _
 '        &"FROM SINGLECUSTADSL INNER JOIN " _
 '        &"RTObj ON SINGLECUSTADSL.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
 '        &"RTCounty ON SINGLECUSTADSL.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
 '        &"RTCode RTCode1 ON SINGLECUSTADSL.ISP = RTCode1.CODE AND  " _
 '        &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
 '        &"RTCode ON SINGLECUSTADSL.SETTYPE = RTCode1.CODE AND " _
 '        &"RTCode1.KIND = 'A7' " _
 ''        &"WHERE SINGLECUSTADSL.cusid='*' " _
 '        &"ORDER BY RTCOUNTY.CUTNC, SINGLECUSTADSL.TOWNSHIP2, SINGLECUSTADSL.RADDR2,rtobj.shortnc "
  dataTable="RTSparqADSLcust"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="RTCUSTD.ASP"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="ConsigneeCustSS.asp"
  searchFirst=false
  If searchQry="" Then
     searchShow="����"
     searchQry=" rtsparqadslcust.CUSID<>'*' and RTSparqAdslCust.Consignee ='" &Session("UserID")& "' "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'USERLEVEL=2�~�ȤH��(�u��ݨ���ݷ~�ȲէO���)
  'IF USERLEVEL = 2 THEN
  'sqllist="SELECT  SINGLECUSTADSL.CUSID, SINGLECUSTADSL.ENTRYNO, RTObj.SHORTNC,SINGLECUSTADSL.orderno,SINGLECUSTADSL.HOUSENAME, " _
   '      &"SINGLECUSTADSL.RCVD,SINGLECUSTADSL.DELIVERDAT, " _
   '      &"SINGLECUSTADSL.finishdat," _
   '      &"RTCOUNTY.CUTNC + SINGLECUSTADSL.TOWNSHIP2 + SINGLECUSTADSL.RADDR2, " _         
   '      &"SINGLECUSTADSL.HOME " _
    '     &"FROM SINGLECUSTADSL INNER JOIN " _
    '     &"RTObj ON SINGLECUSTADSL.CUSID = RTObj.CUSID INNER JOIN " _
    '     &"RTSalesGroupREF ON " _
    '     &"SINGLECUSTADSL.BUSSID = RTSalesGroupREF.EMPLY LEFT OUTER JOIN " _
   '      &"RTCounty ON SINGLECUSTADSL.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
   '      &"RTCode RTCode1 ON SINGLECUSTADSL.ISP = RTCode1.CODE AND " _
   '      &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
    '     &"RTCode ON SINGLECUSTADSL.SETTYPE = RTCode1.CODE AND " _
    '     &"RTCode1.KIND = 'A7' " _
    ''     &"WHERE " & searchqry & " " & " AND " _
    '     &"(RTSalesGroupREF.AREAID + RTSalesGroupREF.GROUPID = " _
    '     &"(SELECT areaid + groupid " _
    '     &"FROM RTSalesGroupREF " _
    '     &"WHERE emply = '" &emply & "')) " _
    '     &"ORDER BY RTCounty.CUTNC, SINGLECUSTADSL.TOWNSHIP2, SINGLECUSTADSL.RADDR2, " _
    '     &"RTObj.SHORTNC "

  'ELSE
  sqllist="SELECT rtsparqadslcust.CUSID, rtsparqadslcust.ENTRYNO,  RTSparqAdslCmty.comn, "_
		 &"RTObj_1.SHORTNC, rtsparqadslcust.EXTTEL+'-'+rtsparqadslcust.SPHNNO,rtsparqadslcust.orderno, " _
         &"rtsparqadslcust.formaldat, " _
         &"rtsparqadslcust.finishdat,rtsparqadslcust.Docketdat, " _
         &"rtsparqadslcust.dropdat, " _         
         &"RTCOUNTY.CUTNC + rtsparqadslcust.TOWNSHIP2 + rtsparqadslcust.RADDR2, " _         
         &"rtsparqadslcust.HOME " _ 
         &"FROM rtsparqadslcust LEFT OUTER JOIN " _
         &"RTObj RTObj_3 ON rtsparqadslcust.BUSSMAN = RTObj_3.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON rtsparqadslcust.CUSID = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtsparqadslcust.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtsparqadslcust.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode RTCode_1 ON rtsparqadslcust.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' LEFT OUTER JOIN " _
         &"RTSparqAdslCmty RTSparqAdslCmty ON rtsparqadslcust.COMQ1 = RTSparqAdslCmty.CUTYID " _
         &" WHERE " & searchqry & " " _
         &"ORDER BY rtcounty.CUTNC, rtsparqadslcust.TOWNSHIP2, rtsparqadslcust.RADDR2,rtobj_1.shortnc "
   'END IF
 'Response.Write "sql=" & SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
