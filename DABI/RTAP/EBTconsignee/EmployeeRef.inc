<%
Function SrGetEmployeeRef(RTNValue,OPT,Code)
'-----------------------------------------------------------------
' RTNValue=�^�ǭ�
'      OPT=���涵��
'     CODE=�ǤJ�Ѽ� 
'-----------------------------------------------------------------
'      OPT=1:��(logon user)Ū�����u�������
'      OPT=2:��(�u��)Ū���������
' array(0)=Emply(�u��)
' array(1)=cusnc(��H�W��)
' array(2)=shortnc(��H²��)
' array(3)=CUSID(�����Ҧr��)
'-----------------------------------------------------------------
'      OPT=3:��(logon user)Ū���P�_���u��ƬO�_�s�b
'      OPT=4:��(�u��)Ū���P�_���u��ƬO�_�s�b
'      OPT=5:��(logon user)Ū�����u�������
' rtnvalue="Y":�����u��Ʀs�b
'-----------------------------------------------------------------
 rtnvalue=""
 SELECT Case OPT
   Case 1
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      SQL="SELECT RTObj.CUSNC , RTObj.SHORTNC, RTEmployee.EMPLY, " _
         &"RTEmployee.NETID,RTEmployee.CUSID " _
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID " _
         &"WHERE netid = '" & code & "'"
        ' response.write "SQL=" & SQL
      Conn.Open DSN
      Rs.Open SQL,DSN,1,1
      if rs.recordcount > 0 then
         RTNVALUE= rs("EMPLY") & ";" & rs("CUSNC") & ";" & rs("SHORTNC") & ";" & rs("CUSID")
      else
         rtnvalue=";;;"
      end if
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing
   Case 2
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      SQL="SELECT RTObj.CUSNC, RTObj.SHORTNC, RTEmployee.EMPLY, " _
         &"RTEmployee.NETID,RTEmployee.CUSID  " _ 
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID " _
         &"WHERE emply = '" & code & "'"
      Conn.Open DSN
      Rs.Open SQL,DSN,1,1
      If rs.recordcount > 0 then
         RTNVALUE= rs("EMPLY") & ";" & rs("CUSNC") & ";" & rs("SHORTNC") & ";" & rs("CUSID")
      else
         Rtnvalue=";;;"
      end if
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing
   Case 3
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      SQL="SELECT RTObj.CUSNC , RTObj.SHORTNC, RTEmployee.EMPLY, " _
         &"RTEmployee.NETID,RTEmployee.CUSID  " _
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID " _
         &"WHERE netid = '" & code & "'"
      Conn.Open DSN
      Rs.Open SQL,DSN,1,1
      if rs.recordcount > 0 then
         RTNVALUE= "Y"
      else
         rtnvalue=""
      end if
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing      
   Case 4
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      SQL="SELECT RTObj.CUSNC, RTObj.SHORTNC, RTEmployee.EMPLY, " _
         &"RTEmployee.NETID,RTEmployee.CUSID  " _ 
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID " _
         &"WHERE emply = '" & code & "'"
      Conn.Open DSN
      Rs.Open SQL,DSN,1,1
      If rs.recordcount > 0 then
         RTNVALUE= "Y"
      else
         Rtnvalue=""
      end if
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing      
   Case 5
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      SQL="SELECT RTObj.CUSNC, RTObj.SHORTNC, RTEmployee.EMPLY, " _
         &"RTEmployee.NETID,RTEmployee.CUSID,rtemployee.dept  " _ 
         &"FROM RTObj INNER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID " _
         &"WHERE netid = '" & code & "'"
      Conn.Open DSN
      Rs.Open SQL,DSN,1,1
      If rs.recordcount > 0 then
         RTNVALUE= rs("dept")
      else
         Rtnvalue=""
      end if
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing            
   Case Else
 
 End Select
End Function
%>