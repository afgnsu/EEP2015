<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Dim Debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�Ҩ餽�q����򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName="��~��"
  functionOptProgram="RTobjStockBranchBussK.asp"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;����W��;none;��J�H��;��J���;none;���ʤH��;���ʤ��"
  sqlDelete="SELECT RTBranch.CUSID, RTBranch.BRANCH, RTBranch.EUSR, RTObj.CUSNC, " _
           &"RTBranch.EDAT, RTBranch.UUSR, RTObj1.CUSNC, RTBranch.UDAT " _
           &"FROM RTObj RTObj1 RIGHT OUTER JOIN " _
           &"RTEmployee RTEmployee1 ON " _
           &"RTObj1.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTBranch ON RTEmployee.EMPLY = RTBranch.EUSR ON " _
           &"RTEmployee1.EMPLY = RTBranch.UUSR " _
           &"WHERE (cusid='*') "
  dataTable="RTBranch"
  numberOfKey=2
  dataProg="RTobjStockBranchD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
  searchProg="self"
  searchShow=FrGetStockDesc(aryParmKey(0))
  searchQry=" RTBranch.cusid='" &aryParmKey(0) &"' "
  sqlList="SELECT RTBranch.CUSID, RTBranch.BRANCH, RTBranch.EUSR, RTObj.CUSNC, " _
           &"RTBranch.EDAT, RTBranch.UUSR, RTObj1.CUSNC, RTBranch.UDAT " _
           &"FROM RTObj RTObj1 RIGHT OUTER JOIN " _
           &"RTEmployee RTEmployee1 ON " _
           &"RTObj1.CUSID = RTEmployee1.CUSID RIGHT OUTER JOIN " _
           &"RTObj RIGHT OUTER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTBranch ON RTEmployee.EMPLY = RTBranch.EUSR ON " _
           &"RTEmployee1.EMPLY = RTBranch.UUSR " _
           &"WHERE " & searchQry & " " _
           &"ORDER BY RTBranch.cusid "
      
End Sub
%>
<!-- #include file="RTGetStockDesc.inc" -->