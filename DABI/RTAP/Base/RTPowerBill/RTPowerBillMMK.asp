<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�q�O�޲z�t��"
  title="�C���q�O���@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0)&";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  'functionOptName="���Ϩ�L���"
  'functionOptProgram="RTPowerBillCmtyK.asp"
  'functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�q�O�Ǹ�;none;���;���ϦW��;�_��<br>�~��;�I��<br>�~��;�p��覡;����<BR>�u��;����<BR>���;���I<br>�覡;����<br>���B;�e��<BR>�׼�;����<br>�׼�;���u<br>�渹;�䲼<br>�H�X��;����<br>�^����;�O�_�V<br>Sonet�д�;����;�m��;�@�o��;"
  sqlDelete="select x.billno, x.ctno, c.codenc, b.comn, x.strym, x.endym, " &_
			"g.codenc, x.linenum, x.custnum, f.codenc, x.pay, x.ratiobefore, x.ratio, " &_
			"x.workno, x.checkoutdat, receiptdat, " &_
			"replace(sonetreq,'N',''), d.cutnc, b.township, x.canceldat " &_
			"from	RTPowBillMM x " &_
			"inner join 	RTPowBillH a on x.ctno = a.ctno " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"left outer join RTCode f on f.code = x.paytype and f.kind ='F5' " &_
			"left outer join RTCode g on g.code = x.counttype and g.kind ='R4' " &_
			"where x.billno ='' "
  dataTable="RTPowBillMM"
  extTable=""
  numberOfKey=1
  dataProg="RTPowerBillMMD.asp"
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
  
  searchProg="RTPowerBillMMS.asp"
  searchFirst=FALSE
  If searchQry="" then
     'searchQry=" and x.billno<>'' "
     searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If  

  sqlList="select x.billno, x.ctno, c.codenc, b.comn, x.strym, x.endym, " &_
			"g.codenc, x.linenum, x.custnum, f.codenc, x.pay, x.ratiobefore, x.ratio, " &_
			"x.workno, x.checkoutdat, receiptdat, " &_
			"replace(sonetreq,'N',''), d.cutnc, b.township, x.canceldat " &_
			"from	RTPowBillMM x " &_
			"inner join 	RTPowBillH a on x.ctno = a.ctno " &_
			"left outer join RTCmtyAll b on a.comtype = b.comtype and a.comq1 = b.comq1 " &_
			"left outer join RTCode c on c.code = a.comtype and c.kind ='P5' " &_
			"left outer join RTCounty d on d.cutid = b.cutid " &_
			"left outer join RTCode f on f.code = x.paytype and f.kind ='F5' " &_
			"left outer join RTCode g on g.code = x.counttype and g.kind ='R4' " &_
  			"where x.billno<>'' " &searchQry &_
			" order by c.codenc, b.comn "
'Response.Write "sql=" & SQLLIST         
End Sub
%>
