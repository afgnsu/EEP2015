<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τ�M2��O����]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;<center>����u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTEBTcustM2M3SNDWORKHARDWARE.AVSNO, RTEBTcustM2M3SNDWORKHARDWARE.M2M3, RTEBTcustM2M3SNDWORKHARDWARE.seqx, " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.PRTNO, RTEBTcustM2M3SNDWORKHARDWARE.SEQ, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTcustM2M3SNDWORKHARDWARE.QTY, RTEBTcustM2M3SNDWORKHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustM2M3SNDWORKHARDWARE.DROPDAT, RTEBTcustM2M3SNDWORKHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustM2M3SNDWORKHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustM2M3SNDWORKHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustM2M3SNDWORKHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustM2M3SNDWORKHARDWARE.PRODNO " _
         &"WHERE RTEBTcustM2M3SNDWORKHARDWARE.AVSNO=0 "
  dataTable="RTEBTcustM2M3SNDWORKHARDWARE"
  extTable=""
  numberOfKey=4
  dataProg="RTEBTcustM2M3SNDWORKHARDWARED.asp"
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
     searchQry=" RTEBTcustM2M3SNDWORKHARDWARE.AVSNO='" & aryparmkey(0) & "' and RTEBTcustM2M3SNDWORKHARDWARE.M2M3='" & aryparmkey(1) & "'  and RTEBTcustM2M3SNDWORKHARDWARE.seqx=" & aryparmkey(2) & " and RTEBTcustM2M3SNDWORKHARDWARE.prtno='" & aryparmkey(3) & "' "
     searchShow="�X���s���J"& aryparmkey(0) & ",����渹�J" &  aryparmkey(2)  
  ELSE
     SEARCHFIRST=FALSE
  End If  
 sqlList="SELECT RTEBTcustM2M3SNDWORKHARDWARE.AVSNO, RTEBTcustM2M3SNDWORKHARDWARE.M2M3,RTEBTcustM2M3SNDWORKHARDWARE.seqx, " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.PRTNO, RTEBTcustM2M3SNDWORKHARDWARE.SEQ, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTcustM2M3SNDWORKHARDWARE.QTY, RTEBTcustM2M3SNDWORKHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustM2M3SNDWORKHARDWARE.DROPDAT, RTEBTcustM2M3SNDWORKHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustM2M3SNDWORKHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustM2M3SNDWORKHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustM2M3SNDWORKHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustM2M3SNDWORKHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustM2M3SNDWORKHARDWARE.PRODNO " _
                  &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
