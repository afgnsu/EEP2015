<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�i�f���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~����;�@   �o;�@�o����;���ʬd��"
  functionOptProgram="RTStockgoodsdetailK.asp;RTSTOCKDROP.ASP;RTSTOCKDROPCANCEL.ASP;RTSTOCKTRANSK.ASP"
  functionOptPrompt="N;N;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�i�f�渹;�i�f��;�i�f�t��;�禬��;�@�o��;�@�o��;���~����"
  sqlDelete="SELECT RTSTOCKGOODSH.STOCKNO, RTSTOCKGOODSH.STOCKDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC AS Expr1, " _
         &"RTSTOCKGOODSH.DROPDAT, RTObj_3.SHORTNC AS Expr2, " _
         &"SUM(CASE WHEN RTSTOCKGOODSD1.stockno IS NULL THEN 0 ELSE 1 END)  " _ 
         &"FROM RTSTOCKGOODSH INNER JOIN " _
         &"RTObj RTObj_2 ON " _
         &"RTSTOCKGOODSH.FACTORY = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_3 INNER JOIN " _
         &"RTEmployee RTEmployee_1 ON RTObj_3.CUSID = RTEmployee_1.CUSID ON " _
         &"RTSTOCKGOODSH.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTSTOCKGOODSD1 ON " _
         &"RTSTOCKGOODSH.STOCKNO = RTSTOCKGOODSD1.STOCKNO LEFT OUTER JOIN " _
         &"RTObj RTObj_1 INNER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
         &"RTSTOCKGOODSH.CHECKUSR = RTEmployee.EMPLY " _
         &"WHERE RTSTOCKGOODSH.STOCKNO='*' " _           
         &"GROUP BY  RTSTOCKGOODSH.STOCKNO, RTSTOCKGOODSH.STOCKDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC, RTSTOCKGOODSH.DROPDAT, " _
         &"RTObj_3.SHORTNC " _
         &"ORDER BY  RTSTOCKGOODSH.STOCKNO " 
  dataTable="RTSTOCKGOODSH"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTSTOCKGOODSD.asp"
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
  searchProg="RTSTOCKGOODSS.asp"
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
     searchQry=" RTSTOCKGOODSH.STOCKNO <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKGOODSH.STOCKNO, RTSTOCKGOODSH.STOCKDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC AS Expr1, " _
         &"RTSTOCKGOODSH.DROPDAT, RTObj_3.SHORTNC AS Expr2, " _
         &"SUM(CASE WHEN RTSTOCKGOODSD1.stockno IS NULL THEN 0 ELSE 1 END)  " _ 
         &"FROM RTSTOCKGOODSH INNER JOIN " _
         &"RTObj RTObj_2 ON " _
         &"RTSTOCKGOODSH.FACTORY = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_3 INNER JOIN " _
         &"RTEmployee RTEmployee_1 ON RTObj_3.CUSID = RTEmployee_1.CUSID ON " _
         &"RTSTOCKGOODSH.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTSTOCKGOODSD1 ON " _
         &"RTSTOCKGOODSH.STOCKNO = RTSTOCKGOODSD1.STOCKNO LEFT OUTER JOIN " _
         &"RTObj RTObj_1 INNER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
         &"RTSTOCKGOODSH.CHECKUSR = RTEmployee.EMPLY " _
         &"WHERE " &searchQry &" " _           
         &"GROUP BY  RTSTOCKGOODSH.STOCKNO, RTSTOCKGOODSH.STOCKDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC, RTSTOCKGOODSH.DROPDAT, " _
         &"RTObj_3.SHORTNC " _
         &"ORDER BY  RTSTOCKGOODSH.STOCKNO " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>