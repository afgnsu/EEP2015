<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="KTS�޲z�t��"
  title="KTS�Τ�ӽйq�ܳ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �@ �o ;�@�o����"
  functionOptProgram="KTSCUSTTELDROP.asp;KTSCUSTTELDROPRTN.asp"
  functionOptPrompt="Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�Τ�N��;�q�ܥӽг渹;�ӽФ��;�ӽ����ɤ�;�@�o��;�ӽЪ�����;�}�q������;�@�o������;�@�o������"
  sqlDelete="SELECT KTSCUSTTELH.CUSID, KTSCUSTTELH.PNO, KTSCUSTTELH.APPLYDAT,KTSCUSTTELH.TRANSDAT, KTSCUSTTELH.CANCELDAT, " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'A' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'A' and KTSCUSTTELD1.finishdat is not null THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'D' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'D' and KTSCUSTTELD1.finishdat is not null THEN 1 ELSE 0 END) " _
           &"FROM KTSCUSTTELH LEFT OUTER JOIN KTSCUSTTELD1 ON KTSCUSTTELH.CUSID = KTSCUSTTELD1.CUSID AND " _
           &"KTSCUSTTELH.PNO = KTSCUSTTELD1.PNO GROUP BY  KTSCUSTTELH.CUSID, KTSCUSTTELH.PNO, KTSCUSTTELH.APPLYDAT, " _
           &"KTSCUSTTELH.TRANSDAT, KTSCUSTTELH.CANCELDAT "

  dataTable="ktscusttelh"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="KTSCusttelD.asp"
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
  searchProg="none"
  '----
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" KTSCusttelh.CUSID<>'' and KTSCUSTTELH.CUSID='" & aryparmkey(0) & "' "
     searchShow="����"
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
  
         sqlList="SELECT KTSCUSTTELH.CUSID, KTSCUSTTELH.PNO, KTSCUSTTELH.APPLYDAT,KTSCUSTTELH.TRANSDAT, KTSCUSTTELH.CANCELDAT, " _
           &"SUM(CASE WHEN  KTSCUSTTELD1.AORD = 'A' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'A' and KTSCUSTTELD1.finishdat is not null THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN  KTSCUSTTELD1.AORD = 'D' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN KTSCUSTTELD1.AORD = 'D' and KTSCUSTTELD1.finishdat is not null THEN 1 ELSE 0 END) " _
           &"FROM KTSCUSTTELH LEFT OUTER JOIN KTSCUSTTELD1 ON KTSCUSTTELH.CUSID = KTSCUSTTELD1.CUSID AND " _
           &"KTSCUSTTELH.PNO = KTSCUSTTELD1.PNO " _
           &"where " & searchqry & " " _
           &"GROUP BY  KTSCUSTTELH.CUSID, KTSCUSTTELH.PNO, KTSCUSTTELH.APPLYDAT, " _
           &"KTSCUSTTELH.TRANSDAT, KTSCUSTTELH.CANCELDAT " _
           
'  Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>