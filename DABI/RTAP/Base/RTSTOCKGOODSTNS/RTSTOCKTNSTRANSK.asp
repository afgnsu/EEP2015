<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�ռ��沧�ʪ��p�d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�ռ��渹;����;�ռ���;���X�ܮw;���X��;���J�ܮw;���J��;���J���;�@�o���;�@�o��;���ʤ��;���ʧO;���ʭ�"
  sqlDelete="SELECT RTSTOCKTNSTRANSLOG.TRANSNO , RTSTOCKTNSTRANSLOG.ENTRYNO , "_
           &"RTSTOCKTNSTRANSLOG.TRANSDAT , HBwarEhouse.WARENAME , RTEmployee.EMPLY, HBwarEhouse_1.WARENAME, RTObj.CUSNC, " _
           &"RTSTOCKTNSTRANSLOG.INSIGNDAT, RTSTOCKTNSTRANSLOG.DROPDAT,  RTObj_2.CUSNC , RTSTOCKTNSTRANSLOG.TRANSD, " _
           &"RTCode.CODENC, RTObj_3.CUSNC " _
           &"FROM RTCode INNER JOIN RTSTOCKTNSTRANSLOG INNER JOIN HBwarEhouse ON " _
           &"RTSTOCKTNSTRANSLOG.OUTWAREHOUSE = HBwarEhouse.WAREHOUSE INNER JOIN HBwarEhouse HBwarEhouse_1 ON " _
           &"RTSTOCKTNSTRANSLOG.INWAREHOUSE = HBwarEhouse_1.WAREHOUSE INNER JOIN RTEmployee ON " _
           &"RTSTOCKTNSTRANSLOG.OUTSIGN = RTEmployee.EMPLY INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON RTSTOCKTNSTRANSLOG.INSIGN = RTEmployee_1.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTCode.CODE = RTSTOCKTNSTRANSLOG.TRANSCODE AND " _
           &"RTCode.KIND = 'G2' INNER JOIN RTEmployee RTEmployee_3 ON " _
           &"RTSTOCKTNSTRANSLOG.TRANSUSR = RTEmployee_3.EMPLY INNER JOIN " _
           &"RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID LEFT OUTER JOIN " _
           &"RTObj RTObj_2 INNER JOIN RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
           &"RTSTOCKTNSTRANSLOG.DROPUSR = RTEmployee_2.EMPLY " _
           &"WHERE RTSTOCKTNSTRANSLOG.TRANSNO='*' "       

  dataTable=""
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="None"
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
  keyListPageSize=20
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
  searchFirst=false
  If searchQry="" Then
     searchQry=" AND RTSTOCKTNSTRANSLOG.transNO ='" & ARYPARMKEY(0) & "' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKTNSTRANSLOG.TRANSNO , RTSTOCKTNSTRANSLOG.ENTRYNO , "_
           &"RTSTOCKTNSTRANSLOG.TRANSDAT , HBwarEhouse.WARENAME , RTEmployee.EMPLY, HBwarEhouse_1.WARENAME, RTObj.CUSNC, " _
           &"RTSTOCKTNSTRANSLOG.INSIGNDAT, RTSTOCKTNSTRANSLOG.DROPDAT,  RTObj_2.CUSNC , RTSTOCKTNSTRANSLOG.TRANSD, " _
           &"RTCode.CODENC, RTObj_3.CUSNC " _
           &"FROM RTCode INNER JOIN RTSTOCKTNSTRANSLOG INNER JOIN HBwarEhouse ON " _
           &"RTSTOCKTNSTRANSLOG.OUTWAREHOUSE = HBwarEhouse.WAREHOUSE INNER JOIN HBwarEhouse HBwarEhouse_1 ON " _
           &"RTSTOCKTNSTRANSLOG.INWAREHOUSE = HBwarEhouse_1.WAREHOUSE INNER JOIN RTEmployee ON " _
           &"RTSTOCKTNSTRANSLOG.OUTSIGN = RTEmployee.EMPLY INNER JOIN RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON RTSTOCKTNSTRANSLOG.INSIGN = RTEmployee_1.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON RTCode.CODE = RTSTOCKTNSTRANSLOG.TRANSCODE AND " _
           &"RTCode.KIND = 'G2' INNER JOIN RTEmployee RTEmployee_3 ON " _
           &"RTSTOCKTNSTRANSLOG.TRANSUSR = RTEmployee_3.EMPLY INNER JOIN " _
           &"RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID LEFT OUTER JOIN " _
           &"RTObj RTObj_2 INNER JOIN RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
           &"RTSTOCKTNSTRANSLOG.DROPUSR = RTEmployee_2.EMPLY " _
           &"WHERE RTSTOCKTNSTRANSLOG.transNO ='" & ARYPARMKEY(0) & "' " &searchQry &" " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>