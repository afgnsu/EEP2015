<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="HI-Building�D�u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=" �@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTcmtyHARDWAREDROP.ASP;RTcmtyHARDWAREDROPc.ASP;RTcmtyHARDWARELOGK.ASP"
  functionOptPrompt="N;N;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>�X�w�O</center>;<center>�겣�s��</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTcmtyHARDWARE.COMQ1, " _
         &"RTcmtyHARDWARE.PRTNO, RTcmtyHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTcmtyHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTcmtyHARDWARE.ASSETNO, RTcmtyHARDWARE.DROPDAT, RTcmtyHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTcmtyHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTcmtyHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTcmtyHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTcmtyHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTcmtyHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTcmtyHARDWARE.PRODNO " _
         &"WHERE RTcmtyHARDWARE.COMQ1=0 "
  dataTable="RTcmtyHARDWARE"
  extTable=""
  numberOfKey=3
  dataProg="RTcmtyHARDWARED.asp"
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
  sqlYY="select * from rtcmty LEFT OUTER JOIN RTCOUNTY ON RTCMTY.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     TELEADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("ADDR")
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
     searchQry=" RTcmtyHARDWARE.COMQ1=" & aryparmkey(0)  & " and RTcmtyHARDWARE.prtno='" & aryparmkey(1) & "' "
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",�q�H�Ǧ�m�J" & COMADDR & ",���u�渹�J" & aryparmkey(1)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTcmtyHARDWARE.COMQ1, " _
         &"RTcmtyHARDWARE.PRTNO, RTcmtyHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTcmtyHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTcmtyHARDWARE.ASSETNO, RTcmtyHARDWARE.DROPDAT, RTcmtyHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTcmtyHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTcmtyHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTcmtyHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTcmtyHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTcmtyHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTcmtyHARDWARE.PRODNO " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
