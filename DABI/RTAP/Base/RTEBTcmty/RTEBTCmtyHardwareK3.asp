<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS���ϳ]�Ƹ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���ʬd��"
  functionOptProgram="RTEBTCMTYHARDWARELOGK.ASP"
  functionOptPrompt="N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�D�u;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>�X�w�O</center>;<center>�겣�s��</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTEBTCMTYHARDWARE.COMQ1, RTEBTCMTYHARDWARE.LINEQ1, " _
         &"RTEBTCMTYHARDWARE.PRTNO, RTEBTCMTYHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTCMTYHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTEBTCMTYHARDWARE.ASSETNO, RTEBTCMTYHARDWARE.DROPDAT, RTEBTCMTYHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTCMTYHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTCMTYHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTCMTYHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTCMTYHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTCMTYHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTCMTYHARDWARE.PRODNO " _
         &"WHERE RTEBTCMTYHARDWARE.COMQ1=0 "
  dataTable="RTEBTCMTYHARDWARE"
  extTable=""
  numberOfKey=4
  dataProg="RTEBTCMTYHARDWARED.asp"
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
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTEBTCMTYH LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCMTYhardware.ComQ1=" & aryparmkey(0) 
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN 
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTEBTCMTYHARDWARE.COMQ1, RTEBTCMTYHARDWARE.LINEQ1, " _
         &"RTEBTCMTYHARDWARE.PRTNO, RTEBTCMTYHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTCMTYHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTEBTCMTYHARDWARE.ASSETNO, RTEBTCMTYHARDWARE.DROPDAT, RTEBTCMTYHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTCMTYHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTCMTYHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTCMTYHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTCMTYHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTCMTYHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTCMTYHARDWARE.PRODNO " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
