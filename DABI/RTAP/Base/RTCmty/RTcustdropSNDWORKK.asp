<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building�޲z�t��"
  title="����HB599�h���������u�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �C �L ;���u����;�����u����;���ת���; �@ �o ;�@�o����;���v����"
  functionOptProgram="RTCUSTdropSNDPV.asp;RTCUSTdropsndworkF.asp;RTCUSTdropsndworkUF.asp;RTCUSTdropsndworkFR.asp;RTCUSTdropsndworkdrop.asp;RTCUSTdropsndworkdropc.asp;RTCUSTdropsndworkLOGK.asp"
  functionOptPrompt="N;Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;���ϦW��;���u�渹;���u���;�w�w�I�u��;��ڬI�u��;���������;���u���פ�;�����u���פ�;�@�o��;���������;�����f�֤�;�w�s�����;�w�s�f�֤�"
  sqlDelete="SELECT RTCUSTdropsndwork.CUSID,RTCUSTdropsndwork.entryno, RTCUSTdropsndwork.PRTNO, RTCMTY.COMN, RTCUSTdropsndwork.PRTNO, " _
           &"RTCUSTdropsndwork.SENDWORKDAT,  CASE WHEN rtobj.cusnc <> '' THEN rtobj.cusnc ELSE rtobj_1.shortnc END, " _
           &"CASE WHEN rtobj_2.cusnc <> '' THEN rtobj_2.cusnc ELSE rtobj_3.shortnc END, " _
           &"RTCUSTdropsndwork.CLOSEDAT,RTCUSTdropsndwork.finishDAT,RTCUSTdropsndwork.UNCLOSEDAT,RTCUSTdropsndwork.DROPDAT,RTCUSTdropsndwork.BONUSCLOSEYM, RTCUSTdropsndwork.BONUSFINCHK, RTCUSTdropsndwork.STOCKCLOSEYM, " _
           &"RTCUSTdropsndwork.STOCKFINCHK " _
           &"FROM  RTObj RTObj_3 RIGHT OUTER JOIN RTCUSTdropsndwork ON " _
           &"RTObj_3.CUSID = RTCUSTdropsndwork.REALCONSIGNEE LEFT OUTER JOIN RTEmployee RTEmployee_1 LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON RTCUSTdropsndwork.REALENGINEER = RTEmployee_1.EMPLY " _
           &"LEFT OUTER JOIN RTObj RTObj_1 ON RTCUSTdropsndwork.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTCUSTdropsndwork.ASSIGNENGINEER = RTEmployee.EMPLY " _
           &"LEFT OUTER JOIN RTCMTY ON RTCUSTdropsndwork.comq1 = RTCMTY.COMQ1 " 
  dataTable="RTCUSTdropsndwork"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTCUSTdropsndworkD.asp"
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
  keyListPageSize=25
  searchProg="self"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.COMQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.COMQ1 <> 0
  '----
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from rtobj where cusid='" & ARYPARMKEY(0) & "' "
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     cusnc=rsYY("cusnc")
  else
     cusnc=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTCUSTdropsndwork.CUSID='" & ARYPARMKEY(0) & "' AND RTCUSTdropsndwork.ENTRYNO=" & ARYPARMKEY(1)
     searchShow="�Τ�W�١J" & cusnc
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="P92010" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
         sqlList="SELECT RTCUSTdropsndwork.CUSID,RTCUSTdropsndwork.entryno, RTCUSTdropsndwork.PRTNO, RTCMTY.COMN, RTCUSTdropsndwork.PRTNO,  " _
           &"RTCUSTdropsndwork.SENDWORKDAT,  CASE WHEN rtobj.cusnc <> '' THEN rtobj.cusnc ELSE rtobj_1.shortnc END, " _
           &"CASE WHEN rtobj_2.cusnc <> '' THEN rtobj_2.cusnc ELSE rtobj_3.shortnc END, " _
           &"RTCUSTdropsndwork.CLOSEDAT,RTCUSTdropsndwork.finishDAT,RTCUSTdropsndwork.UNCLOSEDAT,RTCUSTdropsndwork.DROPDAT,RTCUSTdropsndwork.BONUSCLOSEYM, RTCUSTdropsndwork.BONUSFINCHK, RTCUSTdropsndwork.STOCKCLOSEYM, " _
           &"RTCUSTdropsndwork.STOCKFINCHK " _
           &"FROM  RTObj RTObj_3 RIGHT OUTER JOIN RTCUSTdropsndwork ON " _
           &"RTObj_3.CUSID = RTCUSTdropsndwork.REALCONSIGNEE LEFT OUTER JOIN RTEmployee RTEmployee_1 LEFT OUTER JOIN " _
           &"RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON RTCUSTdropsndwork.REALENGINEER = RTEmployee_1.EMPLY " _
           &"LEFT OUTER JOIN RTObj RTObj_1 ON RTCUSTdropsndwork.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTCUSTdropsndwork.ASSIGNENGINEER = RTEmployee.EMPLY " _
           &"LEFT OUTER JOIN RTCMTY ON RTCUSTdropsndwork.comq1 = RTCMTY.COMQ1 " _
           &"where " & searchqry
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>