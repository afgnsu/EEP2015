<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�ȡ@��;�[�J����"
  functionOptProgram="RTCustK.asp;RTJOINcmtycfm.ASP"
  functionOptPrompt="N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Ǹ�;���ϦW��;HB���X;IP;�]�Ʀ�m;ADSL���q��;�`���;�w���u;�v���m" 
  sqlDelete="SELECT RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
           &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, RTCustAdslCmty.ADSLAPPLY, " _
           &"SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtcustadsl.finishdat IS NOT NULL OR rtcustadsl.finishdat <> '' THEN 1 ELSE 0 END), " _           
           &"SUM(CASE WHEN rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '' THEN 1 ELSE 0 END) " _
           &"FROM RTCustAdslCmty LEFT OUTER JOIN RTCustADSL ON RTCustAdslCmty.CUTYID = RTCustADSL.COMQ1 " _
           &"WHERE (RTCustAdslCmty.COMN <> '*') " _
           &"GROUP BY  RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
           &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, " _
           &"RTCustAdslCmty.ADSLAPPLY " _
           &"ORDER BY  RTCustAdslCmty.equipaddr "
  dataTable="RTCUSTADSLCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTCmtyD.asp"
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
  keyListPageSize=20
  searchProg="RTCmtyS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=true
  If searchQry="" Then
     searchQry=" RTCUSTADSLCMTY.CUTYID<>0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
'  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
'  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
'  set connXX=server.CreateObject("ADODB.connection")
'  set rsXX=server.CreateObject("ADODB.recordset")
'  dsnxx="DSN=XXLIB"
'  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
'  connxx.Open dsnxx
'  rsxx.Open sqlxx,connxx
'  if not rsxx.EOF then
'     usergroup=rsxx("group")
'  else
'     usergroup=""
'  end if
'  rsxx.Close
'  connxx.Close
'  set rsxx=nothing
'  set connxx=nothing
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
'  Domain=Mid(Emply,1,1)
'  select case Domain
'         case "T"
'            DAreaID="='A1'"
'         case "C"
'            DAreaID="='A2'"         
'         case "K"
'            DAreaID="='A3'"         
''         case else
'            DareaID="=''"
 ' end select
  '�����D�ޥiŪ���������
 ' if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" OR _
 '    Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="P92010" then
 '    DAreaID="<>'*'"
 ' end if
  '��T���޲z���iŪ���������
 ' if userlevel=31 then DAreaID="<>'*'"
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
'
sqllist="SELECT RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
       &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, RTCustAdslCmty.ADSLAPPLY, " _
       &"SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.cusid <> '' THEN 1 ELSE 0 END), " _ 
       &"SUM(CASE WHEN rtcustadsl.finishdat IS NOT NULL OR rtcustadsl.finishdat <> '' THEN 1 ELSE 0 END), " _           
       &"SUM(CASE WHEN rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '' THEN 1 ELSE 0 END) " _     
       &"FROM RTCustAdslCmty LEFT OUTER JOIN RTCustADSL ON RTCustAdslCmty.CUTYID = RTCustADSL.COMQ1 " _
       &"WHERE (RTCustAdslCmty.COMN <> '*') and " & searchqry _
       &"GROUP BY  RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
       &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, " _
       &"RTCustAdslCmty.ADSLAPPLY " _
       &"ORDER BY  RTCustAdslCmty.equipaddr "
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>