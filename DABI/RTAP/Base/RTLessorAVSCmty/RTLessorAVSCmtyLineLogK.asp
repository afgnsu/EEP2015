<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�D�u��Ʋ��ʰO���d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;����;�D�u;���ʤ��;���ʧO;���ʭ�;�m��;�s��;�D�uIP;none;none;none;�D�u����;�u��ISP;IP����;�D�u�t�v;IP��;none;none;�q����;�]�Ʀw��;���q��;�u�����;����Ѽ�;�M�u��;�@�o��;none;none;none;none;none"
  sqlDelete="SELECT RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEQ1, RTLessorAVSCmtyLineLog.entryno,rtrim(convert(char(6),RTLessorAVSCmtyLineLog.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineLog.lineQ1)) , " _
                &"RTLessorAVSCmtyLineLog.chgdat,RTCODE_9.CODENC,''," _
                &"RTLessorAVSCmtyLineLog.TOWNSHIP,RTLessorAVSCmtyLineLog.LINEGROUP,RTLessorAVSCmtyLineLog.LINEIP,RTLessorAVSCmtyLineLog.GATEWAY, " _
                &"RTLessorAVSCmtyLineLog.PPPOEACCOUNT, RTLessorAVSCmtyLineLog.PPPOEPASSWORD, RTLessorAVSCmtyLineLog.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorAVSCmtyLineLog.IPCNT, " _
                &"RTLessorAVSCmtyLineLog.RCVDAT, RTLessorAVSCmtyLineLog.INSPECTDAT, RTLessorAVSCmtyLineLog.HINETNOTIFYDAT, " _
                &"RTLessorAVSCmtyLineLog.HARDWAREDAT, RTLessorAVSCmtyLineLog.ADSLAPPLYDAT, RTLessorAVSCmtyLineLog.LINEDUEDAT, " _
                &"RTLessorAVSCmtyLineLog.DROPDAT, RTLessorAVSCmtyLineLog.CANCELDAT, " _
                &"SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND RTLessorAVSCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND RTLessorAVSCust.FINISHDAT IS NOT NULL AND " _
                &"RTLessorAVSCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"(RTLessorAVSCust.STRBILLINGDAT IS NOT NULL OR RTLessorAVSCust.NEWBILLINGDAT IS NOT NULL) AND " _
                &"RTLessorAVSCust.DROPDAT IS NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"RTLessorAVSCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"RTLessorAVSCust.FINISHDAT IS NOT NULL AND RTLessorAVSCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
                &"- SUM(CASE WHEN RTLessorAVSCust.CANCELDAT IS NULL AND (RTLessorAVSCust.STRBILLINGDAT IS NOT NULL OR " _
                &"RTLessorAVSCust.NEWBILLINGDAT IS NOT NULL) AND RTLessorAVSCust.DROPDAT IS NULL THEN 1 ELSE 0 END) " _
                &"FROM    RTLessorAVSCmtyLineLog LEFT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCmtyLineLog.COMQ1 = RTLessorAVSCust.COMQ1 AND " _
                &"RTLessorAVSCmtyLineLog.LINEQ1 = RTLessorAVSCust.LINEQ1 LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorAVSCmtyLineLog.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorAVSCmtyLineLog.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorAVSCmtyLineLog.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorAVSCmtyLineLog.SALESID = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTLessorAVSCmtyLineLog.CONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTLessorAVSCMTYH ON " _
                &"RTLessorAVSCmtyLineLog.COMQ1 = RTLessorAVSCMTYH.COMQ1 LEFT OUTER JOIN RTCOUNTY ON " _
                &"RTLessorAVSCmtyLineLog.CUTID = RTCOUNTY.CUTID " _
                &"WHERE RTLessorAVSCmtyLineLog.COMQ1=0 " _
                &"GROUP BY  RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEQ1, RTLessorAVSCmtyLineLog.entryno,rtrim(convert(char(6),RTLessorAVSCmtyLineLog.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineLog.lineQ1)) ," _
                &"RTLessorAVSCmtyLineLog.TOWNSHIP, RTLessorAVSCmtyLineLog.LINEGROUP, RTLessorAVSCmtyLineLog.LINEIP, " _
                &"RTLessorAVSCmtyLineLog.GATEWAY, RTLessorAVSCmtyLineLog.PPPOEACCOUNT, RTLessorAVSCmtyLineLog.PPPOEPASSWORD, " _
                &"RTLessorAVSCmtyLineLog.LINETEL, RTCode_1.CODENC, RTCode_3.CODENC, RTCode_2.CODENC, " _
                &"RTLessorAVSCmtyLineLog.IPCNT, RTLessorAVSCmtyLineLog.RCVDAT, RTLessorAVSCmtyLineLog.INSPECTDAT, " _
                &"RTLessorAVSCmtyLineLog.HINETNOTIFYDAT, RTLessorAVSCmtyLineLog.HARDWAREDAT, RTLessorAVSCmtyLineLog.ADSLAPPLYDAT, " _
                &"RTLessorAVSCmtyLineLog.LINEDUEDAT, RTLessorAVSCmtyLineLog.DROPDAT, RTLessorAVSCmtyLineLog.CANCELDAT " _
                &"ORDER BY  RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEQ1 "

  dataTable="RTLessorAVSCmtyLineLog"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
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
 
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorAVSCmtyLineLog.ComQ1=" & aryparmkey(0) & " and RTLessorAVSCmtyLineLog.lineq1=" & aryparmkey(1) & " "
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
         sqlList="SELECT RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEQ1, RTLessorAVSCmtyLineLog.entryno,rtrim(convert(char(6),RTLessorAVSCmtyLineLog.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineLog.lineQ1)) , " _
                &"RTLessorAVSCmtyLineLog.chgdat,RTCODE_9.CODENC,rtobj_9.cusnc," _
                &"RTLessorAVSCmtyLineLog.TOWNSHIP,RTLessorAVSCmtyLineLog.LINEGROUP,RTLessorAVSCmtyLineLog.LINEIP,RTLessorAVSCmtyLineLog.GATEWAY, " _
                &"RTLessorAVSCmtyLineLog.PPPOEACCOUNT, RTLessorAVSCmtyLineLog.PPPOEPASSWORD, RTLessorAVSCmtyLineLog.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorAVSCmtyLineLog.IPCNT, " _
                &"RTLessorAVSCmtyLineLog.RCVDAT, RTLessorAVSCmtyLineLog.INSPECTDAT, RTLessorAVSCmtyLineLog.HINETNOTIFYDAT, " _
                &"RTLessorAVSCmtyLineLog.HARDWAREDAT, RTLessorAVSCmtyLineLog.ADSLAPPLYDAT, RTLessorAVSCmtyLineLog.LINEDUEDAT, " _
                &"RTLessorAVSCmtyLineLog.DROPDAT, RTLessorAVSCmtyLineLog.CANCELDAT, " _
                &"SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND RTLessorAVSCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END), " _
                &"SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND RTLessorAVSCust.FINISHDAT IS NOT NULL AND " _
                &"RTLessorAVSCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END), SUM(CASE  WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"(RTLessorAVSCust.STRBILLINGDAT IS NOT NULL OR RTLessorAVSCust.NEWBILLINGDAT IS NOT NULL) AND " _
                &"RTLessorAVSCust.DROPDAT IS NULL THEN 1 ELSE 0 END), SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"RTLessorAVSCust.FINISHDAT IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND " _
                &"RTLessorAVSCust.FINISHDAT IS NOT NULL AND RTLessorAVSCust.DROPDAT IS NOT NULL THEN 1 ELSE 0 END) " _
                &"- SUM(CASE WHEN RTLessorAVSCust.cusid is not null and RTLessorAVSCust.CANCELDAT IS NULL AND (RTLessorAVSCust.STRBILLINGDAT IS NOT NULL OR " _
                &"RTLessorAVSCust.NEWBILLINGDAT IS NOT NULL) AND RTLessorAVSCust.DROPDAT IS NULL THEN 1 ELSE 0 END) " _
                &"FROM    RTLessorAVSCmtyLineLog LEFT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCmtyLineLog.COMQ1 = RTLessorAVSCust.COMQ1 AND " _
                &"RTLessorAVSCmtyLineLog.LINEQ1 = RTLessorAVSCust.LINEQ1 LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorAVSCmtyLineLog.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorAVSCmtyLineLog.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorAVSCmtyLineLog.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorAVSCmtyLineLog.SALESID = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTLessorAVSCmtyLineLog.CONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTLessorAVSCMTYH ON " _
                &"RTLessorAVSCmtyLineLog.COMQ1 = RTLessorAVSCMTYH.COMQ1 LEFT OUTER JOIN RTCOUNTY ON " _
                &"RTLessorAVSCmtyLineLog.CUTID = RTCOUNTY.CUTID left outer join rtcode rtcode_9 on RTLessorAVSCmtyLineLog.chgcodE=rtcode_9.code and rtcode_9.kind='G2' " _
                &"LEFT OUTER JOIN rtemployee rtemployee_9 on RTLessorAVSCmtyLineLog.chgusr=rtemployee.emply left outer join rtobj rtobj_9 on rtemployee_9.cusid=rtobj_9.cusid " _
                &"WHERE " & SEARCHQRY & " " _
                &"GROUP BY  RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEQ1, RTLessorAVSCmtyLineLog.entryno,rtrim(convert(char(6),RTLessorAVSCmtyLineLog.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorAVSCmtyLineLog.lineQ1)) , " _
                &"RTLessorAVSCmtyLineLog.chgdat,RTCODE_9.CODENC,rtobj_9.cusnc," _
                &"RTLessorAVSCmtyLineLog.TOWNSHIP,RTLessorAVSCmtyLineLog.LINEGROUP,RTLessorAVSCmtyLineLog.LINEIP,RTLessorAVSCmtyLineLog.GATEWAY, " _
                &"RTLessorAVSCmtyLineLog.PPPOEACCOUNT, RTLessorAVSCmtyLineLog.PPPOEPASSWORD, RTLessorAVSCmtyLineLog.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC, RTCode_2.CODENC, RTLessorAVSCmtyLineLog.IPCNT, " _
                &"RTLessorAVSCmtyLineLog.RCVDAT, RTLessorAVSCmtyLineLog.INSPECTDAT, RTLessorAVSCmtyLineLog.HINETNOTIFYDAT, " _
                &"RTLessorAVSCmtyLineLog.HARDWAREDAT, RTLessorAVSCmtyLineLog.ADSLAPPLYDAT, RTLessorAVSCmtyLineLog.LINEDUEDAT, " _
                &"RTLessorAVSCmtyLineLog.DROPDAT, RTLessorAVSCmtyLineLog.CANCELDAT " _
                &"ORDER BY  RTLessorAVSCmtyLineLog.COMQ1, RTLessorAVSCmtyLineLog.LINEGROUP, RTLessorAVSCmtyLineLog.LINEQ1 "
 
  'end if
  ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>