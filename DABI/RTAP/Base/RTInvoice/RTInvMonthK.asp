<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�o���޲z�t��"
  title="�C��o�����X�r�y���@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=v(0)&";Y;Y;Y;Y;Y"  
  buttonEnable="Y;Y;Y;Y;Y;N"
  'functionOptName="���ݪ��Ͻu��"
  'functionOptProgram="RTPowerBillCmtyK.asp"
  'functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�~��;���;�o���r�y;�G�p�o���_�l���X;�G�p�o���������X;�T�p�o���_�l���X;�T�p�o���������X;"
  sqlDelete="SELECT	INVYEAR, INVMONTH, INVTRACK, INVNOS, INVNOE, INVNOS3, INVNOE3 "_
		   &"FROM	RTInvMonth "_
		   &"where	INVTRACK ='*' "
  dataTable="RTInvMonth"
  extTable=""
  numberOfKey=2
  dataProg="RTInvMonthD.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=25
  
  'searchProg="RTInvMonthS.asp"
  searchFirst=FALSE
  If searchQry="" then
     searchQry=" INVTRACK<>'' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If  
  sqlList="SELECT	INVYEAR, INVMONTH, INVTRACK, INVNOS, INVNOE, INVNOS3, INVNOE3 " &_
		  "FROM	RTInvMonth " &_
		  "where	" & searchQry &_
		  " order by invyear desc, invmonth desc "
'Response.Write "sql=" & SQLLIST         
End Sub
%>
