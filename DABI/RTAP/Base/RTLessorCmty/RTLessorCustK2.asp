<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City�Τ��ƺ��@"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���צ���;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�]�ƫO�ަ��ڦC�L;�ΤᲾ��;�վ���;�]�Ƭd��;���@�t IP;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCustRepairK.asp;RTLessorCustsndworkk.asp;RTLessorCustContK.asp;RTLessorCustReturnK.asp;RTLessorCustDropK.asp;RTLessorCustARK.asp;RTLessorCustfaqK.asp;/RTAP/REPORT/Common/RTStorageReceiptET.asp;RTLessorCustmove.asp;RTLessorCustadjdayK.asp;RTLessorCusttothardwareK.asp;RTLessorCustAutoIP.asp;RTLessorCustCANCEL.asp;RTLessorCustCANCELRTN.asp;RTLessorCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;N;Y;N;N;Y;Y;N"
  functionoptopen=  "1;1;1;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�;�ĤG<br>��;���;�g��;ú��;IP��};none;�ӽФ�;���u��;������;�}�l�p�O;�̪�<br>�����;�����;����;�h����;�@�o��;none;none;�i��<BR>���;�̪�<br>�����B"
  sqlDelete="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCmtyH.COMN,RTLessorCust.CUSNC,case when RTLessorCust.secondcase='Y' THEN RTLessorCust.secondcase ELSE '' END,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLessorCust.TOWNSHIP1 + " _
                &"RTLessorCust.RADDR1 AS ADDR, RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, RTLESSORCUST.DOCKETDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.DUEDAT,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC," _
                &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 left outer join rtlessorcmtyline on " _
                &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"left outer join RTCode c on c.code = rtlessorcust.casekind and c.kind ='O9' " _
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
  searchProg="RTLessorCusts2.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" RTLessorCust.comq1=0 "
     SEATCHQRY2=""
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and RTLessorcmtyline.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close

  connxx.Close
  set rsxx=nothing
  set connxx=nothing


  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
         sqlList="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCmtyH.COMN,case when len(RTLessorCust.CUSNC) > 4 then substring(RTLessorCust.CUSNC,1,4)+'...' else RTLessorCust.CUSNC end,case when RTLessorCust.secondcase='Y' THEN RTLessorCust.secondcase ELSE '' END,c.codenc,RTCODE_1.CODENC,RTCODE_2.CODENC,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLessorCust.TOWNSHIP1 + " _
                &"RTLessorCust.RADDR1 AS ADDR, RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, RTLESSORCUST.DOCKETDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.newBILLINGDAT,RTLESSORCUST.DUEDAT,case when RTLESSORCUST.freecode='Y' THEN RTLESSORCUST.freecode ELSE '' END,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC," _
                &"case when RTLESSORCUST.DUEDAT is null then 0 when RTLESSORCUST.canceldat is not null or RTLESSORCUST.dropdat is not null then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end as validdat,rtlessorcust.rcvmoney  " _
                &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 inner join rtlessorcmtyline on " _
                &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"left outer join RTCode c on c.code = rtlessorcust.casekind and c.kind ='O9' " _
                &"where " & searchqry & " " & limitemply & " " & searchqry2                 
 'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>