<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�o���޲z�t��"
  title="�o�����Ӻ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";Y;Y;Y;Y;Y"  
  ButtonEnable=V(0) & ";"& V(1) &";"& "Y;Y;Y;Y"  
  'functionOptName="�o������"
  'functionOptProgram="RTInvoiceSubK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�o�����X;����;���~�W��;�ƶq;���;�P���B;�|�B;�X�p"
  sqlDelete="SELECT INVNO, ENTRY, PRODNC, QTY, UNITAMT, SALEAMT, TAXAMT, SALEAMT+TAXAMT as Num " &_
		    "FROM RTInvoiceSub where invno ='' "
  dataTable="RTInvoiceSub"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTInvoiceSubD.asp"
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
  keyListPageSize=25
  'searchProg=""

  searchFirst=FALSE
  'If searchQry="" Then
     searchQry=" INVNO='" & aryparmkey(0) &"' "
  '   searchShow="�̪�o��"
  'End If

  'userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  'Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  sqlList="SELECT INVNO, ENTRY, PRODNC, QTY, UNITAMT, SALEAMT, TAXAMT, SALEAMT+TAXAMT as Num " &_
          "FROM RTInvoiceSub WHERE " & searchQry &" ORDER BY ENTRY "
  'Response.Write "SQL=" & SQLlist
End Sub

Sub SrRunUserDefineDelete()
    Dim conn, rs, strsql, sale, tax, total
    Set conn=Server.CreateObject("ADODB.Connection")
    SET RS=Server.CreateObject("ADODB.RECORDSET")  
    Conn.Open DSN
    
	strsql="select sum(saleamt) as sale, sum(taxamt) as tax, sum(saleamt) + sum(taxamt) as total " &_
		   "from RTInvoiceSub where invno IN " &extDeleList(1) &" "
    rs.Open strsql,conn
    If not rs.Eof Then	  
		sale = rs("sale")
		tax = rs("tax")
		total = rs("total")
	else
		sale = 0
		tax = 0
		total = 0
	end if
	rs.close
	
	strsql="update RTInvoice set salesum="& sale &", taxsum ="& tax &", totalsum="& total &_
		   ",amtc = '"& right("0000000" & cstr(total), 8) &"' where invno IN " &extDeleList(1) &" "
	conn.Execute strsql
	
	conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
%>