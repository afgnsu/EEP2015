<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�~���ҰϻP�m�������Y���@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="none;none;none;none;�����W��;�m����;�ͮĤ��;�I����;�ϰ�O"
  sqlDelete="SELECT RTAreatownship.AREAID,RTAreatownship.groupID, RTAreatownship.CUTID,RTAreatownship.township, " _
           &"RTCounty.CUTNC,RTAreatownship.township, RTAreatownship.TDAT, RTAreatownship.EXDAT,case when RTAreatownship.distancecode='1' then '������' when RTAreatownship.distancecode='2' then '�~����' else '' end  " _
           &"FROM RTAreatownship INNER JOIN " _
           &"RTArea ON RTAreatownship.AREAID = RTArea.AREAID INNER JOIN " _
           &"RTCounty ON RTAreatownship.CUTID = RTCounty.CUTID WHERE rtarea.areatype='1' and RTareatownship.areaid='*' "
  dataTable="rtareaTOWNSHIP"
  numberOfKey=4
  dataProg="RTareatownshipD.asp"
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
  colSplit=2
  keyListPageSize=40
  searchProg="self"
  searchFirst=False
  If searchQry="" Then
     searchQry=" and RTareatownship.areaid='" & aryparmkey(0) & "' and rtareatownship.groupid='" & aryparmkey(1) & "'"
     searchShow=FrGetAreatownshipDesc(aryParmKey(0),aryparmkey(1),aryparmkey(2))       
  End If
  sqlList="SELECT RTAreatownship.AREAID,RTAreatownship.groupid, RTAreatownship.CUTID,RTAreatownship.township, " _
           &"RTCounty.CUTNC,RTAreatownship.township, RTAreatownship.TDAT, RTAreatownship.EXDAT,case when RTAreatownship.distancecode='1' then '������' when RTAreatownship.distancecode='2' then '�~����' else '' end   " _
           &"FROM RTAreatownship INNER JOIN " _
           &"RTArea ON RTAreatownship.AREAID = RTArea.AREAID INNER JOIN " _
           &"RTCounty ON RTAreatownship.CUTID = RTCounty.CUTID WHERE rtarea.areatype='1' " &searchqry
End Sub
%>
<!-- #include file="RTGetAreatownshipDesc.inc" -->