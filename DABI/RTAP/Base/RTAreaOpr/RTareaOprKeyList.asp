<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�I�u�Ұϸ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����O���Y"
  functionOptProgram="rtareaOprctyKeyList.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="�ҰϥN�X;�ҰϦW��;�Ұ����O;none;��J�H��;��J���;none;���ʤH��;���ʤ��"
  sqlDelete="SELECT RTArea.AREAID, RTArea.AREANC, " _
           &"CASE rtarea.areatype WHEN '1' THEN '�~���Ұ�' WHEN '2' THEN '�I�u�Ұ�' END AS AreaTypeC, " _
           &"RTArea.EUSR, RTObj.CUSNC, RTArea.EDAT, RTArea.UUSR, RTObj1.CUSNC, " _
           &"RTArea.UDAT " _
           &"FROM RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTObj RTObj1 RIGHT OUTER JOIN " _
           &"RTEmployee RTEmployee1 ON  " _
           &"RTObj1.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
           &"RTArea ON RTEmployee1.EMPLY = RTArea.UUSR ON " _
           &"RTEmployee.EMPLY = RTArea.EUSR " _
           &"WHERE rtarea.areatype='2' and rtarea.areaid='*' "
  dataTable="rtarea"
  numberOfKey=1
  dataProg="rtareaOprDataList.asp"
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
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  If searchQry="" Then
     searchQry=" and areaid<>'*' "
     searchShow="�I�u�ҰϡG����"
  End If  
  sqlList="SELECT RTArea.AREAID, RTArea.AREANC, " _
           &"CASE rtarea.areatype WHEN '1' THEN '�~���Ұ�' WHEN '2' THEN '�I�u�Ұ�' END AS AreaTypeC, " _
           &"RTArea.EUSR, RTObj.CUSNC, RTArea.EDAT, RTArea.UUSR, RTObj1.CUSNC, " _
           &"RTArea.UDAT " _
           &"FROM RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTObj RTObj1 RIGHT OUTER JOIN " _
           &"RTEmployee RTEmployee1 ON  " _
           &"RTObj1.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
           &"RTArea ON RTEmployee1.EMPLY = RTArea.UUSR ON " _
           &"RTEmployee.EMPLY = RTArea.EUSR " _
           &"WHERE areatype='2'" 
End Sub
%>