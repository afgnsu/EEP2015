<%@ Language=VBScript %>
<%
keyary=split(request("key"),";")
Randomize
select case keyary(2)
'���T599
   case "1"
      response.Redirect "/webap/rtap/base/HBADSLCUST/RTCUSTPAYMENTK.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(3) & ";" & KEYARY(4)
'����399 
   case "2"
      response.Redirect "/webap/rtap/base/HBADSLCUST/RTCUSTPAYMENTK.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(3) & ";" & KEYARY(4)
'�t��399   
   case "3"
      response.Redirect "/webap/rtap/base/rtSPARQCUST/RTSPARQCUSTPAYK.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(3) & ";" & KEYARY(4)
'�F�T599
   case "4"
      response.Redirect "/webap/rtap/base/HBADSLCUST/RTCUSTPAYMENTK.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(3) & ";" & KEYARY(4)
'�F��499   
   case "5"
      response.Redirect "/webap/rtap/base/rtEBTcmty/rtEBTCUSTPAYK.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0) & ";" & KEYARY(1) & ";" & KEYARY(3)
end select
%>