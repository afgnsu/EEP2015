<%
session.Timeout=999
K1=request("key")
K1ary=split(k1,";") '0=���Ͻs��,1=�Ȥ�N�X,2=�Ȥ�榸
K2=request("Fdat")  '�������
K3=request("Tel")   '�D�u�����q��
set conn=server.CreateObject("ADODB.connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
conn.Open DSN

'91/10/24 �אּ�H�����q�ܸ��X�����Τ�����y�������̾�==>����Ϊ��ϸ��X(���]���ǽu��������y����ӥH�W�����Ϩ�����q�ܤ@��,���Τ�y�����o�U�۽s�C
sql="select isnull(MAX(case sphnno when '' then 0 else sphnno end),0) AS SPHNNO499 from rtsparq499cust where rtrim(NCICCUSNO)='" & TRIM(k3) & "' "
rs.Open sql,conn
SPHNNO499 = Cint(rs("SPHNNO499"))
rs.Close

sql="select isnull(MAX(case sphnno when '' then 0 else sphnno end),0) AS SPHNNO399 from rtsparqadslcust where rtrim(EXTTEL)='" & TRIM(k3) & "' "  
rs.Open sql,conn
SPHNNO399 = Cint(rs("SPHNNO399"))
rs.Close

if SPHNNO499 >= SPHNNO399 and SPHNNO499 <>0  then
   NewNo=right("000" & cstr(SPHNNO499 +1),3)
elseif SPHNNO499 < SPHNNO399 then
   NewNo=right("000" & cstr(SPHNNO399 +1),3)
elseif SPHNNO499 =0 and SPHNNO399 =0 then
   NewNo="001"
end if


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

