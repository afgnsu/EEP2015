<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�Τ���׬��u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���γ�;�����γ�; �@�@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTLessorAVSCustFaqHARDWARETRNRCV.ASP;RTLessorAVSCustFaqHARDWARETRNRCVRTN.ASP;RTLessorAVSCustFaqHARDWAREDROP.ASP;RTLessorAVSCustFaqHARDWAREDROPc.ASP;RTLessorAVSCustFaqHARDWARELOGK.ASP"
  functionOptPrompt="Y;Y;Y;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>;�b�ڽs��;�������b�ڤ�;��γ渹;��ε��פ�"
  sqlDelete="SELECT RTLessorAVSCustFaqHARDWARE.cusid, " _
         &"RTLessorAVSCustFaqHARDWARE.faqno,RTLessorAVSCustFaqHARDWARE.PRTNO, RTLessorAVSCustFaqHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTLessorAVSCustFaqHARDWARE.QTY, RTLessorAVSCustFaqHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVSCustFaqHARDWARE.DROPDAT, RTLessorAVSCustFaqHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVSCustFaqHARDWARE.BATCHNO,RTLessorAVSCustFaqHARDWARE.TARDAT,RTLessorAVSCustFaqHARDWARE.rcvprtno,RTLessorAVSCustFaqHARDWARE.rcvfinishdat " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVSCustFaqHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVSCustFaqHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVSCustFaqHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVSCustFaqHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVSCustFaqHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVSCustFaqHARDWARE.PRODNO " _
         &"left outer join RTLessorAVScust on RTLessorAVSCustFaqHARDWARE.cusid=RTLessorAVScust.cusid " _
         &"WHERE RTLessorAVSCustFaqHARDWARE.cusid='' "
  dataTable="RTLessorAVSCustFaqHARDWARE"
  extTable=""
  numberOfKey=4
  dataProg="RTLessorAVSCustFaqHARDWARED.asp"
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
     searchQry=" RTLessorAVSCustFaqHARDWARE.cusid='" & aryparmkey(0) & "' and RTLessorAVSCustFaqHARDWARE.faqno='" & aryparmkey(1) & "' and RTLessorAVSCustFaqHARDWARE.prtno='" & aryparmkey(2) & "' "
     searchShow="�D�u�J"& comq1xx & "-" & lineq1xx & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�J" & cusnc & ",���u�渹�J" & aryparmkey(2)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTLessorAVSCustFaqHARDWARE.cusid, " _
         &"RTLessorAVSCustFaqHARDWARE.faqno,RTLessorAVSCustFaqHARDWARE.PRTNO, RTLessorAVSCustFaqHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.itemnc + '('+ RTProdD1.SPEC+')', RTLessorAVSCustFaqHARDWARE.QTY, RTLessorAVSCustFaqHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTLessorAVSCustFaqHARDWARE.DROPDAT, RTLessorAVSCustFaqHARDWARE.DROPREASON, RTObj.CUSNC,RTLessorAVSCustFaqHARDWARE.BATCHNO,RTLessorAVSCustFaqHARDWARE.TARDAT,RTLessorAVSCustFaqHARDWARE.rcvprtno,RTLessorAVSCustFaqHARDWARE.rcvfinishdat  " _
         &"FROM RTProdH RIGHT OUTER JOIN RTLessorAVSCustFaqHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTLessorAVSCustFaqHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTLessorAVSCustFaqHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTLessorAVSCustFaqHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTLessorAVSCustFaqHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTLessorAVSCustFaqHARDWARE.PRODNO " _
         &"left outer join RTLessorAVScust on  RTLessorAVSCustFaqHARDWARE.cusid=RTLessorAVScust.cusid " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
