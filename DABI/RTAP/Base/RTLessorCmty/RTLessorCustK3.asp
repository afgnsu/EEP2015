<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="���h��������Τ��Ƭd��"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�ΤᲾ��;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�վ���;�]�Ƭd��;���@�t IP;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCustmove.asp;RTLessorCustsndworkk.asp;RTLessorCustContK.asp;RTLessorCustReturnK.asp;RTLessorCustDropK.asp;RTLessorCustARK.asp;RTLessorCustfaqK.asp;RTLessorCustadjdayK.asp;RTLessorCusttothardwareK.asp;RTLessorCustAutoIP.asp;RTLessorCustCANCEL.asp;RTLessorCustCANCELRTN.asp;RTLessorCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;Y;N;Y;Y;N"
  functionoptopen="2;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�;�ĤG��;�g��;ú��;IP��};none;�s���q��;�ӽФ�;���u��;�}�l�p�O;�̪�<br>�����;�վ�<br>���;�����;����;�h����;�@�o��;none;none;����;�i��<BR>���;�̪�<br>�����B"
  sqlDelete="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCmtyH.COMN,RTLessorCust.CUSNC,case when RTLessorCust.secondcase='Y' THEN RTLessorCust.secondcase ELSE '' END,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLessorCust.TOWNSHIP1 + " _
                &"RTLessorCust.RADDR1 AS ADDR,RTLessorCust.CONTACTTEL + CASE WHEN RTLessorCust.CONTACTTEL = '' OR " _
                &"RTLessorCust.CONTACTTEL IS NULL OR RTLessorCust.MOBILE = '' OR RTLessorCust.MOBILE IS NULL " _
                &"THEN '' ELSE ',' END + RTLessorCust.MOBILE AS Expr1, RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.DUEDAT,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC, RTLESSORCUST.PERIOD " _
                &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 left outer join rtlessorcmtyline on " _
                &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"where RTLessorCust.COMQ1=0 "
  dataTable="RTLessorCust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTLessorCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=400,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="400"
  diaHeight="250"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorCusts3.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorCust.ComQ1<>0 "
     SEATCHQRY2=""
     searchShow="����"
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
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=rtLIB"
  sqlxx="select * from RTEmployee where emply='" & emply & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  IF not rsxx.EOF then
     if rsxx("dept")="B400" THEN Dareaid="<>'*'"
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '�����D�ޥiŪ���������
  '  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
  '	 Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
  '	 Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
  '     DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
 ' if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  if userlevel=31 then DAreaID="<>'*'"
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
         sqlList="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCmtyH.COMN,case when len(RTLessorCust.CUSNC) > 4 then substring(RTLessorCust.CUSNC,1,4)+'...' else RTLessorCust.CUSNC end,case when RTLessorCust.secondcase='Y' THEN RTLessorCust.secondcase ELSE '' END,RTCODE_1.CODENC,RTCODE_2.CODENC,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLessorCust.TOWNSHIP1 + " _
                &"RTLessorCust.RADDR1 AS ADDR,RTLessorCust.CONTACTTEL + CASE WHEN RTLessorCust.CONTACTTEL = '' OR " _
                &"RTLessorCust.CONTACTTEL IS NULL OR RTLessorCust.MOBILE = '' OR RTLessorCust.MOBILE IS NULL " _
                &"THEN '' ELSE ',' END + RTLessorCust.MOBILE AS Expr1, RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.newBILLINGDAT,RTLESSORCUST.adjustday,RTLESSORCUST.DUEDAT,case when RTLESSORCUST.freecode='Y' THEN RTLESSORCUST.freecode ELSE '' END,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC, RTLESSORCUST.PERIOD," _
                &"case when RTLESSORCUST.DUEDAT is null then 0 when RTLESSORCUST.canceldat is not null or RTLESSORCUST.dropdat is not null then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end as validdat,rtlessorcust.rcvmoney  " _
                &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 left outer join rtlessorcmtyline on " _
                &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"where case when RTLESSORCUST.DUEDAT is null then 0 when RTLESSORCUST.canceldat is not null or RTLESSORCUST.dropdat is not null then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end < 0 and " & searchqry & " " & searchqry2
 'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>