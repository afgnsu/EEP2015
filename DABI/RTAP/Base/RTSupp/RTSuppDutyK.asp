<!-- #include virtual="/WebUtilityV2/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�t�ӳd���Ϥ���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName=""
  functionOptProgram=""
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�����N�X;�����W��;none;�d���Ϥ�"
  sqlDelete="SELECT RTSuppCty.CUSID, RTSuppCty.CUTID, RTCounty.CUTNC, RTSuppCty.DUTYTYPE," _
           &"RTCODE.CODENC " _
           &"FROM RTSuppCty INNER JOIN " _
           &"RTCounty ON RTSuppCty.CUTID = RTCounty.CUTID INNER JOIN " _
           &"RTCODE ON RTSuppCty.DUTYTYPE = RTCODE.CODE " _
           &"WHERE RTCODE.KIND = 'A2' AND RTSuppCty.CUSID='*' " 
  dataTable="RTSuppCty"
  numberOfKey=2
  dataProg="RTSuppDutyD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  debug36=false
  goodMorningImage="cbbn.jpg"
  colSplit=3
  keyListPageSize=60
  searchProg="self"
  searchShow=FrGetSuppDesc(aryParmKey(0))
  searchQry="rtsuppcty.cusid='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTSuppCty.CUSID, RTSuppCty.CUTID, RTCounty.CUTNC, RTSuppCty.DUTYTYPE," _
           &"RTCODE.CODENC " _
           &"FROM RTSuppCty INNER JOIN " _
           &"RTCounty ON RTSuppCty.CUTID = RTCounty.CUTID INNER JOIN " _
           &"RTCODE ON RTSuppCty.DUTYTYPE = RTCODE.CODE " _
           &"WHERE RTCODE.KIND = 'A2' and " & searchQry & " " _
           &"ORDER BY RTSuppCty.CUSID,RTSuppCty.CUTID "
End Sub
%>
<!-- #include file="RTGetSuppDesc.inc" -->