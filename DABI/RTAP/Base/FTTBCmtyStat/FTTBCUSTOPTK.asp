<%@ Language=VBScript %>
<%
keyary=split(request("key"),";")
Randomize
DSN="DSN=RTLib"
Set connXX=Server.CreateObject("ADODB.Connection")
Set rsXX=Server.CreateObject("ADODB.Recordset")
CONNXX.OPEN DSN
sqlxx="select * from fttbcust where comq1=" & keyARY(0) & " and cusid='" & keyARY(1) & "' and entryno=" & keyARY(2)
rsxx.open sqlxx,connxx
if rsxx("cuskind")="01" or rsxx("cuskind")="02" then
   OPT="2"
elseif rsxx("cuskind")="03" or rsxx("cuskind")="04" then
   OPT="1"
end if
RSXX.CLOSE
CONNXX.CLOSE
SET RSXX=NOTHING
SET CONNXX=NOTHING

select case OPT
'�DHB�Τ�
   case "1"
      response.Redirect "/webap/rtap/base/fttbcmtystat/fttbcustd.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0) & ";" & KEYARY(1) & ";" & KEYARY(2)
'HB�Τ�
   case "2"
      response.Redirect "/webap/rtap/base/fttbcmtystat/fttbcustd2.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0) & ";" & KEYARY(1) & ";" & KEYARY(2)
end select
%>