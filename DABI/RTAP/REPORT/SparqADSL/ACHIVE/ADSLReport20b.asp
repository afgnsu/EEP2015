<%@ LANGUAGE="VBSCRIPT" %>
<% option Explicit %>

<%
    Dim rs,conn, sqlstr, v,fso, ftpPathFile, ftpFile, fsoText, iCount, ftpFileLink
    
    v=split(request("parm"),";")  

    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
    Set rs = conn.Execute("usp_RTHinetCheckRPT '" & v(0) &"', '"& v(1) &"', '" & v(2) &"', 'A', '" & v(3) & "'")
    
    ftpFile = "hb" & Replace(v(0),"/", "") & ".dat"
    ftpPathFile = Server.MapPath("/SparqFtp") & "\" & ftpFile
    ftpfilelink = "http://w3c.intra.cbbn.com.tw/WEBroot/SparqFtp/" & ftpFile

    Set fso = CreateObject("Scripting.FileSystemObject")    
    Set fsoText = fso.CreateTextFile(ftpPathFile, True)
    iCount = 0
    While not rs.EOF
		iCount = iCount + 1
        fsoText.WriteLine(rs("FTPLINE"))
		rs.MoveNext
    Wend
    fsoText.Close
    
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
    
    'FTP �W�Ǥ� Script
    Set fsoText = fso.CreateTextFile("d:\CBNWEB\WEBroot\SparqFtp\ftp.ini", True)
    fsoText.WriteLine("bu90017")
    fsoText.WriteLine("bu90017")
    fsoText.WriteLine("lcd d:\CBNWEB\WEBroot\SparqFtp")
    'fsoText.WriteLine("cd share")
    fsoText.WriteLine("put " & ftpFile)
    'fsoText.WriteLine("bye")
    fsoText.Close
%>
<HTML>
<HEAD>
	<title>�t�դ�r��</title>
    
	<SCRIPT language=VBScript>    
	    sub window_onload
	        window.opener.close
	    end sub
	    
		Sub btnFtp_onClick
		    set wHandle = window.open ("/SparqFtp/ftp.shtml", "win1")
		end sub
   
		Sub btnView_onClick
		    set wHandle = window.open ("/SparqFtp/" & document.all("hdFtpFile").value, "win1")
		end sub

		Sub btnExit_onClick
		    window.close
		end sub
</SCRIPT>

</HEAD>

<BODY bgcolor = "lightblue"><br>
<P><center><font color="red">���W�Ǥ���r�� (�@ <b><%=iCount%></b> �����)�G</font><br><br>
<!--   <INPUT name=tbPathFile value="<%=ftpFile%>" size="20" readonly><br><br><br>   -->
   <a href="<%=ftpFileLink%>"><%=ftpFile%></a><br><br><br>
   <INPUT name=btnFtp  type=button value="FTP�W��" disabled>
   <INPUT name=btnView type=button value="�˵���r��">
   <INPUT name=btnExit type=button value="���}">
   <input type=hidden name="hdFtpFile" value="<%=ftpFile%>"> </center>
</P><hr>


</BODY>
</HTML>
