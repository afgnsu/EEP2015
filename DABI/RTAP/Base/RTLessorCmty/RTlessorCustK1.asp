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
  functionOptName="�ΤᲾ��;�˾����u;����@�~;�_���@�~;�h���@�~;�������I;�ȪA�ץ�;�վ���;�]�Ƭd��;���@�t IP;�@�@�@�o;�@�o����;���v����"
  functionOptProgram="RTLessorCustmove.asp;RTLessorCustsndworkk.asp;RTLessorCustContk.asp;RTLessorCustReturnK.asp;RTLessorCustDropK.asp;RTLessorCustARK.asp;RTLessorCustfaqK.asp;RTLessorCustadjdayK.asp;RTLessorCusttothardwareK.asp;RTLessorCustAutoIP.asp;RTLessorCustCANCEL.asp;RTLessorCustCANCELRTN.asp;RTLessorCustLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N;Y;N;Y;N;N"
  functionoptopen="2;1;1;1;1;1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;�Τ�;���;�g��;ú��;IP;none;�ӽФ�;���u��;�}�l<br>�p�O��;�̪�<br>�����;�վ�<br>���;�����;��<BR>��;�h����;�@�o��;�i��<BR>���;�s���q��"
  sqlDelete="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCust.CUSNC,RTLessorCust.casekind, RTCODE_1.CODENC,RTCODE_2.CODENC, " _
                &"RTLESSORCUST.IP, RTLessorCust.RADDR2, " _
                &"RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.NEWBILLINGDAT,RTLESSORCUST.adjustday,RTLESSORCUST.DUEDAT,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT, case when RTLESSORCUST.DUEDAT is null then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end, RTLessorCust.CONTACTTEL + RTLessorCust.MOBILE " _
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
     searchQry=" and RTLessorCust.COMQ1=" & ARYPARMKEY(0) 
     searchShow="�����A���ϡJ" & comn & ",�a�}�J" &  raddr
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
  
         sqlList="SELECT RTLessorCust.COMQ1, RTLessorCust.LINEQ1, RTLessorCust.CUSID, " _
                &"RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, " _
                &"RTLessorCust.CUSNC,rtcode_3.codenc,RTCODE_1.CODENC,RTCODE_2.CODENC, " _
                &"case when RTLessorCust.dropdat is not null or RTLessorCust.canceldat is not null then '<font color=""red"">' end + RTLESSORCUST.IP11+'.'+RTLESSORCUST.IP12+'.'+RTLESSORCUST.IP13+'.'+RTLESSORCUST.IP14, RTLessorCust.RADDR2, " _
                &"RTLESSORCUST.APPLYDAT, RTLESSORCUST.FINISHDAT, " _
                &"RTLESSORCUST.STRBILLINGDAT,RTLESSORCUST.NEWBILLINGDAT,RTLESSORCUST.adjustday,RTLESSORCUST.DUEDAT, " _
                &"case when RTLESSORCUST.freecode='Y' THEN RTLESSORCUST.freecode ELSE '' END,RTLESSORCUST.DROPDAT,RTLESSORCUST.CANCELDAT, " _
                &"case when RTLESSORCUST.DUEDAT is null or RTLessorCust.dropdat is not null or RTLessorCust.canceldat is not null or RTLessorCust.freecode='Y' then 0 else DATEDiFF(d,getdate(),RTLESSORCUST.DUEDAT) end AS VALIDDAT, " _
                &"RTLessorCust.CONTACTTEL + CASE WHEN RTLessorCust.CONTACTTEL ='' or RTLessorCust.mobile ='' THEN '' ELSE ' <font color=""red""><B>/</B></font> ' END + RTLessorCust.MOBILE "_
                &"FROM RTLessorCust LEFT OUTER JOIN RTCounty ON RTLessorCust.CUTID1 = RTCounty.CUTID LEFT OUTER JOIN " _
                &"RTLessorCmtyH ON RTLessorCust.COMQ1 = RTLessorCmtyH.COMQ1 left outer join rtlessorcmtyline on " _
                &"rtlessorcust.comq1=rtlessorcmtyline.comq1 and  rtlessorcust.lineq1=rtlessorcmtyline.lineq1 " _
                &"left outer join rtcode rtcode_1 on rtlessorcust.paycycle=rtcode_1.code and rtcode_1.kind='M8' " _
                &"left outer join rtcode rtcode_2 on rtlessorcust.payTYPE=rtcode_2.code and rtcode_2.kind='M9' " _
                &"left outer join rtcode rtcode_3 on rtlessorcust.casekind=rtcode_3.code and rtcode_3.kind='O9' " _
                &"where RTLessorCust.COMQ1=" & ARYPARMKEY(0) & " " & searchqry & " " & searchqry2 _
        		&" order by RTLessorCust.dropdat, RTLessorCust.canceldat, right('00'+RTLessorCust.IP14,3) "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>