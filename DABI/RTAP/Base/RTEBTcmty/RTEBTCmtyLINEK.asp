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
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  IF USERLEVEL=31 OR UCASE(EMPLY)="T94200" OR UCASE(EMPLY)="T92134" OR Ucase(emply)="T95222" or Ucase(emply)="T94182" THEN  
     functionOptName="���u�d��;�]�Ƭd��;�Τ���@;��������;�M���ӽ�;����ӽ�;�ӽаO��;�D�u��w;�D�u����;�D�u�@�o;�@�o����;���v����"
     functionOptProgram="rtebtCMTYlineSNDWORKk2.asp;rtebtcmtyhardwareK2.asp;rtebtcustK.asp;rtEBTcmtylineCHGK.asp;rtEBTcmtylineCLRPRTNO.asp;rtEBTcmtylineCLRPRTNOC.asp;rtEBTcmtylineAPPLYLOGK.asp;rtEBTcmtylineLOCK.asp;rtEBTcmtylineUNLOCK.asp;rtEBTcmtylineLOGK.asp"
     functionOptPrompt="N;N;N;N;Y;Y;N;Y;Y;Y;Y;N"
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
  formatName="none;none;���ϦW��;�D�u;�u��IP;�����q��;none;�D�u�W�e;none;�i�ظm;�ӽФ�;none;CHT�q����;���q��;�Τ�;����;�h��;���;����;none;�i��;��w"
  sqlDelete="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN,rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
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
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1  inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
           &"WHERE RTEBTCMTYLINE.COMQ1= 0 " _                
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, " _
           &"case WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
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
  '  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or _
  '	 Ucase(emply)="T89018" or Ucase(emply)="T89020" or Ucase(emply)="T89025" or Ucase(emply)="T91099" or _
  '	 Ucase(emply)="T92134" or Ucase(emply)="T93168" or Ucase(emply)="T93177" or Ucase(emply)="T94180" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
  'if userlevel=2 then
  '  If searchShow="����" Then
  '  sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, RTCmty.COMCNT, " _
  '       &"Sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end),  " _
  '       &"Sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
  '       &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
  '       &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
  '       &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
  '       &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
  '       &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
  '       &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
  '       &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
  '       &"FROM RTEmployee INNER JOIN " _
  '       &"##RTCmtyGroup ON RTEmployee.CUSID = ##RTCmtyGroup.CUSID INNER JOIN " _
  '       &"RTCounty INNER JOIN " _
  '       &"RTCust RIGHT OUTER JOIN " _               
  '       &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTCounty.CUTID = RTCmty.CUTID INNER JOIN " _
  '       &"RTArea INNER JOIN " _
  '       &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and rtarea.areaid" & DareaID & " ON " _
  '       &"RTCmty.CUTID = RTAreaCty.CUTID ON ##RTCmtyGroup.COMQ1 = RTCmty.COMQ1 " _
  '       &"WHERE RTArea.AREATYPE='1' AND " &searchQry &" " _         
  '       &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, " _
  '       &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
  '       &"RTCmty.T1APPLY " _
  '       &"ORDER BY RTCmty.COMN "
  '  Else
  '  sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, t1no,netip,RTCounty.CUTNC, RTCmty.COMCNT, " _
  '       &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
  '       &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
  '       &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
  '       &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
  '       &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
  '       &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
  '       &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
  '       &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                    
  '       &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
  '       &"FROM RTCounty INNER JOIN " _
  '       &"##RTCmtyGroup INNER JOIN " _
  '       &"RTCust RIGHT OUTER JOIN " _         
  '       &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON ##RTCmtyGroup.COMQ1 = RTCmty.COMQ1 ON " _
  '       &"RTCounty.CUTID = RTCmty.CUTID INNER JOIN " _
  '       &"RTArea INNER JOIN " _
  '       &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and rtarea.areaid" & DareaID & " ON " _
  '       &"RTCmty.CUTID = RTAreaCty.CUTID INNER JOIN " _
  '       &"RTEmployee ON ##RTCmtyGroup.CUSID = RTEmployee.CUSID " _
  '       &"WHERE RTArea.AREATYPE='1' and " &searchQry & " "  _
  '       &"group by RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, " _
  '       &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
  '       &"RTCmty.T1APPLY " _                  
  '       &"ORDER BY RTCmty.COMN "
  '  End If
  '�~�ȧU�zor�ȪA�H��
  'else
    If searchShow="����" Then
         sqlList="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT, " _
           &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL AND RTEBTCUST.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN rtebtcust.DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) ," _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) ," _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) , " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN, " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1  inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
           &"WHERE RTEBTCMTYLINE.COMQ1<> 0 AND " & SEARCHQRY & " " _
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)), " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  "
           
                       
    Else
         sqlList="SELECT RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1))  as comqline, " _
           &"RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT, " _
           &"SUM(CASE WHEN rtebtcust.cusid IS NOT NULL AND RTEBTCUST.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN rtebtcust.DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) ," _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) ," _
           &"SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE <> 'Y' THEN 1 ELSE 0 END) - SUM(CASE WHEN rtebtcust.DOCKETdat IS NOT NULL AND RTEBTCUST.DROPDAT IS NOT NULL AND RTEBTCUST.OVERDUE = 'Y' THEN 1 ELSE 0 END) , " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN, " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINE ON RTSalesGroup.AREAID = RTEBTCMTYLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTEBTCMTYLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTEBTCMTYLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTEBTCMTYLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTEBTCUST ON RTEBTCMTYLINE.COMQ1 = RTEBTCUST.COMQ1 AND " _
           &"RTEBTCMTYLINE.LINEQ1 = RTEBTCUST.LINEQ1  inner join rtebtcmtyh on rtebtcmtyline.comq1=rtebtcmtyh.comq1 LEFT OUTER JOIN RTCODE ON rtebtcmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
           &"WHERE RTEBTCMTYLINE.COMQ1<> 0 AND " & SEARCHQRY & " " _
           &"GROUP BY RTEBTCMTYLINE.COMQ1, RTEBTCMTYLINE.LINEQ1,RTEBTCMTYH.COMN, rtrim(convert(char(6),RTEBTcmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, RTEBTCMTYLINE.LINEIP,RTEBTCMTYLINE.LINETEL,RTEBTCMTYLINE.applyno, " _
           &"rtcode.codenc, " _
           &"RTEBTCMTYLINE.RCVDAT," _
           &"RTEBTCMTYLINE.AGREE, " _
           &"RTEBTCMTYLINE.UPDEBTCHKDAT, RTEBTCMTYLINE.EBTREPLYDAT, " _
           &"RTEBTCMTYLINE.HINETNOTIFYDAT, " _
           &"RTEBTCMTYLINE.ADSLAPPLYDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END, " _
           &"case  WHEN RTEBTCMTYLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTEBTCMTYLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTEBTCMTYLINE.APPLYUPLOADDAT IS NOT NULL THEN '�}�q����' when RTEBTCMTYLINE.ADSLAPPLYDAT is not null then '������' " _
           &"when RTEBTCMTYLINE.HINETNOTIFYDAT is not null then 'CHT�w�q�����|�����q' WHEN RTEBTCMTYLINE.SCHAPPLYDAT IS NOT NULL THEN '���o�w�w�I�u��' " _
           &"WHEN RTEBTCMTYLINE.linetel <> '' then '���o�����q��' when RTEBTCMTYLINE.lineip <> '' then '���oIP' WHEN RTEBTCMTYLINE.UPDEBTCHKDAT IS NOT NULL THEN '�e��ӽ�' " _
           &"WHEN RTEBTCMTYLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTEBTCMTYLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTEBTCMTYLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END,case when RTEBTCMTYLINE.lockdat is null then '' else 'Y' END  "
                      
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>