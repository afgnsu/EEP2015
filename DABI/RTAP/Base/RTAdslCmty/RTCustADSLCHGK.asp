<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�w�����Ȥ���v���ʬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���ʧ@�o"
  functionOptProgram="RTcustadslchGdrop.asp"
  functionOptPrompt ="Y"
  functionoptopen   ="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;none;�Ȥ�W��;�榸;���ʥN�X;���ʦW��;���ʤ��;���ʤH��;�@�o���;�������;���ɤ��;�˾��a�};�p���q��"
   sqlDelete="SELECT RTCUSTADSLCHG.COMQ1,rtcustadslchg.cusid,rtcustadslchg.entryno,rtcustadslchg.modifycode,rtcustadslchg.modifydat, RTObj_1.SHORTNC, RTCUSTADSLCHG.ENTRYNO, " _
            &"RTCUSTADSLCHG.MODIFYCODE, RTCode.CODENC, " _
            &"RTCUSTADSLCHG.MODIFYDAT, RTObj_2.CUSNC, RTCUSTADSLCHG.DROPDAT, " _
            &"RTCUSTADSLCHG.DOCKETDAT, RTCUSTADSLCHG.TRANSDAT " _
            &"FROM  RTObj RTObj_1 RIGHT OUTER JOIN " _
            &"RTCUSTADSLCHG ON " _
            &"RTObj_1.CUSID = RTCUSTADSLCHG.CUSID LEFT OUTER JOIN " _
            &"RTObj RTObj_2 RIGHT OUTER JOIN " _
            &"RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
            &"RTCUSTADSLCHG.MODIFYUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
            &"RTCode ON RTCUSTADSLCHG.MODIFYCODE = RTCode.CODE AND " _
            &"RTCode.KIND = 'C8' " _
            &"where rtcustadslchg,cusid='*' " _
            &"ORDER BY  RTCUSTADSLCHG.MODIFYDAT " 
  dataTable="RTCUSTADSLCHG"
  userDefineDelete=""
  extTable=""
  numberOfKey=5
  dataProg="RTCustADSLCHGD.asp"
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
  keyListPageSize=20
  searchFirst=false
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  searchQry="RTCUSTADSL.comq1 =" & aryparmkey(0)
  searchProg="self"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqllist="SELECT RTCUSTADSLCHG.COMQ1,rtcustadslchg.cusid,rtcustadslchg.entryno,rtcustadslchg.modifycode,rtcustadslchg.modifydat, RTObj_1.SHORTNC, RTCUSTADSLCHG.ENTRYNO, " _
            &"RTCUSTADSLCHG.MODIFYCODE, RTCode.CODENC, " _
            &"RTCUSTADSLCHG.MODIFYDAT, RTObj_2.CUSNC, RTCUSTADSLCHG.DROPDAT, " _
            &"RTCUSTADSLCHG.DOCKETDAT, RTCUSTADSLCHG.TRANSDAT " _
            &"FROM  RTObj RTObj_1 RIGHT OUTER JOIN " _
            &"RTCUSTADSLCHG ON " _
            &"RTObj_1.CUSID = RTCUSTADSLCHG.CUSID LEFT OUTER JOIN " _
            &"RTObj RTObj_2 RIGHT OUTER JOIN " _
            &"RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
            &"RTCUSTADSLCHG.MODIFYUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
            &"RTCode ON RTCUSTADSLCHG.MODIFYCODE = RTCode.CODE AND " _
            &"RTCode.KIND = 'C8' " _
            &"where rtcustadslchg.comq1=" & aryparmkey(0) & "and  rtcustadslchg.cusid='" & aryparmkey(1) & "' and rtcustadslchg.entryno=" & aryparmkey(2) & " " _
            &"ORDER BY  RTCUSTADSLCHG.MODIFYDAT " 
   'response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
