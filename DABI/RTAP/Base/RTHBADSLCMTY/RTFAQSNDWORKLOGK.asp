<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u���ʸ�ƾ��v���ʬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;����;���ʤ��;�������O;���ʤH��;�@�o��;���פ�"
  sqlDelete="SELECT  HBADSLCMTYFIXSNDWORKLOG.FIXNO, HBADSLCMTYFIXSNDWORKLOG.prtNO, HBADSLCMTYFIXSNDWORKLOG.ENTRYNO, HBADSLCMTYFIXSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"HBADSLCMTYFIXSNDWORKLOG.DROPDAT, HBADSLCMTYFIXSNDWORKLOG.CLOSEDAT " _
           &"FROM  RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID INNER JOIN HBADSLCMTYFIXSNDWORKLOG INNER JOIN " _
           &"RTCode ON HBADSLCMTYFIXSNDWORKLOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' ON RTEmployee.EMPLY = HBADSLCMTYFIXSNDWORKLOG.CHGUSR " _
           &"where HBADSLCMTYFIXSNDWORKLOG.fixno="" ORDER BY  HBADSLCMTYFIXSNDWORKLOG.FIXNO "
  dataTable="HBADSLCMTYFIXSNDWORKLOG"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg=""
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
     searchQry=" HBADSLCMTYFIXSNDWORKLOG.FIXNO='" & aryparmkey(0) & "' and HBADSLCMTYFIXSNDWORKLOG.prtno='" & aryparmkey(1) & "' "
     searchShow="�ȶD�渹�J"& aryparmkey(0) & ";���פu��J" & aryparmkey(1)
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
         sqlList="SELECT  HBADSLCMTYFIXSNDWORKLOG.FIXNO,HBADSLCMTYFIXSNDWORKLOG.prtNO, HBADSLCMTYFIXSNDWORKLOG.ENTRYNO, HBADSLCMTYFIXSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
           &"HBADSLCMTYFIXSNDWORKLOG.DROPDAT, HBADSLCMTYFIXSNDWORKLOG.CLOSEDAT " _
           &"FROM  RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID INNER JOIN HBADSLCMTYFIXSNDWORKLOG INNER JOIN " _
           &"RTCode ON HBADSLCMTYFIXSNDWORKLOG.CHGCODE = RTCode.CODE AND RTCode.KIND = 'G2' ON RTEmployee.EMPLY = HBADSLCMTYFIXSNDWORKLOG.CHGUSR " _
           &"where " & searchqry & " ORDER BY HBADSLCMTYFIXSNDWORKLOG.FIXNO,HBADSLCMTYFIXSNDWORKLOG.prtno  "
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>