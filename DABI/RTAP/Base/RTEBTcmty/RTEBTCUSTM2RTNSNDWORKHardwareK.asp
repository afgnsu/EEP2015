<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τ�M2�_���]�Ƹ�ƺ��@"
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
  formatName="none;none;none;<center>�_���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTEBTcustM2RTNSNDWORKHARDWARE.AVSNO, RTEBTcustM2RTNSNDWORKHARDWARE.M2M3, RTEBTcustM2RTNSNDWORKHARDWARE.seqx, " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.RTNNO, RTEBTcustM2RTNSNDWORKHARDWARE.SEQ, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTcustM2RTNSNDWORKHARDWARE.QTY, RTEBTcustM2RTNSNDWORKHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustM2RTNSNDWORKHARDWARE.DROPDAT, RTEBTcustM2RTNSNDWORKHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustM2RTNSNDWORKHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustM2RTNSNDWORKHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustM2RTNSNDWORKHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustM2RTNSNDWORKHARDWARE.PRODNO " _
         &"WHERE RTEBTcustM2RTNSNDWORKHARDWARE.AVSNO=0 "
  dataTable="RTEBTcustM2RTNSNDWORKHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="RTEBTcustM2RTNSNDWORKHARDWARED.asp"
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
     searchQry=" RTEBTcustM2RTNSNDWORKHARDWARE.AVSNO='" & aryparmkey(0) & "' and RTEBTcustM2RTNSNDWORKHARDWARE.M2M3='" & aryparmkey(1) & "' and RTEBTcustM2RTNSNDWORKHARDWARE.seqx=" & aryparmkey(2) & " and RTEBTcustM2RTNSNDWORKHARDWARE.RTNNO='" & aryparmkey(3) & "' "
     searchShow="�X���s���J"& aryparmkey(0) & ",����渹�J" &  aryparmkey(2)  
  ELSE
     SEARCHFIRST=FALSE
  End If  
 sqlList="SELECT RTEBTcustM2RTNSNDWORKHARDWARE.AVSNO, RTEBTcustM2RTNSNDWORKHARDWARE.M2M3, RTEBTcustM2RTNSNDWORKHARDWARE.seqx, " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.RTNNO, RTEBTcustM2RTNSNDWORKHARDWARE.SEQ, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTcustM2RTNSNDWORKHARDWARE.QTY, RTEBTcustM2RTNSNDWORKHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustM2RTNSNDWORKHARDWARE.DROPDAT, RTEBTcustM2RTNSNDWORKHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustM2RTNSNDWORKHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustM2RTNSNDWORKHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustM2RTNSNDWORKHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustM2RTNSNDWORKHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustM2RTNSNDWORKHARDWARE.PRODNO " _
                  &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
