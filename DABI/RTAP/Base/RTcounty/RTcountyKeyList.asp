<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�����N�X����ɺ��@"
  buttonName=" �s�W ; �R�� ; ���� ; ���s��z ; ���� ; �\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�m��ϩ���"
  functionOptProgram="RTCtyTownKeylist.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="�����N�X;�����W��"
  sqlDelete="Select CUTID,CUTNC from RTCounty WHERE cutid='*' "
  dataTable="rtcounty"
  numberOfKey=1
  dataProg="rtcountyDataList.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=30
  searchProg="self"
  If searchQry="" Then
     searchQry=" cutid <> '*'"
     searchshow="�����G����"
  End If
  sqlList="Select CUTID,CUTNC from RTCounty where " &searchqry
End Sub
%>