<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
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
  functionOptName="��~��;�~�ȭ�;�ީe�|;�Ȥ�"
  functionOptProgram="RTCmtyBusK.asp;RTCmtySaleK.asp;RTCmtySpK.asp;RTCustK.asp"
  functionOptPrompt="N;N;N;N"
  accessMode="U"
  DSN="DSN=RTLib"
  formatName="���ɬy����;���ϧǸ�;���ϦW��;����;�`���;�Ӹˤ��"
  sqlDelete="SELECT RTCmty.COMQ1 , RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, RTCmty.COMCNT, " _
           &"RTCmty.APPLYCNT " _
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
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=12
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
  searchFirst=False
  If searchQry="" Then
     searchQry=" RTCmty.ComQ1<>0 "
     searchShow="����"
  End If
  If searchShow="����" Then
  sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT " _
         &"FROM (RTCounty INNER JOIN RTCmty ON " _
         &"RTCounty.CUTID=RTCmty.CUTID) INNER JOIN " _
         &"(RTArea INNER JOIN RTAreaCty ON RTArea.AREAID=RTAreaCty.AREAID) " _
         &"ON RTCmty.CUTID=RTAreaCty.CUTID " _
         &"WHERE RTArea.AREATYPE='1' AND " &searchQry &" " _
         &"ORDER BY RTCmty.COMQ1, RTCmty.COMQ2 "
  Else
  sqlList="SELECT RTCmty.COMQ1, RTCmty.COMQ2, RTCmty.COMN, RTCounty.CUTNC, " _
         &"RTCmty.COMCNT, RTCmty.APPLYCNT " _
         &"FROM (RTCounty INNER JOIN (RTCmtySale INNER JOIN RTCmty ON " _
         &"RTCmtySale.COMQ1 = RTCmty.COMQ1) ON RTCounty.CUTID = RTCmty.CUTID) " _
         &"INNER JOIN (RTArea INNER JOIN RTAreaCty ON RTArea.AREAID = RTAreaCty.AREAID) " _
         &"ON RTCmty.CUTID = RTAreaCty.CUTID " _
         &"WHERE RTArea.AREATYPE='1' AND rtcmtysale.exdat is null and " &searchQry &" " _
         &"ORDER BY RTCmty.COMQ1, RTCmty.COMQ2 "
  End If
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