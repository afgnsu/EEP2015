<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="���¤W��޲z�t��"
  title="�t�����ʳ��W���ʬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  functionoptopen=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=STOCK;uid=sa;pwd=alittlecat@cbn"
  formatName="none;none;����;���ʤ��;���ʧO;���W���;���W����;�q��;EMAIL;�T�{���;�T�{�H��;�@�o���;�@�o�H��"
  sqlDelete="SELECT  YYMMDD,EMAIL,SEQ, CHGDAT,STCODE_1.CODENC, APPLYDAT,STCODE.CODENC, TEL, EMAIL, CONFIRMDAT, CONFIRMUSR, CANCELDAT, CANCELUSR " _
           &"FROM   SpeechSignuplog INNER JOIN   STCode ON SpeechSignuplog.CHGCODE = STCode.CODE AND STCODE.KIND='A6' LEFT OUTER JOIN STCODE STCODE_1 ON LIVEORNET = STCODE_1.CODE AND STCODE_1.KIND='A5' "

  dataTable="STSPEECHSIGNUPLOG"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="self"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" SPEECHSIGNUPLOG.YYMMDD='" & ARYPARMKEY(0) & "' AND SPEECHSIGNUPLOG.EMAIL='" & ARYPARMKEY(1) & "'"
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  sqlList="SELECT YYMMDD,EMAIL,SEQ, CHGDAT,STCODE.CODENC, APPLYDAT,STCODE_1.CODENC, TEL, EMAIL, CONFIRMDAT, CONFIRMUSR, CANCELDAT, CANCELUSR " _
         &"FROM  SpeechSignuplog INNER JOIN   STCode ON SpeechSignuplog.CHGCODE = STCode.CODE AND STCODE.KIND='A6' LEFT OUTER JOIN STCODE STCODE_1 ON LIVEORNET = STCODE_1.CODE AND STCODE_1.KIND='A5' "
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>