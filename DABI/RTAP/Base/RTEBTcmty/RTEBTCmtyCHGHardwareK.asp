<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u���ʳ]�Ƹ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=" �@�o ; �@�o����;���ʬd��"
  functionOptProgram="RTEBTCMTYCHGHARDWAREDROP.ASP;RTEBTCMTYCHGHARDWAREDROPc.ASP;RTEBTCMTYCHGHARDWARELOGK.ASP"
  functionOptPrompt="N;N;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;<center>���ʳ渹</center>;<center>���u�渹</center>;<center>����</center>;<center>�]�ƦW��/�W��</center>;<center>�ƶq</center>;<center>�X�w�O</center>;<center>�겣�s��</center>;<center>�@�o���</center>;<center>�@�o��]</center>;<center>�@�o�H��</center>"
  sqlDelete="SELECT RTEBTCMTYCHGHARDWARE.COMQ1, RTEBTCMTYCHGHARDWARE.LINEQ1, " _
         &"RTEBTCMTYCHGHARDWARE.PRTNO,RTEBTCMTYCHGHARDWARE.PRTNO2, RTEBTCMTYCHGHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTCMTYCHGHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTEBTCMTYCHGHARDWARE.ASSETNO, RTEBTCMTYCHGHARDWARE.DROPDAT, RTEBTCMTYCHGHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTCMTYCHGHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTCMTYCHGHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTCMTYCHGHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTCMTYCHGHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTCMTYCHGHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTCMTYCHGHARDWARE.PRODNO " _
         &"WHERE RTEBTCMTYCHGHARDWARE.COMQ1=0 "
  dataTable="RTEBTCMTYCHGHARDWARE"
  extTable=""
  numberOfKey=5
  dataProg="RTEBTCMTYCHGHARDWARED.asp"
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
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCMTYCHGHARDWARE.ComQ1=" & aryparmkey(0) & " and RTEBTCMTYCHGHARDWARE.lineq1=" & aryparmkey(1) & " and RTEBTCMTYCHGHARDWARE.prtno='" & aryparmkey(2) & "' and RTEBTCMTYCHGHARDWARE.prtno2='" & aryparmkey(3) & "' "
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN &",�D�u�Ǹ��J" & aryparmkey(1) & ",�D�u��}�J" & COMADDR & ",���ʳ渹�J" & aryparmkey(2) & ",���u�渹�J" & aryparmkey(3)
  ELSE
     SEARCHFIRST=FALSE
  End If  
  searchProg="self"
  sqlList="SELECT RTEBTCMTYCHGHARDWARE.COMQ1, RTEBTCMTYCHGHARDWARE.LINEQ1, " _
         &"RTEBTCMTYCHGHARDWARE.PRTNO,RTEBTCMTYCHGHARDWARE.PRTNO2, RTEBTCMTYCHGHARDWARE.ENTRYNO, " _
         &"RTProdH.PRODNC + '--' + RTProdD1.SPEC, RTEBTCMTYCHGHARDWARE.QTY, " _
         &"HBwarehouse.WARENAME, RTEBTCMTYCHGHARDWARE.ASSETNO, RTEBTCMTYCHGHARDWARE.DROPDAT, RTEBTCMTYCHGHARDWARE.DROPREASON, RTObj.CUSNC " _
         &"FROM RTProdH RIGHT OUTER JOIN RTEBTCMTYCHGHARDWARE LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
         &"RTEBTCMTYCHGHARDWARE.DROPUSR = RTEmployee.EMPLY LEFT OUTER JOIN " _
         &"HBwarehouse ON RTEBTCMTYCHGHARDWARE.WAREHOUSE = HBwarehouse.WAREHOUSE LEFT OUTER " _
         &"JOIN RTProdD1 ON RTEBTCMTYCHGHARDWARE.PRODNO = RTProdD1.PRODNO AND " _
         &"RTEBTCMTYCHGHARDWARE.ITEMNO = RTProdD1.ITEMNO ON RTProdH.PRODNO = RTEBTCMTYCHGHARDWARE.PRODNO " _
         &"WHERE " &searchQry & ""
'Response.Write "sql=" & SQLLIST         
End Sub
%>
