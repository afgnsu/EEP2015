<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�t��499�D�u��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
'  IF USERLEVEL=31 OR UCASE(EMPLY)="T91129" OR UCASE(EMPLY)="P92010" or Ucase(emply)="T94180" THEN  
'     functionOptName="���u�d��;�]�Ƭd��;�Τ���@;��������;�M���ӽ�;����ӽ�;�ӽаO��;�D�u�@�o;�@�o����;���v����"
'     functionOptProgram="RTSparq499cmtylineSNDWORKk2.asp;RTSparq499cmtyhardwareK2.asp;RTSparq499custK.asp;RTSparq499cmtylineCHGK.asp;RTSparq499cmtylineCLRPRTNO.asp;RTSparq499cmtylineCLRPRTNOC.asp;RTSparq499cmtylineAPPLYLOGK.asp;RTSparq499cmtylineLOGK.asp"
'     functionOptPrompt="N;N;N;N;Y;Y;N;Y;Y;Y;Y;N"
'  ELSE
     functionOptName="�Τ���@;���u�d��"
     functionOptProgram="RTSparq499custK.asp;RTSparq499CmtyLineSndWorkK.asp"
     functionOptPrompt="N;N"
'  END IF
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�Ұ�;���ϦW��;�D�u;�u��IP;�����q��;none;none;�s���覡;�ӽФ�;�t�ծ֭��;���q��;�t�ն}�q��;�M�u��;�Τ�;����;�h��;���;����;�i��"
  sqlDelete="SELECT RTSparq499cmtyLINE.COMQ1, RTSparq499cmtyLINE.LINEQ1,RTSparq499cmtyH.COMN,rtrim(convert(char(6),RTSparq499cmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499cmtyline.lineQ1))  as comqline, " _
           &"CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR1)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR2)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR3)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR4)+'-'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPEND),RTSparq499cmtyLINE.LINETEL, " _
           &"rtcode.codenc, " _
           &"RTSparq499cmtyLINE.RCVDAT," _
           &"RTSparq499cmtyLINE.AGREE, " _
           &"RTSparq499cmtyLINE.ADSLAPPLYDAT, " _
           &"RTSparq499cmtyLINE.NCICAGREEDAT, " _
           &"RTSparq499cmtyLINE.ADSLOPENDAT,RTSparq499cmtyLINE.NCICOPENDAT, RTSparq499cmtyLINE.DROPDAT, " _
           &"SUM(CASE WHEN RTSparq499cust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN RTSparq499cust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case  WHEN RTSparq499cmtyLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTSparq499cmtyLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTSparq499cmtyLINE.NCICOPENDAT IS NOT NULL THEN '�t�ն}�q' when RTSparq499cmtyLINE.ADSLOPENDAT is not null then '�D�u���q' " _
           &"when RTSparq499cmtyLINE.EQUIPARRIVE is not null then '�]�ƨ��' WHEN RTSparq499cmtyLINE.BOXARRIVE IS NOT NULL THEN '���d���' " _
           &"WHEN RTSparq499cmtyLINE.LINEARRIVEDAT IS NOT NULL  then '�u�����' when RTSparq499cmtyLINE.TOCHTWORKING IS NOT NULL  then '����B�B' WHEN RTSparq499cmtyLINE.NCICAGREEDAT IS NOT NULL THEN '�t�ծ֭�' " _
           &"WHEN RTSparq499cmtyLINE.ADSLAPPLYDAT IS NOT NULL  then '�D�u�ӽФ�' " _
           &"WHEN RTSparq499cmtyLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTSparq499cmtyLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTSparq499cmtyLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTSparq499cmtyLINE ON RTSalesGroup.AREAID = RTSparq499cmtyLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTSparq499cmtyLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTSparq499cmtyLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTSparq499cmtyLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTSparq499cust ON RTSparq499cmtyLINE.COMQ1 = RTSparq499cust.COMQ1 AND " _
           &"RTSparq499cmtyLINE.LINEQ1 = RTSparq499cust.LINEQ1  inner join RTSparq499cmtyh on RTSparq499cmtyline.comq1=RTSparq499cmtyh.comq1 LEFT OUTER JOIN RTCODE ON RTSparq499cmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
           &"WHERE RTSparq499cmtyLINE.COMQ1= 0 " _                
           &"GROUP BY RTSparq499cmtyLINE.COMQ1, RTSparq499cmtyLINE.LINEQ1,RTSparq499cmtyH.COMN, rtrim(convert(char(6),RTSparq499cmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499cmtyline.lineQ1)) , " _
           &"RTSalesGroup.GROUPNC, CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR1)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR2)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR3)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR4)+'-'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPEND),RTSparq499cmtyLINE.LINETEL, " _
           &"rtcode.codenc, " _
           &"RTSparq499cmtyLINE.RCVDAT," _
           &"RTSparq499cmtyLINE.AGREE, " _
           &"RTSparq499cmtyLINE.ADSLAPPLYDAT, " _
           &"RTSparq499cmtyLINE.NCICAGREEDAT, " _
           &"RTSparq499cmtyLINE.ADSLOPENDAT,RTSparq499cmtyLINE.NCICOPENDAT,RTSparq499cmtyLINE.DROPDAT, " _
           &"case  WHEN RTSparq499cmtyLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTSparq499cmtyLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTSparq499cmtyLINE.NCICOPENDAT IS NOT NULL THEN '�t�ն}�q' when RTSparq499cmtyLINE.ADSLOPENDAT is not null then '�D�u���q' " _
           &"when RTSparq499cmtyLINE.EQUIPARRIVE is not null then '�]�ƨ��' WHEN RTSparq499cmtyLINE.BOXARRIVE IS NOT NULL THEN '���d���' " _
           &"WHEN RTSparq499cmtyLINE.LINEARRIVEDAT IS NOT NULL  then '�u�����' when RTSparq499cmtyLINE.TOCHTWORKING IS NOT NULL  then '����B�B' WHEN RTSparq499cmtyLINE.NCICAGREEDAT IS NOT NULL THEN '�t�ծ֭�' " _
           &"WHEN RTSparq499cmtyLINE.ADSLAPPLYDAT IS NOT NULL  then '�D�u�ӽФ�' " _
           &"WHEN RTSparq499cmtyLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTSparq499cmtyLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTSparq499cmtyLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END  " 
           

  dataTable="RTSparq499cmtyline"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTSparq499cmtylineD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTSparq499CmtyLineS2.asp"
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
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSparq499cmtyline.ComQ1 <> 0 "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If

  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select * from RTAreaSales where cusid='" & Emply & "' and areaid ='D0' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     limitemply	=" and RTSparq499cmtyLINE.salesid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close

  connxx.Close
  set rsxx=nothing
  set connxx=nothing

  
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
	sqlList="SELECT RTSparq499cmtyLINE.COMQ1, RTSparq499cmtyLINE.LINEQ1," _
		&"isnull(RTObj.shortnc, RTEmployee.name)," _
		&"RTSparq499cmtyH.COMN, rtrim(convert(char(6),RTSparq499cmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499cmtyline.lineQ1))  as comqline, " _
		&"CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR1)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR2)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR3)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR4)+'-'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPEND),RTSparq499cmtyLINE.LINETEL, " _
		&"rtcode.codenc, " _
		&"RTSparq499cmtyLINE.RCVDAT," _
		&"RTCodeG5.codenc, " _
		&"RTSparq499cmtyLINE.ADSLAPPLYDAT, " _
		&"RTSparq499cmtyLINE.NCICAGREEDAT, " _
		&"RTSparq499cmtyLINE.ADSLOPENDAT,RTSparq499cmtyLINE.NCICOPENDAT, RTSparq499cmtyLINE.DROPDAT, " _
		&"SUM(CASE WHEN RTSparq499cust.cusid IS NOT NULL AND RTSparq499cust.CANCELDAT IS NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
		&"SUM(CASE WHEN RTSparq499cust.DOCKETDAT IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
		&"SUM(CASE WHEN RTSparq499cust.DOCKETdat IS NOT NULL AND RTSparq499cust.DROPDAT IS NOT NULL AND RTSparq499cust.OVERDUE <> 'Y' THEN 1 ELSE 0 END) ," _
		&"SUM(CASE WHEN RTSparq499cust.DOCKETdat IS NOT NULL AND RTSparq499cust.DROPDAT IS NOT NULL AND RTSparq499cust.OVERDUE = 'Y' THEN 1 ELSE 0 END) ," _
		&"SUM(CASE WHEN RTSparq499cust.DOCKETdat IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN RTSparq499cust.DOCKETdat IS NOT NULL AND RTSparq499cust.DROPDAT IS NOT NULL AND RTSparq499cust.OVERDUE <> 'Y' THEN 1 ELSE 0 END) - SUM(CASE WHEN RTSparq499cust.DOCKETdat IS NOT NULL AND RTSparq499cust.DROPDAT IS NOT NULL AND RTSparq499cust.OVERDUE = 'Y' THEN 1 ELSE 0 END) , " _
		&"case  WHEN RTSparq499cmtyLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTSparq499cmtyLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTSparq499cmtyLINE.NCICOPENDAT IS NOT NULL THEN '�t�ն}�q' when RTSparq499cmtyLINE.ADSLOPENDAT is not null then '�D�u���q' " _
		&"when RTSparq499cmtyLINE.EQUIPARRIVE is not null then '�]�ƨ��' WHEN RTSparq499cmtyLINE.BOXARRIVE IS NOT NULL THEN '���d���' " _
		&"WHEN RTSparq499cmtyLINE.LINEARRIVEDAT IS NOT NULL  then '�u�����' when RTSparq499cmtyLINE.TOCHTWORKING IS NOT NULL  then '����B�B' WHEN RTSparq499cmtyLINE.NCICAGREEDAT IS NOT NULL THEN '�t�ծ֭�' " _
		&"WHEN RTSparq499cmtyLINE.ADSLAPPLYDAT IS NOT NULL  then '�D�u�ӽФ�' " _
		&"WHEN RTSparq499cmtyLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTSparq499cmtyLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTSparq499cmtyLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END  " _
		&"FROM RTEmployee RIGHT OUTER JOIN RTSparq499cmtyLINE ON RTEmployee.emply = RTSparq499cmtyLINE.salesid  " _
		&"LEFT OUTER JOIN RTCounty ON RTSparq499cmtyLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
		&"RTObj ON RTSparq499cmtyLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
		&"RTSparq499cust ON RTSparq499cmtyLINE.COMQ1 = RTSparq499cust.COMQ1 AND " _
		&"RTSparq499cmtyLINE.LINEQ1 = RTSparq499cust.LINEQ1  inner join RTSparq499cmtyh on RTSparq499cmtyline.comq1=RTSparq499cmtyh.comq1 LEFT OUTER JOIN RTCODE ON RTSparq499cmtyline.LINERATE=RTCODE.CODE AND RTCODE.KIND='D3' " _
		&" left outer join rtctytown rtctytownx on RTSparq499Cust.cutid2=rtctytownx.cutid and RTSparq499Cust.township2=rtctytownx.township " _
		&" left outer join RTCode RTCodeG5 on RTCodeG5.code = RTSparq499cmtyLINE.connecttype and RTCodeG5.KIND='G5' " _
		&"WHERE RTSparq499cmtyLINE.COMQ1<> 0 AND " & SEARCHQRY &" "& limitemply _
		&"GROUP BY RTSparq499cmtyLINE.COMQ1, RTSparq499cmtyLINE.LINEQ1," _
		&"isnull(RTObj.shortnc, RTEmployee.name)," _
		&"RTSparq499cmtyH.COMN, rtrim(convert(char(6),RTSparq499cmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499cmtyline.lineQ1)), " _
		&"CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR1)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR2)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR3)+'.'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPSTR4)+'-'+CONVERT(CHAR,RTSparq499cmtyLINE.LINEIPEND),RTSparq499cmtyLINE.LINETEL, " _
		&"rtcode.codenc, " _
		&"RTSparq499cmtyLINE.RCVDAT," _
		&"RTCodeG5.codenc, " _
		&"RTSparq499cmtyLINE.ADSLAPPLYDAT, " _
		&"RTSparq499cmtyLINE.NCICAGREEDAT, " _
		&"RTSparq499cmtyLINE.ADSLOPENDAT,RTSparq499cmtyLINE.NCICOPENDAT,RTSparq499cmtyLINE.DROPDAT, " _
		&"case  WHEN RTSparq499cmtyLINE.CANCELDAT IS NOT NULL THEN '�w�@�o' WHEN RTSparq499cmtyLINE.DROPDAT IS NOT NULL THEN '�w�M�u' when RTSparq499cmtyLINE.NCICOPENDAT IS NOT NULL THEN '�t�ն}�q' when RTSparq499cmtyLINE.ADSLOPENDAT is not null then '�D�u���q' " _
		&"when RTSparq499cmtyLINE.EQUIPARRIVE is not null then '�]�ƨ��' WHEN RTSparq499cmtyLINE.BOXARRIVE IS NOT NULL THEN '���d���' " _
		&"WHEN RTSparq499cmtyLINE.LINEARRIVEDAT IS NOT NULL  then '�u�����' when RTSparq499cmtyLINE.TOCHTWORKING IS NOT NULL  then '����B�B' WHEN RTSparq499cmtyLINE.NCICAGREEDAT IS NOT NULL THEN '�t�ծ֭�' " _
		&"WHEN RTSparq499cmtyLINE.ADSLAPPLYDAT IS NOT NULL  then '�D�u�ӽФ�' " _
		&"WHEN RTSparq499cmtyLINE.AGREE = 'Y' THEN '�ɬd���i��' WHEN  RTSparq499cmtyLINE.AGREE = 'N' THEN '�ɬd�����i��' WHEN RTSparq499cmtyLINE.INSPECTDAT IS NULL THEN '�|���ɬd' ELSE '???����???' END  " 
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>