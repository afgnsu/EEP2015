<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�ȪA�޲z�t��"
  title="����CALL OUT�M�׸�ƺ��@�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�^�ХN�X;�Ȥ�d��"
  functionOptProgram="HBCALLOUTPROJECTD1K.asp;HBCALLOUTK2.ASP"
  functionOptPrompt="N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�M�ץN��;�M�צW��;�w�p�˥���;���ļ�;�w�p����_��;�w�p���樴��;��ڰ���_��;��ڰ��樴��;�M�׹w��"
  sqlDelete="SELECT SRVITEM, SRVNAME, SRVSAMPLE, SRVVARIABLE, SRVSTRDAT, SRVENDDAT ,  SRVREALSTR, SRVREALEND, SRVAMT  from HBCALLOUTPROJECT WHERE SRVITEM ='*' "
  dataTable="HBCALLOUTPROJECT"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="HBCALLOUTPROJECTD.asp"
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
  If searchQry="" Then
     searchQry=" SRVITEM <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT SRVITEM, SRVNAME, SRVSAMPLE, SRVVARIABLE, SRVSTRDAT, SRVENDDAT ,  SRVREALSTR, SRVREALEND, SRVAMT from HBCALLOUTPROJECT WHERE SRVITEM <> '*' and " &searchQry &" order by SRVITEM "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
End Sub
%>