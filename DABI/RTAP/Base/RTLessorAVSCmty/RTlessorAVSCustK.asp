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
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���צ���;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�]�ƫO�ަ��ڦC�L;�ΤᲾ��;�վ���;�]�Ƭd��;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorAVSCustRepairK.asp;RTLessorAVSCustsndworkk.asp;RTLessorAVSCustContk.asp;RTLessorAVSCustReturnK.asp;RTLessorAVSCustDropK.asp;RTLessorAVSCustARK.asp;RTLessorAVSCustfaqK.asp;/RTAP/REPORT/Common/RTStorageReceiptAVS.asp;RTLessorAVSCustmove.asp;RTLessorAVSCustadjdayK.asp;RTLessorAVSCusttothardwareK.asp;RTLessorAVSCustCANCEL.asp;RTLessorAVSCustCANCELRTN.asp;RTLessorAVSCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;N;N;N;Y;Y;N"
  functionoptopen=  "1;1;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;����;�Τ�;�˾��a�};TEL <B>/</B> ���;���;IP��};�ӽФ�;���u��;������;�}�l�p�O;�̪�<br>�����;�����;����;�h����;�@�o��;none;none;�i��<BR>���"
  sqlDelete="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
                &"RTLessorAVSCmtyH.COMN,RTLessorAVSCust.CUSNC, RTLessorAVSCust.raddr2, " _
                &"RTLessorAVSCust.contacttel + case when RTLessorAVSCust.contacttel<>'' and RTLessorAVSCust.mobile<>'' then '<font color=red><B>/</B></font>' else '' end + RTLessorAVSCust.mobile, " _
                &"RTLessorAVSCust.casekind, RTLessorAVSCust.IP11, RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, RTLessorAVSCUST.DOCKETDAT, " _
                &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.NEWBILLINGDAT,RTLessorAVSCUST.DUEDAT, " _
                &"RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT, "_
                &"ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), "_
                &"RTLessorAVSCUST.MAC, "_
                &"case when RTLessorAVSCUST.DUEDAT is not null and RTLessorAVSCUST.dropdat is null then DATEDiFF(d,getdate(),RTLessorAVSCUST.DUEDAT)+1 else 0 end " _
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
  keyListPageSize=30
  searchProg="RTLessorAVSCusts.asp"
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
  sqlYY="select * from RTLessorAVSCmtyH LEFT OUTER JOIN RTCOUNTY ON RTLessorAVSCmtyH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTLessorAVSCmtyLine LEFT OUTER JOIN RTCOUNTY ON RTLessorAVSCmtyLine.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
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
     'searchQry=" and RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorAVSCust.LINEQ1=" & ARYPARMKEY(1)
     'searchShow="����"
	'�ק�A
	if ARYPARMKEY(2) ="" then 
		searchQry=" and RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorAVSCust.LINEQ1=" & ARYPARMKEY(1)
		searchShow="����"
	else
		searchQry=" and RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorAVSCust.LINEQ1=" & ARYPARMKEY(1) & " AND RTLessorAVSCust.CUSID='" & ARYPARMKEY(2) &"' "
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
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  'if userlevel=31 or userlevel =1  or userlevel =5 or userlevel =9 then DAreaID="<>'*'"
  
    sqlList="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, " _
        &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
        &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
        &"RTLessorAVSCmtyH.COMN,RTLessorAVSCust.CUSNC,RTLessorAVSCust.raddr2, " _
        &"RTLessorAVSCust.contacttel + case when RTLessorAVSCust.contacttel<>'' and RTLessorAVSCust.mobile<>'' then ' <font color=red><B>/</B></font> ' else '' end + RTLessorAVSCust.mobile, c.codenc," _
        &"case when RTLessorAvsCust.dropdat is not null or RTLessorAvsCust.canceldat is not null then '<font color=""red"">' end +ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, RTLessorAVSCUST.DOCKETDAT," _
        &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.NEWBILLINGDAT,RTLessorAVSCUST.DUEDAT,case when RTLESSORAVSCUST.freecode='Y' THEN RTLESSORAVSCUST.freecode ELSE '' END,RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT,ltrim(rtrim(RTLessorAVSCust.IP11))+'.'+ltrim(rtrim(RTLessorAVSCust.IP12))+'.'+ltrim(rtrim(RTLessorAVSCust.IP13))+'.'+ltrim(rtrim(RTLessorAVSCust.IP14)), RTLessorAVSCUST.MAC, "_
        &"case when RTLessorAVSCUST.DUEDAT is not null and RTLessorAVSCUST.dropdat is null and getdate() <= dateadd(s, -1, dateadd(d,1, RTLessorAVSCUST.duedat)) then DATEDiFF(d,getdate(),RTLessorAVSCUST.DUEDAT)+1 else 0 end " _
        &"FROM RTLessorAVSCust LEFT OUTER JOIN RTCounty ON RTLessorAVSCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
        &"RTLessorAVSCmtyH ON RTLessorAVSCust.COMQ1 = RTLessorAVSCmtyH.COMQ1 left outer join RTLessorAVScmtyline on " _
        &"RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and  RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 " _
        &"left outer join rtcode rtcode_1 on RTLessorAVScust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
        &"left outer join rtcode rtcode_2 on RTLessorAVScust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
        &"left outer join RTCode c on c.code = rtlessoravscust.casekind and c.kind ='O9' " _
        &"where RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) & " AND RTLessorAVSCust.LINEQ1=" & ARYPARMKEY(1) & searchqry & " " & searchqry2 _
        &" order by case when RTLessorAvsCust.dropdat is null and RTLessorAvsCust.canceldat is null then 0 else 1 end, right('00'+RTLessorAvsCust.IP14,3) "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>