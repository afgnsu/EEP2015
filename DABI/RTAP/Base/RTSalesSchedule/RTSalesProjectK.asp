<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�~�Ⱥ޲z�t��"
  title="�~�Ⱥ޲z�M�׳]�w�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�^�ХN�X"
  functionOptProgram="RTSalesProjectD1K.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�M�ץN��;�M�צW��;�M�פ��e;�����X"
  sqlDelete="SELECT SCITEM, SCNAME, SCDESC, ENDCODE  from HBSalesManageProject WHERE SCITEM ='*' "
  dataTable="HBSalesManageProject"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="RTSalesProjectD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=750,height=250,scrollbars=NO"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
  searchProg="RTSalesProjectS.ASP"
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
     searchQry=" SCITEM <>'' "
     searchShow="����"
  End If
  sqlList="SELECT SCITEM, SCNAME, SCDESC, ENDCODE from HBSalesManageProject WHERE SCITEM <> '' and " &searchQry &" order by SCITEM "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>