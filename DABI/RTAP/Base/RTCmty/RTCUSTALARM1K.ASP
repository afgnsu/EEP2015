<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�p�q��w�ӽ�IP�|�����u�Τ�d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt =""
  functionoptopen   =""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  '====================== history until 90/12/28=================================
  'formatName="none;�Ȥ�N��;�榸;�W��;�}�o����;�ӽФ�;�p���q��;���q�q��;�o�]��;���u��;�M�P���;�w�˭����O"
  ' sqlDelete="SELECT RTCust.COMQ1, RTCust.CUSID, RTCust.ENTRYNO, RTObj.SHORTNC, " _
  '       &"RTCust.CUSTYPE, RTCust.RCVD, RTCust.HOME, " _
  '       &"RTCust.OFFICE + ' ' + RTCust.EXTENSION AS Office,  " _
  '       &"RTCust.REQDAT,rtcust.finishdat,RTCUST.DROPDAT, RTCode.CODENC " _
  '       &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID LEFT OUTER JOIN " _
  '       &"RTCounty ON RTCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN RTCode ON RTCust.SETTYPE = RTCode.CODE " _
  '       &"WHERE RTCust.COMQ1=0 AND (RTCode.KIND = 'A7') " _
  '       &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO " 
  '===============================================================================
  formatName="none;none;none;���ϧǸ�;���ϦW��;�Τ�W��;�˾��a�};�Τ�IP;IP�ӽФ�;���u��;������;�g�P��"
  sqlDelete= "SELECT rtcust.comq1,rtcust.cusid,rtcust.entryno,rtcust.comq1,rtcMTY.comn,rtOBJ.cusnc,rtcounty.cutnc+rtcust.township1+rtcust.raddr1,rtcust.ip," _
           &"rtcust.applyipdat,rtcust.finishdat,rtcust.docketdat,CASE WHEN RTCMTY.COMTYPE IN ('01','02','03') " _
           &"THEN '���T' else RTCODE.CODENC end " _
           &"FROM rtcust inner join rtcmty on rtcust.comq1=rtcmty.comq1 left outer join rtobj on rtcust.cusid=rtobj.cusid " _
           &"left outer join rtcode on rtcmty.comtype=rtcode.code and rtcode.kind='B3' " _
           &"left outer join rtcounty on rtcust.cutid1=rtcounty.cutid " _
           &"WHERE (rtcust. DOCKETDAT IS NULL or rtcust. docketdat <finishdat ) AND ip<> '' and rtcmty.rcomdrop is null " _
           &"and dropdat is null and substring(ip,1,1) >='0' and  substring(ip,1,1) <='9' AND RTCUST.COMQ1=0 " _
           &"ORDER BY rtcmty.comn,rtobj.cusnc " 
  dataTable="RTCust"
  userDefineDelete="Yes"
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
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  searchProg="rtcustALARM1S.asp"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" AND RTcmty.comq1 <>0 "
     searchShow="����"
  ELSE
     searchFirst=False
  End If  
 ' searchShow=FrGetCmtyDesc(aryParmKey(0))
  sqllist="SELECT  rtcust.comq1,rtcust.cusid,rtcust.entryno,rtcust.comq1,rtcMTY.comn,rtOBJ.cusnc,rtcounty.cutnc+rtcust.township1+rtcust.raddr1,rtcust.ip," _
           &"rtcust.applyipdat,rtcust.finishdat,rtcust.docketdat,CASE WHEN RTCMTY.COMTYPE IN ('01','02','03') " _
           &"THEN '���T' else RTCODE.CODENC end " _
           &"FROM rtcust inner join rtcmty on rtcust.comq1=rtcmty.comq1 left outer join rtobj on rtcust.cusid=rtobj.cusid " _
           &"left outer join rtcode on rtcmty.comtype=rtcode.code and rtcode.kind='B3' " _
           &"left outer join rtcounty on rtcust.cutid1=rtcounty.cutid " _
           &"WHERE (rtcust. DOCKETDAT IS NULL) AND ip<> '' and rtcmty.rcomdrop is null " _
           &"and dropdat is null and substring(ip,1,1) >='0' and  substring(ip,1,1) <='9' " & SEARCHQRY & " " _
           &"ORDER BY rtcmty.comn,rtobj.cusnc " 
  ' RESPONSE.Write SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->