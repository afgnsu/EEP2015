<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="�F��AVS�Τ��OM2/M3��ƳB�z"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="M2�����;M3���; �@  �o ;�@�o����"
  functionOptProgram="RTEBTCUSTM2M3SNDWORKK.asp;RTEBTCUSTM3UPD.asp;RTEBTCUSTM2M3DROP.ASP;RTEBTCUSTM2M3DROPRTN.ASP"
  functionOptPrompt="N;Y;Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;M2/M3;�榸;�D�u�Ǹ�;���ϦW��;�Τ�W��;AVS�X���s��;�����Ҹ�;�w�ʼаO;�k�ʼаO;�J��ú�аO;����p�O�аO;���פ�;�@�o��;����渹"
  sqlDelete="SELECT RTEBTCUSTM2M3.AVSNO, RTEBTCUSTM2M3.M2M3, RTEBTCUSTM2M3.SEQ,CASE WHEN RTEBTCUSTM2M3.M2M3='302' THEN 'M2' WHEN RTEBTCUSTM2M3.M2M3='303' THEN 'M3' ELSE '' END, RTEBTCUSTM2M3.SEQ, RTRIM(LTRIM(CONVERT(char(6), RTEBTCUST.COMQ1))) " _
           &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTEBTCUST.LINEQ1))) AS Expr1, RTEBTCMTYH.COMN, RTEBTCUSTM2M3.CUSNC,RTEBTCUSTM2M3.AVSNO, " _
           &"RTEBTCUSTM2M3.SOCIALID, RTEBTCUSTM2M3.ARCSHOLDFLAG, RTEBTCUSTM2M3.ARCSLAWPUSHFLAG,RTEBTCUSTM2M3.ARCSTEMPPAYFLAG, " _
           &"RTEBTCUSTM2M3.STOPBILLINGFLAG, RTEBTCUSTM2M3.CLOSEDAT, RTEBTCUSTM2M3.DROPDAT, RTEBTCUSTM2M3SNDWORK.PRTNO " _
           &"FROM RTEBTCUSTM2M3SNDWORK RIGHT OUTER JOIN RTEBTCUSTM2M3 ON RTEBTCUSTM2M3SNDWORK.AVSNO = RTEBTCUSTM2M3.AVSNO AND " _
           &"RTEBTCUSTM2M3SNDWORK.M2M3 = RTEBTCUSTM2M3.M2M3 AND RTEBTCUSTM2M3SNDWORK.DROPDAT IS NULL LEFT OUTER JOIN " _
           &"RTEBTCMTYH INNER JOIN RTEBTCUST ON RTEBTCMTYH.COMQ1 = RTEBTCUST.COMQ1 ON RTEBTCUSTM2M3.AVSNO = RTEBTCUST.AVSNO "
           
  dataTable="RTEBTCUSTM2M3"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="None"
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
  searchProg="RTEBTCUSTM2M3S.ASP"

  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCUSTM2M3.CLOSEDAT IS NULL AND RTEBTCUSTM2M3.DROPDAT IS NULL "
     searchShow="�����|���B�z���"
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
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
       sqlList="SELECT RTEBTCUSTM2M3.AVSNO, RTEBTCUSTM2M3.M2M3, RTEBTCUSTM2M3.SEQ,CASE WHEN RTEBTCUSTM2M3.M2M3='302' THEN 'M2' WHEN RTEBTCUSTM2M3.M2M3='303' THEN 'M3' WHEN RTEBTCUSTM2M3.M2M3='304' THEN 'M4' ELSE '' END, RTEBTCUSTM2M3.SEQ, RTRIM(LTRIM(CONVERT(char(6), RTEBTCUST.COMQ1))) " _
           &"+ '-' + RTRIM(LTRIM(CONVERT(char(6), RTEBTCUST.LINEQ1))) AS Expr1, RTEBTCMTYH.COMN, RTEBTCUSTM2M3.CUSNC,RTEBTCUSTM2M3.AVSNO, " _
           &"RTEBTCUSTM2M3.SOCIALID, RTEBTCUSTM2M3.ARCSHOLDFLAG, RTEBTCUSTM2M3.ARCSLAWPUSHFLAG,RTEBTCUSTM2M3.ARCSTEMPPAYFLAG, " _
           &"RTEBTCUSTM2M3.STOPBILLINGFLAG, RTEBTCUSTM2M3.CLOSEDAT, RTEBTCUSTM2M3.DROPDAT, RTEBTCUSTM2M3SNDWORK.PRTNO " _
           &"FROM RTEBTCUSTM2M3SNDWORK RIGHT OUTER JOIN RTEBTCUSTM2M3 ON RTEBTCUSTM2M3SNDWORK.AVSNO = RTEBTCUSTM2M3.AVSNO AND " _
           &"RTEBTCUSTM2M3SNDWORK.M2M3 = RTEBTCUSTM2M3.M2M3 AND RTEBTCUSTM2M3SNDWORK.SEQ=RTEBTCUSTM2M3.SEQ AND RTEBTCUSTM2M3SNDWORK.DROPDAT IS NULL LEFT OUTER JOIN " _
           &"RTEBTCMTYH INNER JOIN RTEBTCUST ON RTEBTCMTYH.COMQ1 = RTEBTCUST.COMQ1 ON RTEBTCUSTM2M3.AVSNO = RTEBTCUST.AVSNO " _
           &"WHERE " & SEARCHQRY & " " _
           &"ORDER BY RTEBTCUST.COMQ1,RTEBTCUST.LINEQ1,RTEBTCUSTM2M3.M2M3, RTEBTCUSTM2M3.SEQ "
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>