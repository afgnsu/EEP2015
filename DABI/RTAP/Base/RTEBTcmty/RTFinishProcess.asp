<%
session.Timeout=999
K1=request("key")
K1ary=split(k1,";") '0=���Ͻs��,1=�Ȥ�N�X,2=�Ȥ�榸
K2=request("Fdat")  '�������
K3=request("Tel")   '�D�u�����q��
set conn=server.CreateObject("ADODB.connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
'91/10/24 �אּ�H�����q�ܸ��X�����Τ�����y�������̾�==>����Ϊ��ϸ��X(���]���ǽu��������y����ӥH�W�����Ϩ�����q�ܤ@��,���Τ�y�����o�U�۽s�C
'sql="select MAX(SPHNNO) AS SPHnNo from rtsparqadslcust where comq1=" & k1ary(0)  
sql="select MAX(SPHNNO) AS SPHnNo from rtsparqadslcust where rtrim(exttel)='" & TRIM(k3) & "' "  
conn.Open DSN
rs.Open sql,conn
if len(rs("SPHNNO")) > 0 then
   NewNo=right("000" & cstr(cint(rs("SPHNNO")) + 1),3)
else
   NewNo="001"
end if
rs.Close
on error resume next
sql="update rtsparqadslcust set SpHnNo ='" & NewNo & "',docketdat='" _
   & K2 & "',exttel='" & K3 & "' where comq1=" & k1ary(0) & " and cusid='" & k1ary(1) _
   & "' and entryno=" & k1ary(2)
'Response.Write SQL
conn.Execute sql
conn.Close
set rs=nothing
set conn=nothing
if err > 0 then
   returnvalue=false
else
   returnvalue=true
end if

%>
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    window.close    
 end sub
</script> 
</head>  
</html>

