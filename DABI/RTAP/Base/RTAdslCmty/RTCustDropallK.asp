<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building�޲z�t��"
  title="����ADSL399�h���������u�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="������u"
  functionOptProgram="RTcustADSLdropsndworkk.asp"
  functionOptPrompt ="N"
  functionoptopen   ="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�Τ�W��;������;�h����;����渹;�������;�w�w����H��;�g�P��"
   sqlDelete="SELECT RTCustADSL.CUSID, RTCustADSL.ENTRYNO, RTCustAdslCmty.COMN,RTObj.CUSNC, RTCustADSL.DOCKETDAT, " _
         &"RTCustADSL.DROPDAT, RTCUSTADSLDROPSNDWORK.PRTNO, RTCUSTADSLDROPSNDWORK.SENDWORKDAT, " _
         &"CASE WHEN RTOBJ_1.CUSNC <> '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC  END, " _
         &"CASE WHEN RTCODE.CODE IN ('01', '02', '03', '04', '14') THEN CASE WHEN RTCUSTADSL.CUTID2 IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCUSTADSL.township2 NOT IN ('�T�l��', '�a�q��') " _
         &"THEN '�x�_' WHEN RTCUSTADSL.CUTID2 IN ('05', '06', '07', '08') OR " _
         &"(RTCUSTADSL.cutid2 = '03' AND RTCUSTADSL.township2 IN ('�T�l��', '�a�q��')) " _
         &"THEN '���' WHEN RTCUSTADSL.CUTID2 IN ('09', '10', '11', '12', '13') " _
         &"THEN '�x��' WHEN RTCUSTADSL.CUTID2 IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END " _
         &"FROM RTObj RTObj_2 RIGHT OUTER JOIN RTCUSTADSLDROPSNDWORK ON RTObj_2.CUSID = RTCUSTADSLDROPSNDWORK.ASSIGNCONSIGNEE " _
         &"LEFT OUTER JOIN RTEmployee LEFT OUTER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
         &"RTCUSTADSLDROPSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY RIGHT OUTER JOIN RTCustADSL INNER JOIN RTCustAdslCmty ON " _
         &"RTCustADSL.COMQ1 = RTCustAdslCmty.CUTYID INNER JOIN RTObj ON RTCustADSL.CUSID = RTObj.CUSID ON " _
         &"RTCUSTADSLDROPSNDWORK.CUSID = RTCustADSL.CUSID AND RTCUSTADSLDROPSNDWORK.ENTRYNO = RTCustADSL.ENTRYNO LEFT OUTER JOIN " _
         &"RTCODE ON RTCUSTADSLCMTY.COMTYPE = RTCODE.CODE AND RTCODE.KIND = 'B3' " _
         &"WHERE (RTCustADSL.DROPDAT IS NOT NULL) AND (RTCustADSL.DOCKETDAT IS NOT NULL) AND (RTCustAdslCmty.RCOMDROP IS NULL) " _
         &"AND RTCUSTADSLDROPSNDWORK.CLOSEDAT IS NULL ORDER BY  RTCustAdslCmty.COMN, RTOBJ.CUSNC " 
  dataTable="RTCUSTADSL"
  userDefineDelete=""
  extTable=""
  numberOfKey=2
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  searchFirst=false
 ' response.Write "k0=" & aryparmkey(0) & ";k1=" & aryparmkey(1) & ";k2=" & aryparmkey(2)
  searchShow="�����ݩ�����u"
  'searchQry=""
  searchProg="RTCustDropAllS.asp"
  If searchQry="" Then
     searchQry=" AND RTCUSTADSLDROPSNDWORK.closedat is null "
     searchShow="����(�|������^��)"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqllist="SELECT RTCustADSL.CUSID, RTCustADSL.ENTRYNO, RTCustAdslCmty.COMN,RTObj.CUSNC, RTCustADSL.DOCKETDAT, " _
         &"RTCustADSL.DROPDAT, RTCUSTADSLDROPSNDWORK.PRTNO, RTCUSTADSLDROPSNDWORK.SENDWORKDAT, " _
         &"CASE WHEN RTOBJ_1.CUSNC <> '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC  END, " _
         &"CASE WHEN RTCODE.CODE IN ('01', '02', '03', '04', '14') THEN CASE WHEN RTCUSTADSL.CUTID2 IN " _
         &"('01', '02', '03', '04', '21', '22') AND RTCUSTADSL.township2 NOT IN ('�T�l��', '�a�q��') " _
         &"THEN '�x�_' WHEN RTCUSTADSL.CUTID2 IN ('05', '06', '07', '08') OR " _
         &"(RTCUSTADSL.cutid2 = '03' AND RTCUSTADSL.township2 IN ('�T�l��', '�a�q��')) " _
         &"THEN '���' WHEN RTCUSTADSL.CUTID2 IN ('09', '10', '11', '12', '13') " _
         &"THEN '�x��' WHEN RTCUSTADSL.CUTID2 IN ('14', '15', '16', '17', '18', '19', '20') " _
         &"THEN '����' ELSE '' END ELSE RTCODE.CODENC END " _
         &"FROM RTObj RTObj_2 RIGHT OUTER JOIN RTCUSTADSLDROPSNDWORK ON RTObj_2.CUSID = RTCUSTADSLDROPSNDWORK.ASSIGNCONSIGNEE " _
         &"LEFT OUTER JOIN RTEmployee LEFT OUTER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
         &"RTCUSTADSLDROPSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY RIGHT OUTER JOIN RTCustADSL INNER JOIN RTCustAdslCmty ON " _
         &"RTCustADSL.COMQ1 = RTCustAdslCmty.CUTYID INNER JOIN RTObj ON RTCustADSL.CUSID = RTObj.CUSID ON " _
         &"RTCUSTADSLDROPSNDWORK.CUSID = RTCustADSL.CUSID AND RTCUSTADSLDROPSNDWORK.ENTRYNO = RTCustADSL.ENTRYNO LEFT OUTER JOIN " _
         &"RTCODE ON RTCUSTADSLCMTY.COMTYPE = RTCODE.CODE AND RTCODE.KIND = 'B3' " _
         &"WHERE (RTCustADSL.DROPDAT IS NOT NULL) AND (RTCustADSL.DOCKETDAT IS NOT NULL) AND (RTCustAdslCmty.RCOMDROP IS NULL) " & searchqry _
         &" ORDER BY  RTCustAdslCmty.COMN, RTOBJ.CUSNC " 
  ' response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
