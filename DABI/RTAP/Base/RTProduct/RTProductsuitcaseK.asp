<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi Building�޲z�t��"
  title="���~�A�Τ�׸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName=""
  functionOptProgram=""
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���~�W��;�W��;�A�Τ��;�@�o��"
  sqlDelete="SELECT       RTProdSuitCase.PRODNO, RTProdSuitCase.ITEMNO, " _
           &"             RTProdSuitCase.CASETYPE, RTProdH.PRODNC, RTProdD1.SPEC, " _
           &"             RTCode.CODENC, RTProdSuitCase.DROPDAT " _
           &"FROM         RTProdSuitCase INNER JOIN " _
           &"             RTProdH ON RTProdSuitCase.PRODNO = RTProdH.PRODNO INNER JOIN " _
           &"             RTProdD1 ON RTProdSuitCase.PRODNO = RTProdD1.PRODNO AND " _
           &"             RTProdSuitCase.ITEMNO = RTProdD1.ITEMNO INNER JOIN " _
           &"             RTCode ON RTProdSuitCase.CASETYPE = RTCode.CODE AND " _
           &"             RTCode.KIND = 'E5' " _
           &"WHERE RTProdSuitCase.PRODNO='*' " 
  dataTable="RTProDSUITCASE"
  numberOfKey=3
  dataProg="RTPRODUCTSUITCASED.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
  searchProg="self"
' searchShow=FrGetConsigneeDesc(aryParmKey(0))
'  searchQry="rtConsigneecty.cusid='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
  If searchQry="" Then
     searchFirst=True
     searchQry=" RTProdSuitCase.PRODNO='" & aryparmkey(0) & "' AND RTProdSuitCase.ITEMNO='" & aryparmkey(1) & "'"
     searchShow=""
  Else
     searchFirst=False
  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT       RTProdSuitCase.PRODNO, RTProdSuitCase.ITEMNO, " _
         &"             RTProdSuitCase.CASETYPE, RTProdH.PRODNC, RTProdD1.SPEC, " _
         &"             RTCode.CODENC, RTProdSuitCase.DROPDAT " _
         &"FROM         RTProdSuitCase INNER JOIN " _
         &"             RTProdH ON RTProdSuitCase.PRODNO = RTProdH.PRODNO INNER JOIN " _
         &"             RTProdD1 ON RTProdSuitCase.PRODNO = RTProdD1.PRODNO AND " _
         &"             RTProdSuitCase.ITEMNO = RTProdD1.ITEMNO INNER JOIN " _
         &"             RTCode ON RTProdSuitCase.CASETYPE = RTCode.CODE AND " _
         &"             RTCode.KIND = 'E5' " _
         &"WHERE  " & searchQry & " " _
         &"ORDER BY RTProdSuitCase.CASETYPE "
End Sub
%>
