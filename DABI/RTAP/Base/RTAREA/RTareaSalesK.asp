<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�~���ҰϻP�~�ȭ����Y��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;�~�ȭ��m�W"
  sqlDelete="SELECT RtareaSales.AREAID,rtareaSales.cusid, RTObj.CUSNC " _
           &"FROM RTAreaSales INNER JOIN " _
           &"RTEmployee ON RTAreaSales.CUSID = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID and (RTareaSales.areaid='*') "
  dataTable="RTareaSales"
  userDefineDelete=""  
  extTable=""
  numberOfKey=2
  dataProg="RTareaSalesD.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=5
  keyListPageSize=100
  searchProg="self"
  searchFirst=false
  searchShow=FrGetAreaDesc(aryParmKey(0))  
  searchQry=" RTareaSales.areaid='" & aryparmkey(0) & "'"  
  sqlList="SELECT RtareaSales.AREAID,rtareaSales.cusid, RTObj.CUSNC " _
         &"FROM RTAreaSales INNER JOIN " _
         &"RTEmployee ON RTAreaSales.CUSID = RTEmployee.EMPLY INNER JOIN " _
         &"RTObj ON RTEmployee.CUSID = RTObj.CUSID  AND " &searchQry 
'Response.Write "SQL=" &sqllist           
End Sub
%>
<!-- #include file="RTGetAreaDesc.inc" -->