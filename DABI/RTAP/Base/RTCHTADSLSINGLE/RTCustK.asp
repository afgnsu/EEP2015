<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�W�ɫ��Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�o�]�q��;�M�P�q��;�ȶD�B�z"
  functionOptProgram="RTSndInfo.asp;RTDropInfo.asp;RTFaqK.ASP"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�Ȥ�W��;�ӽг渹;���ϦW��;�ӽФ�;�e����;�w�}�q��;���u��;�˾��a�};�p���q��"
   sqlDelete="SELECT rtchtadslsingle.CUSID, rtchtadslsingle.ENTRYNO, RTObj.SHORTNC,rtchtadslsingle.orderno,rtchtadslsingle.HOUSENAME, " _
         &"rtchtadslsingle.RCVD,rtchtadslsingle.DELIVERDAT, " _
         &"case when rtchtadslsingle.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) " _
         &"when rtchtadslsingle.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtchtadslsingle.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtchtadslsingle.chtsigndat) " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtchtadslsingle.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtchtadslsingle.deliverdat)  end ," _
         &"rtchtadslsingle.finishdat," _
         &"RTCOUNTY.CUTNC + rtchtadslsingle.TOWNSHIP2 + rtchtadslsingle.RADDR2, " _         
         &"rtchtadslsingle.HOME " _
         &"FROM rtchtadslsingle INNER JOIN " _
         &"RTObj ON rtchtadslsingle.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtchtadslsingle.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtchtadslsingle.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtchtadslsingle.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE rtchtadslsingle.cusid='*' " _
         &"ORDER BY RTCOUNTY.CUTNC, rtchtadslsingle.TOWNSHIP2, rtchtadslsingle.RADDR2,rtobj.shortnc "
  dataTable="rtchtadslsingle"
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
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTCustS.asp"
  searchFirst=false
  If searchQry="" Then
     searchShow="����(���t�M�P�ΰh����)"
     searchQry="rtchtadslsingle.CUSID<>'*' "
  ELSE
     SEARCHFIRST=FALSE
  End If  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'USERLEVEL=2�~�ȤH��(�u��ݨ���ݷ~�ȲէO���)
  IF USERLEVEL = 2 THEN
  sqllist="SELECT rtchtadslsingle.CUSID, rtchtadslsingle.ENTRYNO, RTObj.SHORTNC,rtchtadslsingle.orderno,rtchtadslsingle.HOUSENAME, " _
         &"rtchtadslsingle.RCVD,rtchtadslsingle.DELIVERDAT, " _
         &"case when rtchtadslsingle.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) " _
         &"when rtchtadslsingle.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtchtadslsingle.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtchtadslsingle.chtsigndat) " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtchtadslsingle.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtchtadslsingle.deliverdat)  end ," _
         &"rtchtadslsingle.finishdat," _
         &"RTCOUNTY.CUTNC + rtchtadslsingle.TOWNSHIP2 + rtchtadslsingle.RADDR2, " _         
         &"rtchtadslsingle.HOME " _
         &"FROM rtchtadslsingle INNER JOIN " _
         &"RTObj ON rtchtadslsingle.CUSID = RTObj.CUSID INNER JOIN " _
         &"RTSalesGroupREF ON " _
         &"rtchtadslsingle.BUSSID = RTSalesGroupREF.EMPLY LEFT OUTER JOIN " _
         &"RTCounty ON rtchtadslsingle.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtchtadslsingle.ISP = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtchtadslsingle.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " & " AND " _
         &"(RTSalesGroupREF.AREAID + RTSalesGroupREF.GROUPID = " _
         &"(SELECT areaid + groupid " _
         &"FROM RTSalesGroupREF " _
         &"WHERE emply = '" &emply & "')) " _
         &"ORDER BY RTCounty.CUTNC, rtchtadslsingle.TOWNSHIP2, rtchtadslsingle.RADDR2, " _
         &"RTObj.SHORTNC "

  ELSE
  sqllist="SELECT rtchtadslsingle.CUSID, rtchtadslsingle.ENTRYNO, RTObj.SHORTNC,rtchtadslsingle.orderno,rtchtadslsingle.HOUSENAME, " _
         &"rtchtadslsingle.RCVD,rtchtadslsingle.DELIVERDAT, " _
         &"case when rtchtadslsingle.WORKINGREPLY IS NOT NULL and DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.WORKINGREPLY IS NOT NULL THEN DateADD(dd, 7, rtchtadslsingle.WORKINGREPLY) " _
         &"when rtchtadslsingle.CHTSIGNDAT IS NOT NULL and DateADD(dd, 14, rtchtadslsingle.chtsigndat) < '2001/08/20' then '2001/08/20' " _
         &"WHEN rtchtadslsingle.CHTSIGNDAT IS NOT NULL THEN DateADD(dd, 14, rtchtadslsingle.chtsigndat) " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL and DATEADD(mm, 1,rtchtadslsingle.deliverdat) < '2001/08/20' then '2001/08/20' " _
         &"when rtchtadslsingle.DELIVERDAT IS NOT NULL THEN DATEADD(mm, 1,rtchtadslsingle.deliverdat)  end ," _
         &"rtchtadslsingle.finishdat," _
         &"RTCOUNTY.CUTNC + rtchtadslsingle.TOWNSHIP2 + rtchtadslsingle.RADDR2, " _         
         &"rtchtadslsingle.HOME " _
         &"FROM rtchtadslsingle INNER JOIN " _
         &"RTObj ON rtchtadslsingle.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON rtchtadslsingle.CUTID2 = RTCounty.CUTID LEFT OUTER JOIN " _
         &"RTCode RTCode1 ON rtchtadslsingle.ISP = RTCode1.CODE AND  " _
         &"RTCode1.KIND = 'C3' LEFT OUTER JOIN " _
         &"RTCode ON rtchtadslsingle.SETTYPE = RTCode1.CODE AND " _
         &"RTCode1.KIND = 'A7' " _
         &"WHERE " & searchqry & " " _
         &"ORDER BY RTCOUNTY.CUTNC, rtchtadslsingle.TOWNSHIP2, rtchtadslsingle.RADDR2,rtobj.shortnc "
   END IF
 ' Response.Write "sql=" & SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
