<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τᵤ�u�T�{���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �C �L ;���u����;�����u����;���ת���; �@ �o ;�@�o����;�]�Ʃ���;���v����"
  functionOptProgram="\RTAP\BASE\RTEBTCMTY\RTEBTCUSTSNDWORKPV.asp;rtebtCUSTsndworkF.asp;rtebtCUSTsndworkUF.asp;rtebtCUSTsndworkFR.asp;rtebtCUSTsndworkdrop.asp;rtebtCUSTsndworkdropc.asp;rtEBTCUSThardwareK.asp;rtEBTCUSTsndworkLOGK.asp"
  functionOptPrompt="N;Y;N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;�D�u;���u�渹;���u���;�C�L�H��;�w�w�I�u��;��ڬI�u��;���פ�;���������;�����f�֤�;�w�s�����;�w�s�f�֤�;�@�o��"
  sqlDelete="SELECT RTEBTCUSTSNDWORK.COMQ1, RTEBTCUSTSNDWORK.LINEQ1, RTEBTCUSTSNDWORK.CUSID, RTEBTCUSTSNDWORK.PRTNO,rtrim(convert(char(6),RTEBTCUSTSNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORK.lineQ1))  as comqline, RTEBTCUSTSNDWORK.PRTNO, RTEBTCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"case when RTEBTCUSTSNDWORK.closedat is not null then  RTEBTCUSTSNDWORK.closedat else RTEBTCUSTSNDWORK.unclosedat end ,RTEBTCUSTSNDWORK.BONUSCLOSEYM, RTEBTCUSTSNDWORK.BONUSFINCHK, RTEBTCUSTSNDWORK.STOCKCLOSEYM, RTEBTCUSTSNDWORK.STOCKFINCHK, " _
           &"RTEBTCUSTSNDWORK.DROPDAT FROM RTEBTCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTEBTCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTEBTCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY "
  dataTable="RTEBTCUSTSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="RTEBTCUSTSNDWORKD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
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
  searchProg="self"
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
     searchQry=" RTEBTCUSTSNDWORK.ComQ1=" & aryparmkey(0) & " and RTEBTCUSTSNDWORK.lineq1=" & aryparmkey(1) & " and RTEBTCUSTSNDWORK.cusid='" & aryparmkey(2) & "' "
     searchShow="�D�u�Ǹ��J"& aryparmkey(0) &"-" & aryparmkey(1)& ",���ϦW�١J" & COMN & ",�X���s���J" & aryparmkey(2) & ",�D�u��}�J" & COMADDR
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
  
    If searchShow="����" Then
         sqlList="SELECT RTEBTCUSTSNDWORK.COMQ1, RTEBTCUSTSNDWORK.LINEQ1, RTEBTCUSTSNDWORK.CUSID, RTEBTCUSTSNDWORK.PRTNO,rtrim(convert(char(6),RTEBTCUSTSNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORK.lineQ1))  as comqline, RTEBTCUSTSNDWORK.PRTNO, RTEBTCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"case when RTEBTCUSTSNDWORK.closedat is not null then  RTEBTCUSTSNDWORK.closedat else RTEBTCUSTSNDWORK.unclosedat end ,RTEBTCUSTSNDWORK.BONUSCLOSEYM, RTEBTCUSTSNDWORK.BONUSFINCHK, RTEBTCUSTSNDWORK.STOCKCLOSEYM, RTEBTCUSTSNDWORK.STOCKFINCHK, " _
           &"RTEBTCUSTSNDWORK.DROPDAT FROM RTEBTCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTEBTCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTEBTCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY " _
            &"where " & searchqry
    Else
         sqlList="SELECT RTEBTCUSTSNDWORK.COMQ1, RTEBTCUSTSNDWORK.LINEQ1, RTEBTCUSTSNDWORK.CUSID, RTEBTCUSTSNDWORK.PRTNO,rtrim(convert(char(6),RTEBTCUSTSNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORK.lineQ1))  as comqline, RTEBTCUSTSNDWORK.PRTNO, RTEBTCUSTSNDWORK.SENDWORKDAT, " _
           &"RTOBJ.CUSNC,CASE WHEN RTOBJ_2.SHORTNC <>'' THEN RTOBJ_2.SHORTNC ELSE RTOBJ_1.CUSNC END,CASE WHEN RTOBJ_4.SHORTNC <>'' THEN RTOBJ_4.SHORTNC ELSE RTOBJ_3.CUSNC END, " _
           &"case when RTEBTCUSTSNDWORK.closedat is not null then  RTEBTCUSTSNDWORK.closedat else RTEBTCUSTSNDWORK.unclosedat end ,RTEBTCUSTSNDWORK.BONUSCLOSEYM, RTEBTCUSTSNDWORK.BONUSFINCHK, RTEBTCUSTSNDWORK.STOCKCLOSEYM, RTEBTCUSTSNDWORK.STOCKFINCHK, " _
           &"RTEBTCUSTSNDWORK.DROPDAT FROM RTEBTCUSTSNDWORK LEFT OUTER JOIN RTObj RTObj_4 ON RTEBTCUSTSNDWORK.REALCONSIGNEE = RTObj_4.CUSID LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_3 ON RTEmployee_2.CUSID = RTObj_3.CUSID ON RTEBTCUSTSNDWORK.REALENGINEER = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTEBTCUSTSNDWORK.PRTUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>