<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="EBT�w�T�{���q���D�u�i�ӽХΤ�d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  functionOptName="�Τ���@"
  functionOptProgram="rtebtcustK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�D�u;���ϦW��;�D�u�ӽФ�;�D�u�ӽ�<BR>���ɤ�;�D�u�ӽ�<BR>EBT�^�Ф�;�D�u���q��;�D�u���q<BR>�^����;�D�u���q<BR>�^�����ɤ�;EBT�T�{<BR>���q��;�������;���u��;������;�h����;������;���u<BR>��������;�I�u��;�ӽФ�;�ݥӽм�"
  sqlDelete="SELECT RTEBTCMTYLINE.COMQ1,RTEBTCMTYLINE.LINEQ1,rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline,RTEBTCMTYH.COMN,RTEBTCMTYLINE.UPDEBTCHKDAT,RTEBTCMTYLINE.UPDEBTDAT, " _
         &"RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.APPLYUPLOADTNS, " _
         &"RTEBTCMTYLINE.EBTAPPLYOKRTN, SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) AS �����Ȥ��, " _
         &"SUM(CASE WHEN RTEBTCUST.FINISHDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ���u��, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ������, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS �h����, " _
         &"SUM(CASE WHEN rtebtcust.freecode = 'Y' AND rtebtcust.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS ������, " _
         &"SUM(CASE WHEN RTEBTCUST.FINISHDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) " _
         &"- SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ���u��������, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO <> '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL " _
         &"THEN 1 ELSE 0 END) AS �I�u��, SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS �ӽФ�, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.APPLYDAT IS NULL THEN 1 ELSE 0 END) AS �ݥӽм� " _
         &"FROM RTEBTCMTYLINE INNER JOIN  RTEBTCMTYH ON  RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1 LEFT OUTER JOIN RTEBTCUST ON RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1 AND RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 " _
         &"WHERE  RTEBTCMTYLINE.EBTAPPLYOKRTN IS NOT NULL AND RTEBTCMTYLINE.DROPDAT IS NULL AND RTEBTCMTYLINE.CANCELDAT IS NULL " _
         &"GROUP BY  RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)), RTEBTCMTYH.COMN,  RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.UPDEBTDAT, RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
         &"RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.APPLYUPLOADTNS,RTEBTCMTYLINE.EBTAPPLYOKRTN " 

  dataTable="rtebtcmtyline"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=250,scrollbars=yes"
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
  searchProg="RTEBTCMTYLINEAPPLYS.ASP"
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
     searchQry=" RTEBTCmtyline.ComQ1<>0 "
     searchqry2=" having SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND " _
       &"RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND " _
       &"RTEBTCUST.APPLYDAT IS NULL THEN 1 ELSE 0 END) > 0 "
     searchShow="�ݥӽФ�� > 0 "
  ELSE
     SEARCHFIRST=FALSE
  End If
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
            'DAreaID=" and ( ( rtebtcmtyline.cutid in ('01','02','03','04','21','22') and rtebtcmtyline.township not in ('�T�l��','�a�q��') ) or (( rtebtcmtyline.cutid in  ('05','06','07','08') or (rtebtcmtyline.cutid='03' and rtebtcmtyline.township in ('�T�l��','�a�q��') ) ) ))"
            DAreaID="<>'*'"
         case "P"
            DAreaID=" and ( ( rtebtcmtyline.cutid in ('01','02','03','04','21','22') and rtebtcmtyline.township not in ('�T�l��','�a�q��') ) or (( rtebtcmtyline.cutid in  ('05','06','07','08') or (rtebtcmtyline.cutid='03' and rtebtcmtyline.township in ('�T�l��','�a�q��') ) )) )"
         case "C"
            DAreaID=" and rtebtcmtyline.cutid in ('09','10','11','12','13') "         
         case "K"
            DAreaID=" and rtebtcmtyline.cutid in ('14','15','16','17','18','19','20')  "         
         case else
            DareaID=" "
  end select
  
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T93168" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"  or Ucase(emply)="T91129"  or Ucase(emply)="T89031"  or Ucase(emply)="T92134"  or Ucase(emply)="P92010" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31  then DAreaID="<>'*'"
  
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
  'if userlevel=2 then
  '  If searchShow="����" Then
 '�x�_���f
  sqlList="SELECT RTEBTCMTYLINE.COMQ1,RTEBTCMTYLINE.LINEQ1,rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline,RTEBTCMTYH.COMN,RTEBTCMTYLINE.UPDEBTCHKDAT,RTEBTCMTYLINE.UPDEBTDAT, " _
         &"RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.APPLYUPLOADTNS, " _
         &"RTEBTCMTYLINE.EBTAPPLYOKRTN, SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL THEN 1 ELSE 0 END) AS �����Ȥ��, " _
         &"SUM(CASE WHEN RTEBTCUST.FINISHDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ���u��, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ������, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS �h����, " _
         &"SUM(CASE WHEN rtebtcust.freecode = 'Y' AND rtebtcust.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS ������, " _
         &"SUM(CASE WHEN RTEBTCUST.FINISHDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) " _
         &"- SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NOT NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.CANCELDAT IS NULL AND rtebtcust.freecode <> 'Y' THEN 1 ELSE 0 END) AS ���u��������, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO <> '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL " _
         &"THEN 1 ELSE 0 END) AS �I�u��, SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.APPLYDAT IS NOT NULL THEN 1 ELSE 0 END) AS �ӽФ�, " _
         &"SUM(CASE WHEN RTEBTCUST.CANCELDAT IS NULL AND RTEBTCUST.COMQ1 IS NOT NULL AND RTEBTCUST.AVSNO = '' AND RTEBTCUST.FREECODE <> 'Y' AND RTEBTCUST.FINISHDAT IS NULL AND RTEBTCUST.DOCKETDAT IS NULL AND RTEBTCUST.DROPDAT IS NULL AND RTEBTCUST.APPLYDAT IS NULL THEN 1 ELSE 0 END) AS �ݥӽм� " _
         &"FROM RTEBTCMTYLINE INNER JOIN  RTEBTCMTYH ON  RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1 LEFT OUTER JOIN RTEBTCUST ON RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1 AND RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 " _
         &"WHERE  RTEBTCMTYLINE.EBTAPPLYOKRTN IS NOT NULL AND RTEBTCMTYLINE.DROPDAT IS NULL AND RTEBTCMTYLINE.CANCELDAT IS NULL and " & searchqry _
         &"GROUP BY  RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)), RTEBTCMTYH.COMN,  RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.UPDEBTDAT, RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
         &"RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.APPLYUPLOADTNS,RTEBTCMTYLINE.EBTAPPLYOKRTN " & searchqry2
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>