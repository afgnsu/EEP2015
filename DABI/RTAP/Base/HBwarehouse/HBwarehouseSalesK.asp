<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�ܮw�P�~�ȭ����Y��ƺ��@"
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
  formatName="�w�O;�ܮw�W��;�ܺޭ�;�~�ȭ�;�i�_���"
  sqlDelete="SELECT HBWarehouseSales.WAREHOUSE, HBwarEhouse.WARENAME, RTObj.CUSNC, " _
           &"RTObj_1.CUSNC AS Expr1, HBWarehouseSales.ONOFF " _
           &"FROM HBWarehouseSales INNER JOIN " _
           &"HBwarEhouse ON HBWarehouseSales.WAREHOUSE = HBwarEhouse.WAREHOUSE INNER JOIN " _
           &"RTEmployee ON HBwarEhouse.MAINTAINUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"HBWarehouseSales.EMPLY = RTEmployee_1.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID " _
           &"where hbwarehouseSALES.warehouse='*' order by hbwarehouseSALES.warehouse "

  dataTable="hbwarehousesales"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="HBwarehouseSALESD.asp"
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
  colSplit=2
  keyListPageSize=40
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
     searchQry=" HBWAREHOUSEsales.WAREHOUSE <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT HBWarehouseSales.WAREHOUSE, HBwarEhouse.WARENAME, RTObj.CUSNC, " _
           &"RTObj_1.CUSNC AS Expr1, HBWarehouseSales.ONOFF " _
           &"FROM HBWarehouseSales INNER JOIN " _
           &"HBwarEhouse ON HBWarehouseSales.WAREHOUSE = HBwarEhouse.WAREHOUSE INNER JOIN " _
           &"RTEmployee ON HBwarEhouse.MAINTAINUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"HBWarehouseSales.EMPLY = RTEmployee_1.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID " _
           &"where hbwarehouseSALES.warehouse<>'*'  and " & searchqry & " order by hbwarehouseSALES.warehouse "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>