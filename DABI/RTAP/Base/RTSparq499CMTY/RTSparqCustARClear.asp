<%  Dim aryParmKey,parmKey
    parmKey=Request("Key")
    aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt, search12pt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")

'----------�D�u�Ǹ�
    S3=""
	if aryParmKey(2) ="Sparq399" then
	    sql = "SELECT * FROM RTSparqAdslCustAR WHERE CUSID='" & aryParmKey(0) & "' AND BATCHNO='" & aryParmKey(1) & "' "
	elseif aryParmKey(2) ="Sparq499" then
		sql = "SELECT * FROM RTSparq499CustAR WHERE CUSID='" & aryParmKey(0) & "' AND BATCHNO='" & aryParmKey(1) & "' "
	end if
	rs.Open sql, conn
    IF RS.EOF THEN
       TEMPPERIOD=0
       TEMPCOD1=""
       TEMPCOD2=""
       TEMPCOD3=""
       TEMPAMT=0
       TEMPCANCELDAT=""
       temprealamt=0
       diffamt=0
    ELSE
       TEMPPERIOD=RS("PERIOD")
       TEMPCOD1=RS("COD1")
       TEMPCOD2=RS("COD2")
       TEMPCOD3=RS("COD3")
       TEMPAMT=RS("AMT")
       TEMPCANCELDAT=RS("CANCELDAT")
       TEMPrealAMT=RS("realAMT")
       '��w�@�o�ɡA���i�R�b
       IF LEN(TRIM(TEMPCANCELDAT)) > 0 THEN
          diffamt = 0
       ELSE
          diffamt=tempamt-temprealamt
       END IF
    END IF
    RS.CLOSE
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4ebt/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">

Sub btn_onClick()
  dim aryStr,s,t,r
  s2=document.all("search2").value
  s3=document.all("search3").value
  s4=document.all("search4").value
  s10=document.all("search10").value
  s11=document.all("search11").value
  s12=document.all("search12").value
  s13=document.all("search13").value
  s14=document.all("search14").value
  IF len(trim(S3))=0 then
      msgbox "�Τ�N�����i�ťաC"    
  ELSEIF len(trim(S4))=0 then
      msgbox "�����b�ڽs�����i�ťաC"      
  ELSEIF len(trim(S11))=0 OR S11 < 1 then
      msgbox "��R���B���i�p��ε���s�C"         
  ELSEIF cint(S11) > cint(S13) then
      msgbox "��R���B���i�j��i�R�P���B�C"                       
  ELSE
   '  StrFeature="top=0,left=0,scrollbars=yes,status=yes," _
   '              &"location=no,menubar=no,width=5px,height=5px" 
	prog="RTSparqCustArClearExe.asp" & "?key=" & s3 & ";" & s4 & ";" & s11 & ";" & S2 & ";"
     Set diagWindow=Window.open(prog,"",StrFeature)
     window.close
  end if
End Sub

Sub btn1_onClick()  
  window.close  
End Sub

</script>
</head>
<body><CENTER>
<table width="80%">
  <tr class=dataListTitle align=center>�t�եΤ��������I�b�ڨR�b</td><tr>
</table>
<table width="80%" border=1 cellPadding=0 cellSpacing=0>

<tr><td class=dataListHead >��קO</td>
    <td  bgcolor="silver">
      <input type="text" size="15" name="search2" class=dataListDATA READONLY VALUE=<%=aryParmKey(2)%>> 
    </td></tr>    
<tr><td class=dataListHead >�Τ�Ǹ�</td>
    <td  bgcolor="silver">
      <input type="text" size="15" name="search3" class=dataListDATA READONLY VALUE=<%=aryParmKey(0)%>> 
    </td></tr>    
<tr><td class=dataListHead >�����b�ڽs��</td>
    <td  bgcolor="silver">
      <input type="text" size="15" name="search4" class=dataListDATA READONLY VALUE=<%=aryParmKey(1)%>> 
    </td></tr>        
<tr><td class=dataListHead >���Ӷ�����</td>
    <td  bgcolor="silver">
      <input type="text" size="5" name="search6" class=dataListDATA READONLY VALUE=<%=TEMPPERIOD%>> 
    </td></tr>       
<tr><td class=dataListHead >�R�߭n���@</td>
    <td  bgcolor="silver">
      <input type="text" size="30" name="search7" class=dataListDATA READONLY VALUE=<%=TEMPCOD1%>> 
    </td></tr>       
<tr><td class=dataListHead >�R�߭n���G</td>
    <td  bgcolor="silver">
      <input type="text" size="30" name="search8" class=dataListDATA READONLY VALUE=<%=TEMPCOD2%>> 
    </td></tr>       
<tr><td class=dataListHead >�R�߭n���T</td>
    <td  bgcolor="silver">
      <input type="text" size="30" name="search9" class=dataListDATA READONLY VALUE=<%=TEMPCOD3%>> 
    </td></tr>           
<tr><td class=dataListHead >�@�o��</td>
    <td  bgcolor="silver">
      <input type="text" size="10" name="search14" class=dataListDATA READONLY VALUE=<%=TEMPCANCELDAT%>> 
    </td></tr>                      
<tr><td class=dataListHead >����(�I)���B</td>
    <td  bgcolor="silver">
      <input type="text" size="10" name="search10" class=dataListDATA READONLY VALUE=<%=TEMPAMT%>> 
    </td></tr>          
<tr><td class=dataListHead >�w�R�P���B</td>
    <td  bgcolor="silver">
      <input type="text" size="10" name="search12" class=dataListDATA READONLY VALUE=<%=TEMPrealAMT%>> 
    </td></tr>         
<tr><td class=dataListHead >�i�R�P���B</td>
    <td  bgcolor="silver">
      <input type="text" size="10" name="search13" class=dataListDATA READONLY VALUE=<%=diffAMT%>> 
      <%IF LEN(TRIM(TEMPCANCELDAT)) > 0 THEN %>
        <FONT SIZE=2 COLOR=RED>��Ƥw�@�o�A�i�R�P���B�k�s�C</FONT>
      <%ELSE%> 
      <%END IF%>
    </td></tr>                 
<tr><td class=dataListHead >��ڨR�b���B</td>
    <td   bgcolor="silver">
     <%IF LEN(TRIM(TEMPCANCELDAT)) > 0 THEN 
          fieldpa=" class=""dataListData"" readonly "
       ELSE
          fieldpa=" class=""dataListentry"" "
       END IF
     %>
      <input type="text" size="10" name="search11" <%=fieldpa%> VALUE=<%=diffAMT%>> 
      <%IF LEN(TRIM(TEMPCANCELDAT)) > 0 THEN %>
        <FONT SIZE=2 COLOR=RED>��Ƥw�@�o�A���i�R�b�C</FONT>
      <%ELSE%> 
      <%END IF%>
    </td></tr>       
</table>
<UL>
<table width="80%" ><tr><td ALIGN=CENTER>
  <input type="SUBMIT" value="�R�b�T�{" class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</td></tr></table>
</body>
</html>