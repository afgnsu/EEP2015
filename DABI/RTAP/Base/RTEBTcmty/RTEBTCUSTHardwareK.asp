<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τ�]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=" �@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTEBTCUSTHARDWAREDROP.ASP;RTEBTCUSTHARDWAREDROPc.ASP;RTEBTCUSTHARDWARELOGK.ASP"
  functionOptPrompt="N;N;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>���B</center>;<center>�X�w�O</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTEBTcustHARDWARE.COMQ1, RTEBTcustHARDWARE.LINEQ1, RTEBTcustHARDWARE.cusid, " _
         &"RTEBTcustHARDWARE.PRTNO, RTEBTcustHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTcustHARDWARE.QTY, RTEBTcustHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustHARDWARE.DROPDAT, RTEBTcustHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustHARDWARE.PRODNO " _
         &"left outer join rtebtcust on rtebtcusthardware.comq1=rtebtcust.comq1 and rtebtcusthardware.lineq1=rtebtcust.lineq1 " _
         &"and rtebtcusthardware.cusid=rtebtcust.cusid " _
         &"WHERE RTEBTcustHARDWARE.COMQ1=0 "
  dataTable="RTEBTcustHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="RTEBTcustHARDWARED.asp"
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
  sqlYY="select * from RTEBTCMTYline LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYline.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
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
  rsYY.Close
  sqlYY="select * from RTEBTcust where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1) & " and cusid='" & aryparmkey(2) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     cusnc=rsyy("cusnc")
  else
     cusnc=""
  end if
  rsyy.close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTcustHARDWARE.ComQ1=" & aryparmkey(0) & " and RTEBTcustHARDWARE.lineq1=" & aryparmkey(1) & " and rtebtcusthardware.cusid='" & aryparmkey(2) & "' and RTEBTcustHARDWARE.prtno='" & aryparmkey(3) & "' "
     searchShow="�D�u�J"& aryparmkey(0) & "-" & aryparmkey(1) & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�J" & cusnc & ",���u�渹�J" & aryparmkey(3)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTEBTcustHARDWARE.COMQ1, RTEBTcustHARDWARE.LINEQ1, RTEBTcustHARDWARE.cusid, " _
         &"RTEBTcustHARDWARE.PRTNO, RTEBTcustHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.itemnc + '('+ RTProdD1.SPEC+')', RTEBTcustHARDWARE.QTY, RTEBTcustHARDWARE.amt, " _
         &"HBwarehouse.WARENAME, RTEBTcustHARDWARE.DROPDAT, RTEBTcustHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTcustHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTcustHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTcustHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTcustHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTcustHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTcustHARDWARE.PRODNO " _
         &"left outer join rtebtcust on rtebtcusthardware.comq1=rtebtcust.comq1 and rtebtcusthardware.lineq1=rtebtcust.lineq1 " _
         &"and rtebtcusthardware.cusid=rtebtcust.cusid " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
