<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�i�f����Ӹ�ƺ��@"
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
  formatName="�i�f�渹;none;none;���~�W��;���~�W��;���;�ƶq;���;���B;����;�w�O;�Ƶ�"
  sqlDelete="SELECT RTSTOCKGOODSD1.STOCKNO, RTSTOCKGOODSD1.PRODNO, " _
           &"RTSTOCKGOODSD1.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"RTPRODD1.UNIT, RTSTOCKGOODSD1.STOCKQTY, RTSTOCKGOODSD1.PRICE, " _
           &"RTSTOCKGOODSD1.AMT, RTSTOCKGOODSD1.COST, " _
           &"RTSTOCKGOODSD1.WAREHOUSE, RTSTOCKGOODSD1.STOCKDESC " _
           &"FROM RTSTOCKGOODSD1 LEFT OUTER JOIN " _
           &"RTPRODH ON " _
           &"RTSTOCKGOODSD1.PRODNO = RTPRODH.PRODNO LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTSTOCKGOODSD1.PRODNO = RTPRODD1.PRODNO AND " _
           &"RTSTOCKGOODSD1.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE RTSTOCKGOODSD1.STOCKNO='*' " 
  dataTable="RTSTOCKGOODSD1"
  numberOfKey=3
  dataProg="RTSTOCKGOODSDETAILD.asp"
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
  keyListPageSize=60
  searchProg="self"
  searchShow="����"
  searchQry="RTSTOCKGOODSD1.STOCKNO='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTSTOCKGOODSD1.STOCKNO, RTSTOCKGOODSD1.PRODNO, " _
           &"RTSTOCKGOODSD1.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"RTPRODD1.UNIT, RTSTOCKGOODSD1.STOCKQTY, RTSTOCKGOODSD1.PRICE, " _
           &"RTSTOCKGOODSD1.AMT, RTSTOCKGOODSD1.COST, " _
           &"RTSTOCKGOODSD1.WAREHOUSE, RTSTOCKGOODSD1.STOCKDESC " _
           &"FROM RTSTOCKGOODSD1 LEFT OUTER JOIN " _
           &"RTPRODH ON " _
           &"RTSTOCKGOODSD1.PRODNO = RTPRODH.PRODNO LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTSTOCKGOODSD1.PRODNO = RTPRODD1.PRODNO AND " _
           &"RTSTOCKGOODSD1.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE " & searchQry & " " _
           &"ORDER BY RTSTOCKGOODSD1.PRODNO,RTSTOCKGOODSD1.ITEMNO "
End Sub
%>
