<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τᵤ�u�T�{�沧�ʸ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;none;none;�D�u;���u�渹;����;���ʤ��;�������O;���ʤH��;���u��;�@�o��;���ʭ�];���u����;�����u����;�����p��~��"
  sqlDelete="SELECT  RTEBTCUSTSNDWORKLOG.COMQ1, " _
           &"RTEBTCUSTSNDWORKLOG.LINEQ1,RTEBTCUSTSNDWORKLOG.CUSID, RTEBTCUSTSNDWORKLOG.PRTNO, " _
           &"RTEBTCUSTSNDWORKLOG.ENTRYNO, rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.lineQ1))  as comqline," _
           &"RTEBTCUSTSNDWORKLOG.PRTNO,RTEBTCUSTSNDWORKLOG.ENTRYNO,RTEBTCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"RTEBTCUSTSNDWORKLOG.SENDWORKDAT, RTEBTCUSTSNDWORKLOG.DROPDAT, " _
           &"RTEBTCUSTSNDWORKLOG.DROPDESC, RTEBTCUSTSNDWORKLOG.CLOSEDAT, RTEBTCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"RTEBTCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCUSTSNDWORKLOG ON RTCode.CODE = RTEBTCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY where RTEBTCUSTSNDWORKLOG.COMQ1=0"
  dataTable="RTEBTCUSTSNDWORKLOG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="RTEBTCUSTSNDWORKLOGD.asp"
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
  sqlYY="select * from RTEBTCMTYline LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYline.CUTID1=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
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
     searchQry=" RTEBTCUSTSNDWORKLOG.ComQ1=" & aryparmkey(0) & " and RTEBTCUSTSNDWORKLOG.lineq1=" & aryparmkey(1) & " AND RTEBTCUSTSNDWORKLOG.CUSID='" & ARYPARMKEY(2) & "' and RTEBTCUSTSNDWORKLOG.prtno='" & aryparmkey(3) & "' "
     searchShow="�D�u�J"& aryparmkey(0)& "-" & aryparmkey(1) & ",���ϡJ" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�Ǹ��J" & aryparmkey(2) & ",���u�渹�J" & aryparmkey(3)
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
  if userlevel=31  then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT  RTEBTCUSTSNDWORKLOG.COMQ1, " _
           &"RTEBTCUSTSNDWORKLOG.LINEQ1, RTEBTCUSTSNDWORKLOG.CUSID,RTEBTCUSTSNDWORKLOG.PRTNO, " _
           &"RTEBTCUSTSNDWORKLOG.ENTRYNO, rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.lineQ1))  as comqline, " _
           &"RTEBTCUSTSNDWORKLOG.PRTNO,RTEBTCUSTSNDWORKLOG.ENTRYNO,RTEBTCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"RTEBTCUSTSNDWORKLOG.SENDWORKDAT, RTEBTCUSTSNDWORKLOG.DROPDAT, " _
           &"RTEBTCUSTSNDWORKLOG.DROPDESC, RTEBTCUSTSNDWORKLOG.CLOSEDAT, RTEBTCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"RTEBTCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCUSTSNDWORKLOG ON RTCode.CODE = RTEBTCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    Else
         sqlList="SELECT  RTEBTCUSTSNDWORKLOG.COMQ1, " _
           &"RTEBTCUSTSNDWORKLOG.LINEQ1,RTEBTCUSTSNDWORKLOG.CUSID, RTEBTCUSTSNDWORKLOG.PRTNO, " _
           &"RTEBTCUSTSNDWORKLOG.ENTRYNO, rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTCUSTSNDWORKLOG.lineQ1))  as comqline, " _
           &"RTEBTCUSTSNDWORKLOG.PRTNO,RTEBTCUSTSNDWORKLOG.ENTRYNO,RTEBTCUSTSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"RTEBTCUSTSNDWORKLOG.SENDWORKDAT, RTEBTCUSTSNDWORKLOG.DROPDAT, " _
           &"RTEBTCUSTSNDWORKLOG.DROPDESC, RTEBTCUSTSNDWORKLOG.CLOSEDAT, RTEBTCUSTSNDWORKLOG.unCLOSEDAT, " _
           &"RTEBTCUSTSNDWORKLOG.BONUSCLOSEYM FROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCUSTSNDWORKLOG ON RTCode.CODE = RTEBTCUSTSNDWORKLOG.CHGCODE " _
           &"AND RTCode.KIND = 'G3' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCUSTSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>