<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�D�u���׬��u�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���γ�;�����γ�; �@�@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTlessorCmtyLineFaqHARDWARETRNRCV.ASP;RTlessorCmtyLineFaqHARDWARETRNRCVRTN.ASP;RTlessorCmtyLineFaqHARDWAREDROP.ASP;RTlessorCmtyLineFaqHARDWAREDROPc.ASP;RTlessorCmtyLineFaqHARDWARELOGK.ASP"
  functionOptPrompt="Y;Y;Y;Y;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>;�b�ڽs��;�������b�ڤ�;��γ渹;��ε��פ�"
  sqlDelete="SELECT RTlessorCmtyLineFaqHARDWARE.COMQ1,RTlessorCmtyLineFaqHARDWARE.LINEQ1, " _
         &"RTlessorCmtyLineFaqHARDWARE.faqno,RTlessorCmtyLineFaqHARDWARE.PRTNO, RTlessorCmtyLineFaqHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTlessorCmtyLineFaqHARDWARE.QTY, RTlessorCmtyLineFaqHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTlessorCmtyLineFaqHARDWARE.DROPDAT, RTlessorCmtyLineFaqHARDWARE.DROPREASON, RTObj.CUSNC,RTlessorCmtyLineFaqHARDWARE.BATCHNO,RTlessorCmtyLineFaqHARDWARE.TARDAT,RTlessorCmtyLineFaqHARDWARE.rcvprtno,RTlessorCmtyLineFaqHARDWARE.rcvfinishdat " _
         &"FROM RTProdH RIGHT OUTER JOIN RTlessorCmtyLineFaqHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTlessorCmtyLineFaqHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTlessorCmtyLineFaqHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTlessorCmtyLineFaqHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTlessorCmtyLineFaqHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTlessorCmtyLineFaqHARDWARE.PRODNO " _
         &"left outer join RTlessorCmtyLine on RTlessorCmtyLineFaqHARDWARE.comq1=RTlessorCmtyLine.comq1 " _
         &"WHERE RTlessorCmtyLineFaqHARDWARE.comq1=0 "
  dataTable="RTlessorCmtyLineFaqHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="RTlessorCmtyLineFaqHARDWARED.asp"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyH ON " _
       &"RTCounty.CUTID = RTLessorCmtyH.CUTID RIGHT OUTER JOIN RTlessorCmtyLine ON RTLessorCmtyH.COMQ1 = RTlessorCmtyLine.COMQ1 " _
       &"where RTlessorCmtyLine.comq1=" & ARYPARMKEY(0) 
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorCmtyLine.CUTID " _
       &"where RTlessorCmtyLine.comq1=" & ARYPARMKEY(0) & " and RTlessorCmtyLine.lineq1=" & ARYPARMKEY(1)
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
     searchQry=" RTlessorCmtyLineFaqHARDWARE.comq1=" & aryparmkey(0) & " and RTlessorCmtyLineFaqHARDWARE.lineq1=" & aryparmkey(1) & " and RTlessorCmtyLineFaqHARDWARE.faqno='" & aryparmkey(2) & "' "
     searchShow="�D�u�J"& aryparmkey(0) & "-" & aryparmkey(1) & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�J" & cusnc & ",�ȪA�渹�J" & aryparmkey(2)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTlessorCmtyLineFaqHARDWARE.comq1,RTlessorCmtyLineFaqHARDWARE.lineq1, " _
         &"RTlessorCmtyLineFaqHARDWARE.faqno,RTlessorCmtyLineFaqHARDWARE.PRTNO, RTlessorCmtyLineFaqHARDWARE.seq, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.itemnc + '('+ RTProdD1.SPEC+')', RTlessorCmtyLineFaqHARDWARE.QTY, RTlessorCmtyLineFaqHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTlessorCmtyLineFaqHARDWARE.DROPDAT, RTlessorCmtyLineFaqHARDWARE.DROPREASON, RTObj.CUSNC,RTlessorCmtyLineFaqHARDWARE.BATCHNO,RTlessorCmtyLineFaqHARDWARE.TARDAT,RTlessorCmtyLineFaqHARDWARE.rcvprtno,RTlessorCmtyLineFaqHARDWARE.rcvfinishdat  " _
         &"FROM RTProdH RIGHT OUTER JOIN RTlessorCmtyLineFaqHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTlessorCmtyLineFaqHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTlessorCmtyLineFaqHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTlessorCmtyLineFaqHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTlessorCmtyLineFaqHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTlessorCmtyLineFaqHARDWARE.PRODNO " _
         &"left outer join RTlessorCmtyLine on  RTlessorCmtyLineFaqHARDWARE.comq1=RTlessorCmtyLine.comq1 and RTlessorCmtyLineFaqHARDWARE.lineq1=RTlessorCmtyLine.lineq1 " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
