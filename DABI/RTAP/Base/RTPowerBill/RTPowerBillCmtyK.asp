<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�q�O�޲z�t��"
  title="�q�O��L���Ϥ�׬d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0)&";Y;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�X���Ǹ�;none;���ϧǸ�;���;���ϦW��;����;�m��;�@�o��;"
     sqlDelete="select a.ctno, a.comtype, a.comq1, c.codenc, b.comn, d.cutnc, b.township, a.canceldat " &_
			"from 	RTPowBillCmty a " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"where a.CTNO ='' "
  dataTable="RTPowBillCmty"
  extTable=""
  numberOfKey=3
  dataProg="RTPowerBillCmtyD.asp"
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
  
  searchProg=""
  searchFirst=FALSE
  If searchQry="" then
     searchQry= " and a.ctno<>'' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If  
  
     sqlList="select a.ctno, a.comtype, a.comq1, c.codenc, b.comn, d.cutnc, b.township, a.canceldat " &_
			"from 	RTPowBillCmty a " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"where a.ctno ='"& aryparmkey(0) &"' "& searchQry
'Response.Write "sql=" & SQLLIST         
End Sub
%>
