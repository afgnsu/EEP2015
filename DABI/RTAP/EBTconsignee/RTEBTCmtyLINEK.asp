<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u��Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  'functionOptName="�D�u�i��;�Τ���@;���v����"
  'functionOptProgram="rtEBTcmtylineschK.asp;rtebtcustK.asp;rtEBTcmtylineLOGK.asp"
  functionOptName="�Τ�d��"
  functionOptProgram="rtebtcustK.asp"
  functionOptPrompt="N"
  accessMode="I"
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�D�u;�u��IP;�����q��;�p�渹�X;none;�i�ظm;�ӽФ�;EBT�^�Ф�;CHT�q����;���q��;�Τ�;����;none;�i��"
  sqlDelete="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT, " _
           &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN rtebtcust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN,  " _
           &"case when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1  inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 " _
           &"WHERE RTEBTCMTYLINE.COMQ1= 0 " _                
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END " _
           &"case when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END " 
           

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
  '----
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTEBTCMTYH LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     COMADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("RADDR")
  else
     COMN=""
     COMADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCmtyline.ComQ1=" & aryparmkey(0)
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",���Ϧa�}�J" & COMADDR
  ELSE
     SEARCHFIRST=FALSE
  End If
  sqlList="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT, " _
           &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN rtebtcust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN, " _
           &"case when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1  inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 " _
           &"WHERE RTEBTCMTYLINE.COMQ1<> 0 AND " & SEARCHQRY & " " _
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, " _
           &"case when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END " 
           
                       
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>