<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�U���X���޲z�t��"
  title="�~�����X�����~�ɸ�ƺ��@"
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
  formatName="none;���~�N��;�W��N��;���~�W��;�W��W��;�i�f��;�g�P�X�f��;�P���;�Q��;�O�T�_��;�O�T����"
  sqlDelete="SELECT HBContractSalesD.CTNO, HBContractSalesD.PRODNO, " _
           &"HBContractSalesD.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"HBContractSalesD.IPRICE, " _
           &"HBContractSalesD.OPRICE, HBContractSalesD.SPRICE, HBContractSalesD.PROFIT, " _
           &"HBContractSalesD.SGUARANTEE, HBContractSalesD.EGUARANTEE " _
           &"FROM HBContractSalesD INNER JOIN " _
           &"RTPRODH ON HBContractSalesD.PRODNO = RTPRODH.PRODNO INNER JOIN " _
           &"RTPRODD1 ON HBContractSalesD.PRODNO = RTPRODD1.PRODNO AND " _
           &"HBContractSalesD.ITEMNO = RTPRODD1.ITEMNO  " _
           &"WHERE HBContractSalesD.CTNO=0 " 
  dataTable="HBContractSalesD"
  numberOfKey=3
  dataProg="RTContractkind1D.asp"
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
  searchQry="HBContractSalesD.CTNO=" &aryParmKey(0) &" "
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT HBContractSalesD.CTNO, HBContractSalesD.PRODNO, " _
           &"HBContractSalesD.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"HBContractSalesD.IPRICE,  " _
           &"HBContractSalesD.OPRICE, HBContractSalesD.SPRICE, HBContractSalesD.PROFIT, " _
           &"HBContractSalesD.SGUARANTEE, HBContractSalesD.EGUARANTEE " _
           &"FROM HBContractSalesD INNER JOIN " _
           &"RTPRODH ON HBContractSalesD.PRODNO = RTPRODH.PRODNO INNER JOIN " _
           &"RTPRODD1 ON HBContractSalesD.PRODNO = RTPRODD1.PRODNO AND " _
           &"HBContractSalesD.ITEMNO = RTPRODD1.ITEMNO  " _
           &"WHERE " & searchQry
 'Response.Write "sql=" & sqlLIST & "<br>"
End Sub
%>
<!-- #include file="RTGetContractDesc.inc" -->