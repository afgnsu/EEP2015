<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi-Building�޲z�t��"
  title="�Ȧ����򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="none;����N��;����W��"
  sqlDelete="SELECT RTBankbranch.HEADNO, RTBankbranch.branchno,RTBankbranch.branchnc " _
           &"FROM RTBankbranch " _
           &"WHERE (RTBankbranch.HEADNO = '*') " _
           &"order BY  RTBankbranch.HEADNO, RTBankbranch.branchno"
  dataTable="RTBankbranch"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=2
  dataProg="RTBankbranchD.asp"
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
  colSplit=3
  keyListPageSize=60
  searchProg="RTBankbranchS.asp"
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
     searchQry=" and RTBankbranch.HEADNO ='" & aryparmkey(0) & "' "
     searchShow="����"
  End If
  sqlList="SELECT RTBankbranch.HEADNO, RTBankbranch.branchno,RTBankbranch.branchnc " _
           &"FROM RTBankbranch " _
           &"WHERE (RTBankbranch.HEADNO <> '*') and RTBankbranch.HEADNO ='" & aryparmkey(0) & "' " & searchqry & " " _
           &"order BY  RTBankbranch.HEADNO, RTBankbranch.branchno"
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>