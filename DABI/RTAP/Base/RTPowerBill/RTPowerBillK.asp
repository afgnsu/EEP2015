<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�q�O�޲z�t��"
  title="�q�O�򥻸�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0)&";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���Ϩ�L���"
  functionOptProgram="RTPowerBillCmtyK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�X���Ǹ�;���;���ϦW��;����;�m��;�p��覡;���q�g��;�ɧU�覡;�X���ͮĤ�;�X���פ��;�p���H;�p���q��;�O�_�VSonet�д�;�@�o��;"
  sqlDelete="select 	a.ctno, c.codenc, b.comn, d.cutnc, b.township, g.codenc, e.codenc, f.codenc, strdat, enddat, " &_
  			"contact, contacttel, replace(sonetreq,'N',''), canceldat " &_
			"from	RTPowBillH a " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"left outer join RTCode e on e.code = a.paycycle and e.kind ='K5' " &_
			"left outer join RTCode f on f.code = a.paytype and f.kind ='F5' " &_
			"left outer join RTCode g on g.code = a.counttype and g.kind ='R4' " &_
			"where	a.ctno ='' "
  dataTable="RTPowBillH"
  extTable=""
  numberOfKey=1
  dataProg="RTPowerBillD.asp"
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
  keyListPageSize=30
  
  searchProg="RTPowerBillS.asp"
  searchFirst=FALSE
  If searchQry="" then
     searchQry=" and a.ctno<>'' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If  

  sqlList=	"select 	a.ctno, c.codenc, b.comn, d.cutnc, b.township, g.codenc, e.codenc, f.codenc, strdat, enddat, " &_
  			"contact, contacttel, replace(sonetreq,'N',''), canceldat " &_
			"from	RTPowBillH a " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"left outer join RTCode e on e.code = a.paycycle and e.kind ='K5' " &_
			"left outer join RTCode f on f.code = a.paytype and f.kind ='F5' " &_
			"left outer join RTCode g on g.code = a.counttype and g.kind ='R4' " &_
			"where a.ctno<>'' " &searchQry &_
			" order by 4,5,3 "
'Response.Write "sql=" & SQLLIST         
End Sub
%>
