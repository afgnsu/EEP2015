<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�~�ȲէO��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�浧�R��;���ݷ~��;�m����"
  functionOptProgram="RTSalesGroupDrop.asp;RTSalesGroupManK.asp;rtareatownshipk.asp"
  functionOptPrompt="Y;N;N"    
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="none;�s�եN�X;none;�s�����O;�s�զW��;�ժ�;�ͮĤ��;�I����"
  sqlDelete="SELECT RTSalesGroup.AREAID,RTSalesGroup.GROUPID , RTSalesGroup.CUSTYID, RTCode.CODENC, " _
         &"RTSalesGroup.GROUPNC, RTObj.CUSNC,RTSalesGroup.SDATE,RTSalesGroup.EDATE " _
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTSalesGroup INNER JOIN " _
         &"RTCode ON RTSalesGroup.CUSTYID = RTCode.CODE ON " _
         &"RTEmployee.EMPLY = RTSalesGroup.LEADER " _
         &"WHERE (RTCode.KIND = 'B2') and rtsalesgroup.groupid='*'"
  dataTable="RTSalesGroup"
  userDefineDelete=""  
  extTable=""
  numberOfKey=2
  dataProg="RTSalesGroupD.asp"
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
  colSplit=1
  keyListPageSize=20
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
  searchQry=" RTSalesGroup.AREAID='" & aryparmkey(0) & "'"  
  searchShow=FrGetAreaDesc(aryParmKey(0))  
  sqlList="SELECT RTSalesGroup.AREAID, RTSalesGroup.GROUPID , RTSalesGroup.CUSTYID, RTCode.CODENC, " _
         &"RTSalesGroup.GROUPNC, RTObj.CUSNC,RTSalesGroup.SDATE,RTSalesGroup.EDATE  " _
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTSalesGroup INNER JOIN " _
         &"RTCode ON RTSalesGroup.CUSTYID = RTCode.CODE ON " _
         &"RTEmployee.EMPLY = RTSalesGroup.LEADER " _
         &"WHERE (RTCode.KIND = 'B2') and " & searchqry
'Response.Write "SQL=" &sqllist           
End Sub
%>
<!-- #include file="RTGetAreaDesc.inc" -->