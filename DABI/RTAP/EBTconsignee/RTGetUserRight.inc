<%
'role=0:�����H���Ҥ��i��J;role=1:�~�ȧU�z;role=2:�~��;role=4:�޳N��;role=8:�]�|;role=16:�x��z
'ROLE=31:��T���޲z��
Function FrGetUserRight(program,user)
   Dim Role,i,r
  ' response.write "user=" & user
   dim conn,rs,sql,dsn
   set conn=server.createobject("ADODB.Connection")
   set rs=server.createobject("ADODB.recordset")
   DSN="DSN=RTLib;uid=yuanta;pwd=yuanta123"
   SQL="select authlevel from rtemployee where netid='" & user & "'"
   conn.open dsn
   rs.open sql,conn
   if not rs.eof then
     Role=rs("authlevel")
   else
     Role=0
   end if
   r=""
   For i = 0 To 32
      If Role And i Then 
         r=r &";"
      Else
         r=r &" class=dataListData readonly;"
      End If
   Next
   FrGetUserRight=r
   'response.write "R=" & r & "<BR>"
   rs.close
   conn.close
   set rs=nothing
   set conn=nothing
End Function  
%>