<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�ռ����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~����;�@   �o;�@�o����;���ʬd��"
  functionOptProgram="RTStockgoodstnsdetailK.asp;RTSTOCKtnsDROP.ASP;RTSTOCKTNSDROPCANCEL.ASP;RTSTOCKTNSTRANSK.ASP"
  functionOptPrompt="N;N;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�ռ��渹;�ռ���;���X�ܮw;���J�ܮw;���X�H��;���J�H��;���J���;�@�o�H��;�@�o���;���ӵ���"
  sqlDelete="SELECT RTSTOCKTNSH.TRANSNO, RTSTOCKTNSH.TRANSDAT, " _
           &"HBwarEhouse_2.WARENAME, HBwarEhouse_1.WARENAME AS Expr1,RTObj_3.CUSNC, RTObj_1.CUSNC AS Expr2, RTSTOCKTNSH.INSIGNDAT, " _
           &"RTObj_2.CUSNC AS Expr3, RTSTOCKTNSH.DROPDAT, " _
           &"SUM(CASE WHEN RTSTOCKTNSD1.TRANSno IS NULL THEN 0 ELSE 1 END) " _
           &"FROM RTSTOCKTNSH LEFT OUTER JOIN RTSTOCKTNSD1 ON RTSTOCKTNSH.TRANSNO = RTSTOCKTNSD1.TRANSNO LEFT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN " _
           &"RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON RTSTOCKTNSH.DROPUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_1 INNER JOIN RTEmployee RTEmployee_1 ON RTObj_1.CUSID = RTEmployee_1.CUSID ON " _
           &"RTSTOCKTNSH.INSIGN = RTEmployee_1.EMPLY LEFT OUTER JOIN HBwarEhouse HBwarEhouse_1 ON " _
           &"RTSTOCKTNSH.INWAREHOUSE = HBwarEhouse_1.WAREHOUSE LEFT OUTER JOIN HBwarEhouse HBwarEhouse_2 ON " _
           &"RTSTOCKTNSH.OUTWAREHOUSE = HBwarEhouse_2.WAREHOUSE LEFT OUTER JOIN RTObj RTObj_3 INNER JOIN " _
           &"RTEmployee RTEmployee_3 ON RTObj_3.CUSID = RTEmployee_3.CUSID ON RTSTOCKTNSH.OUTSIGN = RTEmployee_3.EMPLY " _
           &"WHERE RTSTOCKTNSH.TRANSNO='*' " _           
           &"GROUP BY  RTSTOCKTNSH.TRANSNO, RTSTOCKTNSH.TRANSDAT, " _
           &"HBwarEhouse_2.WARENAME, HBwarEhouse_1.WARENAME ,RTObj_3.CUSNC, RTObj_1.CUSNC, RTSTOCKTNSH.INSIGNDAT, " _
           &"RTObj_2.CUSNC, RTObj_2.CUSNC , RTSTOCKTNSH.DROPDAT " _
           &"ORDER BY  RTSTOCKTNSH.TRANSNO " 
  dataTable="RTSTOCKREPAIRH"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTSTOCKGOODSTNSD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTSTOCKGOODSTNSS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  If searchQry="" Then
     searchQry=" RTSTOCKTNSH.TRANSNO <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKTNSH.TRANSNO, RTSTOCKTNSH.TRANSDAT, " _
           &"HBwarEhouse_2.WARENAME, HBwarEhouse_1.WARENAME AS Expr1,RTObj_3.CUSNC, RTObj_1.CUSNC AS Expr2, RTSTOCKTNSH.INSIGNDAT, " _
           &"RTObj_2.CUSNC AS Expr3, RTSTOCKTNSH.DROPDAT, " _
           &"SUM(CASE WHEN RTSTOCKTNSD1.TRANSno IS NULL THEN 0 ELSE 1 END) " _
           &"FROM RTSTOCKTNSH LEFT OUTER JOIN RTSTOCKTNSD1 ON RTSTOCKTNSH.TRANSNO = RTSTOCKTNSD1.TRANSNO LEFT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN " _
           &"RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID ON RTSTOCKTNSH.DROPUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_1 INNER JOIN RTEmployee RTEmployee_1 ON RTObj_1.CUSID = RTEmployee_1.CUSID ON " _
           &"RTSTOCKTNSH.INSIGN = RTEmployee_1.EMPLY LEFT OUTER JOIN HBwarEhouse HBwarEhouse_1 ON " _
           &"RTSTOCKTNSH.INWAREHOUSE = HBwarEhouse_1.WAREHOUSE LEFT OUTER JOIN HBwarEhouse HBwarEhouse_2 ON " _
           &"RTSTOCKTNSH.OUTWAREHOUSE = HBwarEhouse_2.WAREHOUSE LEFT OUTER JOIN RTObj RTObj_3 INNER JOIN " _
           &"RTEmployee RTEmployee_3 ON RTObj_3.CUSID = RTEmployee_3.CUSID ON RTSTOCKTNSH.OUTSIGN = RTEmployee_3.EMPLY " _
           &"WHERE " &searchQry &" " _           
           &"GROUP BY  RTSTOCKTNSH.TRANSNO, RTSTOCKTNSH.TRANSDAT, " _
           &"HBwarEhouse_2.WARENAME, HBwarEhouse_1.WARENAME ,RTObj_3.CUSNC, RTObj_1.CUSNC, RTSTOCKTNSH.INSIGNDAT, " _
           &"RTObj_2.CUSNC, RTObj_2.CUSNC , RTSTOCKTNSH.DROPDAT " _
           &"ORDER BY  RTSTOCKTNSH.TRANSNO " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>