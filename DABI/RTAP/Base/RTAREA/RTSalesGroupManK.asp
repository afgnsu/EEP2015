<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�~�ȲէO�P�~�ȭ����Y��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & "N;Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�浧�R��"
  functionOptProgram="RTSalesGroupManDrop.asp"
  functionOptPrompt="Y"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="none;none;�u��;none;�m�W;����;�ͮĤ��;�I����"
  sqlDelete="SELECT RTSalesGroupRef.AREAID,RTSalesGroupref.GROUPID , RTSalesGroupref.EMPLY,RTSalesGroupref.version, RTobj.cusnc, " _
           &"RTSalesGroupref.version,RTSalesGroupREF.SDATE,RTSalesGroupREF.EDATE " _
           &"FROM RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
           &"RTSalesGroupREF ON RTEmployee.EMPLY = RTSalesGroupREF.EMPLY " _
           &"WHERE RTSalesGroupref.AREAID='*'"
  dataTable="RTSalesGroupREF"
  userDefineDelete=""  
  extTable=""
  numberOfKey=4
  dataProg="RTSalesGroupManD.asp"
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
  searchshow1=""
  searchshow2=""
  searchQry=" RTSalesGroupRef.AREAID='" & aryparmkey(0) & "' AND RTSalesGroupRef.GROUPID='" & aryparmkey(1) & "'"
  searchShow1=FrGetAreaDesc(aryParmKey(0))  
  searchShow2=FrGetSalesGroupDesc(aryParmKey(0),aryparmkey(1))    
  searchshow=searchshow1 & searchshow2
  searchFirst=false
  sqlList="SELECT RTSalesGroupRef.AREAID,RTSalesGroupref.GROUPID , RTSalesGroupref.EMPLY,RTSalesGroupref.version, RTobj.cusnc, " _
         &"RTSalesGroupref.version,RTSalesGroupREF.SDATE,RTSalesGroupREF.EDATE " _
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTSalesGroupREF ON RTEmployee.EMPLY = RTSalesGroupREF.EMPLY " _
         &"WHERE " & searchqry 
'Response.Write "SQL=" &sqllist           
End Sub

%>
<!-- #include file="RTGetAreaDesc.inc" -->
<!-- #include file="RTSalesGroupDesc.inc" -->