<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="FTTB���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�~�ȭ�;�ީe�|;HB�Ȥ�;FTTB�Ȥ�;�C�LFTTB�ӽЮ�;�X�@��;���ƶi��"
  functionOptProgram="RTCmtySaleK.asp;RTCmtySpK.asp;/WEBAP/RTAP/BASE/FTTBCMTYSTAT/RTCustK.asp;/WEBAP/RTAP/BASE/FTTBCMTYSTAT/FTTBCUSTK.ASP;/report/fttb/HBReport1d.asp;RTContractK.asp;/WEBAP/RTAP/BASE/FTTBCMTYSTAT/FTTBCmtyStatK.ASP"
  functionOptPrompt="N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
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
  searchProg="RTCmtyS3.asp"
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
    If searchShow="����" Then
         sqlList="SELECT  RTCmty.COMQ1, " _
         &"CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname = '' OR RTCTYTOWNX.operationname IS NULL " _
         &"THEN CASE WHEN rtCMTY.cutid IN ('08','09', '10', '11', '12', '13') THEN '�ĤQ�G��B�I' " _
         &"WHEN rtcMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20', '21', '23') " _
         &"THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END,rtcmty.comq1," _
         &"RTCmty.COMN, rtcmty.netip, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"SUM(CASE WHEN rtcust.cusid <> '' and freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DROPDAT IS not NULL AND rtcust.cusid IS NOT NULL and freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DROPDAT IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y'  THEN 1 ELSE 0 END), " _
         &"CASE WHEN RTCmty.COMCNT = 0 THEN 0 ELSE " _
         &"SUM(CASE WHEN DROPDAT IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y' and docketdat is not null THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT * 1.0) END," _
         &"SUM(CASE WHEN FINISHDAT IS NULL AND dropdat IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN FINISHDAT IS NOT NULL AND dropdat IS NULL and freecode<>'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DOCKETDAT IS NOT NULL AND dropdat IS NULL and freecode<>'Y' THEN 1 ELSE 0 END), RTcmty.T1Apply, " _
         &"FTTBCMTYSTAT.codenc,FTTBCMTYSTAT.parm1, FTTBCHTSERVICEPOINT.CHTNAME " _
         &"fROM (SELECT FTTBCMTYSTAT.comq1, RTCODE.CODENC, rtcode.parm1 FROM fttbcmtystat LEFT OUTER JOIN " _
         &"rtcode ON fttbcmtystat.smode = rtcode.code AND rtcode.kind = 'O6' " _
         &"GROUP BY   FTTBCMTYSTAT.comq1, rtcode.codenc, rtcode.parm1) " _
         &"FTTBCMTYSTAT INNER JOIN RTCmty ON FTTBCMTYSTAT.COMQ1 = RTCmty.COMQ1 LEFT OUTER JOIN " _
         &"rtctytown RTCTYTOWNX ON rtcmty.cutid = rtctytownX.cutid AND rtcmty.township = rtctytownX.township " _
         &"lEFT OUTER JOIN RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID LEFT OUTER JOIN FTTBCHTSERVICEPOINT ON " _
         &"RTCMTY.WORKPLACE = FTTBCHTSERVICEPOINT.CHTID LEFT OUTER JOIN " _
         &"rtcust ON rtcmty.comq1 = rtcust.comq1 " _
         &"where rtcmty.comq1 <> 0 and " & searchQry & " " _
         &"GROUP BY  RTCmty.COMQ1, CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname " _
         &"= '' OR RTCTYTOWNX.operationname IS NULL THEN CASE WHEN rtCMTY.cutid IN " _
         &"('08','09', '10', '11', '12', '13') THEN '�ĤQ�G��B�I' WHEN rtcMTY.cutid IN " _
         &"('14','15', '16', '17', '18', '19', '20', '21', '23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
         &"ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END, RTCmty.COMN, rtcmty.netip, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTcmty.T1Apply,FTTBCMTYSTAT.codenc, FTTBCHTSERVICEPOINT.CHTNAME, FTTBCMTYSTAT.parm1 " _         
         &"ORDER BY RTCmty.COMN "       
    Else
         sqlList="SELECT  RTCmty.COMQ1, " _
         &"CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname = '' OR RTCTYTOWNX.operationname IS NULL " _
         &"THEN CASE WHEN rtCMTY.cutid IN ('08','09', '10', '11', '12', '13') THEN '�ĤQ�G��B�I' " _
         &"WHEN rtcMTY.cutid IN ('14', '15', '16', '17', '18', '19', '20', '21', '23') " _
         &"THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END,rtcmty.comq1," _
         &"RTCmty.COMN, rtcmty.netip, RTCounty.CUTNC, RTCmty.COMCNT, " _
         &"SUM(CASE WHEN rtcust.cusid <> '' and freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DROPDAT IS not NULL AND rtcust.cusid IS NOT NULL and freecode <> 'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DROPDAT IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y'  THEN 1 ELSE 0 END), " _
         &"CASE WHEN RTCmty.COMCNT = 0 THEN 0 ELSE " _
         &"SUM(CASE WHEN DROPDAT IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y' and docketdat is not null THEN 1 ELSE 0 END) * 100 / (RTCmty.COMCNT * 1.0) END," _
         &"SUM(CASE WHEN FINISHDAT IS NULL AND dropdat IS NULL AND rtcust.cusid IS NOT NULL and freecode<>'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN FINISHDAT IS NOT NULL AND dropdat IS NULL and freecode<>'Y' THEN 1 ELSE 0 END), " _
         &"SUM(CASE WHEN DOCKETDAT IS NOT NULL AND dropdat IS NULL and freecode<>'Y' THEN 1 ELSE 0 END), RTcmty.T1Apply, " _
         &"FTTBCMTYSTAT.codenc,FTTBCMTYSTAT.parm1, FTTBCHTSERVICEPOINT.CHTNAME " _
         &"fROM (SELECT FTTBCMTYSTAT.comq1, RTCODE.CODENC, rtcode.parm1 FROM fttbcmtystat LEFT OUTER JOIN " _
         &"rtcode ON fttbcmtystat.smode = rtcode.code AND rtcode.kind = 'O6' " _
         &"GROUP BY   FTTBCMTYSTAT.comq1, rtcode.codenc, rtcode.parm1) " _
         &"FTTBCMTYSTAT INNER JOIN RTCmty ON FTTBCMTYSTAT.COMQ1 = RTCmty.COMQ1 LEFT OUTER JOIN " _
         &"rtctytown RTCTYTOWNX ON rtcmty.cutid = rtctytownX.cutid AND rtcmty.township = rtctytownX.township " _
         &"lEFT OUTER JOIN RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' LEFT OUTER JOIN " _
         &"RTCounty ON RTCmty.CUTID = RTCounty.CUTID LEFT OUTER JOIN FTTBCHTSERVICEPOINT ON " _
         &"RTCMTY.WORKPLACE = FTTBCHTSERVICEPOINT.CHTID LEFT OUTER JOIN " _
         &"rtcust ON rtcmty.comq1 = rtcust.comq1 " _
         &"where rtcmty.comq1 <> 0 and " & searchQry & " " _
         &"GROUP BY  RTCmty.COMQ1, CASE WHEN RTCode.PARM1 = 'AA' THEN CASE WHEN RTCTYTOWNX.operationname " _
         &"= '' OR RTCTYTOWNX.operationname IS NULL THEN CASE WHEN rtCMTY.cutid IN " _
         &"('08','09', '10', '11', '12', '13') THEN '�ĤQ�G��B�I' WHEN rtcMTY.cutid IN " _
         &"('14','15', '16', '17', '18', '19', '20', '21', '23') THEN '�ĤQ�T��B�I' ELSE '�L�k�k��' END " _
         &"ELSE RTCTYTOWNX.operationname END ELSE rtcode.codenc END, RTCmty.COMN, rtcmty.netip, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTcmty.T1Apply, FTTBCMTYSTAT.codenc,FTTBCHTSERVICEPOINT.CHTNAME, FTTBCMTYSTAT.parm1 " _         
         &"ORDER BY RTCmty.COMN "             
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
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