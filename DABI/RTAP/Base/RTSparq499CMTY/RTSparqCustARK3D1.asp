<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t�պ޲z�t��"
  title="�t�եΤ��������I�b�ک��Ӭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  functionoptopen=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�Τ�;none;�b�ڽs��;none;�|�p���;none;�߱b<br>�~��;���ئW��;��/�t;����(�I)<br>���B;�w�R�P<br>���B;���R�b<br>���B;���ͤ�;�R�b��;�@�o��;�@�o��]"
  sqlDelete="SELECT     RTSparq499CustARDTL.TYY,RTSparq499CustARDTL.TMM,RTSparq499cmtyh.comn,RTObj.cusnc,RTSparq499CustARDTL.CUSID, RTSparq499CustARDTL.BATCHNO, " _
                        &"  RTSparq499CustARDTL.SEQ, " _
                        &"  RTSparq499CustARDTL.L14 + '-' + RTSparq499CustARDTL.L23 AS Expr2, " _
                        &"  RTAccountNo.ACNAMEC, RTSparq499CustARDTL.ITEMNC, " _
                        &"  RTSparq499CustARDTL.PORM, RTSparq499CustARDTL.AMT, " _
                        &"  RTSparq499CustARDTL.REALAMT, " _
                        &"  RTSparq499CustARDTL.AMT - RTSparq499CustARDTL.REALAMT AS Expr1, " _
                        &"  RTSparq499CustARDTL.CDAT, RTSparq499CustARDTL.MDAT, " _
                        &"  RTSparq499CustARDTL.CANCELDAT, RTSparq499CustARDTL.CANCELMEMO " _
           &"FROM           RTSparq499CustARDTL LEFT OUTER JOIN " _
                        &"  RTAccountNo ON RTSparq499CustARDTL.L14 = RTAccountNo.L14 AND " _
                        &"  RTSparq499CustARDTL.L23 = RTAccountNo.L23 " _
           &"where RTSparq499CustARDTL.cusid='' "
  dataTable="RTSparq499CustARDTL"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg=""
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
 
  searchFirst=FALSE
  If searchQry="" Then
  	 if ARYPARMKEY(2) ="Sparq399" then
		searchQry=" RTSparqAdslCustARDTL.TYY=" & ARYPARMKEY(0) & " AND RTSparqAdslCustARDTL.TMM=" & ARYPARMKEY(1) & " "
     elseif ARYPARMKEY(2) ="Sparq499" then
		searchQry=" RTSparq499CustARDTL.TYY=" & ARYPARMKEY(0) & " AND RTSparq499CustARDTL.TMM=" & ARYPARMKEY(1) & " "
     end if
     searchShow="�b�ڻ{�C�~��J" & ARYPARMKEY(0) & "/" & right("00" + ARYPARMKEY(1),2)
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
  'Domain=Mid(Emply,1,1)
  if ARYPARMKEY(2) ="Sparq399" then
    sqlList="SELECT         RTSparqAdslCustARDTL.TYY,RTSparqAdslCustARDTL.TMM,RTSparqAdslcmty.comn,RTObj.cusnc, RTSparqAdslCustARDTL.CUSID, RTSparqAdslCustARDTL.BATCHNO, " _
                        &"  RTSparqAdslCustARDTL.SEQ, " _
                        &"  RTSparqAdslCustARDTL.L14 + '-' + RTSparqAdslCustARDTL.L23 AS Expr2, " _
                        &"  RTAccountNo.ACNAMEC,convert(varchar(4),RTSparqAdslCustARDTL.syy)+'/'+convert(varchar(2),RTSparqAdslCustARDTL.smm), RTSparqAdslCustARDTL.ITEMNC, " _
                        &"  RTSparqAdslCustARDTL.PORM, RTSparqAdslCustARDTL.AMT, " _
                        &"  RTSparqAdslCustARDTL.REALAMT, " _
                        &"  RTSparqAdslCustARDTL.AMT - RTSparqAdslCustARDTL.REALAMT AS Expr1, " _
                        &"  RTSparqAdslCustARDTL.CDAT, RTSparqAdslCustARDTL.MDAT, " _
                        &"  RTSparqAdslCustARDTL.CANCELDAT, RTSparqAdslCustARDTL.CANCELMEMO " _
           &"FROM           RTSparqAdslCustARDTL LEFT OUTER JOIN " _
                        &"  RTAccountNo ON RTSparqAdslCustARDTL.L14 = RTAccountNo.L14 AND " _
                        &"  RTSparqAdslCustARDTL.L23 = RTAccountNo.L23 LEFT OUTER JOIN RTSparqAdslCUST ON RTSparqAdslCustARDTL.CUSID=RTSparqAdslCUST.CUSID LEFT OUTER JOIN " _
                        &"  RTSparqAdslCMTY ON RTSparqAdslCUST.COMQ1=RTSparqAdslCMTY.cutyid LEFT OUTER JOIN " _
						&"  RTObj ON RTOBJ.CUSID = RTSparqAdslCUST.CUSID " _
           &"where RTSparqAdslCustARDTL.MDAT IS NOT NULL and RTSparqAdslCustARDTL.canceldat is null AND " & searchqry & " ORDER BY RTSparqAdslCustARDTL.CUSID,RTSparqAdslCustARDTL.SEQ "
  elseif ARYPARMKEY(2) ="Sparq499" then
    sqlList="SELECT         RTSparq499CustARDTL.TYY,RTSparq499CustARDTL.TMM,RTSparq499cmtyh.comn,RTSparq499cust.cusnc, RTSparq499CustARDTL.CUSID, RTSparq499CustARDTL.BATCHNO, " _
                        &"  RTSparq499CustARDTL.SEQ, " _
                        &"  RTSparq499CustARDTL.L14 + '-' + RTSparq499CustARDTL.L23 AS Expr2, " _
                        &"  RTAccountNo.ACNAMEC,convert(varchar(4),RTSparq499CustARDTL.syy)+'/'+convert(varchar(2),RTSparq499CustARDTL.smm), RTSparq499CustARDTL.ITEMNC, " _
                        &"  RTSparq499CustARDTL.PORM, RTSparq499CustARDTL.AMT, " _
                        &"  RTSparq499CustARDTL.REALAMT, " _
                        &"  RTSparq499CustARDTL.AMT - RTSparq499CustARDTL.REALAMT AS Expr1, " _
                        &"  RTSparq499CustARDTL.CDAT, RTSparq499CustARDTL.MDAT, " _
                        &"  RTSparq499CustARDTL.CANCELDAT, RTSparq499CustARDTL.CANCELMEMO " _
           &"FROM           RTSparq499CustARDTL LEFT OUTER JOIN " _
                        &"  RTAccountNo ON RTSparq499CustARDTL.L14 = RTAccountNo.L14 AND " _
                        &"  RTSparq499CustARDTL.L23 = RTAccountNo.L23 LEFT OUTER JOIN RTSparq499CUST ON RTSparq499CustARDTL.CUSID=RTSparq499CUST.CUSID LEFT OUTER JOIN " _
                        &"  RTSparq499CMTYH ON RTSparq499CUST.COMQ1=RTSparq499CMTYH.COMQ1 " _
           &"where RTSparq499CustARDTL.MDAT IS NOT NULL and RTSparq499CustARDTL.canceldat is null AND " & searchqry & " ORDER BY RTSparq499CustARDTL.CUSID,RTSparq499CustARDTL.SEQ "
  end if

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>