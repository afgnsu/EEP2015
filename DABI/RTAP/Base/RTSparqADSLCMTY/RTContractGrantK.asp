<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�U���X���޲z�t��"
  title="�ɧU�ڸ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName=""
  functionOptProgram=""
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�ɧU�ڥN��;�ɧU����;�g��;�ɧU���B;�ɧU�_��;�ɧU����"
  sqlDelete="SELECT HBContractGrant.CTNO,HBContractGrant.grantid,HBContractGrant.PERIOD, RTCode.CODENC, RTCode_1.CODENC AS Expr1, " _
           &"HBContractGrant.EXPENSE, HBContractGrant.GRANTSTRDAT, " _
           &"HBContractGrant.GRANTENDDAT " _
           &"FROM HBContractGrant INNER JOIN " _
           &"RTCode ON HBContractGrant.GRANTID = RTCode.CODE AND " _
           &"RTCode.KIND = 'F8' INNER JOIN " _
           &"RTCode RTCode_1 ON HBContractGrant.PERIOD = RTCode_1.CODE AND " _
           &"RTCode_1.KIND = 'F9'  " _
           &"WHERE HBContractGrant.CTNO=0 " 
  dataTable="HBContractGrant"
  numberOfKey=2
  dataProg="RTContractGrantD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  debug36=false
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=80
  searchProg="self"
  searchShow=FrGetContractDesc(aryParmKey(0))
  searchQry="HBContractgrant.CTNO=" &aryParmKey(0) &" "
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT HBContractGrant.CTNO,HBContractGrant.grantid,HBContractGrant.PERIOD, RTCode.CODENC, RTCode_1.CODENC AS Expr1, " _
           &"HBContractGrant.EXPENSE, HBContractGrant.GRANTSTRDAT, " _
           &"HBContractGrant.GRANTENDDAT " _
           &"FROM HBContractGrant INNER JOIN " _
           &"RTCode ON HBContractGrant.GRANTID = RTCode.CODE AND " _
           &"RTCode.KIND = 'F8' INNER JOIN " _
           &"RTCode RTCode_1 ON HBContractGrant.PERIOD = RTCode_1.CODE AND " _
           &"RTCode_1.KIND = 'F9'  " _
           &"WHERE " & searchQry
 'Response.Write "sql=" & sqlLIST & "<br>"
End Sub
%>
<!-- #include file="RTGetContractDesc.inc" -->