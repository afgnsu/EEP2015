<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  IF USERLEVEL=31 OR UCASE(EMPLY)="T94200" OR UCASE(EMPLY)="T92134" OR Ucase(emply)="T95222" OR Ucase(emply)="T94182" THEN  
     functionOptName="���u�d��;�]�Ƭd��;�Τ���@;��������;�M���ӽ�;����ӽ�;�ӽаO��;�D�u��w;�D�u����;�D�u�@�o;�@�o����;���v����;��ʦ^��"
     functionOptProgram="rtebtCMTYlineSNDWORKk2.asp;rtebtcmtyhardwareK2.asp;rtebtcustK.asp;rtEBTcmtylineCHGK.asp;rtEBTcmtylineCLRPRTNO.asp;rtEBTcmtylineCLRPRTNOC.asp;rtEBTcmtylineAPPLYLOGK.asp;rtEBTcmtylineLOCK.asp;rtEBTcmtylineUNLOCK.asp;rtEBTcmtylineDROP.asp;rtEBTcmtylineDROPC.asp;rtEBTcmtylineLOGK.asp;rtEBTcmtylinemanual.asp"
     functionOptPrompt="N;N;N;N;Y;Y;N;Y;Y;Y;Y;N;Y"
  ELSE
     functionOptName="���u�d��;�]�Ƭd��;�Τ���@;��������;�M���ӽ�;����ӽ�;�ӽаO��;���v����"
     functionOptProgram="rtebtCMTYlineSNDWORKk2.asp;rtebtcmtyhardwareK2.asp;rtebtcustK.asp;rtEBTcmtylineCHGK.asp;rtEBTcmtylineCLRPRTNO.asp;rtEBTcmtylineCLRPRTNOC.asp;rtEBTcmtylineAPPLYLOGK.asp;rtEBTcmtylineLOGK.asp"
     functionOptPrompt="N;N;N;N;Y;Y;N;N"
  END IF
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�D�u;�u��IP;�����q��;none;�D�u�W�e;none;�ӽФ�;�^��EBT��;none;CHT�q����;���q��;�Τ�;����;�h��;���;����;none;�i��;��w"
  sqlDelete="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT, " _
           &"RTEBTCMTYLINE.APPLYUPLOADDAT, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT, " _
           &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN,  " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE ='N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1 inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
           &"WHERE RTEBTCMTYLINE.COMQ1= 0 " _                
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT, " _
           &"RTEBTCMTYLINE.APPLYUPLOADDAT, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  "
 

  dataTable="rtebtcmtyline"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTebtCmtylineD.asp"
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
  searchProg="RTEBTCMTYLINES2.ASP"
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
     searchShow="����"
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
  '  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
  '	 Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
  '	 Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
  '   DAreaID="<>'*'"
  'end if
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31  then DAreaID="<>'*'"
  
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
  'if userlevel=2 then
  '  If searchShow="����" Then
 '�x�_���f
    If DAreaID="<>'*'" Then
       sqlList="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,rtebtcmtyh.comn " _
              &",rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) as comqline, " _
              &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno,rtcode.codenc, RTEBTCMTYLINE.RCVDAT, " _
              &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
              &"RTEBTCMTYLINE.HINETNOTIFYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
              &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL  AND RTEBTCUST.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) ," _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) ," _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) , " _
              &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN, " _
              &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null " _
              &"then '������' when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL " _
              &"THEN '���o�w�w�I�u��' WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' " _
              &"WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' " _
              &"WHEN RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
              &"FROM RTSalesGroup RIGHT OUTER JOIN RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID " _
              &"AND RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID " _
              &"LEFT OUTER JOIN RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN RTEBTCUST ON " _
              &"RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1 inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
              &"WHERE RTEBTCMTYLINE.COMQ1<> 0 AND " & SEARCHQRY  _
              &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1, RTEBTCMTYh.comn, " _
              &"rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)), RTObj.SHORTNC, RTSalesGroup.GROUPNC, " _
              &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno,rtcode.codenc, RTEBTCMTYLINE.RCVDAT, RTEBTCMTYLINE.UPDEBTCHKDAT, " _
              &"RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.HINETNOTIFYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
              &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL " _
              &"THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' when RTEBTCMTYLINE.HINETNOTIFYDAT is not null " _
              &"then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' WHEN RTEBTCMTYLINE.linetel <> '' " _
              &"then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
              &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' " _
              &"WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " 
      Else
         sqlList="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,rtebtcmtyh.comn " _
              &",rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) as comqline, " _
              &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno,rtcode.codenc, RTEBTCMTYLINE.RCVDAT, " _
              &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
              &"RTEBTCMTYLINE.HINETNOTIFYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
              &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL AND RTEBTCUST.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) ," _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) ," _
              &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) , " _
              &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN, " _
              &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null " _
              &"then '������' when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL " _
              &"THEN '���o�w�w�I�u��' WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' " _
              &"WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' " _
              &"WHEN RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
              &"FROM RTSalesGroup RIGHT OUTER JOIN RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID " _
              &"AND RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID " _
              &"LEFT OUTER JOIN RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN RTEBTCUST ON " _
              &"RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1 inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
              &"WHERE RTEBTCMTYLINE.COMQ1<> 0 and " & searchqry & " " & dareaid & " " _
              &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1, RTEBTCMTYh.comn, " _
              &"rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)), RTObj.SHORTNC, RTSalesGroup.GROUPNC, " _
              &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno,rtcode.codenc, RTEBTCMTYLINE.RCVDAT, RTEBTCMTYLINE.UPDEBTCHKDAT, " _
              &"RTEBTCMTYLINE.APPLYUPLOADDAT, RTEBTCMTYLINE.EBTREPLYDAT, RTEBTCMTYLINE.HINETNOTIFYDAT, RTEBTCMTYLINE.ADSLAPPLYDAT, " _
              &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL " _
              &"THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' when RTEBTCMTYLINE.HINETNOTIFYDAT is not null " _
              &"then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' WHEN RTEBTCMTYLINE.linetel <> '' " _
              &"then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
              &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' " _
              &"WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " 
                      
    End If  
  'end if
 'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>