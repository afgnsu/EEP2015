<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�U���X���޲z�t��"
  title="�޲z���X�����~�ɸ�ƺ��@"
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
  formatName="none;none;none;���~�W��;�W��W��;�O��;�ƶq"
  sqlDelete="SELECT HBContractMaintain.CTNO, HBContractMaintain.PRODNO, " _
           &"HBContractMaintain.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"HBContractMaintain.EXPENSE, HBContractMaintain.QTY " _
           &"FROM HBContractMaintain INNER JOIN " _
           &"RTPRODH ON HBContractMaintain.PRODNO = RTPRODH.PRODNO INNER JOIN " _
           &"RTPRODD1 ON HBContractMaintain.PRODNO = RTPRODD1.PRODNO AND " _
           &"HBContractMaintain.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE HBContractMaintain.CTNO=0 " 
  dataTable="HBContractMaintain"
  numberOfKey=3
  dataProg="RTContractkind2D.asp"
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
  keyListPageSize=20
  searchProg="self"
  searchShow=FrGetContractDesc(aryParmKey(0))
  searchQry="HBContractMaintain.CTNO=" &aryParmKey(0) &" "
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT HBContractMaintain.CTNO, HBContractMaintain.PRODNO, " _
           &"HBContractMaintain.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"HBContractMaintain.EXPENSE, HBContractMaintain.QTY " _
           &"FROM HBContractMaintain INNER JOIN " _
           &"RTPRODH ON HBContractMaintain.PRODNO = RTPRODH.PRODNO INNER JOIN " _
           &"RTPRODD1 ON HBContractMaintain.PRODNO = RTPRODD1.PRODNO AND " _
           &"HBContractMaintain.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE " & searchQry
 'Response.Write "sql=" & sqlLIST & "<br>"
End Sub
%>
<!-- #include file="RTGetContractDesc.inc" -->