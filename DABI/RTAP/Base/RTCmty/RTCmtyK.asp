<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�T�w�y�q;�p�q�y�q;��~��;�~�ȭ�;�ީe�|;�ȡ@��;�X�@��;FTTB�i��"
  functionOptProgram="rtcmtyflow.asp;rtcmtyflow2.asp;RTCmtyBusK.asp;RTCmtySaleK.asp;RTCmtySpK.asp;RTCustK.asp;RTContractK.asp;/WEBAP/RTAP/BASE/FTTBCMTYSTAT/FTTBCmtyStatK.ASP"
  functionOptPrompt="N;N;N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
 ' formatName="none;��B�I;�Ǹ�;none;���ϦW��;none;����IP;����;�W��<br>���;�Ӹˤ�;�`�Ѥ�; " _
 '           &"���O<br>������;�M�P��;�{����<br>�ƦX�p;�}�o<br>��v%;����<br>�u��;�w��<br>�u��;������;none;T1�}<br>�q��"
  formatName="none;��B�I;�Ǹ�;���ϦW��;HB����IP;����;�W��<br>���;HB<br>�ӽФ�;" _
            &"HB<br>�h���;HB<br>�{����;HB<br>�}�o�v%;HB<br>�����u��;HB<br>���u��;HB<BR>������;T1�}<br>�q��;FTTB�i��;�Ѹ�<BR>�ɵ{;��B�B"
            
  sqlDelete="SELECT RTCmty.COMQ1 , RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
           &"RTCmty.APPLYCNT,RTcmty.T1PETITION,RTCmty.Schdat,RTcmty.T1Apply " _
           &"FROM RTCmty INNER JOIN RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
           &"WHERE (((RTCmty.COMQ1)=0)) "
  dataTable="RTCmty"
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
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTCmtyS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" RTCmty.ComQ1=0 "
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
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89003" or Ucase(emply)="T89018" OR _
  '   Ucase(emply)="T89020" or Ucase(emply)="T89025"  then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
  '�~�Ȥu�{�v�u��Ū���Ӥu�{�v������
  'if userlevel=2 then

  '  If searchShow="����" Then
  '       sqlList="SELECT RTCmty.COMQ1," _
  '       &"CASE WHEN RTCode.PARM1 =  'AA'  THEN " _
  '       &"case when RTCTYTOWNX.operationname=''  OR RTCTYTOWNX.operationname IS NULL then " _
  '       &"CASE WHEN rtCMTY.cutid IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
  '       &"WHEN   rtCMTY.cutid IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
  '       &"ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE  rtcode.codenc END," _
  '       &"RTCmty.COMQ1,RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, RTCmty.COMCNT, " _
  '       &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end),  " _
  '       &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end), " _ 
  '       &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
  '       &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
  '       &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
  '       &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
  '       &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
  '       &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _   
  '       &"Sum(CASE when docketDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                  
  '       &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
  '       &"FROM RTArea INNER JOIN " _
  '       &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID  and RTArea.AREATYPE='1' and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
  '       &"RTVCmtyGroup RIGHT OUTER JOIN " _
  '       &"RTCust RIGHT OUTER JOIN " _
  '       &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTVCmtyGroup.COMQ1 = RTCmty.COMQ1  ON  " _
  '       &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
  '       &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _
  '       &" left outer JOIN RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' " _
  '       &" left outer join rtctytown RTCTYTOWNX on rtcust.cutid1=rtctytownX.cutid and rtcust.township1=rtctytownX.township " _
  '       &"WHERE "& searchQry &" " _
  '       &"group by RTCmty.COMQ1," _
  '       &"CASE WHEN RTCode.PARM1 =  'AA'  THEN " _
  '       &"case when RTCTYTOWNX.operationname=''  OR RTCTYTOWNX.operationname IS NULL then " _
  '       &"CASE WHEN rtCMTY.cutid IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
  '       &"WHEN   rtcMTY.cutid IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
  '       &"ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE  rtcode.codenc END," _
  '       &"RTCmty.COMQ1,RTCmty.COMQ2, RTCmty.COMN,t1no,netip, RTCounty.CUTNC, " _
  '       &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
  '       &"RTCmty.T1APPLY " _         
  '       &"ORDER BY RTCmty.COMN "       
  '  Else
  '       sqlList="SELECT RTCmty.COMQ1," _
  '       &"CASE WHEN RTCode.PARM1 =  'AA'  THEN " _
  '       &"case when RTCTYTOWNX.operationname=''  OR RTCTYTOWNX.operationname IS NULL then " _
  '       &"CASE WHEN rtCMTY.cutid IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
  '       &"WHEN   rtcMTY.cutid IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
  '       &"ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE  rtcode.codenc END," _
  '       &"RTCmty.COMQ1,RTCmty.COMQ2, RTCmty.COMN,t1no,netip ,RTCounty.CUTNC, RTCmty.COMCNT, " _
  '       &"sum( CASE custype  when '�Ӹˤ�'  THEN 1 ELSE 0 end) ,  " _
  '       &"sum(CASE custype  when '�`�Ѥ�'  THEN 1 ELSE 0 end) , " _ 
  '       &"Sum(CASE custype  when ''  THEN 1 ELSE 0 end), " _
  '       &"Sum(CASE when DROPDAT is Null  THEN 0 ELSE 1 END ), " _                    
  '       &"Sum(CASE when DROPDAT is Null and rtcust.cusid is not null THEN 1 ELSE 0 END), " _            
  '       &"case when RTCmty.COMCNT = 0 then 0 else Sum(CASE when DROPDAT is Null and rtcust.cusid is not null  THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT*1.0)  end , "  _                    
  '       &"Sum(CASE when FINISHDAT is Null and dropdat is null  and rtcust.cusid is not null THEN 1 ELSE 0 END), " _                    
  '       &"Sum(CASE when FINISHDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _   
  '       &"Sum(CASE when DOCKETDAT is not Null and dropdat is null THEN 1 ELSE 0 END), " _                  
  '       &"RTcmty.T1PETITION,RTcmty.T1Apply  " _
  ''       &"FROM RTArea inner JOIN " _
  '       &"RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID and RTArea.AREATYPE='1' and rtarea.areaid" & DareaID & " RIGHT OUTER JOIN " _
  '       &"RTVCmtyGroup RIGHT OUTER JOIN " _
  '       &"RTCust RIGHT OUTER JOIN " _         
  '       &"RTCmty ON RTCUST.COMQ1 = RTCMTY.COMQ1 ON RTVCmtyGroup.COMQ1 = RTCmty.COMQ1  ON " _
  '       &"RTAreaCty.CUTID = RTCmty.CUTID LEFT OUTER JOIN " _
  '       &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID " _ 
  '       &" left outer JOIN RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' " _
  '       &" left outer join rtctytown RTCTYTOWNX on rtcust.cutid1=rtctytownX.cutid and rtcust.township1=rtctytownX.township " _
  '       &"WHERE "& searchQry &" " _
  '       &"group by RTCmty.COMQ1," _
  '       &"CASE WHEN RTCode.PARM1 =  'AA'  THEN " _
  '       &"case when RTCTYTOWNX.operationname=''  OR RTCTYTOWNX.operationname IS NULL then " _
  '       &"CASE WHEN rtCMTY.cutid IN ('08','09','10','11','12','13') THEN '�ĤQ�G��B�I' " _
  '       &"WHEN   rtcMTY.cutid IN ('14','15','16','17','18','19','20','21','23') THEN '�ĤQ�T��B�I' " _
  '       &"ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE  rtcode.codenc END," _
  '       &"RTCmty.COMQ1,RTCmty.COMQ2, RTCmty.COMN, t1no,netip,RTCounty.CUTNC, " _
  '       &"RTCmty.COMCNT, RTCmty.APPLYCNT, RTCmty.T1PETITION, RTCmty.SCHDAT, " _
  '       &"RTCmty.T1APPLY " _                  
  '       &"ORDER BY RTCmty.COMN "       
  '  End If  
  'end if
  sqlList="SELECT RTCmty.COMQ1,CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname = '' OR " _
         &"RTCTYTOWNX.operationname IS NULL THEN CASE WHEN rtCMTY.cutid IN ('08','09', '10', '11', '12', '13') " _
         &"THEN '�ĤQ�G��B�I' WHEN rtcMTY.cutid IN ('14','15', '16', '17', '18', '19', '20', '21', '23') " _
         &"THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END, " _
         &"rtcmty.comq1, RTCmty.COMN, rtcmty.netip,RTCounty.CUTNC, RTCmty.COMCNT, SUM(CASE WHEN rtcust.cusid <> '' AND " _
         &"freecode <> 'Y' THEN 1 ELSE 0 END), SUM(CASE WHEN DROPDAT IS NOT NULL AND rtcust.cusid IS NOT NULL AND " _
         &"freecode <> 'Y' THEN 1 ELSE 0 END), SUM(CASE WHEN DROPDAT IS NULL AND rtcust.cusid IS NOT NULL AND " _
         &"freecode <> 'Y' THEN 1 ELSE 0 END), CASE WHEN RTCmty.COMCNT = 0 THEN 0 ELSE SUM(CASE WHEN DROPDAT IS NULL AND " _
         &"rtcust.cusid IS NOT NULL AND freecode <> 'Y' AND docketdat IS NOT NULL THEN 1 ELSE 0 END) * 100 / " _
         &"(RTCmty.COMCNT * 1.0) END, SUM(CASE WHEN FINISHDAT IS NULL AND dropdat IS NULL AND " _
         &"rtcust.cusid IS NOT NULL AND freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN FINISHDAT IS NOT NULL AND dropdat IS NULL AND freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DOCKETDAT IS NOT NULL AND dropdat IS NULL AND freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"RTcmty.T1Apply, FTTBCMTYSTAT.codenc, FTTBCMTYSTAT.parm1, FTTBCHTSERVICEPOINT.CHTNAME " _
         &"FROM (SELECT FTTBCMTYSTAT.comq1, RTCODE.CODENC, rtcode.parm1 FROM fttbcmtystat LEFT OUTER JOIN " _
         &"             rtcode ON fttbcmtystat.smode = rtcode.code AND rtcode.kind = 'O6' " _
         &"             GROUP BY   FTTBCMTYSTAT.comq1, rtcode.codenc, rtcode.parm1) FTTBCMTYSTAT right outer JOIN " _
         &"RTCmty ON FTTBCMTYSTAT.COMQ1 = RTCmty.COMQ1 LEFT OUTER JOIN rtctytown RTCTYTOWNX ON " _
         &"rtcmty.cutid = rtctytownX.cutid AND rtcmty.township = rtctytownX.township LEFT OUTER JOIN " _
         &"RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' LEFT OUTER JOIN " _
         &"rTCounty ON RTCmty.CUTID = RTCounty.CUTID LEFT OUTER JOIN FTTBCHTSERVICEPOINT ON  " _
         &"RTCMTY.WORKPLACE = FTTBCHTSERVICEPOINT.CHTID LEFT OUTER JOIn rtcust ON rtcmty.comq1 = rtcust.comq1 " _
         &"WHERE rtcmty.comq1 <> 0 and " & searchqry & " " _
         &"GROUP BY  RTCmty.COMQ1, CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname = '' OR " _
         &"RTCTYTOWNX.operationname IS NULL THEN CASE WHEN rtCMTY.cutid IN ('08','09', '10', '11', '12', '13') " _
         &"THEN '�ĤQ�G��B�I' WHEN rtcMTY.cutid IN ('14','15', '16', '17', '18', '19', '20', '21', '23') " _
         &"THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END, " _
         &"RTCmty.COMN, rtcmty.netip, RTCounty.CUTNC, RTCmty.COMCNT, RTcmty.T1Apply, FTTBCMTYSTAT.codenc, " _
         &"FTTBCHTSERVICEPOINT.CHTNAME, FTTBCMTYSTAT.parm1 ORDER BY  RTCmty.COMN " 
  
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(1)) > 0 Then
     delSql="DELETE  FROM RTCmtyBus WHERE COMQ1 IN " &extDeleList(1) &" " 
     conn.Execute delSql
     delSql="DELETE  FROM RTCmtySale WHERE COMQ1 IN " &extDeleList(1) &" "
     conn.Execute delSql
     delSql="DELETE  FROM RTCmtySp WHERE COMQ1 IN " &extDeleList(1) &" "
     conn.Execute delSql
  End If
  conn.Close
End Sub
%>