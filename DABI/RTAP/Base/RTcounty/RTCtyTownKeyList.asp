<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�m��ϸ�ƺ��@��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="none;�����W��;�m��ϦW��"
  sqlDelete="SELECT a.cutid,b.cutnc,a.TownShip from RTCtyTown a,rtcounty b Where a.cutid*=b.cutid and Cutid='*'"
  dataTable="rtctyTown"
  numberOfKey=2
  dataProg="RTCtyTownDataList.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=4
  keyListPageSize=80
  searchProg="rtctysearch.asp"
  If searchQry="" Then
     searchQry=" a.cutid='" & aryparmkey(0) & "'"
     searchShow=FrGetctyDesc(aryParmKey(0))       
  End If
  sqlList="SELECT a.cutid,b.cutnc,a.TownShip from RTCtyTown a,rtcounty b Where a.cutid=b.cutid and " &searchqry
End Sub
%>
<!-- #include file="RTGetCtyDesc.inc" -->