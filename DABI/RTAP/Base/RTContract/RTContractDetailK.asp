<%
parmkey=request("key")
aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
DIM conn,rs,dsn,sql
SET conn=server.CreateObject("ADODB.Connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
conn.Open dsn
SQL="select * from HBContractH where CTNO=" & aryparmkey(0)
rs.Open sql,conn
if NOT rs.EOF THEN
   IF rs("CTPROPERTY")="A" or rs("CTPROPERTY")="B" or rs("CTPROPERTY")="E" or rs("CTPROPERTY")="F"  then
      PGMID="1"
      PGMNAME="RTContractkind1k.asp" & "?key=" & parmkey
   ELSE
      PGMID="2"
      PGMNAME="RTContractkind2k.asp" & "?key=" & parmkey      
   end if
END IF
rs.close
'�ˬd�O�_�s�b�~�������~���Ӹ�� ==> IF YES,�h���޷~�����O����...�̲��~�����ɦs�b����Ƭ��D,�a�X���Ӹ�Ʃ��ݤ��e��
SQL="select  COUNT(*) as CNT from HBContractSalesD where CTNO=" & aryparmkey(0)
rs.Open sql,conn
IF RS("CNT") > 0 THEN
   PGMNAME="RTContractkind1k.asp" & "?key=" & parmkey
END if
rs.close
'�ˬd�O�_�s�b�޲z�����~���Ӹ�� ==> IF YES,�h���޷~�����O����...�̲��~�����ɦs�b����Ƭ��D,�a�X���Ӹ�Ʃ��ݤ��e��
SQL="select COUNT(*) AS CNT from HBContractMaintain where CTNO=" & aryparmkey(0)
rs.Open sql,conn
IF RS("CNT") > 0  THEN
   PGMNAME="RTContractkind2k.asp" & "?key=" & parmkey
END if
rs.Close
conn.Close
set rs=nothing
set conn=nothing
%>
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       window.frm2.submit
    else
       window.frm2.submit
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=verify.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=PGMID%>" ID="Text1">
</form>
<form name=frm2 method=post action=<%=pgmname%> ID="Form2">
</form>
</html>