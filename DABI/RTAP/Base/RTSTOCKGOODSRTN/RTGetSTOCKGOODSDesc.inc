<%
  Function FrGetSuppDesc(Cusid)
  Dim s,conn,rs,sql
  Set conn=Server.CreateObject("ADODB.Connection")  
  Set rs=Server.CreateObject("ADODB.Recordset")
  conn.Open DSN
  sql="SELECT RTObj.SHORTNC, RTObjLink.CUSTYID " _
     &"FROM RTObj INNER JOIN " _
     &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
     &"WHERE (RTObjLink.CUSTYID = '04') " _
     &"AND rtobj.cusid='" &cusid & "'"
 ' response.write "SQL=" & SQL
  rs.Open sql,conn
  s=""
  If rs.Eof Then
     s="�t�ӥN��:" &cusid &"�b�t�Ӱ򥻸�Ƥ��䤣��"
  Else 
     s="�t��²��:" &rs("shortnc") 
  End If
  rs.Close
  Set rs=Nothing
  conn.Close
  Set conn=Nothing
  FrGetsuppDesc=s
End Function
%>