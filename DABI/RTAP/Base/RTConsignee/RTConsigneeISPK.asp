<!-- #include virtual="/WebUtilityV2/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<% dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��(Sparq*)�޲z�t��"
  title="�g�P�Ӹg�PISP��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName=""
  functionOptProgram=""
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;ISP�N�X;ISP�W��"
  sqlDelete="SELECT RTConsigneeISP.CUSID, RTConsigneeISP.ISP, RTCODE.CODENC " _
           &"FROM RTConsigneeISP INNER JOIN " _
           &"RTCODE ON RTConsigneeISP.ISP = RTCODE.CODE  " _
           &"WHERE RTCODE.KIND = 'C3' AND RTConsigneeISP.CUSID='*' " 
  dataTable="RTConsigneeCty"
  numberOfKey=2
  dataProg="RTConsigneeISPD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  debug36=false
  goodMorningImage="cbbn.jpg"
  colSplit=4
  keyListPageSize=80
  searchProg="self"
  searchShow=FrGetConsigneeDesc(aryParmKey(0))
  searchQry="rtConsigneeISP.cusid='" &aryParmKey(0) &"'"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTConsigneeISP.CUSID, RTConsigneeISP.ISP, RTCODE.CODENC " _
           &"FROM RTConsigneeISP INNER JOIN " _
           &"RTCODE ON RTConsigneeISP.ISP = RTCODE.CODE  " _
           &"WHERE RTCODE.KIND = 'C3' and " & searchQry & " " _
           &"ORDER BY RTConsigneeISP.CUSID,RTConsigneeISP.ISP "
' Response.Write "sql=" & sqlLIST & "<br>"
End Sub
%>
<!-- #include file="RTGetConsigneeDesc.inc" -->