<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�Τ��ƺ��@"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  functionOptName="���צ���;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�]�ƫO�ަ��ڦC�L;�ΤᲾ��;�վ���;�]�Ƭd��;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorAVSCustRepairK.asp;RTLessorAVSCustsndworkk.asp;RTLessorAVSCustContK.asp;RTLessorAVSCustReturnK.asp;RTLessorAVSCustDropK.asp;RTLessorAVSCustARK.asp;RTLessorAVSCustfaqK.asp;/RTAP/REPORT/Common/RTStorageReceiptAVS.asp;RTLessorAVSCustmove.asp;RTLessorAVSCustadjdayK.asp;RTLessorAVSCusttothardwareK.asp;RTLessorAVSCustCANCEL.asp;RTLessorAVSCustCANCELRTN.asp;RTLessorAVSCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;N;N;N;Y;Y;N"
  functionoptopen=  "1;1;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�~���Ұ�;�D�u;����;�Τ�;���;�g��;ú��;none;none;�ӽФ�;���u��;������;�}�l�p�O;�̪�<br>�����;�����;����;�h����;�@�o��;none;none;�i��<BR>���;�̪�<br>�����B"
  sqlDelete="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, RTLessorAVSCmtyLine.salesid," _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
                &"RTLessorAVSCmtyH.COMN,RTLessorAVSCust.CUSNC,c.codenc,ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCust.TOWNSHIP1 + " _
                &"RTLessorAVSCust.RADDR1 AS ADDR, RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, RTLessorAVSCUST.DOCKETDAT, " _
                &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.DUEDAT,RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT,ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCUST.MAC," _
                &"FROM RTLessorAVSCust LEFT OUTER JOIN RTCounty ON RTLessorAVSCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorAVSCmtyH ON RTLessorAVSCust.COMQ1 = RTLessorAVSCmtyH.COMQ1 left outer join RTLessorAVScmtyline on " _
                &"RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and  RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on RTLessorAVScust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on RTLessorAVScust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"left outer join RTCode c on c.code = rtlessoravscust.casekind and c.kind ='O9' " _
                &"where RTLessorAVSCust.COMQ1=0 "
  dataTable="RTLessorAVSCust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTLessorAVSCustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=500,scrollbars=yes"
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
  searchProg="RTLessorAVSCusts2.asp"
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" RTLessorAVSCust.COMQ1=0 "
     SEATCHQRY2=""
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and RTLessorAVScmtyline.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close

  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '-------------------------------------------------------------------------------------------
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
         sqlList="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, isnull(RTObj_a.shortnc, RTObj_1.cusnc), " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
                &"RTLessorAVSCmtyH.COMN,case when len(RTLessorAVSCust.CUSNC) > 4 then substring(RTLessorAVSCust.CUSNC,1,4)+'...' else RTLessorAVSCust.CUSNC end,c.codenc,RTCODE_1.CODENC,RTCODE_2.CODENC,ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCust.TOWNSHIP1 + " _
                &"RTLessorAVSCust.RADDR1 AS ADDR, RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, RTLessorAVSCUST.DOCKETDAT, " _
                &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.newBILLINGDAT,RTLessorAVSCUST.DUEDAT,case when RTLESSORAVSCUST.freecode='Y' THEN RTLESSORAVSCUST.freecode ELSE '' END,RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT,ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCUST.MAC," _
                &"case when RTLessorAVSCUST.DUEDAT is null then 0 when RTLessorAVSCUST.canceldat is not null or RTLessorAVSCUST.dropdat is not null then 0 else DATEDiFF(d,getdate(),RTLessorAVSCUST.DUEDAT) end as validdat,RTLessorAVScust.rcvmoney  " _
                &"FROM RTLessorAVSCust LEFT OUTER JOIN RTCounty ON RTLessorAVSCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorAVSCmtyH ON RTLessorAVSCust.COMQ1 = RTLessorAVSCmtyH.COMQ1 inner join RTLessorAVScmtyline on " _
                &"RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and  RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on RTLessorAVScust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on RTLessorAVScust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"LEFT OUTER JOIN RTCtyTown ON RTLessorAVSCust.CUTID2 = RTCtyTown.CUTID AND " _
                &"RTLessorAVSCust.TOWNSHIP2 = RTCtyTown.TOWNSHIP " _
                &"left outer join rtobj rtobj_a on RTLessorAVSCmtyLine.consignee=rtobj_a.cusid LEFT OUTER JOIN " _
                &"RTEmployee INNER JOIN RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID ON " _
                &"RTLessorAVSCmtyLine.SALESID = RTEmployee.EMPLY " _
                &"left outer join RTCode c on c.code = rtlessoravscust.casekind and c.kind ='O9' " _
                &"where " & searchqry & " " & limitemply & " " & searchqry2 
 'response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>