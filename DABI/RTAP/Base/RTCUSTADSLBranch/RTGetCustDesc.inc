<%
  Function FrGetCustDesc(Comq1,cusid,entryno)
  Dim s,conn,rs,sql
  Set conn=Server.CreateObject("ADODB.Connection")  
  Set rs=Server.CreateObject("ADODB.Recordset")
  conn.Open DSN
  sql="select * from rtcustadsl where cusid='" & cusid & "' and entryno=" & entryno
  rs.open sql,conn
  if rs.eof then
     s="�Ȥ�N��:" &cusid &"�b�Ȥ�򥻸�Ƥ��䤣��"  
  else
     comq1=rs("comq1")
     rs.close
     sql="select * from rtCUSTADSLcmty where CUTYID=" & comq1
     rs.Open sql,conn
     s=""
     If rs.Eof Then
        s="���ϥN��:" &Comq1 &"�b���ϰ򥻸�Ƥ��䤣��"
     Else 
        s="���ϦW��:" &rs("comn") 
     End If
     rs.Close

     sql="select * from rtobj where cusid='" & cusid & "'"
     rs.Open sql,conn
     If rs.Eof Then
        s= s & "  �Ȥ�N��:" & Cusid &" �b��H�򥻸�Ƥ��䤣��"
     Else 
        s= s & "  �Ȥ�W��:" &rs("shortnc") 
     End If
     rs.Close
     sql="select * from rtcustadsl where cusid='" & cusid & "' and entryno=" & entryno
     rs.Open sql,conn
     If rs.Eof Then
        s= s & "  �Ȥ�:" & Cusid &" �b�Ȥ�򥻸�Ƥ��䤣��"
     Else 
        s= s & "  ���u���:" &rs("finishdat") 
     End If
  end if
  rs.Close  
  Set rs=Nothing
  conn.Close
  Set conn=Nothing
  FrGetcustDesc=s
End Function
%>