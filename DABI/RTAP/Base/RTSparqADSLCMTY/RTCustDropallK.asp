<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL�h���������u�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="������u"
  functionOptProgram="RTsparqadslcustdropsndworkk.asp"
  functionOptPrompt ="N"
  functionoptopen   ="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;�Τ�W��;���ʧO;���ʤ�;���ʳ�����;�������ɤ�;����渹;�������;�w�w����H��"
   sqlDelete="SELECT RTSparqAdslChg.CUSID, RTSparqAdslChg.ENTRYNO, RTSparqAdslChg.COMQ1,RTSPARQADSLCMTY.COMN,RTOBJ.CUSNC, RTCode.CODENC, " _
            &"RTSparqAdslChg.MODIFYDAT, RTSparqAdslChg.DOCKETDAT, RTSparqAdslChg.TRANSDAT,RTSparqadslcustdropsndwork.PRTNO, RTSparqadslcustdropsndwork.SENDWORKDAT, " _
            &"CASE WHEN rtobj_1.cusnc <> '' THEN rtobj_1.cusnc ELSE rtobj_2.shortnc END " _
            &"FROM  RTObj RTObj_2 RIGHT OUTER JOIN RTSparqadslcustdropsndwork ON " _
            &"RTObj_2.CUSID = RTSparqadslcustdropsndwork.ASSIGNCONSIGNEE LEFT OUTER JOIN RTEmployee LEFT OUTER JOIN " _
            &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
            &"RTSparqadslcustdropsndwork.ASSIGNENGINEER = RTEmployee.EMPLY RIGHT OUTER JOIN RTSparqAdslChg INNER JOIN " _
            &"RTCode ON RTSparqAdslChg.MODIFYCODE = RTCode.CODE AND RTCode.KIND = 'K1' LEFT OUTER JOIN " _
            &"RTSparqAdslCmty ON RTSparqAdslChg.COMQ1 = RTSparqAdslCmty.CUTYID LEFT OUTER JOIN " _
            &"RTObj ON RTSparqAdslChg.CUSID = RTObj.CUSID ON RTSparqadslcustdropsndwork.CUSID = RTSparqAdslChg.CUSID AND " _
            &"RTSparqadslcustdropsndwork.ENTRYNO = RTSparqAdslChg.ENTRYNO AND RTSparqadslcustdropsndwork.DROPDAT IS NULL " _
            &"WHERE (RTSparqAdslChg.DROPDAT IS NULL) AND (RTSparqAdslChg.MODIFYCODE = 'DR') " 
  dataTable="RTSparqAdslChg"
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
  keyListPageSize=20
  searchFirst=false
 ' response.Write "k0=" & aryparmkey(0) & ";k1=" & aryparmkey(1) & ";k2=" & aryparmkey(2)
  searchShow="�����ݩ�����u"
  searchProg="RTCustDropAllS.asp"
 
  If searchQry="" Then
     searchQry=" AND RTSparqadslcustdropsndwork.closedat is null "
     searchShow="����(�|������^��)"
  ELSE
     SEARCHFIRST=FALSE
  End If
    
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqllist="SELECT RTSparqAdslChg.CUSID, RTSparqAdslChg.ENTRYNO, RTSparqAdslChg.COMQ1,RTSPARQADSLCMTY.COMN,RTOBJ.CUSNC, RTCode.CODENC, " _
         &"RTSparqAdslChg.MODIFYDAT, RTSparqAdslChg.DOCKETDAT, RTSparqAdslChg.TRANSDAT,RTSparqadslcustdropsndwork.PRTNO, RTSparqadslcustdropsndwork.SENDWORKDAT, " _
         &"CASE WHEN rtobj_1.cusnc <> '' THEN rtobj_1.cusnc ELSE rtobj_2.shortnc END " _
         &"FROM  RTObj RTObj_2 RIGHT OUTER JOIN RTSparqadslcustdropsndwork ON " _
         &"RTObj_2.CUSID = RTSparqadslcustdropsndwork.ASSIGNCONSIGNEE LEFT OUTER JOIN RTEmployee LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
         &"RTSparqadslcustdropsndwork.ASSIGNENGINEER = RTEmployee.EMPLY RIGHT OUTER JOIN RTSparqAdslChg INNER JOIN " _
         &"RTCode ON RTSparqAdslChg.MODIFYCODE = RTCode.CODE AND RTCode.KIND = 'K1' LEFT OUTER JOIN " _
         &"RTSparqAdslCmty ON RTSparqAdslChg.COMQ1 = RTSparqAdslCmty.CUTYID LEFT OUTER JOIN " _
         &"RTObj ON RTSparqAdslChg.CUSID = RTObj.CUSID ON RTSparqadslcustdropsndwork.CUSID = RTSparqAdslChg.CUSID AND " _
         &"RTSparqadslcustdropsndwork.ENTRYNO = RTSparqAdslChg.ENTRYNO AND RTSparqadslcustdropsndwork.DROPDAT IS NULL " _
         &"where (RTSparqAdslChg.DROPDAT IS NULL) AND (RTSparqadslcustdropsndwork.DROPDAT IS NULL) AND (RTSparqAdslChg.MODIFYCODE = 'DR') " & searchqry _
         &" order by 7 desc "
   'response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
