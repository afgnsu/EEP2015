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
'path = Server.MapPath("./") & "\barcode\"
path = Server.MapPath("/WebAp/misFTP/SeednetReckon/") & "\"
filename = SaveFile("fruit",path,4096,2)
If	filename <> "*TooBig*" Then
	'���o�`����
	dim fs,tx,totalline
	set fs=Server.CreateObject("Scripting.FileSystemObject") 
	set tx=fs.OpenTextFile(path & filename,1,false)
	do while tx.AtEndOfStream<>true
		linecur = tx.readline
		if left(linecur,14) = "�p�ƪ�Seednet��ڦ���" then
			linex = split(linecur,",")
		end if
	loop 
	tx.Close
	set tx=nothing
	set fs=nothing

    Set conn=Server.CreateObject("ADODB.Connection")
	conn.Open DSN
    sql="DECLARE @sourcefile varchar(34), @sqlstr varchar(1024) " &_
    	"set @sourcefile = '" &filename& "' " &_
		"DELETE FROM RTBillSeednetReckon WHERE SOURCEFILE =@sourcefile " &_
		"SET @sqlstr ='BULK INSERT RTBillSeednetReckon FROM '+ '''"& path &"' +@sourcefile+ " &_
		"	''' WITH( " &_
		"		FIRSTROW =2, " &_
		"		LASTROW ="& cstr(linex(1)+1) &", " &_
		"		FORMATFILE =''" &path& "SeednetReckon.fmt'' " &_
		"		)' " &_
		"	EXEC(@sqlstr) " &_
		"	UPDATE RTBillSeednetReckon SET SOURCEFILE =@sourcefile WHERE SOURCEFILE ='' "

	'response.write "<br>"&sql&"<br>"
    conn.Execute sql
    
    '��smis��Ʈw    
'    sql="declare @countTemp int, @countJoin int " &_
'
'		"select @countTemp = count(*)  from	##RTLessorAVSCustBillingTemp a " &_
'
'		"select 	@countJoin = count(*) " &_
'		"from	##RTLessorAVSCustBillingTemp a " &_
'		"		inner join RTLessorAVSCustBillingBarcode b on a.cscusid = b.cscusid " &_
'		"		inner join RTLessorAVSCustBillingPrtSub c on c.noticeid = b. noticeid " &_
'		"where 	c.batch ='" & v(0) &"' " &_
'
'		"IF @countTemp = @countJoin BEGIN" &_
'		"	update RTLessorAVSCustBillingBarcode " &_
'		"	set csbarcod1 =  left(a.csbarcod, 9), csbarcod2 = substring(a.csbarcod, 10, 16), " &_
'		"		csbarcod3 = right(a.csbarcod, 15), atmcod=a.atmcod " &_
'		"	from	##RTLessorAVSCustBillingTemp a " &_
'		"			inner join RTLessorAVSCustBillingBarcode b on a.cscusid = b.cscusid " &_
'		"			inner join RTLessorAVSCustBillingPrtSub c on c.noticeid = b. noticeid " &_
'		"	where 	c.batch ='" & v(0) &"' " &_
'
'		"	update RTLessorAVSCustBillingPrt set BARCODINDAT = getdate(), BARCODINUSR ='" &logonid(0)& "' where batch ='" & v(0) &"' " &_
'		"END "
'    conn.Execute(sql)

    set conn = nothing
    Response.Write "<br><br>""" & filename & """�����ɤW�ǧ���..."
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
