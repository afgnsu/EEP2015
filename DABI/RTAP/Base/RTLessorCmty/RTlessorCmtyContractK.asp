<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City���ϦX����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="����@�~;�X������;���ת���;�@�@�@�o;�@�o����;���ʬd��"
  functionOptProgram="RTLessorCmtyContractContK.asp;RTLessorCmtyContractF.asp;RTLessorCmtyContractFR.asp;RTLessorCmtyContractCancel.asp;RTLessorCmtyContractCancelRTN.asp;RTLessorCmtyContractLogK.asp"
  functionOptPrompt="N;Y;Y;Y;Y;N"
  functionoptopen="1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�X���s��;�X��<BR>�_���;�̪�<BR>�����;���<BR>����;�X��<BR>�����;ñ��<BR>��H;�q��;��ʹq��;none;none;none;none;�q�O<BR>�ɧU����;���I<BR��I;�C��(��)<BR>���B;�I��<BR>�覡;�I��<BR>�g��;���פ�;���׭�;�����b<BR>�ڽs��;������<BR>�b�ڤ�;�@�o��;�@�o��"
  sqlDelete="SELECT  RTLessorCmtyContract.COMQ1, RTLessorCmtyContract.CONTRACTNO, RTLessorCmtyContract.STRDAT, " _
                &"RTLessorCmtyContract.CONTDAT,RTLessorCmtyContract.CONTCNT, RTLessorCmtyContract.ENDDAT, " _
                &"RTLessorCmtyContract.CONTRACTOBJ, RTLessorCmtyContract.OBJTEL, RTLessorCmtyContract.OBJMOBILE, " _
                &"RTDept.DEPTN4, RTObj_3.CUSNC, case when RTLessorCmtyContract.REMITBANK1 <> '' then RTLessorCmtyContract.REMITBANK1 else '' end + case when  RTLessorCmtyContract.REMITBANK1 <> '' and RTLessorCmtyContract.REMITBANK2<>'' then '-' + RTLessorCmtyContract.REMITBANK2 else '' end + case when RTLessorCmtyContract.REMITBANK1 <> '' or RTLessorCmtyContract.REMITBANK2<>'' then '-' + RTLessorCmtyContract.ACNO else '' end, " _
                &"RTLessorCmtyContract.AC, RTCode_2.CODENC, RTCode_1.CODENC AS Expr1, RTLessorCmtyContract.SCALEAMT, " _
                &"RTCode_3.CODENC AS Expr2,RTCode_4.CODENC AS Expr3,RTLessorCmtyContract.CLOSEDAT,RTObj_2.CUSNC AS Expr4," _
                &"RTLessorCmtyContract.CANCELDAT, RTObj_1.CUSNC AS Expr5,RTLessorCmtyContract.batchno,RTLessorCmtyContract.tardat " _
                &"FROM    RTEmployee RTEmployee_3 LEFT OUTER JOIN RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID " _
                &"RIGHT OUTER JOIN RTLessorCmtyContract ON RTEmployee_3.EMPLY = RTLessorCmtyContract.SIGNPERSON " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 LEFT OUTER JOIN RTObj RTObj_1 ON " _
                &"RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorCmtyContract.CANCELUSR = RTEmployee_1.EMPLY " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_2 LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTEmployee_2.CUSID = RTObj_2.CUSID ON RTLessorCmtyContract.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
                &"RTCode RTCode_4 ON RTLessorCmtyContract.PAYCYCLE = RTCode_4.CODE AND RTCode_4.KIND = 'F9' LEFT OUTER JOIN " _
                &"RTCode RTCode_3 ON RTLessorCmtyContract.PAYKIND = RTCode_3.CODE AND RTCode_3.KIND = 'F5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyContract.POWERBILLPAYKIND = RTCode_1.CODE AND RTCode_1.KIND = 'O4' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyContract.POWERBILLKIND = RTCode_2.CODE AND RTCode_2.KIND = 'O3' " _
                &"LEFT OUTER JOIN RTBankNo ON RTLessorCmtyContract.REMITBANK1 = RTBankNo.HEADNO AND " _
                &"RTLessorCmtyContract.REMITBANK2 = RTBankNo.BRANCHNO LEFT OUTER JOIN RTBank ON " _
                &"RTLessorCmtyContract.REMITBANK1 = RTBank.HEADNO LEFT OUTER JOIN RTDept ON " _
                &"RTLessorCmtyContract.SIGNDEPT = RTDept.DEPT " _
                &"WHERE RTLessorCmtyContract.COMQ1=0"

  dataTable="RTLessorCmtyContract"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTLessorCmtyContractD.asp"
  datawindowFeature=""
  searchWindowFeature="width=300,height=160,scrollbars=yes"
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
  searchProg="RTLessorCmtyContractS.asp"
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
  sqlYY="select * from RTLessorCmtyH LEFT OUTER JOIN RTCOUNTY ON RTLessorCmtyH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     COMADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("RADDR")
  else
     COMN=""
     COMADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorCmtyContract.ComQ1=" & aryparmkey(0) & " AND RTLessorCmtyContract.CANCELDAT IS NULL "
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",���Ϧa�}�J" & COMADDR
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
         sqlList="SELECT  RTLessorCmtyContract.COMQ1, RTLessorCmtyContract.CONTRACTNO, RTLessorCmtyContract.STRDAT, " _
                &"RTLessorCmtyContract.CONTDAT,RTLessorCmtyContract.CONTCNT, RTLessorCmtyContract.ENDDAT, " _
                &"RTLessorCmtyContract.CONTRACTOBJ, RTLessorCmtyContract.OBJTEL, RTLessorCmtyContract.OBJMOBILE, " _
                &"RTDept.DEPTN4, RTObj_3.CUSNC,  case when RTLessorCmtyContract.REMITBANK1 <> '' then RTLessorCmtyContract.REMITBANK1 else '' end + case when  RTLessorCmtyContract.REMITBANK1 <> '' and RTLessorCmtyContract.REMITBANK2<>'' then '-' + RTLessorCmtyContract.REMITBANK2 else '' end + case when RTLessorCmtyContract.REMITBANK1 <> '' or RTLessorCmtyContract.REMITBANK2<>'' then '-' + RTLessorCmtyContract.ACNO else '' end, " _
                &"RTLessorCmtyContract.AC, RTCode_2.CODENC, RTCode_1.CODENC AS Expr1, RTLessorCmtyContract.SCALEAMT, " _
                &"RTCode_3.CODENC AS Expr2,RTCode_4.CODENC AS Expr3,RTLessorCmtyContract.CLOSEDAT,RTObj_2.CUSNC AS Expr4," _
                &"RTLessorCmtyContract.CANCELDAT, RTObj_1.CUSNC AS Expr5 " _
                &"FROM    RTEmployee RTEmployee_3 LEFT OUTER JOIN RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID " _
                &"RIGHT OUTER JOIN RTLessorCmtyContract ON RTEmployee_3.EMPLY = RTLessorCmtyContract.SIGNPERSON " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 LEFT OUTER JOIN RTObj RTObj_1 ON " _
                &"RTEmployee_1.CUSID = RTObj_1.CUSID ON RTLessorCmtyContract.CANCELUSR = RTEmployee_1.EMPLY " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_2 LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTEmployee_2.CUSID = RTObj_2.CUSID ON RTLessorCmtyContract.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
                &"RTCode RTCode_4 ON RTLessorCmtyContract.PAYCYCLE = RTCode_4.CODE AND RTCode_4.KIND = 'F9' LEFT OUTER JOIN " _
                &"RTCode RTCode_3 ON RTLessorCmtyContract.PAYKIND = RTCode_3.CODE AND RTCode_3.KIND = 'F5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyContract.POWERBILLPAYKIND = RTCode_1.CODE AND RTCode_1.KIND = 'O4' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyContract.POWERBILLKIND = RTCode_2.CODE AND RTCode_2.KIND = 'O3' " _
                &"LEFT OUTER JOIN RTBankNo ON RTLessorCmtyContract.REMITBANK1 = RTBankNo.HEADNO AND " _
                &"RTLessorCmtyContract.REMITBANK2 = RTBankNo.BRANCHNO LEFT OUTER JOIN RTBank ON " _
                &"RTLessorCmtyContract.REMITBANK1 = RTBank.HEADNO LEFT OUTER JOIN RTDept ON " _
                &"RTLessorCmtyContract.SIGNDEPT = RTDept.DEPT " _
                &"WHERE RTLessorCmtyContract.COMQ1=" & ARYPARMKEY(0) & " AND " & SEARCHQRY & " ORDER BY RTLessorCmtyContract.CONTRACTNO" 
                      

 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>