<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�D�u������u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�ಾ���;���ಾ���; �@�@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTLessorAVSCmtyLineDROPHARDWARETRNrtn.ASP;RTLessorAVSCmtyLineDROPHARDWARETRNrtnRTN.ASP;RTLessorAVSCmtyLineDROPHARDWAREDROP.ASP;RTLessorAVSCmtyLineDROPHARDWAREDROPc.ASP;RTLessorAVSCmtyLineDROPHARDWARELOGK.ASP"
  functionOptPrompt="Y;Y;Y;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>;�b�ڽs��;�������b�ڤ�;����渹;���൲�פ�"
  sqlDelete="SELECT RTLessorAVSCmtyLineDropHARDWARE.COMQ1,RTLessorAVSCmtyLineDropHARDWARE.LINEQ1, " _
         &"RTLessorAVSCmtyLineDropHARDWARE.ENTRYNO,RTLessorAVSCmtyLineDropHARDWARE.PRTNO, RTLessorAVSCmtyLineDropHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTLessorAVSCmtyLineDropHARDWARE.QTY, RTLessorAVSCmtyLineDropHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVSCmtyLineDropHARDWARE.DROPDAT, RTLessorAVSCmtyLineDropHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVSCmtyLineDropHARDWARE.BATCHNO,RTLessorAVSCmtyLineDropHARDWARE.TARDAT,RTLessorAVSCmtyLineDropHARDWARE.rcvprtno,RTLessorAVSCmtyLineDropHARDWARE.rcvfinishdat " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVSCmtyLineDropHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVSCmtyLineDropHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVSCmtyLineDropHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVSCmtyLineDropHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVSCmtyLineDropHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVSCmtyLineDropHARDWARE.PRODNO " _
         &"left outer join RTLessorAVSCmtyLine on RTLessorAVSCmtyLineDropHARDWARE.comq1=RTLessorAVSCmtyLine.comq1 " _
         &"WHERE RTLessorAVSCmtyLineDropHARDWARE.comq1=0 "
  dataTable="RTLessorAVSCmtyLineDropHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="RTLessorAVSCmtyLineDropHARDWARED.asp"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyH ON " _
       &"RTCounty.CUTID = RTLessorAVSCmtyH.CUTID RIGHT OUTER JOIN RTLessorAVSCmtyLine ON RTLessorAVSCmtyH.COMQ1 = RTLessorAVSCmtyLine.COMQ1 " _
       &"where RTLessorAVSCmtyLine.comq1=" & ARYPARMKEY(0) 
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorAVSCmtyLine.CUTID " _
       &"where RTLessorAVSCmtyLine.comq1=" & ARYPARMKEY(0) & " and RTLessorAVSCmtyLine.lineq1=" & ARYPARMKEY(1)
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
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorAVSCmtyLineDropHARDWARE.comq1=" & aryparmkey(0) & " and RTLessorAVSCmtyLineDropHARDWARE.lineq1=" & aryparmkey(1) & " and RTLessorAVSCmtyLineDropHARDWARE.ENTRYNO=" & aryparmkey(2) & " and RTLessorAVSCmtyLineDropHARDWARE.prtno='" & aryparmkey(3) & "' "
     searchShow="�D�u�J"& aryparmkey(0) & "-" & aryparmkey(1) & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR  & ",������u�渹�J" & aryparmkey(3)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTLessorAVSCmtyLineDropHARDWARE.comq1,RTLessorAVSCmtyLineDropHARDWARE.lineq1, " _
         &"RTLessorAVSCmtyLineDropHARDWARE.ENTRYNO,RTLessorAVSCmtyLineDropHARDWARE.PRTNO, RTLessorAVSCmtyLineDropHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.itemnc + '('+ RTProdD1.SPEC+')', RTLessorAVSCmtyLineDropHARDWARE.QTY, RTLessorAVSCmtyLineDropHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVSCmtyLineDropHARDWARE.DROPDAT, RTLessorAVSCmtyLineDropHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVSCmtyLineDropHARDWARE.BATCHNO,RTLessorAVSCmtyLineDropHARDWARE.TARDAT,RTLessorAVSCmtyLineDropHARDWARE.rcvprtno,RTLessorAVSCmtyLineDropHARDWARE.rcvfinishdat  " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVSCmtyLineDropHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVSCmtyLineDropHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVSCmtyLineDropHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVSCmtyLineDropHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVSCmtyLineDropHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVSCmtyLineDropHARDWARE.PRODNO " _
         &"left outer join RTLessorAVSCmtyLine on  RTLessorAVSCmtyLineDropHARDWARE.comq1=RTLessorAVSCmtyLine.comq1 and RTLessorAVSCmtyLineDropHARDWARE.lineq1=RTLessorAVSCmtyLine.lineq1 " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
