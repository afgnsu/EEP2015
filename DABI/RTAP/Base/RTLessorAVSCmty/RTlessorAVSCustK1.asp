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
  functionOptName="�ΤᲾ��;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�վ���;�]�Ƭd��;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorAVSCustmove.asp;RTLessorAVSCustsndworkk.asp;RTLessorAVSCustContk.asp;RTLessorAVSCustReturnK.asp;RTLessorAVSCustDropK.asp;RTLessorAVSCustARK.asp;RTLessorAVSCustfaqK.asp;RTLessorAVSCustadjdayK.asp;RTLessorAVSCusttothardwareK.asp;RTLessorAVSCustCANCEL.asp;RTLessorAVSCustCANCELRTN.asp;RTLessorAVSCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;Y;Y;N;N"
  functionoptopen="2;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;�Τ�;���;�g��;ú��;IP;none;�ӽФ�;���u��;�}�l<br>�p�O��;�̪�<br>�����;�վ�<br>���;�����;��<br>��;�h����;�@�o��;�i��<BR>���;�s���q��"
  sqlDelete="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
                &"RTLessorAVSCust.CUSNC,RTLessorAVSCust.casekind,RTCODE_1.CODENC,RTCODE_2.CODENC, RTLessorAVSCUST.IP, " _
                &"RTLessorAVSCust.RADDR2, RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, " _
                &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.NEWBILLINGDAT,RTLessorAVSCUST.adjustday,RTLessorAVSCUST.DUEDAT, " _
                &"RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT, " _
                &"case when RTLessorAVSCUST.DUEDAT is null then 0 else DATEDiFF(d,getdate(),RTLessorAVSCUST.DUEDAT) end, RTLessorAVSCust.CONTACTTEL + RTLessorAVSCust.MOBILE " _
                &"FROM RTLessorAVSCust LEFT OUTER JOIN RTCounty ON RTLessorAVSCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorAVSCmtyH ON RTLessorAVSCust.COMQ1 = RTLessorAVSCmtyH.COMQ1 left outer join RTLessorAVScmtyline on " _
                &"RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and  RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on RTLessorAVScust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on RTLessorAVScust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
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
  keyListPageSize=25
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
     raddr=rsyy("cutnc")+rsyy("township")+rsyy("raddr")
  else
     COMN=""
     raddr=""
  end if
  rsYY.Close

  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" and RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) 
     searchShow="�����A���ϡJ" & comn & ", �a�}�J" &  raddr
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T93168" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 or userlevel =9 then DAreaID="<>'*'"
  
         sqlList="SELECT RTLessorAVSCust.COMQ1, RTLessorAVSCust.LINEQ1, RTLessorAVSCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCust.LINEQ1))) AS comqline, " _
                &"RTLessorAVSCust.CUSNC,RTCODE_3.CODENC,RTCODE_1.CODENC,RTCODE_2.CODENC, " _
                &"case when RTLessorAvsCust.dropdat is not null or RTLessorAvsCust.canceldat is not null then '<font color=""red"">' end + RTLessorAVSCUST.IP11+'.'+RTLessorAVSCUST.IP12+'.'+RTLessorAVSCUST.IP13+'.'+RTLessorAVSCUST.IP14, RTLessorAVSCust.RADDR2, " _
                &"RTLessorAVSCUST.APPLYDAT, RTLessorAVSCUST.FINISHDAT, " _
                &"RTLessorAVSCUST.STRBILLINGDAT,RTLessorAVSCUST.NEWBILLINGDAT,RTLessorAVSCUST.adjustday,RTLessorAVSCUST.DUEDAT, " _
                &"case when RTLESSORAVSCUST.freecode='Y' THEN RTLESSORAVSCUST.freecode ELSE '' END,RTLessorAVSCUST.DROPDAT,RTLessorAVSCUST.CANCELDAT, " _
                &"case when RTLessorAVSCUST.DUEDAT is null or RTLessorAvsCust.dropdat is not null or RTLessorAvsCust.canceldat is not null or RTLessorAvsCust.freecode='Y' then 0 else DATEDiFF(d,getdate(),RTLessorAVSCUST.DUEDAT) end AS VALIDDAT, " _
                &"RTLessorAVSCust.CONTACTTEL + CASE WHEN RTLessorAVSCust.CONTACTTEL ='' OR RTLessorAVSCust.MOBILE ='' THEN '' ELSE ' <font color=""red""><B>/</B></font> ' END + RTLessorAVSCust.MOBILE " _
                &"FROM RTLessorAVSCust LEFT OUTER JOIN RTCounty ON RTLessorAVSCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorAVSCmtyH ON RTLessorAVSCust.COMQ1 = RTLessorAVSCmtyH.COMQ1 left outer join RTLessorAVScmtyline on " _
                &"RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and  RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on RTLessorAVScust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on RTLessorAVScust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"left outer join rtcode rtcode_3 on rtlessorAvsCust.casekind=rtcode_3.code and rtcode_3.kind='O9' " _
                &"where RTLessorAVSCust.COMQ1=" & ARYPARMKEY(0) & " " & searchqry & " " & searchqry2 _
        		&" order by RTLessorAvsCust.dropdat, RTLessorAvsCust.canceldat, right('00'+RTLessorAvsCust.IP14,3) "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>