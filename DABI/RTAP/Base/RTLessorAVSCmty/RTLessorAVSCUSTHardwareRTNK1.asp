<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City���~������ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���൲��;���ת���;�������;�C�L�����;���ʰO��"
  functionOptProgram="RTLessorAVSCustHardwareRTNF.ASP;RTLessorAVSCustHardwareRTNFR.ASP;RTLessorAVSCustHardwareRTNDTLK.ASP;RTLessorAVSCustHardwareRTNP.ASP;RTLessorAVSCustHardwareRTNlogk.ASP"
  functionOptPrompt="Y;Y;N;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="����渹;�D�u;���ϦW;�������O;����ӽФ�;����ӽФH;��ڲ���H;���൲�פ�;���פH��;�@�o��;�@�o�H��;���u�渹;�ಾ���H��;����ƶq"
  sqlDelete="SELECT  RTLessorAVSCustRTNHardware.RCVPRTNO AS RCVPRTNO, " _
                       &" CASE WHEN RTLessorAVSCustRTNHardware.DATASRC ='01' THEN '�˾����u���'  WHEN  RTLessorAVSCustRTNHardware.DATASRC ='02'  THEN '������ڬ��u���' WHEN RTLessorAVSCustRTNHardware.DATASRC = '03' THEN '�_�����ڬ��u���' ELSE '' END, " _
                       &" RTLessorAVSCustRTNHardware.APPLYDAT AS APPLYDAT, " _
                       &" CASE WHEN RTObj_7.CUSNC='' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE  RTObj_7.CUSNC END , " _
                       &" CASE WHEN RTObj_1.CUSNC='' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                       &" RTLessorAVSCustRTNHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5, RTLessorAVSCustRTNHardware.CANCELDAT AS CANCELDAT, RTObj_5.CUSNC AS CUSNC6, " _
                       &" RTLessorAVSCustRTNHardware.PRTNO AS PRTNO, " _
                       &" RTObj_6.CUSNC AS cusnc7,SUM(RTLessorAVSCustRTNHardwareDTL.QTY) " _
&"  FROM             RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID RIGHT OUTER JOIN " _
                       &" RTLessorAVSCustRTNHardware ON RTEmployee_4.EMPLY = RTLessorAVSCustRTNHardware.RCVUSR LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID ON " _
                       &" RTLessorAVSCustRTNHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                       &" RTLessorAVSCustRTNHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                       &" RTLessorAVSCustRTNHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                       &" RTLessorAVSCustRTNHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                       &" RTLessorAVSCustRTNHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                       &" RTObj RTObj_7 INNER JOIN RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                       &" RTLessorAVSCustRTNHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorAVSCustRTNHardwareDTL ON " _
                       &" RTLessorAVSCustRTNHardware.RCVPRTNO=RTLessorAVSCustRTNHardwareDTL.RCVPRTNO " _
                       &" where " & searchqry & " " _
                       &" GROUP BY  RTLessorAVSCustRTNHardware.RCVPRTNO , " _
                       &" CASE WHEN RTLessorAVSCustRTNHardware.DATASRC ='01' THEN '�˾����u���'  WHEN  RTLessorAVSCustRTNHardware.DATASRC ='02'  THEN '������ڬ��u���' WHEN RTLessorAVSCustRTNHardware.DATASRC = '03' THEN '�_�����ڬ��u���' ELSE '' END, " _
                       &" RTLessorAVSCustRTNHardware.APPLYDAT , " _
                       &" CASE WHEN RTObj_7.CUSNC='' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE  RTObj_7.CUSNC END , " _
                       &" CASE WHEN RTObj_1.CUSNC='' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                       &" RTLessorAVSCustRTNHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorAVSCustRTNHardware.PRTNO, " _
                       &" RTLessorAVSCustRTNHardware.CANCELDAT, RTObj_6.CUSNC " _
                       &" where RTLessorAVSCustRTNHardware.rcvprtno='' "
  dataTable="RTLessorAVSCustRTNHardware"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTLessorAVSCustHardwareRTND.ASP"
  datawindowFeature=""
  searchWindowFeature="width=350,height=250,scrollbars=yes"
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
  searchProg="RTLessorAVSCustHardwareRTNS1.ASP"
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
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTLessorAVSCustRTNHardware.prtno<>'' and RTLessorAVSCustRTNHardware.canceldat is null and RTLessorAVSCustRTNHardware.closedat is null "
     searchShow="�|�����൲��"
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 then DAreaID="<>'*'"
  
          sqlList="SELECT RTLessorAVSCustRTNHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCMTYLINEDROPSNDWORK.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCMTYLINEDROPSNDWORK.LINEQ1))) AS comqline, RTLessorAVSCMTYH.COMN, " _
                 &"RTCODE_1.CODENC,RTLessorAVSCustRTNHardware.APPLYDAT AS APPLYDAT, " _ 
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorAVSCustRTNHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorAVSCustRTNHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorAVSCustRTNHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorAVSCustRTNHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorAVSCustRTNHardware ON RTEmployee_4.EMPLY = RTLessorAVSCustRTNHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorAVSCustRTNHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorAVSCustRTNHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorAVSCustRTNHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorAVSCustRTNHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorAVSCustRTNHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorAVSCustRTNHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorAVSCustRTNHardwareDTL ON " _
                 &"RTLessorAVSCustRTNHardware.RCVPRTNO = RTLessorAVSCustRTNHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLessorAVSCMTYLINEDROPSNDWORK ON RTLessorAVSCustRTNHardware.prtno = RTLessorAVSCMTYLINEDROPSNDWORK.prtno LEFT OUTER JOIN " _
                 &"RTLessorAVSCMTYH ON RTLessorAVSCMTYLINEDROPSNDWORK.COMQ1 = RTLessorAVSCMTYH.COMQ1  LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorAVSCustRTNHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='O1' " _
                 &"WHERE  RTLessorAVSCustRTNHardware.prtno <> '' AND RTLessorAVSCustRTNHardware.datasrc = '01' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorAVSCustRTNHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCMTYLINEDROPSNDWORK.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorAVSCMTYLINEDROPSNDWORK.LINEQ1))), " _
                 &"RTLessorAVSCMTYH.COMN,RTCODE_1.CODENC,RTLessorAVSCustRTNHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorAVSCustRTNHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorAVSCustRTNHardware.PRTNO, " _
                 &"RTLessorAVSCustRTNHardware.CANCELDAT, RTObj_6.CUSNC " 
                                                                                             

   'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>