<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�D�u�M�u������u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~�����;�C�@�@�L;���u����;�����u����;���ת���;�@�@�@�o;�@�o����;�]�Ʃ���;���v����"
  functionOptProgram="RTLessorAVSCustHardwareRTNK4.ASP;/RTAP/REPORT/AvsCity/RTLessorAVSCmtylineDropSNDWORKPV.asp;RTLessorAVSCmtylineDropsndworkF.asp;RTLessorAVSCmtylineDropsndworkUF.asp;RTLessorAVSCmtylineDropsndworkFR.asp;RTLessorAVSCmtylineDropsndworkdrop.asp;RTLessorAVSCmtylineDropsndworkdropc.asp;RTLessorAVSCmtylineDrophardwareK.asp;RTLessorAVSCmtylineDropsndworkLOGK.asp"
  functionOptPrompt="N;N;Y;N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;�D�u;���u�渹;���u���;�C�L�H��;�w�w�I�u��;��ڬI�u��;���פ�;�����u���פ�;none;none;�����b�ڽs��;none;none;�@�o��;�]�Ƽƶq;�ಾ���ƶq;�w��ƶq;����ƶq"
  sqlDelete="SELECT RTLessorAVSCmtyLineDropSNDWORK.comq1,RTLessorAVSCmtyLineDropSNDWORK.lineq1,RTLessorAVSCmtyLineDropSNDWORK.entryno, RTLessorAVSCmtyLineDropSNDWORK.PRTNO,rtrim(convert(char(6),RTLessorAVSCmtyLineDrop.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineDrop.lineQ1))  as comqline, RTLessorAVSCmtyLineDropSNDWORK.PRTNO, RTLessorAVSCmtyLineDropSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.closedat,RTLessorAVSCmtyLineDropSNDWORK.unclosedat,RTLessorAVSCmtyLineDropSNDWORK.BONUSCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.BONUSFINCHK,RTLessorAVSCmtyLineDropSNDWORK.batchno, RTLessorAVSCmtyLineDropSNDWORK.STOCKCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.STOCKFINCHK, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.DROPDAT FROM RTLessorAVSCmtyLineDropSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTLessorAVSCmtyLineDropSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTLessorAVSCmtyLineDropSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.PRTUSR = RTEmployee.EMPLY left outer join " _
           &"RTLessorAVSCmtyLineDrop on RTLessorAVSCmtyLineDropSNDWORK.comq1=RTLessorAVSCmtyLineDrop.comq1 and RTLessorAVSCmtyLineDrop.lineq1=RTLessorAVSCmtyLineDropSNDWORK.lineq1 and " _
           &"RTLessorAVSCmtyLineDropSNDWORK.entryno=RTLessorAVSCmtyLineDrop.entryno " _
           &"where RTLessorAVSCmtyLineDropSNDWORK.comq1=0 "
  dataTable="RTLessorAVSCmtyLineDropSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="RTLessorAVSCmtyLineDropSNDWORKD.asp"
  datawindowFeature=""
  searchWindowFeature="width=350,height=160,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorAVSCmtyLineDropSNDWORKs.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----
   set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyH ON " _
       &"RTCounty.CUTID = RTLessorAVSCmtyH.CUTID " _
       &"where RTLessorAVSCmtyH.comq1=" & ARYPARMKEY(0) 
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
     searchQry=" RTLessorAVSCmtyLineDropSNDWORK.comq1=" & aryparmkey(0) & " and RTLessorAVSCmtyLineDropSNDWORK.lineq1=" & aryparmkey(1) & " and RTLessorAVSCmtyLineDropSNDWORK.entryno=" & aryparmkey(2) & " and  RTLessorAVSCmtyLineDropSNDWORK.dropdat is null AND RTLessorAVSCmtyLineDropSNDWORK.UNCLOSEDAT IS NULL "
     searchShow="�D�u�Ǹ��J"& aryparmkey(0) &"-" & aryparmkey(1) & ",���ϦW�١J" & COMN & ",�D�u��}�J" & COMADDR
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 then DAreaID="<>'*'"
  
         sqlList="SELECT RTLessorAVSCmtyLineDropSNDWORK.comq1,RTLessorAVSCmtyLineDropSNDWORK.lineq1,RTLessorAVSCmtyLineDropSNDWORK.entryno, RTLessorAVSCmtyLineDropSNDWORK.PRTNO,rtrim(convert(char(6),RTLessorAVSCmtyLineDrop.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineDrop.lineQ1))  as comqline, RTLessorAVSCmtyLineDropSNDWORK.PRTNO, RTLessorAVSCmtyLineDropSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.closedat,RTLessorAVSCmtyLineDropSNDWORK.unclosedat,RTLessorAVSCmtyLineDropSNDWORK.BONUSCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.BONUSFINCHK,RTLessorAVSCmtyLineDropSNDWORK.batchno, RTLessorAVSCmtyLineDropSNDWORK.STOCKCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.STOCKFINCHK, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.DROPDAT,SUM(CASE WHEN RTLessorAVSCmtyLineDropHARDWARE.dropdat IS NULL AND RTLessorAVSCmtyLineDropHARDWARE.QTY > 0 " _
           &"THEN RTLessorAVSCmtyLineDropHARDWARE.QTY ELSE 0 END), SUM(CASE WHEN RTLessorAVSCmtyLineDropHARDWARE.dropdat IS NULL AND " _
           &"RCVPRTNO <> '' THEN RTLessorAVSCmtyLineDropHARDWARE.QTY ELSE 0 END), SUM(CASE WHEN RTLessorAVSCmtyLineDropHARDWARE.dropdat IS NULL " _
           &"AND RCVPRTNO <> '' AND RTLessorAVSCmtyLineDropHARDWARE.rcvfinishdat IS NOT NULL THEN RTLessorAVSCmtyLineDropHARDWARE.QTY ELSE 0 END), " _
           &"SUM(CASE WHEN RTLessorAVSCmtyLineDropHARDWARE.dropdat IS NULL AND RTLessorAVSCmtyLineDropHARDWARE.QTY > 0 THEN RTLessorAVSCmtyLineDropHARDWARE.QTY ELSE 0 END) - " _
           &"SUM(CASE WHEN RTLessorAVSCmtyLineDropHARDWARE.dropdat IS NULL AND RCVPRTNO <> '' AND RTLessorAVSCmtyLineDropHARDWARE.rcvfinishdat IS NOT NULL THEN RTLessorAVSCmtyLineDropHARDWARE.QTY ELSE 0 END) " _
           &"FROM RTLessorAVSCmtyLineDropSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTLessorAVSCmtyLineDropSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTLessorAVSCmtyLineDropSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTLessorAVSCmtyLineDropSNDWORK.PRTUSR = RTEmployee.EMPLY left outer join " _
           &"RTLessorAVSCmtyLineDrop on RTLessorAVSCmtyLineDropSNDWORK.comq1=RTLessorAVSCmtyLineDrop.comq1 and " _
           &"RTLessorAVSCmtyLineDropSNDWORK.lineq1=RTLessorAVSCmtyLineDrop.lineq1 and " _
           &"RTLessorAVSCmtyLineDropSNDWORK.entryno=RTLessorAVSCmtyLineDrop.entryno LEFT OUTER JOIN " _
           &"RTLessorAVSCmtyLineDropHARDWARE ON RTLessorAVSCmtyLineDropSNDWORK.comq1 = RTLessorAVSCmtyLineDropHARDWARE.comq1 AND " _
           &"RTLessorAVSCmtyLineDropSNDWORK.lineq1 = RTLessorAVSCmtyLineDropHARDWARE.lineq1 and " _
           &"RTLessorAVSCmtyLineDropSNDWORK.entryno = RTLessorAVSCmtyLineDropHARDWARE.entryno and " _
           &"RTLessorAVSCmtyLineDropSNDWORK.PRTNO = RTLessorAVSCmtyLineDropHARDWARE.PRTNO " _
           &"where RTLessorAVSCmtyLineDropSNDWORK.comq1=" & aryparmkey(0) & " and RTLessorAVSCmtyLineDropSNDWORK.lineq1=" & aryparmkey(1) & " and RTLessorAVSCmtyLineDropSNDWORK.entryno=" & aryparmkey(2) & " and " & searchqry & " " _
           &"GROUP BY  RTLessorAVSCmtyLineDropSNDWORK.comq1,RTLessorAVSCmtyLineDropSNDWORK.lineq1,RTLessorAVSCmtyLineDropSNDWORK.entryno, RTLessorAVSCmtyLineDropSNDWORK.PRTNO, " _
           &"rtrim(CONVERT(char(6), RTLessorAVSCmtyLineDrop.COMQ1)) + '-' + rtrim(CONVERT(char(6), RTLessorAVSCmtyLineDrop.lineQ1)), " _
           &"RTLessorAVSCmtyLineDropSNDWORK.PRTNO, RTLessorAVSCmtyLineDropSNDWORK.SENDWORKDAT, RTOBJ.CUSNC, " _
           &"CASE WHEN RTOBJ_2.SHORTNC <> '' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END, " _
           &"CASE WHEN RTOBJ_4.SHORTNC <> '' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, RTLessorAVSCmtyLineDropSNDWORK.closedat, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.unclosedat, RTLessorAVSCmtyLineDropSNDWORK.BONUSCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.BONUSFINCHK, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.batchno, RTLessorAVSCmtyLineDropSNDWORK.STOCKCLOSEYM, RTLessorAVSCmtyLineDropSNDWORK.STOCKFINCHK, " _
           &"RTLessorAVSCmtyLineDropSNDWORK.DROPDAT "

   'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>