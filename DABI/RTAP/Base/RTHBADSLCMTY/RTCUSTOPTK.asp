<%@ Language=VBScript %>
<%
keyary=split(request("key"),";")
select case keyary(2)
'���T599
   case "1"
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtcmty/rtcustk3.asp?key=" & KEYary(0)
'����399 
   case "2"
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtADSLcmty/rtcustk3.asp?key=" & KEYary(0)
'�t��399   
   case "3"
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtSPARQADSLcmty/rtcustk3.asp?key=" & KEYary(0)
'�F�T599   
   case "4"
    '  response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtcmty/rtcustk2.asp?key=" & KEYary(0)
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtcmty/rtcustk3.asp?key=" & KEYary(0)
'�F��499   
   case "5"
    '  response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtcmty/rtcustk2.asp?key=" & KEYary(0)
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtEBTcmty/rtEBTCUSTK4.asp?key=" & KEYary(0) & ";" & KEYARY(1)
'�t��499   
   case "6"
      response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtSPARQ499cmty/RTSparq499CustK3.asp?key=" & KEYary(0) & ";" & KEYARY(1)
end select
%>