<%@ Language=VBScript%>
<% 
  key=Split(Request("key"),";")

  Dim conn, rs, sql, comn
  set conn=server.CreateObject("ADODB.Connection")
  set rs=server.CreateObject("ADODB.Recordset")
  DSN="DSN=RTLib"
  Conn.Open DSN

	sql="select cutyid, comn, case when rcomdrop is null then '' else '�@[�w�M�u]' end as dropflag " &_
		"from RTSparqAdslCmty a " &_
		"where a.comn like '%" &key(1)& "%' "

'Response.Write SQL

  rs.CursorType = 3
  rs.Open sql,conn
  s1=""
  rscnt = rs.RecordCount
  if rscnt <= 300 then
		Do While Not rs.Eof
			s1=	s1 &"<option value=""" & rs("cutyid") &";"& rs("comn") & """>" _
				   & "["&rs("cutyid")&"]" &rs("COMN") & rs("dropflag") & "</option>"
			rs.MoveNext
		Loop
  else
  		s1=s1 &"<option>�j�M���G�@: "&rscnt&" ����ơA���Y�p�j�M�d��!!</option>"
  end if
  rs.Close

  conn.Close
  set rs=Nothing
  set conn=Nothing
%>
<HTML>
<HEAD>
	<meta http-equiv="Content-Type" content="text/html; charset=Big5">
	<TITLE>���Ͽ�ܲM��</TITLE>
</HEAD>
<BODY style="BACKGROUND: lightblue">
<SCRIPT LANGUAGE="VBScript">
  Sub lstOrder1_onclick()
      selno=lstorder1.selectedIndex
      if selno >=0 then
         window.document.all("cmdtext").value= lstOrder1(selno).innerHTML
         window.document.all("cmdtext1").value=lstOrder1(selno).value
         window.document.all("cmdtext2").value="Y"         
      end if
  End Sub

  Sub cmdSure_onClick()
    ReturnValue=""
    'if len(trim(window.document.all("cmdtext").value)) = 0 then
    '   msgbox "�п�ܶm����!",vbokonly,"���~�T������"
    'else    
       'returnvalue= window.document.all("cmdtext2").value &";"& window.document.all("cmdtext1").value &";"& window.document.all("cmdtext").value 
       returnvalue= window.document.all("cmdtext2").value &";"& window.document.all("cmdtext1").value
       window.close
    'end if
  End Sub

  Sub cmdCancel_onClick()
      returnvalue=""
      window.close
  End Sub

  Sub lstOrder1_onkeypress()
		'enter
  		if window.event.keycode =13 then 
			lstOrder1_onclick
			cmdSure_onClick()
		'ESC			
  		elseif window.event.keycode =27 then 
			cmdCancel_onClick
		end if
  End Sub
</SCRIPT>
<Fieldset STYLE="HEIGHT: 390px; LEFT: 16px; POSITION: absolute; TOP: 45px; WIDTH: 600px" ID="select0">
	<LEGEND>���Ͽ�ܲM��</LEGEND> 
	
	<FIELDSET STYLE="HEIGHT: 308px; LEFT: 16px; POSITION: absolute; TOP: 20px; WIDTH: 570px" ID="select1">
		<LEGEND>���ϦW��</LEGEND>
		<SELECT style="font-family:�ө���;HEIGHT: 269px; LEFT: 10px; POSITION: absolute; TOP: 25px; WIDTH: 550px" id="lstOrder1" size="5">
				<%=s1%>
		</SELECT>
	</FIELDSET>&nbsp;
</Fieldset>&nbsp; <font style="LEFT: 30px; POSITION: absolute; TOP: 380px">�ثe��ܤ��e </font>
		<INPUT id="cmdtext" style="LEFT: 130px; POSITION: absolute; TOP: 380px; " size="58" type="text" readonly>
		<INPUT id="cmdtext1" style="LEFT: 130px; POSITION: absolute; TOP: 380px;display:none" size="30" type="text" readonly>
		<INPUT id="cmdtext2" style="LEFT: 130px; POSITION: absolute; TOP: 380px; display:none" size="30" type="text" readonly>
		<INPUT id="cmdCancel" style="LEFT: 490px; POSITION: absolute; TOP: 405px" type="button" value="����">
		<INPUT id="cmdSure" style="LEFT: 436px; POSITION: absolute; TOP: 405px" type="button" value="�T�w">
	</BODY>
</HTML>
