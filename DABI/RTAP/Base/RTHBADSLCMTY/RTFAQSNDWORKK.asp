<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="ADSL��Hibuilding�޲z�t��"
  title="���ϥD�����׬��u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���u����;�����u����;���ת���; �@ �o ;�@�o����;���v����"
  functionOptProgram="RTFAQsndworkF.asp;RTFAQsndworkUF.asp;RTFAQsndworkFR.asp;RTFAQsndworkdrop.asp;RTFAQsndworkdropc.asp;RTFAQsndworkLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;���u�渹;���u���;�w�w�I�u��;��ڬI�u��;���u���פ�;�����u���פ�;�@�o��;���������;�����f�֤�;�w�s�����;�w�s�f�֤�"
  sqlDelete="SELECT HBADSLCMTYFIXSNDWORK.FIXNO, HBADSLCMTYFIXSNDWORK.PRTNO, HBADSLCMTYFIXSNDWORK.SENDWORKDAT, " _
           &"CASE WHEN RTObj_4.CUSNC IS NULL OR RTObj_4.CUSNC = '' THEN RTObj_1.SHORTNC ELSE RTObj_4.CUSNC END, " _
           &"CASE WHEN RTObj_2.CUSNC IS NULL OR RTObj_2.CUSNC = '' THEN RTObj_3.SHORTNC ELSE RTObj_2.CUSNC END, " _
           &"HBADSLCMTYFIXSNDWORK.CLOSEDAT, HBADSLCMTYFIXSNDWORK.UNCLOSEDAT, HBADSLCMTYFIXSNDWORK.DROPDAT, " _
           &"HBADSLCMTYFIXSNDWORK.BONUSCLOSEYM, HBADSLCMTYFIXSNDWORK.BONUSCLOSEDAT, HBADSLCMTYFIXSNDWORK.STOCKCLOSEYM, " _
           &"HBADSLCMTYFIXSNDWORK.STOCKCLOSEDAT " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN HBADSLCMTYFIXSNDWORK ON RTObj_3.CUSID = HBADSLCMTYFIXSNDWORK.REALCONSIGNEE " _
           &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"HBADSLCMTYFIXSNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
           &"HBADSLCMTYFIXSNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj RTObj_4 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_4.CUSID = RTEmployee_2.CUSID ON HBADSLCMTYFIXSNDWORK.ASSIGNENGINEER = RTEmployee_2.EMPLY "
  dataTable="HBADSLCMTYFIXSNDWORK"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTFAQSNDWORKD.asp"
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
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" HBADSLCMTYFIXSNDWORK.FIXNO='" & aryparmkey(0) & "' "
     searchShow="�ȶD�渹�J"& aryparmkey(0) 
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
            DAreaID="='A1'"
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
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT HBADSLCMTYFIXSNDWORK.FIXNO, HBADSLCMTYFIXSNDWORK.PRTNO, HBADSLCMTYFIXSNDWORK.SENDWORKDAT, " _
           &"CASE WHEN RTObj_4.CUSNC IS NULL OR RTObj_4.CUSNC = '' THEN RTObj_1.SHORTNC ELSE RTObj_4.CUSNC END, " _
           &"CASE WHEN RTObj_2.CUSNC IS NULL OR RTObj_2.CUSNC = '' THEN RTObj_3.SHORTNC ELSE RTObj_2.CUSNC END, " _
           &"HBADSLCMTYFIXSNDWORK.CLOSEDAT, HBADSLCMTYFIXSNDWORK.UNCLOSEDAT, HBADSLCMTYFIXSNDWORK.DROPDAT, " _
           &"HBADSLCMTYFIXSNDWORK.BONUSCLOSEYM, HBADSLCMTYFIXSNDWORK.BONUSCLOSEDAT, HBADSLCMTYFIXSNDWORK.STOCKCLOSEYM, " _
           &"HBADSLCMTYFIXSNDWORK.STOCKCLOSEDAT " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN HBADSLCMTYFIXSNDWORK ON RTObj_3.CUSID = HBADSLCMTYFIXSNDWORK.REALCONSIGNEE " _
           &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"HBADSLCMTYFIXSNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
           &"HBADSLCMTYFIXSNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj RTObj_4 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_4.CUSID = RTEmployee_2.CUSID ON HBADSLCMTYFIXSNDWORK.ASSIGNENGINEER = RTEmployee_2.EMPLY " _
            &"where " & searchqry
    Else
         sqlList="SELECT HBADSLCMTYFIXSNDWORK.FIXNO, HBADSLCMTYFIXSNDWORK.PRTNO, HBADSLCMTYFIXSNDWORK.SENDWORKDAT, " _
           &"CASE WHEN RTObj_4.CUSNC IS NULL OR RTObj_4.CUSNC = '' THEN RTObj_1.SHORTNC ELSE RTObj_4.CUSNC END, " _
           &"CASE WHEN RTObj_2.CUSNC IS NULL OR RTObj_2.CUSNC = '' THEN RTObj_3.SHORTNC ELSE RTObj_2.CUSNC END, " _
           &"HBADSLCMTYFIXSNDWORK.CLOSEDAT, HBADSLCMTYFIXSNDWORK.UNCLOSEDAT, HBADSLCMTYFIXSNDWORK.DROPDAT, " _
           &"HBADSLCMTYFIXSNDWORK.BONUSCLOSEYM, HBADSLCMTYFIXSNDWORK.BONUSCLOSEDAT, HBADSLCMTYFIXSNDWORK.STOCKCLOSEYM, " _
           &"HBADSLCMTYFIXSNDWORK.STOCKCLOSEDAT " _
           &"FROM RTObj RTObj_3 RIGHT OUTER JOIN HBADSLCMTYFIXSNDWORK ON RTObj_3.CUSID = HBADSLCMTYFIXSNDWORK.REALCONSIGNEE " _
           &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_2 ON RTEmployee_1.CUSID = RTObj_2.CUSID ON " _
           &"HBADSLCMTYFIXSNDWORK.REALENGINEER = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj RTObj_1 ON " _
           &"HBADSLCMTYFIXSNDWORK.ASSIGNCONSIGNEE = RTObj_1.CUSID LEFT OUTER JOIN RTObj RTObj_4 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_4.CUSID = RTEmployee_2.CUSID ON HBADSLCMTYFIXSNDWORK.ASSIGNENGINEER = RTEmployee_2.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>