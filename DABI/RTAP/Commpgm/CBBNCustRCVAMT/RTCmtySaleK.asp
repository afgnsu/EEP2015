<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���Ϸ~�ȭ���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�~�ȩm�W;�ͮĤ��;�I����"
  sqlDelete="SELECT RTCmtySale.COMQ1, RTCmtySale.CUSID, RTObj.CUSNC, RTCmtySale.TDAT, " _
           &"RTCmtySale.EXDAT " _
           &"FROM RTObj INNER JOIN RTCmtySale ON RTObj.CUSID = RTCmtySale.CUSID " _
           &"WHERE RTCmtySale.CUSID='0' "
  dataTable="RTCmtySale"
  extTable=""
  numberOfKey=2
  dataProg="RTCmtySaleD.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  searchQry="RTCmtySale.COMQ1=" &aryParmKey(0) &" "
  sqlList="SELECT RTCmtySale.COMQ1, RTCmtySale.CUSID, RTObj.CUSNC, RTCmtySale.TDAT, " _
         &"RTCmtySale.EXDAT " _
         &"FROM RTCmtySale INNER JOIN RTObj ON RTCmtySale.CUSID = RTObj.CUSID " _
         &"WHERE " &searchQry
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
