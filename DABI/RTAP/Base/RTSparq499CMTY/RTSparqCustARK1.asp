<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t�պ޲z�t��"
  title="�t�եΤ��������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �R  �b ;�R�b����;�b�ک���"
  functionOptProgram="RTSparqCustARClear.asp;RTSparqCustARClearK.asp;RTSparqCustARDTLK.asp"
  functionOptPrompt="N;N;N"
  functionoptopen="2;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�b�ڽs��;��קO;����;�Ȥ�;AR/AP;����;���R<br>���B;�w�R<br>���B;���R<br>���B;�R�b��;�R�b��;�R�߶��@;�R�߶��G;none;���ͤ�;�@�o��;�@�o��;�@�o��]"
  sqlDelete="SELECT  RTSparq499CustAR.CUSID, RTSparq499CustAR.BATCHNO, RTSparq499CmtyH.COMN,RTSparq499Cust.CUSNC," _
                &" RTCode.CODENC, RTSparq499CustAR.PERIOD,RTSparq499CustAR.AMT,RTSparq499CustAR.REALAMT," _
                &"RTSparq499CustAR.AMT - RTSparq499CustAR.REALAMT AS DIFFAMT, RTSparq499CustAR.MDAT, RTObj_1.CUSNC AS MUSR, " _
                &"RTSparq499CustAR.COD1, RTSparq499CustAR.COD2,RTSparq499CustAR.COD3, RTSparq499CustAR.CDAT, " _
                &"RTSparq499CustAR.CANCELDAT, RTObj_2.CUSNC AS CANCELUSR, " _
                &", RTSparq499CustAR.CANCELMEMO " _
                &"FROM    RTSparq499CmtyH RIGHT OUTER JOIN RTSparq499Cust ON RTSparq499CmtyH.COMQ1 = RTSparq499Cust.COMQ1 " _
                &"RIGHT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = " _
                &"RTObj_2.CUSID RIGHT OUTER JOIN RTSparq499CustAR ON RTEmployee_2.EMPLY = RTSparq499CustAR.CANCELUSR " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                &"RTObj_1.CUSID ON RTSparq499CustAR.MUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTCode ON RTSparq499CustAR.ARTYPE = RTCode.CODE AND RTCode.KIND = 'N2' ON RTSparq499Cust.CUSID = " _
                &"RTSparq499CustAR.CUSID " _
                &"WHERE RTSparq499CustAR.cusid='' "
  dataTable="RTSparq499CUSTLOG"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=350,height=250,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="500"
  diaHeight="500"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTSparqCustARS1.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----

  searchFirst=FALSE
  If searchQry="" Then
     searchQry ="  a.amt <> a.realamt and a.canceldat is null " 
     searchQry2 =searchQry
     searchShow="�������R�P�b��"
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  'Domain=Mid(Emply,1,1)
	sqlList="select	a.cusid, a.batchno, 'Sparq399', c.comn, i.cusnc, d.codenc, a.period, " &_
			"a.amt, a.realamt, a.amt-a.realamt, a.mdat, f.cusnc, " &_
			"a.cod1, a.cod2, a.cod3, a.cdat, a.canceldat, h.cusnc, a.cancelmemo " &_
			"from 	RTSparqAdslCustAR a " &_
			"inner join RTSparqAdslCust b on a.cusid = b.cusid " &_
			"inner join RTSparqAdslCmty c on c.cutyid = b.comq1 " &_
			"left outer join RTCode d on a.artype = d.CODE AND d.KIND = 'N2' " &_
			"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.musr " &_
			"left outer join RTEmployee g inner join RTObj h on h.cusid = g.cusid on g.emply = a.cancelusr " &_
			"left outer join RTObj i on i.cusid = b.cusid " &_
			"where " & searchQry &_
			" union " &_
			"select	a.cusid, a.batchno, 'Sparq499', c.comn, b.cusnc, d.codenc, a.period, " &_
			"a.amt, a.realamt, a.amt-a.realamt, a.mdat, f.cusnc, " &_
			"a.cod1, a.cod2, a.cod3, a.cdat, a.canceldat, h.cusnc, a.cancelmemo " &_
			"from 	RTSparq499CustAR a " &_
			"inner join RTSparq499Cust b on a.cusid = b.cusid " &_
			"inner join RTSparq499CmtyH c on c.comq1 = b.comq1 " &_
			"left outer join RTCode d on a.artype = d.CODE AND d.KIND = 'N2' " &_
			"left outer join RTEmployee e inner join RTObj f on f.cusid = e.cusid on e.emply = a.musr " &_
			"left outer join RTEmployee g inner join RTObj h on h.cusid = g.cusid on g.emply = a.cancelusr " &_
			"where " & searchQry2 &_ 
			" order by  a.CDAT " 

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>