<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�D�u�����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="�������;�@�@�@�o;�@�o����;���ʬd��"
  functionOptProgram="RTLessorCmtyLineContClose.asp;RTLessorCmtyLineContCancel.asp;RTLessorCmtyLineContCancelRTN.asp;RTLessorCmtyLineContLogK.asp"
  functionOptPrompt="Y;Y;Y;N"
  functionoptopen="1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;����;���ϦW��;�D�u;�D�uIP;none;none;none;�D�u����;�u��ISP;IP����;�D�u�t�v;IP��;����ӽФ�;�q����;���q��;�u�������;���פ��;�@�o��"
  sqlDelete="SELECT RTLessorCmtyLineCont.COMQ1, RTLessorCmtyLineCont.LINEQ1, RTLessorCmtyLineCont.ENTRYNO,RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLineCont.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLineCont.lineQ1)) ,  " _
                &"RTLessorCmtyLineCont.LINEIP,RTLessorCmtyLineCont.GATEWAY, " _
                &"RTLessorCmtyLineCont.PPPOEACCOUNT, RTLessorCmtyLineCont.PPPOEPASSWORD, RTLessorCmtyLineCont.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorCmtyLineCont.IPCNT, " _
                &"RTLessorCmtyLineCont.CONTAPPLYDAT,RTLessorCmtyLineCont.HINETNOTIFYDAT, " _
                &"RTLessorCmtyLineCont.ADSLAPPLYDAT, RTLessorCmtyLineCont.LINEDUEDAT, RTLessorCmtyLineCont.closedat, " _
                &"RTLessorCmtyLineCont.CANCELDAT " _
                &"FROM    RTLessorCmtyLineCont LEFT OUTER JOIN RTLessorCust ON RTLessorCmtyLineCont.COMQ1 = RTLessorCust.COMQ1 AND " _
                &"RTLessorCmtyLineCont.LINEQ1 = RTLessorCust.LINEQ1 LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorCmtyLineCont.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyLineCont.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyLineCont.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorCmtyLineCont.SALESID = RTEmployee.EMPLY LEFT OUTER JOIN RTObj RTObj_2 ON " _
                &"RTLessorCmtyLineCont.CONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                &"RTLessorCmtyLineCont.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCOUNTY ON " _
                &"RTLessorCmtyLineCont.CUTID = RTCOUNTY.CUTID " _
                &"WHERE RTLessorCmtyLineCont.COMQ1=0 " 

  dataTable="RTLessorCmtyLineCont"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTLessorCmtyLineContD.asp"
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
     searchQry=" RTLessorCmtyLineCont.ComQ1=" & aryparmkey(0) & " AND RTLessorCmtyLineCont.LINEQ1=" & aryparmkey(1)
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
         sqlList="SELECT RTLessorCmtyLineCont.COMQ1, RTLessorCmtyLineCont.LINEQ1, RTLessorCmtyLineCont.ENTRYNO,RTLESSORCMTYH.COMN,rtrim(convert(char(6),RTLessorCmtyLineCont.COMQ1)) +'-'+ rtrim(convert(char(6),RTLessorCmtyLineCont.lineQ1)) ,  " _
                &"RTLessorCmtyLineCont.LINEIP,RTLessorCmtyLineCont.GATEWAY, " _
                &"RTLessorCmtyLineCont.PPPOEACCOUNT, RTLessorCmtyLineCont.PPPOEPASSWORD, RTLessorCmtyLineCont.LINETEL, " _
                &"RTCode_1.CODENC, RTCode_3.CODENC AS Expr1, RTCode_2.CODENC AS Expr2, RTLessorCmtyLineCont.IPCNT, " _
                &"RTLessorCmtyLineCont.CONTAPPLYDAT, RTLessorCmtyLineCont.HINETNOTIFYDAT, " _
                &"RTLessorCmtyLineCont.ADSLAPPLYDAT, RTLessorCmtyLineCont.LINEDUEDAT, RTLessorCmtyLineCont.closedat, " _
                &"RTLessorCmtyLineCont.CANCELDAT " _
                &"FROM    RTLessorCmtyLineCont  LEFT OUTER JOIN RTCode RTCode_3 ON " _
                &"RTLessorCmtyLineCont.LINEIPTYPE = RTCode_3.CODE AND RTCode_3.KIND = 'M5' LEFT OUTER JOIN " _
                &"RTCode RTCode_1 ON RTLessorCmtyLineCont.LINEISP = RTCode_1.CODE AND RTCode_1.KIND = 'C3' LEFT OUTER JOIN " _
                &"RTCode RTCode_2 ON RTLessorCmtyLineCont.LINERATE = RTCode_2.CODE AND RTCode_2.KIND = 'D3' " _
                &"LEFT OUTER JOIN RTLESSORCMTYH ON " _
                &"RTLessorCmtyLineCont.COMQ1 = RTLESSORCMTYH.COMQ1 " _
                &"WHERE " & SEARCHQRY & " ORDER BY ENTRYNO" 
                      

 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>