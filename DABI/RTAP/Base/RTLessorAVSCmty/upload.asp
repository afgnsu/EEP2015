<%@ LANGUAGE = VBScript %>

<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
	logonid=Request.ServerVariables("LOGON_USER")
	Call SrGetEmployeeRef(Rtnvalue,1,logonid)
	logonid=split(rtnvalue,";")  

    parm=request("key")
    v=split(parm,";")
%>

<!-- #include virtual="/Webap/include/uploadx.asp" -->
<!-- #include virtual="/Webap/include/database.inc" -->
<%
'Response.Write "<br>Name=""" & GetFormVal("name") & """"
'Response.Write "<br>Sex=""" & GetFormVal("sex") & """"
'Response.Write "<br>province=""" & GetFormVal("province") & """"
'Response.Write "<br>city=""" & GetFormVal("city") & """"
'Response.Write "<br>lover=""" & GetFormVal("lover") & """"
dim filename
path = Server.MapPath("./") & "\barcode\"
filename = SaveFile("fruit",path,4096,0)
If	filename <> "*TooBig*" Then
    Set conn=Server.CreateObject("ADODB.Connection")
	conn.Open DSN
	'�}�Ȧstable
	sql="if exists (select * from [sysobjects] where id = object_id(N'[##RTLessorAVSCustBillingTemp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) " &_
		"drop table [##RTLessorAVSCustBillingTemp]"
    conn.Execute(sql)
	sql="CREATE TABLE [##RTLessorAVSCustBillingTemp] ( " &_
		"	[CSCUSID] [varchar] (15) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL , " &_
		"	[CSBARCOD] [varchar] (40) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL , " &_
		"	[ATMCOD] [varchar] (16) COLLATE Chinese_Taiwan_Stroke_CI_AS NOT NULL )"
    conn.Execute(sql)

    '�פJ��r�ɦܼȦstable
    sql= "BULK INSERT ##RTLessorAVSCustBillingTemp FROM '"& path & filename &"' "&_
      	 "WITH (FIRSTROW =1, FORMATFILE ='"& Server.MapPath("./") & "\upload.fmt') "

    conn.Execute(sql)

    
    '��smis��Ʈw    
    sql="declare @countTemp int, @countJoin int " &_

		"select @countTemp = count(*)  from	##RTLessorAVSCustBillingTemp a " &_

		"select 	@countJoin = count(*) " &_
		"from	##RTLessorAVSCustBillingTemp a " &_
		"		inner join RTLessorAVSCustBillingBarcode b on a.cscusid = b.cscusid " &_
		"		inner join RTLessorAVSCustBillingPrtSub c on c.noticeid = b. noticeid " &_
		"where 	c.batch ='" & v(0) &"' " &_

		"IF @countTemp = @countJoin BEGIN" &_
		"	update RTLessorAVSCustBillingBarcode " &_
		"	set csbarcod1 =  left(a.csbarcod, 9), csbarcod2 = substring(a.csbarcod, 10, 16), " &_
		"		csbarcod3 = right(a.csbarcod, 15), atmcod=a.atmcod " &_
		"	from	##RTLessorAVSCustBillingTemp a " &_
		"			inner join RTLessorAVSCustBillingBarcode b on a.cscusid = b.cscusid " &_
		"			inner join RTLessorAVSCustBillingPrtSub c on c.noticeid = b. noticeid " &_
		"	where 	c.batch ='" & v(0) &"' " &_
				
		"	update RTLessorAVSCustBillingPrt set BARCODINDAT = getdate(), BARCODINUSR ='" &logonid(0)& "' where batch ='" & v(0) &"' " &_
		"END "
    conn.Execute(sql)

    set conn = nothing
    Response.Write "<br><br>""" & filename & """���X�ɤW�ǧ���..."
Else
	Response.Write "<br><br>���j�p�W�X 4 MB������"
End IF

'filename = SaveFile("fruit2",path,1024,0)
'If filename <> "*TooBig*" Then
'Response.Write "<br><br>""" & filename & """�w�g�W��"
'Else
'Response.Write "<br><br>���W�X����Ӥj"
'End IF
%>
 

<html>
	<head>
		<title>�W�ǵ��G</title>
		
<script language=vbscript>
Sub cmdcancel_onClick
  window.close
End Sub
</script>		

	</head>
	<BODY style="BACKGROUND: lightblue">
		<p><center>
			  <INPUT TYPE="button" VALUE="����" ID="cmdcancel" NAME="cmdcancel">
		</center><HR>			  
		</p>
	</body>
</html>
