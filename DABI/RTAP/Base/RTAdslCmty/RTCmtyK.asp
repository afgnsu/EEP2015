<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����y�q;�ȡ@��"
  functionOptProgram="RTCMTYFLOW.ASP;RTCustK.asp"
  functionOptPrompt="N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;��B�I;���ϦW��;HB���X;IP;�]�Ʀ�m;���q��;�M�u��;�ӽ�;���u;���m;�M�P<BR>�h��;�t��" 
  sqlDelete="SELECT RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
           &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, RTCustAdslCmty.ADSLAPPLY, RTCustAdslCmty.RCOMDROP, " _
           &"SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.CUSID <> '' THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN (rtcustadsl.finishdat IS NOT NULL OR rtcustadsl.finishdat <> '') AND rtcustadsl.dropdat is null THEN 1 ELSE 0 END), " _           
           &"SUM(CASE WHEN (rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '') and rtcustadsl.dropdat is null THEN 1 ELSE 0 END), " _
           &"SUM(CASE WHEN rtcustadsl.dropdat   IS NOT NULL OR rtcustadsl.dropdat <> ''   THEN 1 ELSE 0 END), " _
           &"case when rtcustadslcmty.rcomdrop is null then ( SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.cusid <> '' THEN 1 ELSE 0 END)- " _
           &"SUM(CASE WHEN (rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '') and rtcustadsl.dropdat is null THEN 1 ELSE 0 END)- " _
           &"SUM(CASE WHEN rtcustadsl.dropdat   IS NOT NULL OR rtcustadsl.dropdat <> ''   THEN 1 ELSE 0 END)) else 0 end " _        
           &"FROM RTCustAdslCmty LEFT OUTER JOIN RTCustADSL ON RTCustAdslCmty.CUTYID = RTCustADSL.COMQ1 " _
           &"WHERE (RTCustAdslCmty.COMN <> '*') " _
           &"GROUP BY  RTCustAdslCmty.CUTYID, RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
           &"RTCustAdslCmty.IPADDR, RTCustAdslCmty.EQUIPADDR, " _
           &"RTCustAdslCmty.ADSLAPPLY, RTCustAdslCmty.RCOMDROP " _
           &"ORDER BY  RTCustAdslCmty.equipaddr "
  dataTable="RTCUSTADSLCmty"
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
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTCmtyS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=true
  If searchQry="" Then
     searchQry=" RTCUSTADSLCMTY.CUTYID=0  "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
     searchQry2=" "
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=RTLIB"
  sqlxx="select areaid,groupid from RTsalesgroupref where emply='" & emply & "' "
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  areaid=""
  groupid=""
  DO while not rsxx.eof
     leadingA=","
     leadingB=","  
     if len(trim(areaid))=0 then leadingA=""
     if len(trim(groupid))=0 then leadingB=""
     areaid=areaid & leadingA & "'" &  rsxx("areaid") & "' "
     groupid=groupid & leadingB & "'" & rsxx("groupid") & "' "
     rsxx.movenext 
  loop
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing

  sqllist="SELECT RTCustAdslCmty.CUTYID," _
       &"case WHEN RTCODE.PARM1<>'AA' THEN RTCODE.CODENC when operationname='' AND RTCODE.PARM1='AA' then '�L�k�k��' WHEN RTCODE.PARM1='AA' AND operationname<>'' THEN operationname ELSE '�L�k�k��' END," _
       &"RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
       &"RTCustAdslCmty.IPADDR, SUBSTRING(RTCustAdslCmty.EQUIPADDR,1,25)+'....', RTCustAdslCmty.ADSLAPPLY, RTCustAdslCmty.RCOMDROP, " _
       &"SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.cusid <> '' THEN 1 ELSE 0 END), " _ 
       &"SUM(CASE WHEN (rtcustadsl.finishdat IS NOT NULL OR rtcustadsl.finishdat <> '') AND rtcustadsl.dropdat is null THEN 1 ELSE 0 END), " _           
       &"SUM(CASE WHEN (rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '') and rtcustadsl.dropdat is null THEN 1 ELSE 0 END), " _
       &"SUM(CASE WHEN rtcustadsl.dropdat   IS NOT NULL OR rtcustadsl.dropdat <> ''   THEN 1 ELSE 0 END), " _ 
       &"case when rtcustadslcmty.rcomdrop is null then ( SUM(CASE WHEN rtcustadsl.cusid IS NOT NULL OR rtcustadsl.cusid <> '' THEN 1 ELSE 0 END)- " _
       &"SUM(CASE WHEN (rtcustadsl.docketdat IS NOT NULL OR rtcustadsl.docketdat <> '') and rtcustadsl.dropdat is null THEN 1 ELSE 0 END)- " _
       &"SUM(CASE WHEN rtcustadsl.dropdat   IS NOT NULL OR rtcustadsl.dropdat <> ''   THEN 1 ELSE 0 END)) else 0 end " _        
       &"FROM RTCustAdslCmty LEFT OUTER JOIN RTCustADSL ON RTCustAdslCmty.CUTYID = RTCustADSL.COMQ1 " _
       &"LEFT OUTER JOIN RTCODE ON rtcustadslcmty.COMTYPE=RTCODE.CODE AND RTCODE.KIND='B3' " _
       &"left outer join rtctytown on rtcustadsl.cutid2=rtctytown.cutid and rtcustadsl.township2=rtctytown.township " _
       &"WHERE " &  searchqry  _
       &" GROUP BY  RTCustAdslCmty.CUTYID, " _
       &"case WHEN RTCODE.PARM1<>'AA' THEN RTCODE.CODENC when operationname='' AND RTCODE.PARM1='AA' then '�L�k�k��' WHEN RTCODE.PARM1='AA' AND operationname<>'' THEN operationname ELSE '�L�k�k��' END," _
       &"RTCustAdslCmty.COMN, RTCustAdslCmty.HBNO, " _
       &"RTCustAdslCmty.IPADDR, SUBSTRING(RTCustAdslCmty.EQUIPADDR,1,25)+'....', " _
       &"RTCustAdslCmty.ADSLAPPLY, RTCustAdslCmty.RCOMDROP " _
       & searchQry2 & " " _
       &"ORDER BY  RTCustAdslCmty.comn "
'response.Write SQLLIST
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>