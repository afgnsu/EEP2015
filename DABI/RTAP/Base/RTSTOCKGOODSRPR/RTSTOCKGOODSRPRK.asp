<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�e�׳��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~����;�@   �o;�@�o����;���ʬd��"
  functionOptProgram="RTStockgoodsRPRdetailK.asp;RTSTOCKRPRDROP.ASP;RTSTOCKRPRDROPCANCEL.ASP;RTSTOCKRPRTRANSK.ASP"
  functionOptPrompt="N;N;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�e�׳渹;�e�פ�;�e�׼t��;�e�׭�;�@�o��;�@�o��;���~����"
  sqlDelete="SELECT RTSTOCKREPAIRH.REPAIRNO, RTSTOCKREPAIRH.REPAIRDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC AS Expr1, " _
         &"RTSTOCKREPAIRH.DROPDAT, RTObj_3.SHORTNC AS Expr2, " _
         &"SUM(CASE WHEN RTSTOCKREPAIRD1.REPAIRno IS NULL THEN 0 ELSE 1 END)  " _ 
         &"FROM RTSTOCKREPAIRH INNER JOIN " _
         &"RTObj RTObj_2 ON " _
         &"RTSTOCKREPAIRH.FACTORY = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_3 INNER JOIN " _
         &"RTEmployee RTEmployee_1 ON RTObj_3.CUSID = RTEmployee_1.CUSID ON " _
         &"RTSTOCKREPAIRH.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTSTOCKREPAIRD1 ON " _
         &"RTSTOCKREPAIRH.REPAIRNO = RTSTOCKREPAIRD1.REPAIRNO LEFT OUTER JOIN " _
         &"RTObj RTObj_1 INNER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
         &"RTSTOCKREPAIRH.CHECKUSR = RTEmployee.EMPLY " _
         &"WHERE RTSTOCKREPAIRH.REPAIRNO='*' " _           
         &"GROUP BY  RTSTOCKREPAIRH.REPAIRNO, RTSTOCKREPAIRH.REPAIRDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC, RTSTOCKREPAIRH.DROPDAT, " _
         &"RTObj_3.SHORTNC " _
         &"ORDER BY  RTSTOCKREPAIRH.REPAIRNO " 
  dataTable="RTSTOCKREPAIRH"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTSTOCKGOODSRPRD.asp"
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
  searchProg="RTSTOCKGOODSRTNS.asp"
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
     searchQry=" RTSTOCKREPAIRH.REPAIRNO <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKREPAIRH.REPAIRNO, RTSTOCKREPAIRH.REPAIRDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC AS Expr1, " _
         &"RTSTOCKREPAIRH.DROPDAT, RTObj_3.SHORTNC AS Expr2, " _
         &"SUM(CASE WHEN RTSTOCKREPAIRD1.REPAIRno IS NULL THEN 0 ELSE 1 END)  " _ 
         &"FROM RTSTOCKREPAIRH INNER JOIN " _
         &"RTObj RTObj_2 ON " _
         &"RTSTOCKREPAIRH.FACTORY = RTObj_2.CUSID LEFT OUTER JOIN " _
         &"RTObj RTObj_3 INNER JOIN " _
         &"RTEmployee RTEmployee_1 ON RTObj_3.CUSID = RTEmployee_1.CUSID ON " _
         &"RTSTOCKREPAIRH.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTSTOCKREPAIRD1 ON " _
         &"RTSTOCKREPAIRH.REPAIRNO = RTSTOCKREPAIRD1.REPAIRNO LEFT OUTER JOIN " _
         &"RTObj RTObj_1 INNER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
         &"RTSTOCKREPAIRH.CHECKUSR = RTEmployee.EMPLY " _
         &"WHERE " &searchQry &" " _           
         &"GROUP BY  RTSTOCKREPAIRH.REPAIRNO, RTSTOCKREPAIRH.REPAIRDAT, " _
         &"RTObj_2.SHORTNC, RTObj_1.SHORTNC, RTSTOCKREPAIRH.DROPDAT, " _
         &"RTObj_3.SHORTNC " _
         &"ORDER BY  RTSTOCKREPAIRH.REPAIRNO " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>