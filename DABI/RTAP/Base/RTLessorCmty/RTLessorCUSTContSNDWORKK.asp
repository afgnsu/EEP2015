<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�Τ�������ڬ��u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~��γ�; �C �L ;���u����;�����u����;���ת���; �@ �o ;�@�o����;�]�Ʃ���;���v����"
  functionOptProgram="RTLessorCustcontHardwareRCVK.ASP;/RTAP/REPORT/ETCity/RTLessorCustContSNDWORKPV.asp;RTLessorCustContsndworkF.asp;RTLessorCustContsndworkUF.asp;RTLessorCustContsndworkFR.asp;RTLessorCustContSNDWORKdrop.asp;RTLessorCustContSNDWORKdropc.asp;RTLessorCustCONThardwareK.asp;RTLessorCustContSNDWORKLOGK.asp"
  functionOptPrompt="N;N;Y;Y;Y;Y;Y;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;���u�渹;���u���;�C�L�H��;�w�w�I�u��;��ڬI�u��;���פ�;�����u���פ�;none;none;�����b�ڽs��;none;none;�@�o��;�]�Ƽƶq;���γ�ƶq;�w��ƶq;�ݻ�ƶq"
  sqlDelete="SELECT RTLessorCustContSNDWORK.CUSID, RTLessorCustContSNDWORK.ENTRYNO, RTLessorCustContSNDWORK.PRTNO,rtrim(convert(char(6),rtlessorcust.COMQ1)) +'-'+ rtrim(convert(char(6),rtlessorcust.lineQ1))  as comqline, RTLessorCustContSNDWORK.PRTNO, RTLessorCustContSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"RTLessorCustContSNDWORK.closedat,RTLessorCustContSNDWORK.unclosedat,RTLessorCustContSNDWORK.BONUSCLOSEYM, RTLessorCustContSNDWORK.BONUSFINCHK,RTLessorCustContSNDWORK.batchno, RTLessorCustContSNDWORK.STOCKCLOSEYM, RTLessorCustContSNDWORK.STOCKFINCHK, " _
           &"RTLessorCustContSNDWORK.DROPDAT FROM RTLessorCustContSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTLessorCustContSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTLessorCustContSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTLessorCustContSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorCustContSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTLessorCustContSNDWORK.PRTUSR = RTEmployee.EMPLY left outer join rtlessorcmtyline on " _
           &"RTLessorCustContSNDWORK.cusid=rtlessorcust.cusid where RTLessorCustContSNDWORK.cusid=''" 
  dataTable="RTLessorCustContSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTLessorCustContSNDWORKD.asp"
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
  searchProg="RTLessorCustcontSNDWORKs.asp"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyH ON " _
       &"RTCounty.CUTID = RTLessorCmtyH.CUTID RIGHT OUTER JOIN RTLessorCust ON RTLessorCmtyH.COMQ1 = RTLessorCust.COMQ1 " _
       &"where RTLessorCust.cusid='" & ARYPARMKEY(0) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorCmtyLine.CUTID RIGHT OUTER JOIN " _
       &"RTLessorCust ON RTLessorCmtyLine.COMQ1 = RTLessorCust.COMQ1 AND " _
       &"RTLessorCmtyLine.LINEQ1 = RTLessorCust.LINEQ1 " _
       &"where RTLessorCust.cusid='" & ARYPARMKEY(0) & "'"
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
  sqlYY="select * from RTLESSORCUST  where CUSID='" & ARYPARMKEY(0) & "' "
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
     searchQry=" RTLessorCustContSNDWORK.cusid='" & aryparmkey(0) & "' and RTLessorCustContSNDWORK.entryno=" & aryparmkey(1) & " and RTLessorCustContSNDWORK.dropdat is null and RTLessorCustContSNDWORK.unclosedat is null "
     searchShow="�D�u�Ǹ��J"& comq1xx &"-" & lineq1xx & ",���ϦW�١J" & COMN & ",�Τ�W�١J" & cusnc & ",�D�u��}�J" & COMADDR
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
  

         sqlList="SELECT RTLessorCustContSNDWORK.CUSID, RTLessorCustContSNDWORK.ENTRYNO, RTLessorCustContSNDWORK.PRTNO,rtrim(convert(char(6),rtlessorcust.COMQ1)) +'-'+ rtrim(convert(char(6),rtlessorcust.lineQ1))  as comqline, RTLessorCustContSNDWORK.PRTNO, RTLessorCustContSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"RTLessorCustContSNDWORK.closedat,RTLessorCustContSNDWORK.unclosedat,RTLessorCustContSNDWORK.BONUSCLOSEYM, RTLessorCustContSNDWORK.BONUSFINCHK,RTLessorCustContSNDWORK.batchno, RTLessorCustContSNDWORK.STOCKCLOSEYM, RTLessorCustContSNDWORK.STOCKFINCHK, " _
           &"RTLessorCustContSNDWORK.DROPDAT ,SUM(CASE WHEN RTLessorCustcontHARDWARE.dropdat IS NULL AND RTLessorCustcontHARDWARE.QTY > 0 " _
           &"THEN RTLessorCustcontHARDWARE.QTY ELSE 0 END), SUM(CASE WHEN RTLessorCustcontHARDWARE.dropdat IS NULL AND " _
           &"RCVPRTNO <> '' THEN RTLessorCustcontHARDWARE.QTY ELSE 0 END), SUM(CASE WHEN RTLessorCustcontHARDWARE.dropdat IS NULL " _
           &"AND RCVPRTNO <> '' AND RTLessorCustcontHARDWARE.rcvfinishdat IS NOT NULL THEN RTLessorCustcontHARDWARE.QTY ELSE 0 END), " _
           &"SUM(CASE WHEN RTLessorCustcontHARDWARE.dropdat IS NULL AND RTLessorCustcontHARDWARE.QTY > 0 THEN RTLessorCustcontHARDWARE.QTY ELSE 0 END) - " _
           &"SUM(CASE WHEN RTLessorCustcontHARDWARE.dropdat IS NULL AND RCVPRTNO <> '' AND RTLessorCustcontHARDWARE.rcvfinishdat IS NOT NULL THEN RTLessorCustcontHARDWARE.QTY ELSE 0 END) " _
           &"FROM RTLessorCustContSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTLessorCustContSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTLessorCustContSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTLessorCustContSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorCustContSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTLessorCustContSNDWORK.PRTUSR = RTEmployee.EMPLY left outer join rtlessorcust on " _
           &"RTLessorCustContSNDWORK.cusid=rtlessorcust.cusid LEFT OUTER JOIN " _
           &"RTLessorCustcontHARDWARE ON RTLessorCustContSNDWORK.cusid = RTLessorCustcontHARDWARE.CUSID AND " _
           &"RTLessorCustContSNDWORK.PRTNO = RTLessorCustcontHARDWARE.PRTNO " _
            &"where  RTLessorCustContSNDWORK.cusid='" & aryparmkey(0) & "' and RTLessorCustContSNDWORK.entryno=" & aryparmkey(1) & " and " & searchqry & " " _
           &"GROUP BY  RTLessorCustContSNDWORK.CUSID, RTLessorCustContSNDWORK.ENTRYNO, RTLessorCustContSNDWORK.PRTNO, " _
           &"rtrim(CONVERT(char(6), rtlessorcust.COMQ1)) + '-' + rtrim(CONVERT(char(6), rtlessorcust.lineQ1)), " _
           &"RTLessorCustContSNDWORK.PRTNO, RTLessorCustContSNDWORK.SENDWORKDAT, RTOBJ.CUSNC, " _
           &"CASE WHEN RTOBJ_2.SHORTNC <> '' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END, " _
           &"CASE WHEN RTOBJ_4.SHORTNC <> '' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, RTLessorCustContSNDWORK.closedat, " _
           &"RTLessorCustContSNDWORK.unclosedat, RTLessorCustContSNDWORK.BONUSCLOSEYM, RTLessorCustContSNDWORK.BONUSFINCHK, " _
           &"RTLessorCustContSNDWORK.batchno, RTLessorCustContSNDWORK.STOCKCLOSEYM, RTLessorCustContSNDWORK.STOCKFINCHK, " _
           &"RTLessorCustContSNDWORK.DROPDAT "

  'end if
'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>