<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ET-City�޲z�t��"
  title="ET-City���~��γ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="��ε���;���ת���;��Ω���;�C�L��γ�;���ʰO��"
  functionOptProgram="RTLessorCustHardwareRCVF.ASP;RTLessorCustHardwareRCVFR.ASP;RTLessorCustHardwareRCVDTLK.ASP;RTLessorCustHardwareRCVP.ASP;RTLessorCustHardwareRCVlogk.ASP"
  functionOptPrompt="Y;Y;N;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="��γ渹;�D�u;���ϦW;�Τ�W;������O;��ΥӽФ�;��ΥӽФH;��ڻ�ΤH;��ε��פ�;���פH��;�@�o��;�@�o�H��;���u�渹;���γ�H��;��μƶq"
  sqlDelete="SELECT  RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO, " _
                       &" CASE WHEN RTLessorCustRCVHardware.DATASRC ='01' THEN '�˾����u���'  WHEN  RTLessorCustRCVHardware.DATASRC ='02'  THEN '������ڬ��u���' WHEN RTLessorCustRCVHardware.DATASRC = '03' THEN '�_�����ڬ��u���' ELSE '' END, " _
                       &" RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                       &" CASE WHEN RTObj_7.CUSNC='' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE  RTObj_7.CUSNC END , " _
                       &" CASE WHEN RTObj_1.CUSNC='' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                       &" RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5, RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, RTObj_5.CUSNC AS CUSNC6, " _
                       &" RTLessorCustRCVHardware.PRTNO AS PRTNO, " _
                       &" RTObj_6.CUSNC AS cusnc7,SUM(RTLessorCustRCVHardwareDTL.QTY) " _
&"  FROM             RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID RIGHT OUTER JOIN " _
                       &" RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID ON " _
                       &" RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                       &" RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                       &" RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                       &" RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
                       &" RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                       &" RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                       &" RTObj RTObj_7 INNER JOIN RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                       &" RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                       &" RTLessorCustRCVHardware.RCVPRTNO=RTLessorCustRCVHardwareDTL.RCVPRTNO " _
                       &" where " & searchqry & " " _
                       &" GROUP BY  RTLessorCustRCVHardware.RCVPRTNO , " _
                       &" CASE WHEN RTLessorCustRCVHardware.DATASRC ='01' THEN '�˾����u���'  WHEN  RTLessorCustRCVHardware.DATASRC ='02'  THEN '������ڬ��u���' WHEN RTLessorCustRCVHardware.DATASRC = '03' THEN '�_�����ڬ��u���' ELSE '' END, " _
                       &" RTLessorCustRCVHardware.APPLYDAT , " _
                       &" CASE WHEN RTObj_7.CUSNC='' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE  RTObj_7.CUSNC END , " _
                       &" CASE WHEN RTObj_1.CUSNC='' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                       &" RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                       &" RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _
                       &" where RTLessorCustRCVHardware.rcvprtno='' "
  dataTable="RTLessorCustRCVHardware"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTLessorCustHardwareRCVD.ASP"
  datawindowFeature=""
  searchWindowFeature="width=350,height=160,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorCustHardwareRCVS2.ASP"
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
     searchQry=" RTLessorCustrcvhardware.prtno<>'' and RTLessorCustrcvhardware.canceldat is null and RTLessorCustrcvhardware.closedat is null "
     searchShow="�|����ε���"
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
  
          sqlList="SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _ 
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCUSTHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCUSTHARDWARE.rcvprtno LEFT OUTER JOIN " _
                 &"RTLESSORCUST ON RTLESSORCUSTHARDWARE.CUSID = RTLESSORCUST.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCUST.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '01' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN, RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _
                 &"UNION " _
                 &"SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCUSTcontHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCUSTcontHARDWARE.rcvprtno LEFT OUTER JOIN " _
                 &"RTLESSORCUST ON RTLESSORCUSTcontHARDWARE.CUSID = RTLESSORCUST.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCUST.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '02' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN, RTLESSORCUST.CUSNC, RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _
                 &"UNION " _
                 &"SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCUSTRETURNHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCUSTRETURNHARDWARE.rcvprtno LEFT OUTER JOIN " _
                 &"RTLESSORCUST ON RTLESSORCUSTRETURNHARDWARE.CUSID = RTLESSORCUST.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCUST.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '03' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN, RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _       
                 &"UNION " _
                 &"SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"RTLESSORCUST.CUSNC,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCUSTfaqHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCUSTfaqHARDWARE.rcvprtno LEFT OUTER JOIN " _
                 &"RTLESSORCUST ON RTLESSORCUSTfaqHARDWARE.CUSID = RTLESSORCUST.CUSID LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCUST.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '04' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLessorCust.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN, RTLESSORCUST.CUSNC, RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _
                 &"UNION " _
                 &"SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylineHARDWARE.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylineHARDWARE.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"'',RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCmtylineHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCmtylineHARDWARE.rcvprtno LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCmtylineHARDWARE.COMQ1 = RTLESSORCMTYH.COMQ1 LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '05' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylineHARDWARE.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylineHARDWARE.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN,RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC " _
                 &"UNION " _
                 &"SELECT RTLessorCustRCVHardware.RCVPRTNO AS RCVPRTNO,  RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylinefaqHARDWARE.COMQ1))) " _
                 &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylinefaqHARDWARE.LINEQ1))) AS comqline, RTLESSORCMTYH.COMN, " _
                 &"'',RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT AS APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT AS CLOSEDAT, RTObj_4.CUSNC AS CUSNC5,RTLessorCustRCVHardware.CANCELDAT AS CANCELDAT, " _
                 &"RTObj_5.CUSNC AS CUSNC6, RTLessorCustRCVHardware.PRTNO AS PRTNO, RTObj_6.CUSNC AS cusnc7, " _
                 &"SUM(RTLessorCustRCVHardwareDTL.QTY) " _
                 &"FROM   RTEmployee RTEmployee_4 INNER JOIN RTObj RTObj_6 ON RTEmployee_4.CUSID = RTObj_6.CUSID " _
                 &"RIGHT OUTER JOIN RTLessorCustRCVHardware ON RTEmployee_4.EMPLY = RTLessorCustRCVHardware.RCVUSR " _
                 &"LEFT OUTER JOIN RTEmployee RTEmployee_3 INNER JOIN RTObj RTObj_5 ON RTEmployee_3.CUSID = RTObj_5.CUSID " _
                 &"ON RTLessorCustRCVHardware.CANCELUSR = RTEmployee_3.EMPLY LEFT OUTER JOIN RTEmployee RTEmployee_2 " _
                 &"INNER JOIN RTObj RTObj_4 ON RTEmployee_2.CUSID = RTObj_4.CUSID ON " _
                 &"RTLessorCustRCVHardware.CLOSEUSR = RTEmployee_2.EMPLY LEFT OUTER JOIN RTObj RTObj_3 ON " _
                 &"RTLessorCustRCVHardware.REALCONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN RTObj RTObj_2 ON " _
                 &"RTLessorCustRCVHardware.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN RTEmployee RTEmployee_1 " _
                 &"INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
                 &"RTLessorCustRCVHardware.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_7 INNER JOIN " _
                 &"RTEmployee RTEmployee_5 ON RTObj_7.CUSID = RTEmployee_5.CUSID ON " _
                 &"RTLessorCustRCVHardware.ASSIGNENGINEER = RTEmployee_5.EMPLY LEFT OUTER JOIN RTLessorCustRCVHardwareDTL ON " _
                 &"RTLessorCustRCVHardware.RCVPRTNO = RTLessorCustRCVHardwareDTL.RCVPRTNO LEFT OUTER JOIN " _
                 &"RTLESSORCmtylinefaqHARDWARE ON RTLessorCustRCVHardware.rcvprtno = RTLESSORCmtylinefaqHARDWARE.rcvprtno LEFT OUTER JOIN RTLESSORCMTYH ON " _
                 &"RTLESSORCmtylinefaqHARDWARE.COMQ1 = RTLESSORCMTYH.COMQ1  LEFT OUTER JOIN RTCODE RTCODE_1 ON RTLessorCustRCVHardware.DATASRC=RTCODE_1.CODE AND RTCODE_1.KIND='N8' " _
                 &"WHERE  RTLessorCustrcvhardware.prtno <> '' AND RTLessorCustrcvhardware.datasrc = '06' AND " & searchqry & " " _
                 &"GROUP BY  RTLessorCustRCVHardware.RCVPRTNO, RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylinefaqHARDWARE.COMQ1))) + '-' + RTRIM(LTRIM(CONVERT(char(6), RTLESSORCmtylinefaqHARDWARE.LINEQ1))), " _
                 &"RTLESSORCMTYH.COMN, RTCODE_1.CODENC,RTLessorCustRCVHardware.APPLYDAT, " _
                 &"CASE WHEN RTObj_7.CUSNC = '' OR RTObj_7.CUSNC IS NULL THEN RTObj_2.SHORTNC ELSE RTObj_7.CUSNC END, " _
                 &"CASE WHEN RTObj_1.CUSNC = '' OR RTObj_1.CUSNC IS NULL THEN RTObj_3.SHORTNC ELSE RTObj_1.CUSNC END, " _
                 &"RTLessorCustRCVHardware.CLOSEDAT, RTObj_4.CUSNC, RTObj_5.CUSNC, RTLessorCustRCVHardware.PRTNO, " _
                 &"RTLessorCustRCVHardware.CANCELDAT, RTObj_6.CUSNC "                                                                                                

   'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>