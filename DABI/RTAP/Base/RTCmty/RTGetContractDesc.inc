<%
  Function FrGetContractDesc(ctno)
  Dim s,conn,rs,sql
  Set conn=Server.CreateObject("ADODB.Connection")  
  Set rs=Server.CreateObject("ADODB.Recordset")
  conn.Open DSN
  sql="SELECT CTNO, CTOBJNAME FROM HBCONTRACTH WHERE HBcontracth.ctno=" &ctno
 ' response.write "SQL=" & SQL
  rs.Open sql,conn
  s=""
  If rs.Eof Then
     s="�k�ɧǸ�:" &ctno &"�b�t�Ӱ򥻸�Ƥ��䤣��"
  Else 
     s="�k�ɧǸ�:" &rs("CTNO") & " �X����H:" & rs("CTOBJNAME")
  End If
  rs.Close
  Set rs=Nothing
  conn.Close
  Set conn=Nothing
  FrGetContractDesc=s
End Function
%>