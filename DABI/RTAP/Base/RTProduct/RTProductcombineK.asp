<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi Building�޲z�t��"
  title="�M�\�զX��ƺ��@"
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
  formatName="none;none;none;none;���~�s��;�M�\���~;�W��;�ƶq;���;���B"
  sqlDelete="SELECT RTPRODD2.PRODNO AS PRODNO, RTPRODD2.ITEMNO AS ITEMNO, " _
           &"RTPRODD2.PRODNO2 AS PRODNO2,RTPRODD2.itemNO2 AS itemNO2,RTPRODD2.PRODNO2+'-'+RTPRODD2.itemNO2, RTPRODD1.ITEMNC AS ITEMNC, " _
           &"RTPRODD1.SPEC AS SPEC, RTPRODD2.QTY AS QTY, " _
           &"RTPRODD2.UNITPRICE AS UNITPRICE, " _
           &"RTPRODD2.QTY * RTPRODD2.UNITPRICE AS AMT " _
           &"FROM RTPRODD2 LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTPRODD2.PRODNO2 = RTPRODD1.PRODNO " _
           &"WHERE RTPRODD2.PRODNO='*' " 
  dataTable="RTProDD2"
  numberOfKey=4
  dataProg="RTPRODUCTcombineD.asp"
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
  colSplit=1
  keyListPageSize=60
  searchProg="self"
' searchShow=FrGetConsigneeDesc(aryParmKey(0))
'  searchQry="rtConsigneecty.cusid='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
  If searchQry="" Then
     searchFirst=True
     searchQry=" RTproDD2.PRODNO='" & aryparmkey(0) & "' and RTproDD2.itemno='" & aryparmkey(1) & "' "
     searchShow=""
  Else
     searchFirst=False
  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTPRODD2.PRODNO AS PRODNO, RTPRODD2.ITEMNO AS ITEMNO, " _
           &"RTPRODD2.PRODNO2 AS PRODNO2,RTPRODD2.itemNO2 AS itemNO2,RTPRODD2.PRODNO2+'-'+RTPRODD2.itemNO2, RTPRODD1.ITEMNC AS ITEMNC, " _
           &"RTPRODD1.SPEC AS SPEC, RTPRODD2.QTY AS QTY, " _
           &"RTPRODD2.UNITPRICE AS UNITPRICE, " _
           &"RTPRODD2.QTY * RTPRODD2.UNITPRICE AS AMT " _
           &"FROM RTPRODD2 LEFT OUTER JOIN " _
           &"RTPRODD1 ON RTPRODD2.PRODNO2 = RTPRODD1.PRODNO " _
           &"WHERE RTPRODD2.PRODNO='" & aryparmkey(0) &"' and RTProDD2.ITEMNO='" & aryparmkey(1) & "' and " & searchQry & " " _
           &"ORDER BY RTPRODD2.PRODNO,rtprodd2.itemno,RTPRODD2.PRODNO2 "
'Response.Write SQLlist
End Sub
%>
