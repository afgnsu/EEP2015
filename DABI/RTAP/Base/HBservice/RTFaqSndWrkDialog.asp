<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
	parm=split(REQUEST("KEY"),";")
	Call SrGetEmployeeRef(Rtnvalue,1,session("userid"))
	V=split(rtnvalue,";")  	

    Dim rs,conn,S1
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    rs.Open "select code, codenc from rtcode where kind ='P9' ",conn
    s1="<option value="""" selected></option>" &vbCrLf
    Do While Not rs.Eof
       s1=s1 &"<option value=""" &rs("code") & """>" &rs("codenc") &"</option>" &vbCrLf
       rs.MoveNext
    Loop
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=big5">
		<title>�ȶD���u�槹�u�@�~</title>
		<script language="vbscript">
			Sub cmdSure_onClick
				finishtyp = document.all("search1").value
				if document.all("Checkbox2").checked then
					exportsch = "Y"
				else
					exportsch = "N"
				end if
				if len(finishtyp)=0 then
					msgbox "�п�ܧ��u����!!", vbCritical+vbOKOnly
				else
					pgm="RTFaqSndWrkF.asp?key=" & "<%=parm(0)%>" &";"& finishtyp &";"& "<%=v(0)%>" &";"& exportsch &";"
					window.open pgm 
					'window.close	
				end if
			End Sub

			Sub cmdcancel_onClick
				window.close
			End Sub
		</script>
	</head>
	<BODY style="BACKGROUND: lightblue">
		<table align="center">
			<tr><td ALIGN="RIGHT"><font face="�з���">�п�ܧ��u�����G</font></td>
				<td><select name="search1" size="1" class="dataListEntry" ID="Select1"><%=s1%></select></td>
			</tr>
			<tr><td ALIGN="RIGHT"><font face="�з���">�t�ץX�ܦ�{��G</font></td>			
				<td><input type="checkbox" READONLY ID="Checkbox2" name="Checkbox2" value="Y" bgcolor="silver"></td>
			</tr>
		</table>
		<p><center>
				<INPUT TYPE="button" VALUE="�e�X" ID="cmdSure" name="cmdSure" style="font-family: �з���; color: #FF0000;cursor:hand">
				<INPUT TYPE="button" VALUE="����" ID="cmdcancel" name="cmdcancel" style="font-family: �з���; color: #FF0000;cursor:hand">
			</center>
		</p>
		<HR>
	</BODY>
</html>
