<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi_Building�޲z�t��"
  title="���Ͼ�u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=" �@�o ; �@�o����;���ʬd��"
  functionOptProgram="HBCmtyarrangeHARDWAREDROP.ASP;HBCmtyarrangeHARDWAREDROPc.ASP;HBCmtyarrangeHARDWARELOGK.ASP"
  functionOptPrompt="Y;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;<center>���ϦW��</center>;<center>������O</center>;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���</center>;<center>�@�o���</center>;none;<center>�@�o�H��</center>"
  sqlDelete="SELECT HBcmtyarrangeHardware.COMQ1,HBcmtyarrangeHardware.COMTYPE,HBcmtyarrangeHardware.PRTNO,HBcmtyarrangeHardware.ENTRYNO, " _
           &"RTCmty.COMN, 'Hi-Building' AS Expr1,HBcmtyarrangeHardware.PRTNO AS Expr2, HBcmtyarrangeHardware.ENTRYNO AS Expr3, " _
           &"RTProdH.PRODNC+ RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, HBcmtyarrangeHardware.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTCmty ON HBcmtyarrangeHardware.COMQ1 = RTCmty.COMQ1 " _
           &"LEFT OUTER JOIN RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID ON " _
           &"HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON RTCode.CODE = HBcmtyarrangeHardware.UNIT AND " _
           &"RTCode.KIND = 'B5' LEFT OUTER JOIN HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
           &"JOIN RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND  HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '1') " _
           &"union " _
           &"SELECT HBcmtyarrangeHardware.COMQ1, HBcmtyarrangeHardware.COMTYPE, HBcmtyarrangeHardware.PRTNO, " _
           &"HBcmtyarrangeHardware.ENTRYNO, RTCUSTADSLCmty.COMN, '399A��(����399)' AS Expr1, HBcmtyarrangeHardware.PRTNO AS Expr2, " _
           &"HBcmtyarrangeHardware.ENTRYNO AS Expr3, RTProdH.PRODNC+ RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, " _
           &"HBcmtyarrangeHardware.DROPDAT, HBwarehouse.WARENAME, RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTCUSTADSLCmty ON " _
           &"HBcmtyarrangeHardware.COMQ1 =RTcustadslCmty.CUTYID LEFT OUTER JOIN RTEmployee INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID ON HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON " _
           &"RTCode.CODE = HBcmtyarrangeHardware.UNIT AND RTCode.KIND = 'B5' LEFT OUTER JOIN " _
           &"HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER JOIN " _
           &"RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '2') " _
           &"union " _
           &"SELECT HBcmtyarrangeHardware.COMQ1, HBcmtyarrangeHardware.COMTYPE, HBcmtyarrangeHardware.PRTNO, " _
           &"HBcmtyarrangeHardware.ENTRYNO, RTSPARQADSLCmty.COMN, '399B��(�t��399)' AS Expr1, " _
           &"HBcmtyarrangeHardware.PRTNO AS Expr2, HBcmtyarrangeHardware.ENTRYNO AS Expr3, RTProdH.PRODNC+ " _
           &"RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, HBcmtyarrangeHardware.DROPDAT, HBwarehouse.WARENAME, " _
           &"RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTSPARQADSLCmty ON " _
           &"HBcmtyarrangeHardware.COMQ1 =RTSPARQadslCmty.CUTYID LEFT OUTER JOIN RTEmployee INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID ON HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON " _
           &"RTCode.CODE = HBcmtyarrangeHardware.UNIT AND RTCode.KIND = 'B5' LEFT OUTER JOIN " _
           &"HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
           &"JOIN RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '3') " 
           
  dataTable="HBCmtyarrangeHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="HBCmtyarrangeHARDWARED.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" HBCmtyarrangeHARDWARE.ComQ1<>0 AND HBCmtyarrangeHARDWARE.ComQ1=" & ARYPARMKEY(0) & " AND HBCmtyarrangeHARDWARE.COMTYPE='" & ARYPARMKEY(1) & "' AND HBCmtyarrangeHARDWARE.PRTNO='" & ARYPARMKEY(2) & "' "  
    ' searchShow=" HBCmtyarrangeHARDWARE.ComQ1<>0 AND HBCmtyarrangeHARDWARE.ComQ1=" & ARYPARMKEY(0) & " AND HBCmtyarrangeHARDWARE.COMTYPE='" & ARYPARMKEY(1) & "' AND HBCmtyarrangeHARDWARE.PRTNO='" & ARYPARMKEY(2) & "' "  
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT HBcmtyarrangeHardware.COMQ1,HBcmtyarrangeHardware.COMTYPE,HBcmtyarrangeHardware.PRTNO,HBcmtyarrangeHardware.ENTRYNO, " _
           &"RTCmty.COMN, 'Hi-Building' AS Expr1,HBcmtyarrangeHardware.PRTNO AS Expr2, HBcmtyarrangeHardware.ENTRYNO AS Expr3, " _
           &"RTProdH.PRODNC+RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, HBcmtyarrangeHardware.DROPDAT, " _
           &"HBwarehouse.WARENAME, RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTCmty ON HBcmtyarrangeHardware.COMQ1 = RTCmty.COMQ1 " _
           &"LEFT OUTER JOIN RTEmployee INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID ON " _
           &"HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON RTCode.CODE = HBcmtyarrangeHardware.UNIT AND " _
           &"RTCode.KIND = 'B5' LEFT OUTER JOIN HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
           &"JOIN RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND  HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '1' OR HBcmtyarrangeHardware.COMTYPE = '4' ) and "  & SEARCHQRY _
           &"union " _
           &"SELECT HBcmtyarrangeHardware.COMQ1, HBcmtyarrangeHardware.COMTYPE, HBcmtyarrangeHardware.PRTNO, " _
           &"HBcmtyarrangeHardware.ENTRYNO, RTCUSTADSLCmty.COMN, '399A��(����399)' AS Expr1, HBcmtyarrangeHardware.PRTNO AS Expr2, " _
           &"HBcmtyarrangeHardware.ENTRYNO AS Expr3, RTProdH.PRODNC+ RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, " _
           &"HBcmtyarrangeHardware.DROPDAT, HBwarehouse.WARENAME, RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTCUSTADSLCmty ON " _
           &"HBcmtyarrangeHardware.COMQ1 =RTcustadslCmty.CUTYID LEFT OUTER JOIN RTEmployee INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID ON HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON " _
           &"RTCode.CODE = HBcmtyarrangeHardware.UNIT AND RTCode.KIND = 'B5' LEFT OUTER JOIN " _
           &"HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER JOIN " _
           &"RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '2') and "  & SEARCHQRY _
           &"union " _
           &"SELECT HBcmtyarrangeHardware.COMQ1, HBcmtyarrangeHardware.COMTYPE, HBcmtyarrangeHardware.PRTNO, " _
           &"HBcmtyarrangeHardware.ENTRYNO, RTSPARQADSLCmty.COMN, '399B��(�t��399)' AS Expr1, " _
           &"HBcmtyarrangeHardware.PRTNO AS Expr2, HBcmtyarrangeHardware.ENTRYNO AS Expr3, RTProdH.PRODNC+ " _
           &"RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, HBcmtyarrangeHardware.DROPDAT, HBwarehouse.WARENAME, " _
           &"RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTSPARQADSLCmty ON " _
           &"HBcmtyarrangeHardware.COMQ1 =RTSPARQadslCmty.CUTYID LEFT OUTER JOIN RTEmployee INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID ON HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON " _
           &"RTCode.CODE = HBcmtyarrangeHardware.UNIT AND RTCode.KIND = 'B5' LEFT OUTER JOIN " _
           &"HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
           &"JOIN RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '3') and " & SEARCHQRY _
           &"union " _
           &"SELECT HBcmtyarrangeHardware.COMQ1, HBcmtyarrangeHardware.COMTYPE, HBcmtyarrangeHardware.PRTNO, " _
           &"HBcmtyarrangeHardware.ENTRYNO, RTEBTCMTYH.COMN, '�F��AVS499' AS Expr1, " _
           &"HBcmtyarrangeHardware.PRTNO AS Expr2, HBcmtyarrangeHardware.ENTRYNO AS Expr3, RTProdH.PRODNC+ " _
           &"RTProdD1.SPEC, HBcmtyarrangeHardware.QTY, RTCode.CODENC, HBcmtyarrangeHardware.DROPDAT, HBwarehouse.WARENAME, " _
           &"RTObj.CUSNC " _
           &"FROM RTCode RIGHT OUTER JOIN HBcmtyarrangeHardware INNER JOIN RTEBTCMTYH ON " _
           &"HBcmtyarrangeHardware.COMQ1 =RTEBTCMTYH.COMQ1 LEFT OUTER JOIN RTEmployee INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID ON HBcmtyarrangeHardware.DROPUSR = RTEmployee.EMPLY ON " _
           &"RTCode.CODE = HBcmtyarrangeHardware.UNIT AND RTCode.KIND = 'B5' LEFT OUTER JOIN " _
           &"HBwarehouse ON HBcmtyarrangeHardware.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
           &"JOIN RTProdH ON HBcmtyarrangeHardware.PRODNO = RTProdH.PRODNO LEFT OUTER JOIN " _
           &"RTProdD1 ON HBcmtyarrangeHardware.PRODNO = RTProdD1.PRODNO AND HBcmtyarrangeHardware.ITEMNO = RTProdD1.ITEMNO " _
           &"WHERE (HBcmtyarrangeHardware.COMTYPE = '5') and " & SEARCHQRY           
'Response.Write "sql=" & SQLLIST         
End Sub
%>
