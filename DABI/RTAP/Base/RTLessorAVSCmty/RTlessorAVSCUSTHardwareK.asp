<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�Τ�˾����u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���γ�;��γ����;�]�Ƨ@�o;�@�o����;���ʬd��"
  functionOptProgram="RTLessorAVSCUSTHARDWARETRNRCV.ASP;RTLessorAVSCUSTHARDWARETRNRCVRTN.ASP;RTLessorAVSCUSTHARDWAREDROP.ASP;RTLessorAVSCUSTHARDWAREDROPc.ASP;RTLessorAVSCUSTHARDWARELOGK.ASP"
  functionOptPrompt="Y;Y;Y;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>;�b�ڽs��;�������b�ڤ�;��γ渹;��ε��פ�"
  sqlDelete="SELECT RTLessorAVScustHARDWARE.cusid, " _
         &"RTLessorAVScustHARDWARE.PRTNO, RTLessorAVScustHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTLessorAVScustHARDWARE.QTY, RTLessorAVScustHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVScustHARDWARE.DROPDAT, RTLessorAVScustHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVScustHARDWARE.BATCHNO,RTLessorAVScustHARDWARE.TARDAT,RTLessorAVScustHARDWARE.rcvprtno,RTLessorAVScustHARDWARE.rcvfinishdat " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVScustHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVScustHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVScustHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVScustHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVScustHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVScustHARDWARE.PRODNO " _
         &"left outer join RTLessorAVScust on  RTLessorAVScusthardware.cusid=RTLessorAVScust.cusid " _
         &"WHERE RTLessorAVScustHARDWARE.cusid='' "
  dataTable="RTLessorAVScustHARDWARE"
  extTable=""
  numberOfKey=3
  dataProg="RTLessorAVScustHARDWARED.asp"
  datawindowFeature=""
  searchWindowFeature="width=350,height=160,scrollbars=yes"
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
  searchProg="RTLessorAVSCustHardwareS.ASP"
  '----
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyH ON " _
       &"RTCounty.CUTID = RTLessorAVSCmtyH.CUTID RIGHT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCmtyH.COMQ1 = RTLessorAVSCust.COMQ1 " _
       &"where RTLessorAVSCust.cusid='" & ARYPARMKEY(0) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorAVSCmtyLine.CUTID RIGHT OUTER JOIN " _
       &"RTLessorAVSCust ON RTLessorAVSCmtyLine.COMQ1 = RTLessorAVSCust.COMQ1 AND " _
       &"RTLessorAVSCmtyLine.LINEQ1 = RTLessorAVSCust.LINEQ1 " _
       &"where RTLessorAVSCust.cusid='" & ARYPARMKEY(0) & "'"
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township")
     if rsyy("village") <> "" then
         COMaddr= COMaddr & rsyy("village") & rsyy("cod1")
     end if
     if rsyy("NEIGHBOR") <> "" then
         COMaddr= COMaddr & rsyy("NEIGHBOR") & rsyy("cod2")
     end if
     if rsyy("STREET") <> "" then
         COMaddr= COMaddr & rsyy("STREET") & rsyy("cod3")
     end if
     if rsyy("SEC") <> "" then
         COMaddr= COMaddr & rsyy("SEC") & rsyy("cod4")
     end if
     if rsyy("LANE") <> "" then
         COMaddr= COMaddr & rsyy("LANE") & rsyy("cod5")
     end if
     if rsyy("ALLEYWAY") <> "" then
         COMaddr= COMaddr & rsyy("ALLEYWAY") & rsyy("cod7")
     end if
     if rsyy("NUM") <> "" then
         COMaddr= COMaddr & rsyy("NUM") & rsyy("cod8")
     end if
     if rsyy("FLOOR") <> "" then
         COMaddr= COMaddr & rsyy("FLOOR") & rsyy("cod9")
     end if
     if rsyy("ROOM") <> "" then
         COMaddr= COMaddr & rsyy("ROOM") & rsyy("cod10")
     end if
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select * from RTLessorAVSCUST  where CUSID='" & ARYPARMKEY(0) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     CUSNC=rsYY("CUSNC")
     comq1xx=rsyy("comq1")
     lineq1xx=rsyy("lineq1")
  else
     CUSNC=""
     comq1xx=""
     lineq1xx=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorAVScusthardware.cusid='" & aryparmkey(0) & "' and RTLessorAVScustHARDWARE.prtno='" & aryparmkey(1) & "' and RTLessorAVScustHARDWARE.dropdat is null"
     searchShow="�D�u�J"& comq1xx & "-" & lineq1xx & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�J" & cusnc & ",���u�渹�J" & aryparmkey(1)
  ELSE
     SEARCHFIRST=FALSE
  End If  

  sqlList="SELECT RTLessorAVScustHARDWARE.cusid, " _
         &"RTLessorAVScustHARDWARE.PRTNO, RTLessorAVScustHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.itemnc + '('+ RTProdD1.SPEC+')', RTLessorAVScustHARDWARE.QTY, RTLessorAVScustHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVScustHARDWARE.DROPDAT, RTLessorAVScustHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVScustHARDWARE.BATCHNO,RTLessorAVScustHARDWARE.TARDAT,RTLessorAVScustHARDWARE.rcvprtno,RTLessorAVScustHARDWARE.rcvfinishdat  " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVScustHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVScustHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVScustHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVScustHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVScustHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVScustHARDWARE.PRODNO " _
         &"left outer join RTLessorAVScust on RTLessorAVScusthardware.cusid=RTLessorAVScust.cusid " _
         &"WHERE RTLessorAVScusthardware.cusid='" & aryparmkey(0) & "' and RTLessorAVScustHARDWARE.prtno='" & aryparmkey(1) & "' and " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
