<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="��H���O��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  'functionOptName=""
  'functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="���O�N�X;���O�W��"
  sqlDelete="SELECT CUSTYID,CUSTN FROM rtobjKind WHERE custyid='*'"
  dataTable="rtobjKind"
  numberOfKey=1
  dataProg="rtobjKindDataList.asp"
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
  colSplit=3
  keyListPageSize=60
  searchProg="self"
  If searchqry="" Then
     searchqry=" custyid<>'*'"
     searchshow="��H���O�G����" 
  End If
  sqlList="SELECT CUSTYID,CUSTN FROM rtobjKind WHERE " &searchqry
End Sub
%>