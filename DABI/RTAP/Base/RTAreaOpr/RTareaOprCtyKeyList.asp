<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�I�u�ҰϻP�����O���Y���@"
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
  formatName="�ҰϥN�X;none;�ҰϦW��;�Ұ����O;�����W��;�ͮĤ��;�I����"
  sqlDelete="SELECT RTAreacty.AREAID,  RTAreaCty.CUTID,RTArea.AREANC, case areatype when '1' then '�~���Ұ�' when '2' then '�I�u�Ұ�' END AS AreaTypeC, " _
           &"RTCounty.CUTNC, RTAreaCty.TDAT, RTAreaCty.EXDAT " _
           &"FROM RTAreacty INNER JOIN " _
           &"RTArea ON RTAreacty.AREAID = RTArea.AREAID INNER JOIN " _
           &"RTCounty ON RTAreaCty.CUTID = RTCounty.CUTID WHERE rtarea.areatype='2' and RTareacty.areaid='*' "
  dataTable="rtareacty"
  numberOfKey=2
  dataProg="RTareaOprCtyDataList.asp"
  dataWindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="rtareaOprsearch.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and RTareacty.areaid='" & aryparmkey(0) & "'"
     searchShow=FrGetAreaDesc(aryParmKey(0))       
  End If
  sqlList="SELECT RTAreacty.AREAID, RTAreaCty.CUTID,RTArea.AREANC,case areatype when '1' then '�~���Ұ�' when '2' then '�I�u�Ұ�' END AS AreaTypeC,  " _
           &"RTCounty.CUTNC, RTAreaCty.TDAT, RTAreaCty.EXDAT " _
           &"FROM RTAreacty INNER JOIN " _
           &"RTArea ON RTAreacty.AREAID = RTArea.AREAID INNER JOIN " _
           &"RTCounty ON RTAreaCty.CUTID = RTCounty.CUTID WHERE rtarea.areatype='2' " &searchqry
'Response.Write "SQL=" & sqllist
End Sub
%>
<!-- #include file="RTGetAreaDesc.inc" -->