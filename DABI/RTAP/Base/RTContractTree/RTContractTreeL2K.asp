<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�X���޲z�t��"
  title="�X���ݩʾ�(�p���O)��ƺ��@"
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
  formatName="none;none;���O�N��;���廡��"
  sqlDelete="SELECT propertyid, category1,category2,category2nm from HBcontractTreeL2 WHERE propertyid ='*' "
  dataTable="RTContractTreeL1"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=3
  dataProg="RTContractTreeL2D.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=800,height=220,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=4
  keyListPageSize=80
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
     searchQry=" propertyid ='" & aryparmkey(0) & "' AND CATEGORY1='" & ARYPARMKEY(1) & "' "
     searchShow="����"
  End If
  sqlList="SELECT propertyid, category1,category2,category2nm from HBcontractTreeL2 WHERE propertyid ='" & aryparmkey(0) & "' AND CATEGORY1='" & ARYPARMKEY(1) & "' and " &searchQry &" order by propertyid,CATEGORY1 "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>