<%@ Language=VBScript %>
<%
keyary=split(request("key"),";")
'RESPONSE.Write "K1=" & KEYARY(0) & ";K2=" & KEYARY(1) & ";K3=" & KEYARY(2) & ";K4=" & KEYARY(3) & ";K5=" & KEYARY(4)
Randomize
select case keyary(4)
'���T599
   case "HB599"
      response.Redirect "http://W3C.INTRA.CBBN.COM.TW/webap/rtap/base/rtcmty/rtFAQD.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0)
'����399 
   case "����399"
      response.Redirect "http://W3C.INTRA.CBBN.COM.TW/webap/rtap/base/rtADSLcmty/rtFAQD.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0)
'�t��399   
   case "�t��399"
      response.Redirect "http://W3C.INTRA.CBBN.COM.TW/webap/rtap/base/rtSPARQADSLcmty/rtFAQD.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0)
'�F��499   
   case "�F��499"
    '  response.Redirect "http://w3c.intra.cbbn.com.tw/webap/rtap/base/rtcmty/rtcustk2.asp?key=" & KEYary(0)
      response.Redirect "http://W3C.INTRA.CBBN.COM.TW/webap/rtap/base/rtEBTcmty/rtFAQD.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0)
'�t��499   
   case "�t��499"
      response.Redirect "http://W3C.INTRA.CBBN.COM.TW/webap/rtap/base/rtsparq499cmty/rtFAQD.asp?V=" &RND() & "&accessMode=U" & "&key=" & KEYary(0)
end select
%>