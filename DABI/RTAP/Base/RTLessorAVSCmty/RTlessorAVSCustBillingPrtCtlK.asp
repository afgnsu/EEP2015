<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�C������b��C�L�d��<BR><font color=white>�t�ӽs���GBPIS0334<BR>�t�ӱK�X�Gyyvu7knt</font><BR><font color=red size=4><B>�����r�ɽЩ�U�� 1:00 �e�W��</B></font>"
  buttonName=" �s  �W ; �R  �� ; ��  �� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="0.���������;0.���������(�L��);1.�ץX�����r��;2.�W�������r��;3.�פJ���X��;4.�C�L�����;5.�C�L�H��;�Τ����"
  functionOptProgram="RTLessorAVSCustBillingPrtCtlTRNK.asp;RTLessorAVSCustBillingPrtCtlTRNK_duedate.asp;RTLessorAVSCustBillSeednetBatch.asp;https://service.seed.net.tw/proxy_portal.htm;RTLessorAVSCustBillBarcode.asp;/REPORT/Common/RTLessorAVSCustBillingPrtCtlP.asp;/Report/AVSCity/RTLessorAVSCustBillingPrtEnvP.asp;RTLessorAVSCustBillingPrtCtlk2.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N"
  functionoptopen="1;1;1;1;1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  'formatName="�q���ѧ妸;�����B(�_);�����B(��);�����A(�_);�����A(��);���ͤ�;���ͭ�;�̫�C�L��;�C�L��"
  formatName="�q����妸;none;none;�����(�_);�����(��);���ͤ�;���ͭ�;�ץX��;�ץX��;���X�פJ��;���X�פJ��;�̫�C�L��;�C�L��"
  sqlDelete="SELECT BATCH, DUEDATSB, DUEDATEB, DUEDATSA, DUEDATEA, CDAT, c.CUSNC, " &_
			"BARCODOUTDAT, g.cusnc, BARCODINDAT, i.cusnc, PRTDAT, e.CUSNC " &_
			"FROM RTLessorAVSCustBillingPrt a " &_
			"left outer join RTEmployee b inner join RTObj c on c.cusid =b.cusid on b.emply = a.CUSR " &_
			"left outer join RTEmployee d inner join RTObj e on d.cusid =e.cusid on d.emply = a.PRTUSR " &_
			"left outer join RTEmployee f inner join RTObj g on f.cusid =g.cusid on f.emply = a.BARCODOUTUSR " &_
			"left outer join RTEmployee h inner join RTObj i on h.cusid =i.cusid on h.emply = a.BARCODINUSR " &_
			"WHERE BATCH=0 " &_
  dataTable="RTLessorAVSCustBillingPrt"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=300,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=50
  searchProg="self"
  If searchQry="" Then
     searchFirst=FALSE
     searchQry=" BATCH <> 0 "
     searchShow="����"
  Else
     searchFirst=False
  End If


  '----------------------------------------------------------------------------------------------
  'set connXX=server.CreateObject("ADODB.connection")
  'set rsXX=server.CreateObject("ADODB.recordset")
  'dsnxx="DSN=XXLIB"
  'sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  'connxx.Open dsnxx
  'rsxx.Open sqlxx,connxx
  'if not rsxx.EOF then
  '   usergroup=rsxx("group")
  'else
  '   usergroup=""
  'end if
  'rsxx.Close
  'connxx.Close
  'set rsxx=nothing
  'set connxx=nothing
  '----------------------------------------------------------------------------------------------
  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  
  sqlList="SELECT BATCH, DUEDATSB, DUEDATEB, DUEDATSA, DUEDATEA, CDAT, c.CUSNC, " &_
			"BARCODOUTDAT, g.cusnc, BARCODINDAT, i.cusnc, PRTDAT, e.CUSNC " &_
			"FROM RTLessorAVSCustBillingPrt a " &_
			"left outer join RTEmployee b inner join RTObj c on c.cusid =b.cusid on b.emply = a.CUSR " &_
			"left outer join RTEmployee d inner join RTObj e on d.cusid =e.cusid on d.emply = a.PRTUSR " &_
			"left outer join RTEmployee f inner join RTObj g on f.cusid =g.cusid on f.emply = a.BARCODOUTUSR " &_
			"left outer join RTEmployee h inner join RTObj i on h.cusid =i.cusid on h.emply = a.BARCODINUSR " &_
			"WHERE " & SEARCHQRY &_
			"ORDER BY BATCH DESC "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>