<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�D�u��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="�D�u���u;�]�Ƭd��;�Τ���@;�ȪA�ץ�;������;�M�u�@�~;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCmtyLineSNDWORKK.asp;RTLessorCmtyLINEHardwareK2.asp;RTLessorCustK.asp;RTLessorCmtyLineFAQK.asp;RTLessorCmtyLineContK.asp;RTLessorCmtyLineDROPK.asp;RTLessorCmtyLineCANCEL.asp;RTLessorCmtyLineCANCELRTN.asp;RTLessorCmtyLineLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�D�u;�m��;�s��;�D�uIP;none;none;none;�D�u����;�u��ISP;IP����;�D�u�t�v;IP��;none;none;�q����;�]�Ʀw��;���q��;�u�����;����Ѽ�;�M�u��;�@�o��;�Τ�;����;�h��;�p�O;�t��"
  sqlDelete="SELECT RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEQ1,RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLine.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLine.lineQ1)) , " _
                &"RTLESSORCMTYLINE.TOWNSHIP,RTLessorCmtyLine.LINEGROUP,RTLessorCmtyLine.LINEIP,RTLessorCmtyLine.GATEWAY, " _
                &"RTLessorCmtyLine.PPPOEACCOUNT, RTLessorCmtyLine.PPPOEPASSWORD, RTLessorCmtyLine.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorCmtyLine.IPCNT, " _
                &"RTLessorCmtyLine.RCVDAT, RTLessorCmtyLine.INSPECTDAT, RTLessorCmtyLine.HINETNOTIFYDAT, " _
                &"RTLessorCmtyLine.HARDWAREDAT, RTLessorCmtyLine.ADSLAPPLYDAT, RTLessorCmtyLine.LINEDUEDAT,isnull(datediff(dd,getdate(),RTLessorCmtyLine.LINEDUEDAT),0), " _
                &"RTLessorCmtyLine.DROPDAT, RTLessorCmtyLine.CANCELDAT, " _
                &"SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND RTLessorCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND RTLessorCust.FINISHDAT IS NOT NULL AND " _
                &"RTLessorCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND " _
                &"(RTLessorCust.STRBILLINGDAT IS NOT NULL OR RTLessorCust.NEWBILLINGDAT IS NOT NULL) AND " _
                &"RTLessorCust.DROPDAT IS NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND " _
                &"RTLessorCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND " _
                &"RTLessorCust.FINISHDAT IS NOT NULL AND RTLessorCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
                &"- SUM(CASE WHEN RTLessorCust.CANCELDAT IS NULL AND (RTLessorCust.STRBILLINGDAT IS NOT NULL OR " _
                &"RTLessorCust.NEWBILLINGDAT IS NOT NULL) AND RTLessorCust.DROPDAT IS NULL THEN 1 ELSE 0 END) " _
                &"FROM    RTLessorCmtyLine LEFT OUTER JOIN RTLessorCust ON RTLessorCmtyLine.COMQ1 = RTLessorCust.COMQ1 AND " _
                &"RTLessorCmtyLine.LINEQ1 = RTLessorCust.LINEQ1 LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorCmtyLine.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyLine.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyLine.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorCmtyLine.SALESID = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTLessorCmtyLine.CONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                &"RTLessorCmtyLine.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCOUNTY ON " _
                &"RTLESSORCMTYLINE.CUTID = RTCOUNTY.CUTID " _
                &"WHERE RTLessorCmtyLine.COMQ1=0 " _
                &"GROUP BY  RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEQ1, RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLine.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLine.lineQ1)) ," _
                &"RTLESSORCMTYLINE.TOWNSHIP, RTLessorCmtyLine.LINEGROUP, RTLessorCmtyLine.LINEIP, " _
                &"RTLessorCmtyLine.GATEWAY, RTLessorCmtyLine.PPPOEACCOUNT, RTLessorCmtyLine.PPPOEPASSWORD, " _
                &"RTLessorCmtyLine.LINETEL, RTCode_1.CODENC, RTCode_3.CODENC, RTCode_2.CODENC, " _
                &"RTLessorCmtyLine.IPCNT, RTLessorCmtyLine.RCVDAT, RTLessorCmtyLine.INSPECTDAT, " _
                &"RTLessorCmtyLine.HINETNOTIFYDAT, RTLessorCmtyLine.HARDWAREDAT, RTLessorCmtyLine.ADSLAPPLYDAT, " _
                &"RTLessorCmtyLine.LINEDUEDAT, RTLessorCmtyLine.DROPDAT, RTLessorCmtyLine.CANCELDAT " _
                &"ORDER BY  RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEQ1 "

  dataTable="RTLessorCmtyLine"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTLessorCmtyLineDtemp.asp"
  datawindowFeature=""
  searchWindowFeature="width=450,height=350,scrollbars=yes"
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
  searchProg="RTLessorCmtylineS2.asp"
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
 
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorCmtyLine.ComQ1<>0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
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
  '  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
  '	 Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
  '	 Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
         sqlList="SELECT RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEQ1,RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLine.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLine.lineQ1)) , " _
                &"RTLESSORCMTYLINE.TOWNSHIP,RTLessorCmtyLine.LINEGROUP,RTLessorCmtyLine.LINEIP,RTLessorCmtyLine.GATEWAY, " _
                &"RTLessorCmtyLine.PPPOEACCOUNT, RTLessorCmtyLine.PPPOEPASSWORD, RTLessorCmtyLine.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorCmtyLine.IPCNT, " _
                &"RTLessorCmtyLine.RCVDAT, RTLessorCmtyLine.INSPECTDAT, RTLessorCmtyLine.HINETNOTIFYDAT, " _
                &"RTLessorCmtyLine.HARDWAREDAT, RTLessorCmtyLine.ADSLAPPLYDAT, RTLessorCmtyLine.LINEDUEDAT,isnull(datediff(dd,getdate(),RTLessorCmtyLine.LINEDUEDAT),0), " _
                &"RTLessorCmtyLine.DROPDAT, RTLessorCmtyLine.CANCELDAT, " _
                &"SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND RTLessorCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND RTLessorCust.FINISHDAT IS NOT NULL AND " _
                &"RTLessorCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END), SUM(CASE  WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND " _
                &"(RTLessorCust.STRBILLINGDAT IS NOT NULL OR RTLessorCust.NEWBILLINGDAT IS NOT NULL) AND " _
                &"RTLessorCust.DROPDAT IS NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND " _
                &"RTLessorCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND " _
                &"RTLessorCust.FINISHDAT IS NOT NULL AND RTLessorCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
                &"- SUM(CASE WHEN RTLessorCust.cusid is not null and RTLessorCust.CANCELDAT IS NULL AND (RTLessorCust.STRBILLINGDAT IS NOT NULL OR " _
                &"RTLessorCust.NEWBILLINGDAT IS NOT NULL) AND RTLessorCust.DROPDAT IS NULL THEN 1 ELSE 0 END) " _
                &"FROM    RTLessorCmtyLine LEFT OUTER JOIN RTLessorCust ON RTLessorCmtyLine.COMQ1 = RTLessorCust.COMQ1 AND " _
                &"RTLessorCmtyLine.LINEQ1 = RTLessorCust.LINEQ1 LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorCmtyLine.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyLine.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyLine.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorCmtyLine.SALESID = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTLessorCmtyLine.CONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                &"RTLessorCmtyLine.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCOUNTY ON " _
                &"RTLESSORCMTYLINE.CUTID = RTCOUNTY.CUTID " _
                &"WHERE " & SEARCHQRY & " " _
                &"GROUP BY  RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEQ1, RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLine.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLine.lineQ1)) ,  " _
                &"RTLESSORCMTYLINE.TOWNSHIP, RTLessorCmtyLine.LINEGROUP, RTLessorCmtyLine.LINEIP, " _
                &"RTLessorCmtyLine.GATEWAY, RTLessorCmtyLine.PPPOEACCOUNT, RTLessorCmtyLine.PPPOEPASSWORD, " _
                &"RTLessorCmtyLine.LINETEL, RTCode_1.CODENC, RTCode_3.CODENC, RTCode_2.CODENC, " _
                &"RTLessorCmtyLine.IPCNT, RTLessorCmtyLine.RCVDAT, RTLessorCmtyLine.INSPECTDAT, " _
                &"RTLessorCmtyLine.HINETNOTIFYDAT, RTLessorCmtyLine.HARDWAREDAT, RTLessorCmtyLine.ADSLAPPLYDAT, " _
                &"RTLessorCmtyLine.LINEDUEDAT, RTLessorCmtyLine.DROPDAT, RTLessorCmtyLine.CANCELDAT " _
                &"ORDER BY  RTLessorCmtyLine.COMQ1, RTLessorCmtyLine.LINEGROUP, RTLessorCmtyLine.LINEQ1 "
 
  'end if
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>