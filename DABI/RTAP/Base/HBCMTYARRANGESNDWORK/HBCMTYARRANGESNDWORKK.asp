<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���Ͼ�u���u�@�~���@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  

  '���M�B�f�����f�֤H��
  IF EMPLY="T89015" or EMPLY="T90055" THEN
     functionOptName=" �C �L ;�f�ֽT�{;�f�֪���; �@ �o ;�@�o����;�]�ƺ��@;���v����"
     functionOptProgram="HBcmtyarrangesndworkpv.ASP;HBcmtyarrangesndworkCFMF.ASP;HBcmtyarrangesndworkCFMFR.ASP;HBcmtyarrangesndworkDROP.ASP;HBcmtyarrangesndworkDROPC.ASP;HBcmtyarrangeHardwareK.ASP;HBcmtyarrangesndworkLOGK.ASP"
     functionOptPrompt="N;Y;Y;Y;Y;N;N"
  ELSE
     functionOptName=" �C �L ; �� �� ;���ת���; �@ �o ;�@�o����;�]�ƺ��@;���v����"
     functionOptProgram="HBcmtyarrangesndworkpv.ASP;HBcmtyarrangesndworkF.ASP;HBcmtyarrangesndworkFR.ASP;HBcmtyarrangesndworkDROP.ASP;HBcmtyarrangesndworkDROPC.ASP;HBcmtyarrangeHardwareK.ASP;HBcmtyarrangesndworkLOGK.ASP"
     functionOptPrompt="N;Y;Y;Y;Y;N;N"
  END IF
  if userlevel=31 THEN
     functionOptName=" �C �L ; �� �� ;���ת���;�f�ֽT�{;�f�֪���; �@ �o ;�@�o����;�]�ƺ��@;���v����"
     functionOptProgram="HBcmtyarrangesndworkpv.ASP;HBcmtyarrangesndworkF.ASP;HBcmtyarrangesndworkFR.ASP;HBcmtyarrangesndworkCFMF.ASP;HBcmtyarrangesndworkCFMFR.ASP;HBcmtyarrangesndworkDROP.ASP;HBcmtyarrangesndworkDROPC.ASP;HBcmtyarrangeHardwareK.ASP;HBcmtyarrangesndworkLOGK.ASP"
     functionOptPrompt="N;Y;Y;Y;Y;Y;Y;N;N"
  END IF
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;��u�渹;���ϦW��;���Ϥ��;���u���;�w�p��u�H��;��ھ�u�H��;�@�o��;���פ�;�f�֤�" 
  sqlDelete="SELECT  HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE, HBCMTYARRANGESNDWORK.PRTNO, RTCmty.COMN AS COMNXX, " _
         &"'Hi-Building', HBCMTYARRANGESNDWORK.SNDDAT, RTObj.CUSNC, RTObj_1.SHORTNC,RTObj_2.CUSNC , RTObj_3.SHORTNC AS Expr2, " _
         &"HBCMTYARRANGESNDWORK.DROPDAT,  HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT " _
         &"FROM RTObj RTObj_3 RIGHT OUTER JOIN HBCMTYARRANGESNDWORK INNER JOIN RTCmty ON HBCMTYARRANGESNDWORK.COMQ1 = RTCmty.COMQ1 ON " _
         &"RTObj_3.CUSID = HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN  RTEmployee RTEmployee_1 INNER JOIN " _
         &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE in ('1','4') " _
         &"union " _
         &"SELECT HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE, HBCMTYARRANGESNDWORK.PRTNO,RTcustadslCmty.COMN AS COMNXX,'399A��', " _
         &"HBCMTYARRANGESNDWORK.SNDDAT, RTObj.CUSNC, RTObj_1.SHORTNC, RTObj_2.CUSNC AS Expr1, RTObj_3.SHORTNC AS Expr2, " _
         &"HBCMTYARRANGESNDWORK.DROPDAT, HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT FROM RTObj RTObj_3 RIGHT OUTER JOIN " _
         &"HBCMTYARRANGESNDWORK INNER JOIN RTcustadslCmty ON HBCMTYARRANGESNDWORK.COMQ1 = RTcustadslCmty.cutyid ON " _
         &"RTObj_3.CUSID = HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
         &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE='2' " _
         &"union " _
         &"SELECT HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE,HBCMTYARRANGESNDWORK.PRTNO,RTsparqadslCmty.COMN AS COMNXX,'399B��', " _
         &"HBCMTYARRANGESNDWORK.SNDDAT,RTObj.CUSNC,RTObj_1.SHORTNC,RTObj_2.CUSNC AS Expr1,RTObj_3.SHORTNC AS Expr2,HBCMTYARRANGESNDWORK.DROPDAT, " _ 
         &"HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT FROM RTObj RTObj_3 RIGHT OUTER JOIN HBCMTYARRANGESNDWORK INNER JOIN RTsparqadslCmty " _
         &"ON HBCMTYARRANGESNDWORK.COMQ1 = RTsparqadslCmty.cutyid ON RTObj_3.CUSID=HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
         &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
         &"HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
         &"HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE='3' " _
         &"ORDER BY COMNXX "
  dataTable="HBCMTYARRANGESNDWORK"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="HBcmtyarrangesndworkD.asp"
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
  searchProg="HBcmtyarrangesndworkS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  If searchQry="" Then
    ' searchQry=" RTCUSTADSLCMTY.CUTYID<>0 and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' "
     searchQry=" and HBCMTYARRANGESNDWORK.COMQ1=" & aryparmkey(0) & " and HBCMTYARRANGESNDWORK.comtype='" & aryparmkey(2) & "' "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
     searchQry2=" "
    searchShow="����" 
  ELSE
     SEARCHFIRST=FALSE
  End If
 
  sqllist="SELECT  HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE, HBCMTYARRANGESNDWORK.PRTNO, RTCmty.COMN AS COMNXX, " _
         &"'Hi-Building', HBCMTYARRANGESNDWORK.SNDDAT, case when RTObj.cusnc is null then RTObj_1.SHORTNC else RTObj.cusnc end ,case when RTObj_2.CUSNC is null then RTObj_3.SHORTNC  else RTObj_2.CUSNC end , " _
         &"HBCMTYARRANGESNDWORK.DROPDAT,  HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT " _
         &"FROM RTObj RTObj_3 RIGHT OUTER JOIN HBCMTYARRANGESNDWORK INNER JOIN RTCmty ON HBCMTYARRANGESNDWORK.COMQ1 = RTCmty.COMQ1 ON " _
         &"RTObj_3.CUSID = HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN  RTEmployee RTEmployee_1 INNER JOIN " _
         &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN " _
         &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE in ('1','4') " & searchqry  _
         &"union " _
         &"SELECT HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE, HBCMTYARRANGESNDWORK.PRTNO,RTcustadslCmty.COMN AS COMNXX,'399A��(����399)', " _
         &"HBCMTYARRANGESNDWORK.SNDDAT, case when RTObj.cusnc is null then RTObj_1.SHORTNC else RTObj.cusnc end ,case when RTObj_2.CUSNC is null then RTObj_3.SHORTNC else RTObj_2.CUSNC end , " _
         &"HBCMTYARRANGESNDWORK.DROPDAT, HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT FROM RTObj RTObj_3 RIGHT OUTER JOIN " _
         &"HBCMTYARRANGESNDWORK INNER JOIN RTcustadslCmty ON HBCMTYARRANGESNDWORK.COMQ1 = RTcustadslCmty.cutyid ON " _
         &"RTObj_3.CUSID = HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN " _
         &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
         &"RTObj RTObj_1 ON HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE='2' " & searchqry  _
         &"union " _
         &"SELECT HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE,HBCMTYARRANGESNDWORK.PRTNO,RTsparqadslCmty.COMN AS COMNXX,'399B��(�t��399)', " _
         &"HBCMTYARRANGESNDWORK.SNDDAT, case when RTObj.cusnc is null then RTObj_1.SHORTNC else RTObj.cusnc end ,case when RTObj_2.CUSNC is null then RTObj_3.SHORTNC else RTObj_2.CUSNC end , " _
         &"HBCMTYARRANGESNDWORK.DROPDAT, " _ 
         &"HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT FROM RTObj RTObj_3 RIGHT OUTER JOIN HBCMTYARRANGESNDWORK INNER JOIN RTsparqadslCmty " _
         &"ON HBCMTYARRANGESNDWORK.COMQ1 = RTsparqadslCmty.cutyid ON RTObj_3.CUSID=HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
         &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
         &"HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
         &"HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE='3' " &  searchqry  _
         &"union " _
         &"SELECT HBCMTYARRANGESNDWORK.COMQ1, HBCMTYARRANGESNDWORK.COMTYPE,HBCMTYARRANGESNDWORK.PRTNO,RTEBTCMTYH.COMN AS COMNXX,'�F��AVS499', " _
         &"HBCMTYARRANGESNDWORK.SNDDAT, case when RTObj.cusnc is null then RTObj_1.SHORTNC else RTObj.cusnc end ,case when RTObj_2.CUSNC is null then RTObj_3.SHORTNC else RTObj_2.CUSNC end , " _
         &"HBCMTYARRANGESNDWORK.DROPDAT, " _ 
         &"HBCMTYARRANGESNDWORK.CLOSEDAT,  HBCMTYARRANGESNDWORK.AUDITDAT FROM RTObj RTObj_3 RIGHT OUTER JOIN HBCMTYARRANGESNDWORK INNER JOIN RTEBTCMTYH " _
         &"ON HBCMTYARRANGESNDWORK.COMQ1 = RTEBTCMTYH.COMQ1 ON RTObj_3.CUSID=HBCMTYARRANGESNDWORK.REALCONSIGNEE LEFT OUTER JOIN " _
         &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
         &"HBCMTYARRANGESNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
         &"HBCMTYARRANGESNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCMTYARRANGESNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY " _
         &"where  HBCMTYARRANGESNDWORK.COMTYPE='5' " &  searchqry  _
         &"ORDER BY COMNXX "
         
         SESSION("LINEQ1")=ARYPARMKEY(1)

'response.Write SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>