<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�U���X���޲z�t��"
  title="�������I�b����ƺ��@"
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
  formatName="none;����;���I�O;�����I���;�����I��;�O�λ���;����/�I���B;�ꦬ�I���;�ꦬ/�I���B;���׽X"
  sqlDelete="SELECT HBContractARAP.CTNO,HBContractARAP.ITEMNO, RTCode.CODENC, " _
           &"HBContractARAP.STRBILLINGYM, HBContractARAP.MONTHLYDAT, " _
           &"HBContractARAP.EXPENSEITEMNM, HBContractARAP.AMT, " _
           &"HBContractARAP.ACTUALDAT, HBContractARAP.ACTAMT, " _
           &"HBContractARAP.ENDCODE " _
           &"FROM HBContractARAP INNER JOIN " _
           &"RTCode ON HBContractARAP.ARORAP = RTCode.CODE AND RTCode.KIND = 'F7' " _
           &"WHERE HBContractARAP.CTNO=0 " 
  dataTable="HBContractARAP"
  numberOfKey=2
  dataProg="RTContractARAPd.asp"
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
  colSplit=1
  keyListPageSize=80
  searchProg="self"
  searchShow=FrGetContractDesc(aryParmKey(0))
  searchQry="HBContractarap.CTNO=" &aryParmKey(0) &" "
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT HBContractARAP.CTNO, HBContractARAP.ITEMNO, RTCode.CODENC, " _
           &"HBContractARAP.STRBILLINGYM, HBContractARAP.MONTHLYDAT, " _
           &"HBContractARAP.EXPENSEITEMNM, HBContractARAP.AMT, " _
           &"HBContractARAP.ACTUALDAT, HBContractARAP.ACTAMT, " _
           &"HBContractARAP.ENDCODE " _
           &"FROM HBContractARAP INNER JOIN " _
           &"RTCode ON HBContractARAP.ARORAP = RTCode.CODE AND RTCode.KIND = 'F7' " _
           &"WHERE " & searchQry
 'Response.Write "sql=" & sqlLIST & "<br>"
End Sub
%>
<!-- #include file="RTGetContractDesc.inc" -->