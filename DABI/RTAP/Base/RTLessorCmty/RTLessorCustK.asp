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
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���צ���;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�]�ƫO�ަ��ڦC�L;�ΤᲾ��;�վ���;�]�Ƭd��;���@�t IP;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCustRepairK.asp;RTLessorCustsndworkk.asp;RTLessorCustContk.asp;RTLessorCustReturnK.asp;RTLessorCustDropK.asp;RTLessorCustARK.asp;RTLessorCustfaqK.asp;/RTAP/REPORT/Common/RTStorageReceiptET.asp;RTLessorCustmove.asp;RTLessorCustadjdayK.asp;RTLessorCusttothardwareK.asp;RTLessorCustAutoIP.asp;RTLessorCustCANCEL.asp;RTLessorCustCANCELRTN.asp;RTLessorCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;N;N;N;N;Y;Y;N"
  functionoptopen=  "1;1;1;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�;�˾��a�};TEL <B>/</B> ���;���;IP��};none;�ӽФ�;���u��;������;�}�l�p�O;�̪�<br>�����;�����;����;�h����;�@�o��;none;none;�i��<BR>���;�̪�<br>�����B"
  sqlDelete="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCmtyH.COMN,RTLessorCust.CUSNC, RTLessorCust.raddr2, " _
                &"RTLessorCust.contacttel + case when RTLessorCust.contacttel<>'' and RTLessorCust.mobile<>'' then '<font color=red><B>/</B></font>' else '' end + RTLessorCust.mobile, c.codenc," _
                &"ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTCounty.CUTNC + RTLessorCust.TOWNSHIP1 + " _
                &"RTLessorCust.RADDR1 AS ADDR, RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, RTLESSORCUST.DOCKETDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.NEWBILLINGDAT,RTLESSORCUST.DUEDAT,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC,case when RTLESSORCUST.DUEDAT is null then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end,RTLESSORCUST.RCVMONEY  " _
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
  searchWindowFeature="width=640,height=300,scrollbars=yes"
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
  searchProg="RTLessorCusts.asp"
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
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTLessorCmtyLine LEFT OUTER JOIN RTCOUNTY ON RTLessorCmtyLine.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
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
  '   searchQry=" and RTLessorCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorCust.LINEQ1=" & ARYPARMKEY(1)
  '   searchShow="����"
    '�ק�A
	if ARYPARMKEY(2) ="" then 
		searchQry=" and RTLessorCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorCust.LINEQ1=" & ARYPARMKEY(1)
		searchShow="����"
	else
		searchQry=" and RTLessorCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorCust.LINEQ1=" & ARYPARMKEY(1) & " AND RTLessorCust.CUSID='" & ARYPARMKEY(2) &"' "
		searchShow=""
	end if		
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
  'Domain=Mid(Emply,1,1)
    sqlList="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
        &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
        &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
        &"RTLessorCmtyH.COMN,RTLessorCust.CUSNC, RTLessorCust.raddr2, " _
        &"RTLessorCust.contacttel + case when RTLessorCust.contacttel<>'' and RTLessorCust.mobile<>'' then ' <font color=red><B>/</B></font> ' else '' end + RTLessorCust.mobile, c.codenc, " _
        &"case when RTLessorCust.dropdat is not null or RTLessorCust.canceldat is not null then '<font color=""red"">' end + ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLessorCust.TOWNSHIP1 + " _
        &"RTLessorCust.RADDR1 AS ADDR,RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, RTLESSORCUST.DOCKETDAT, " _
        &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.NEWBILLINGDAT,RTLESSORCUST.DUEDAT,case when RTLESSORCUST.freecode='Y' THEN RTLESSORCUST.freecode ELSE '' END,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT,ltrim(rtrim(RTLessorCust.IP11))+'.'+ltrim(rtrim(RTLessorCust.IP12))+'.'+ltrim(rtrim(RTLessorCust.IP13))+'.'+ltrim(rtrim(RTLessorCust.IP14)), RTLESSORCUST.MAC, " _
        &"case when RTLessorCUST.DUEDAT is not null and RTLessorCUST.dropdat is null and getdate() <= dateadd(s, -1, dateadd(d,1, RTLessorCUST.duedat)) then DATEDiFF(d,getdate(),RTLessorCUST.DUEDAT)+1 else 0 end,RTLessorCUST.RCVMONEY  " _
        &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
        &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 left outer join rtlessorcmtyline on " _
        &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
        &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
        &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
        &"left outer join RTCode c on c.code = rtlessorcust.casekind and c.kind ='O9' " _
        &"where RTLessorCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorCust.LINEQ1=" & ARYPARMKEY(1) & searchqry & " " & searchqry2 _
        &" order by case when RTLessorCust.dropdat is null and RTLessorCust.canceldat is null then 0 else 1 end, right('00'+RTLessorCust.IP14,3) "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>