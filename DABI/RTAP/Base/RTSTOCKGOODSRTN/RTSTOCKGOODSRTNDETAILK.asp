<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�h�f����Ӹ�ƺ��@"
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
  formatName="�h�f�渹;none;none;���~�W��;���~�W��;���;�ƶq;���;���B;����;�w�O;�Ƶ�"
  sqlDelete="SELECT RTRETURNRETURND1.RETURNNO, RTRETURNRETURND1.PRODNO, " _
           &"RTRETURNRETURND1.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"RTPRODD1.UNIT, RTRETURNRETURND1.RETURNQTY, RTRETURNRETURND1.PRICE, " _
           &"RTRETURNRETURND1.AMT, RTRETURNRETURND1.COST, " _
           &"RTRETURNRETURND1.WAREHOUSE, RTRETURNRETURND1.RETURNDESC " _
           &"FROM RTRETURNRETURND1 LEFT OUTER JOIN " _
           &"RTPRODH ON " _
           &"RTRETURNRETURND1.PRODNO = RTPRODH.PRODNO LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTRETURNRETURND1.PRODNO = RTPRODD1.PRODNO AND " _
           &"RTRETURNRETURND1.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE RTRETURNRETURND1.RETURNNO='*' " 
  dataTable="RTRETURNRETURND1"
  numberOfKey=3
  dataProg="RTSTOCKGOODSRTNDETAILD.asp"
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
  searchQry="RTSTOCKRETURND1.RETURNNO='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTSTOCKRETURND1.RETURNNO, RTSTOCKRETURND1.PRODNO, " _
           &"RTSTOCKRETURND1.ITEMNO, RTPRODH.PRODNC, RTPRODD1.SPEC, " _
           &"RTPRODD1.UNIT, RTSTOCKRETURND1.RETURNQTY, RTSTOCKRETURND1.PRICE, " _
           &"RTSTOCKRETURND1.AMT, RTSTOCKRETURND1.COST, " _
           &"RTSTOCKRETURND1.WAREHOUSE, RTSTOCKRETURND1.RETURNDESC " _
           &"FROM RTSTOCKRETURND1 LEFT OUTER JOIN " _
           &"RTPRODH ON " _
           &"RTSTOCKRETURND1.PRODNO = RTPRODH.PRODNO LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTSTOCKRETURND1.PRODNO = RTPRODD1.PRODNO AND " _
           &"RTSTOCKRETURND1.ITEMNO = RTPRODD1.ITEMNO " _
           &"WHERE " & searchQry & " " _
           &"ORDER BY RTSTOCKRETURND1.PRODNO,RTSTOCKRETURND1.ITEMNO "
End Sub
%>
