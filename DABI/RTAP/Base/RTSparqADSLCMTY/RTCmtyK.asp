<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�t��ADSL���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����y�q;�ȡ@��;�ީe�|;�X�@��"
  functionOptProgram="RTCMTYFLOW.ASP;RTCustK.asp;RTCmtySpK.asp;RTContractK.asp"
  functionOptPrompt="N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�~���Ұ�;���ϦW��;none;none;IP;�]�Ʀ�m;none;���q��;�M�P��;�ӽ�;���u;���m;�h��;���;����" 
  sqlDelete="SELECT RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
           &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR, " _
           &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
           &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL OR rtsparqadslcust.finishdat <> '' THEN 1 ELSE 0 END), " _           
           &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END) " _
           &"FROM RTSparqAdslCmty LEFT OUTER JOIN rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
           &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
           &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL " _
           &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _
           &"WHERE (RTSparqAdslCmty.COMN <> '*') " _
           &"GROUP BY  RTSparqAdslCmty.CUTYID, RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
           &"RTSparqAdslCmty.IPADDR, IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR,rtsparqadslcmtysndwork.prtno, " _
           &"RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP " _
           &"ORDER BY  RTSparqAdslCmty.equipaddr "
  dataTable="RTSparqAdslCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTCmtyD.asp"
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
  searchProg="RTCmtyS.asp"
  searchFirst=TRUE
  If searchQry="" Then
    'searchQry=" RTSparqAdslCmty.cutyid =0  "
    'searchShow=""
	'�ק�A
    if ARYPARMKEY(0) ="" then 
	    searchQry=" RTSparqAdslCmty.cutyid =0  "
		searchShow=""
	else
		searchQry=" RTSparqAdslCmty.cutyid=" & aryparmkey(0)
		searchShow="���ϧǸ��J"& aryparmkey(0)
	    searchFirst=FALSE
	end if		
    
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
     limitemply	=" and RTSparqAdslCmty.bussid ='" & Emply & "' "
  else
     limitemply =" " 
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '-------------------------------------------------------------------------------------------

  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
sqllist="SELECT RTSparqAdslCmty.CUTYID, " _
       &"isnull(RTOBJ.shortnc, isnull(rtobj_a.cusnc,'�L�k��')), " _
       &"RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, substring(IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR,1,25)+'....', " _
       &"rtsparqadslcmtysndwork.prtno, RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP, " _
       &"SUM(CASE WHEN rtsparqadslcust.cusid IS NOT NULL OR rtsparqadslcust.cusid <> '' THEN 1 ELSE 0 END), " _ 
       &"SUM(CASE WHEN rtsparqadslcust.finishdat IS NOT NULL OR rtsparqadslcust.finishdat <> '' THEN 1 ELSE 0 END), " _           
       &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END), " _     
       &"SUM(CASE WHEN (rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '') AND RTSPARQADSLCUST.DROPDAT IS NOT NULL AND RTSPARQADSLCUST.OVERDUE<>'Y' THEN 1 ELSE 0 END), " _     
       &"SUM(CASE WHEN (rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '') AND RTSPARQADSLCUST.DROPDAT IS NOT NULL AND RTSPARQADSLCUST.OVERDUE='Y' THEN 1 ELSE 0 END), " _     
       &"SUM(CASE WHEN rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '' THEN 1 ELSE 0 END) - " _     
       &"SUM(CASE WHEN (rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '') AND RTSPARQADSLCUST.DROPDAT IS NOT NULL AND RTSPARQADSLCUST.OVERDUE<>'Y' THEN 1 ELSE 0 END) - " _     
       &"SUM(CASE WHEN (rtsparqadslcust.docketdat IS NOT NULL OR rtsparqadslcust.docketdat <> '') AND RTSPARQADSLCUST.DROPDAT IS NOT NULL AND RTSPARQADSLCUST.OVERDUE='Y' THEN 1 ELSE 0 END) " _
       &"FROM RTSparqAdslCmty left outer join rtsparqadslcust ON RTSparqAdslCmty.CUTYID = rtsparqadslcust.COMQ1 " _
       &"LEFT OUTER JOIN rtsparqadslcmtysndwork ON rtsparqadslcmty.cutyid = rtsparqadslcmtysndwork.cutyid AND " _
       &"rtsparqadslcmtysndwork.dropdat IS NULL AND rtsparqadslcmtysndwork.unclosedat IS NULL " _
       &"LEFT OUTER JOIN RTCounty ON RTSparqAdslCmty.CUTID = RTCounty.CUTID " _       
       &"LEFT OUTER JOIN RTObj ON RTSparqAdslCmty.CONSIGNEE = RTObj.CUSID " _
       &"LEFT OUTER JOIN RTEmployee inner join RTObj rtobj_a ON rtobj_a.cusid=RTEmployee.cusid on RTEmployee.emply = RTSparqAdslCmty.bussid " _
       &"left outer join rtctytown on RTSparqAdslCust.cutid2=rtctytown.cutid and RTSparqAdslCust.township2=rtctytown.township " _
       &"where " & searchqry & " " & limitemply _
       &" GROUP BY  RTSparqAdslCmty.CUTYID, " _
       &"isnull(RTOBJ.shortnc, isnull(rtobj_a.cusnc,'�L�k��')), " _
       &"RTSparqAdslCmty.COMN, RTSparqAdslCmty.cmtytel, RTSparqAdslCmty.HBNO, " _
       &"RTSparqAdslCmty.IPADDR, substring(IsNull(RTCounty.CUTNC,'')+RTSparqAdslCmty.TOWNSHIP+RTSparqAdslCmty.ADDR,1,25)+'....',rtsparqadslcmtysndwork.prtno, " _
       &"RTSparqAdslCmty.ADSLAPPLY, RTSparqAdslCmty.RCOMDROP " _
       &"ORDER BY  RTSparqAdslCmty.comn "
 'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>