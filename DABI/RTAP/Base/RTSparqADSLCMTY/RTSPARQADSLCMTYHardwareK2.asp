<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL�D�u�]�Ƹ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���ʬd��"
  functionOptProgram="RTSPARQADSLCMTYHARDWARELOGK.ASP"
  functionOptPrompt="N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>�X�w�O</center>;<center>�겣�s��</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTSPARQADSLCMTYHARDWARE.CUTYID, " _
         &"RTSPARQADSLCMTYHARDWARE.PRTNO, RTSPARQADSLCMTYHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTSPARQADSLCMTYHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTSPARQADSLCMTYHARDWARE.ASSETNO, RTSPARQADSLCMTYHARDWARE.DROPDAT, RTSPARQADSLCMTYHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTSPARQADSLCMTYHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTSPARQADSLCMTYHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTSPARQADSLCMTYHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTSPARQADSLCMTYHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTSPARQADSLCMTYHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTSPARQADSLCMTYHARDWARE.PRODNO " _
         &"WHERE RTSPARQADSLCMTYHARDWARE.CUTYID=0 "
  dataTable="RTSPARQADSLCMTYHARDWARE"
  extTable=""
  numberOfKey=3
  dataProg="RTSPARQADSLCMTYHARDWARED.asp"
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
  sqlYY="select * from RTSPARQADSLCMTY where CUTYID=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     TELEADDR=RSYY("TELEADDR")
  else
     COMN=""
     TELEADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSPARQADSLCMTYHARDWARE.CUTYID=" & aryparmkey(0) 
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR 
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTSPARQADSLCMTYHARDWARE.CUTYID, " _
         &"RTSPARQADSLCMTYHARDWARE.PRTNO, RTSPARQADSLCMTYHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTSPARQADSLCMTYHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTSPARQADSLCMTYHARDWARE.ASSETNO, RTSPARQADSLCMTYHARDWARE.DROPDAT, RTSPARQADSLCMTYHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTSPARQADSLCMTYHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTSPARQADSLCMTYHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTSPARQADSLCMTYHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTSPARQADSLCMTYHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTSPARQADSLCMTYHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTSPARQADSLCMTYHARDWARE.PRODNO " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
