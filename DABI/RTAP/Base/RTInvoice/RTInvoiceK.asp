<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/RTGetUserEmply.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�o���޲z�t��"
  title="�o����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";Y;Y;Y;Y;Y"
  ButtonEnable=V(0) & ";"& V(1) &";"& "Y;Y;Y;Y"  
  functionOptName="�o������"
  functionOptProgram="RTInvoiceSubK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�o�����X;�o�����;�o�����Y;���q�νs;�p��;�|�O;�P���B;�|�B;�o���`�B;�C�L�妸;�@�o���"
  sqlDelete="SELECT a.INVNO, a.INVDAT, a.INVTITLE, a.UNINO, a.INVTYPE, b.codenc, a.SALESUM, "_
		   &"a.TAXSUM, a.TOTALSUM, a.BATCH, a.CANCELDAT "_
		   &"FROM RTInvoice a  left outer join RTCode b on a.TAXTYPE = b.CODE and b.KIND = 'P1' where invno ='' "
  dataTable="RTInvoice"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="RTInvoiceD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTInvoiceS.asp"

  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" batch =(select max(batch) from RTInvoice) "
     searchShow="�̪�o��"
  End If

  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  sqlList="SELECT a.INVNO, a.INVDAT, a.INVTITLE, a.UNINO, a.INVTYPE, b.codenc, a.SALESUM, "_
		 &"a.TAXSUM, a.TOTALSUM, a.BATCH, a.CANCELDAT "_
		 &"FROM RTInvoice a  left outer join RTCode b on a.TAXTYPE = b.CODE and b.KIND = 'P1' where "_
		 & searchqry &" ORDER BY 2,1 "
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()
	Dim conn
	Set conn=Server.CreateObject("ADODB.Connection")
	On Error Resume Next
	conn.Open DSN
	delSql="DELETE FROM RTInvoiceSub WHERE INVNO IN " &extDeleList(1) &" " 
	conn.Execute delSql
	conn.Close
	Set conn=Nothing
End Sub
%>