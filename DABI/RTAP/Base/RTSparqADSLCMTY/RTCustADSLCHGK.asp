<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL�w�����Ȥ���v���ʬd��"
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
   sqlDelete="SELECT RTSparqADSLCHG.COMQ1,RTSparqADSLCHG.cusid,RTSparqADSLCHG.entryno,RTSparqADSLCHG.modifycode,RTSparqADSLCHG.modifydat, RTObj_1.SHORTNC,RTSparqADSLCHG.ENTRYNO, " _
            &"RTSparqADSLCHG.MODIFYCODE, RTCode.CODENC, " _
            &"RTSparqADSLCHG.MODIFYDAT, RTObj_2.CUSNC, RTSparqADSLCHG.DROPDAT, " _
            &"RTSparqADSLCHG.DOCKETDAT, RTSparqADSLCHG.TRANSDAT " _
            &"FROM  RTObj RTObj_1 RIGHT OUTER JOIN " _
            &"RTSparqADSLCHG ON " _
            &"RTObj_1.CUSID = RTSparqADSLCHG.CUSID LEFT OUTER JOIN " _
            &"RTObj RTObj_2 RIGHT OUTER JOIN " _
            &"RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
            &"RTSparqADSLCHG.MODIFYUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
            &"RTCode ON RTSparqADSLCHG.MODIFYCODE = RTCode.CODE AND " _
            &"RTCode.KIND = 'C8' " _
            &"where RTSparqADSLCHG.cusid='*' " _
            &"ORDER BY  RTSparqADSLCHG.MODIFYDAT " 
  dataTable="RTSparqADSLCHG"
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
 ' response.Write "k0=" & aryparmkey(0) & ";k1=" & aryparmkey(1) & ";k2=" & aryparmkey(2)
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  searchQry="RTSparqADSLCHG.comq1 =" & aryparmkey(0) & " and cusid='" & aryparmkey(1) & "' and entryno=" & aryparmkey(2)
  searchProg="self"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqllist="SELECT RTSparqADSLCHG.COMQ1,RTSparqADSLCHG.cusid,RTSparqADSLCHG.entryno,RTSparqADSLCHG.modifycode,RTSparqADSLCHG.modifydat, RTObj_1.SHORTNC, RTSparqADSLCHG.ENTRYNO, " _
            &"RTSparqADSLCHG.MODIFYCODE, RTCode.CODENC, " _
            &"RTSparqADSLCHG.MODIFYDAT, RTObj_2.CUSNC, RTSparqADSLCHG.DROPDAT, " _
            &"RTSparqADSLCHG.DOCKETDAT, RTSparqADSLCHG.TRANSDAT " _
            &"FROM  RTObj RTObj_1 RIGHT OUTER JOIN " _
            &"RTSparqADSLCHG ON " _
            &"RTObj_1.CUSID = RTSparqADSLCHG.CUSID LEFT OUTER JOIN " _
            &"RTObj RTObj_2 RIGHT OUTER JOIN " _
            &"RTEmployee ON RTObj_2.CUSID = RTEmployee.CUSID ON " _
            &"RTSparqADSLCHG.MODIFYUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
            &"RTCode ON RTSparqADSLCHG.MODIFYCODE = RTCode.CODE AND " _
            &"RTCode.KIND = 'K1' " _
            &"where RTSparqADSLCHG.comq1=" & aryparmkey(0) & "and  RTSparqADSLCHG.cusid='" & aryparmkey(1) & "' and RTSparqADSLCHG.entryno=" & aryparmkey(2) & " " _
            &"ORDER BY  RTSparqADSLCHG.MODIFYDAT " 
  ' response.write "SQL=" & sqllist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
