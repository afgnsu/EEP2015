<%
 Dim dspkey(100),DSN
 DSN="DSN=RTLib"
 dspkey(3)=Request.Form("search3")
 dspkey(4)=Request.Form("search4")
 dspkey(5)=Request.Form("search5")
 
Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    DSN="DSN=RTLIB"
    conn.open DSN
    sql="SELECT RTSalesGroup.GROUPID, RTSalesGroup.GROUPNC, RTSalesGroupREF.EMPLY, " _
       &"RTObj.CUSNC " _
       &"FROM RTSalesGroup INNER JOIN " _
       &"RTSalesGroupREF ON RTSalesGroup.AREAID = RTSalesGroupREF.AREAID AND " _
       &"RTSalesGroup.GROUPID = RTSalesGroupREF.GROUPID AND " _
       &"RTSalesGroupREF.EDATE IS NULL INNER JOIN " _
       &"RTEmployee ON RTSalesGroupREF.EMPLY = RTEmployee.EMPLY AND " _
       &"RTEmployee.TRAN2 <> '10' INNER JOIN " _
       &"RTObj ON RTEmployee.CUSID = RTObj.CUSID " _
       &"WHERE (RTSalesGroup.EDATE IS NULL) " _
       &"ORDER BY RTSalesGroup.GROUPID "
    s10="<option value="";"" >(��끝)</option>"   
    rs.Open sql,conn
    sx=""
    areaCnt=0
    pregroupID=""    
    Do While Not rs.Eof
       If pregroupID <> rs("groupID") Then
          If areaCnt > 0 Then
             s11=s11 &"</select>""" &vbCrLf      
          End If
          areaCnt=areaCnt + 1           
          s11=s11 &"arygroup(" &areaCnt &")=""<select name=""""search11"""" size=""""1"""">" _   
              &"<option value=""""<>'*';��끝"""">��끝</option>"
          s10=s10 &"<option value=""" &rs("GROUPID") & ";" & rs("GROUPnc") &"""" &sx &">" &rs("GROUPnc") &"</option>"

          pregroupID=rs("groupID")
       End If
       s11=s11 &"<option value=""""='" &rs("EMPLY") &"';" &rs("CUSNC") &""""">" _
                             &rs("CUSNC") &"</option>"            
       rs.MoveNext
       sx=""
    Loop
    If areaCnt > 0 Then
       s11=s11 &"</select>""" &vbCrLf
       s11="Dim arygroup(" &areaCnt &")" &vbCrLf _
        &"arygroup(0)=""<select name=""""search11""""><option value=""""<>'*';��끝"""">��끝</option></select>""" &vbCrLf &s11     
    End If         
    rs.Close    
    conn.close       
    set rs=nothing
    set conn=nothing

%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV3/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub search10_OnChange()
    <%=s11%>
    document.all("search11TD").innerHTML=arygroup(document.all("search10").selectedIndex)
End Sub
Sub btn_onClick()
  dim s,t
  t=""
  s=""
  '--------------
  s1=document.all("search1").value
  if len(trim(s1)) > 0 then
     s="トㅱ쫁붙좬쬽('" & s1 & "')쫞ㅈ"  
     t=t & " rtobj.cusnc like '%" & s1 & "%' "
  else
     s="トㅱ쫁붙좬��끝  "
     t=t & " rtcustadsl.cusid <> '*' "
  end if
  '-----쫤맷턨プ
  s2=document.all("search2").value
  s2ary=split(s2,";")
  
  s=S & "쫤맷턨プが챥좬" & s2ary(1)  
  if s2ary(0)="" then 
     t=t & " and rtcustadsl.dropdat is null and rtcustadsl.agree <>'N' " 
  '((쨡놜췱))
  elseif s2ary(0)="1" then
     t=t & " and rtcustadsl.docketdat is not null "
  '((쨢㏏쨠�|�설覇m))
  elseif s2ary(0)="2" then
     t=t & " and rtcustadsl.finishdat is not null and rtcustadsl.docketdat is null " 
  '((쨢¾켹��굶퉞멎))--�|�섯鱇�
  elseif s2ary(0)="3" then
     t=t & " and rtcustadsl.workingreply is not null and rtcustadsl.finishdat is null and rtcustadsl.docketdat is null " 
  '((쨢캿╁재툫쿍데ポ��굶퉞멎))
  elseif s2ary(0)="4" then
     t=t & " and rtcustadsl.sendworking is not null and rtcustadsl.workingreply is null and rtcustadsl.docketdat is null and rtcustadsl.finishdat is null " 
  '((ㄴ뒈퉞첞쨢챰�^�|�섟e재툫쿍))
  elseif s2ary(0)="5" then
     t=t & " and rtcustadsl.chtsigndat is not null and rtcustadsl.sendworking is null and rtcustadsl.workingreply is null and rtcustadsl.docketdat is null and rtcustadsl.finishdat is null " 
  '((쨢캿τㄴ뒈퉞첞�|�셌괜^))
  elseif s2ary(0)="6" then
     t=t & " and rtcustadsl.deliverdat is not null and rtcustadsl.chtsigndat is null and  rtcustadsl.sendworking is null and rtcustadsl.workingreply is null and rtcustadsl.docketdat is null and rtcustadsl.finishdat is null " 
  '((�|�섟eτ))
  elseif s2ary(0)="7" then
     t=t & " and rtcustadsl.deliverdat is null and rtcustadsl.dropdat is null and rtcustadsl.chtsigndat is null and  rtcustadsl.sendworking is null and rtcustadsl.workingreply is null and rtcustadsl.docketdat is null and rtcustadsl.finishdat is null " 
  '((ㄳ쩳ヘ퇹ㅱ))
  elseif s2ary(0)="8" then
     t=t & " and rtcustadsl.agree ='N' "
  '((튝푉Τ싻ㅱ))
  elseif s2ary(0)="9" then
     t=t & " and rtcustadsl.dropdat is not null and rtcustadsl.finishdat is null "
  '((컃�꺄擔圭�))
  elseif s2ary(0)="10" then
     t=t & " and rtcustadsl.dropdat is not null and rtcustadsl.finishdat is not null "
  elseif s2ary(0)="11" then
     t=t & " and ( rtcustadsl.agree = '' or rtcustadsl.agree is null ) "     
  end if
  
  '-------------
  s3=document.all("search3").value
  s4=document.all("search4").value
  s5=document.all("search5").value
  if len(trim(s3))>0 then
     t=t & " and rtcustadsl.stockid='" & s3 & "' "
  end if
  if len(trim(s4))>0 then
     t=t & " and rtcustadsl.branch='" & s4 & "' "
  end if  
  if len(trim(s5))>0 then
     t=t & " and rtcustadsl.bussman='" & s5 & "' "
  end if    
  s6=document.all("search6").value
  if len(trim(s6))>0 then
     t=t & " and RTCOUNTY.CUTNC + RTCUSTADSL.TOWNSHIP2 + RTCUSTADSL.RADDR2 like '%" & s6 & "%' "
     s=S & "�@맷업쫆�}좬쬽('" & s6 & "')쫞ㅈ"
  end if  
  s7=document.all("search7").value
  if len(trim(s7))>0 then
     t=t & " and RTCUSTADSL.housename like '%" & s7 & "%' "
     s=S & "�@だ겅쫁붙좬쬽('" & s7 & "')쫞ㅈ"
  end if    
  s8=document.all("search8").value
  if len(trim(s8))>0 then
     t=t & " and RTCUSTADSL.ORDERNO like '%" & s8 & "%' "
     s=S & "�@━τ퐏많좬쬽('" & s8 & "')쫞ㅈ"
  end if    
  s9=document.all("search9").value
  if len(trim(s9))>0 then
     t=t & " and RTCUSTADSL.CUSNO like '%" & s9 & "%' "
     s=S & "�@HN많폵좬쬽('" & s9 & "')쫞ㅈ"
  end if    
  s11=document.all("search11").value
  s11ary=split(s11,";")  
  s=s & "  �~걷쨠�{췾:" & s11ary(1) & "  "
  t=t & " and rtcustadsl.bussid " & s11ary(0)   
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  docP.all("searchQry").value=t
  docP.all("searchShow").value=s
  docP.all("keyform").Submit
  winP.focus()
  window.close
End Sub
Sub btn1_onClick()
  Dim winP,docP
  Set winP=window.Opener
  Set docP=winP.document
  winP.focus()
  window.close
End Sub
Sub SrReNew()
  Window.form.Submit
End Sub
-->
</script>
</head>
<body>
<form method="post" id="form">
<center>
<table width="80%">
  <tr class=dataListTitle align=center>싻욥짫(울앳)トㅱ멸�틔j퀾깡τ</td><tr>
</table>
<table width="80%" border=1 cellPadding=0 cellSpacing=0>
<TR>        <td width="30%" class="dataListHead" height="32">촤③/ㅐ��/재�~��</td>                                      
        <td width="70%" height="32" bgcolor="silver">
<%  Call SrGetBRANCHBUSS(accessmode,"E",0,dspkey(3),dspkey(4),dspkey(5),s,t,U)%>        
           <select size="1" name="search3" onChange="SrRenew()" class="dataListEntry">      
             <option value="""" selected>(��끝)</option>"                                        
              <%=s%>
           </select>
           <select size="1" name="search4"  onChange="SrRenew()" class="dataListEntry">      
            <option value="""" selected>(��끝)</option>"                                        
              <%=T%>
           </select>
           <select size="1" name="search5"  class="dataListEntry">               
            <option value="""" selected>(��끝)</option>"                               
              <%=U%>
           </select> 
        </td>     </TR>
<tr><td class=dataListHead width="40%">�~걷꾐쬜</td>
    <td width="60%" bgcolor="silver">

      <select name="search10" size="1" class=dataListEntry>
        <%=s10%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">�~걷쨠�{췾</td>
    <td width="60%"  id="search11TD" bgcolor="silver">
      <select name="search11" size="1" class=dataListEntry>
        <option value="<>'*';��끝">��끝</option>
      </select>
    </td>
    </td></tr>             
<tr><td class=dataListHead width="30%">トㅱ쫁붙</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search1" size="25" maxlength="25" class=dataListEntry>
    </td></tr>
<tr><td class=dataListHead width="30%">━τ퐏많</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search8" size="7" maxlength="25" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="30%">HN많폵</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search9" size="10" maxlength="10" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="30%">맷업쫆�}</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search6" size="40" maxlength="50" class=dataListEntry>
    </td></tr>    
<tr><td class=dataListHead width="30%">だ겅쫁붙</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search7" size="30" maxlength="60" class=dataListEntry>
    </td></tr>        
<tr><td class=dataListHead width="30%">쫤맷턨プが챥</td>
    <td width="70%" bgcolor="silver" >
      <select name="search2" size="1" class=dataListEntry>
        <option value=";��끝(ㄳ쬽튝푉ㅱ좦컃�깽誠課％iヘ퇹ㅱ)"  selected >(1)��끝(ㄳ쬽튝푉ㅱ좦컃�깽誠課％iヘ퇹ㅱ)</option>
        <option value="1;쨢놜췱トㅱ">(2)쨢놜췱トㅱ</option>
        <option value="2;쨢맷업㏏쨠トㅱ(�설覇m)">(3)쨢맷업㏏쨠トㅱ(�설覇m)</option>
        <option value="3;쨢¾켹��굶퉞멎トㅱ(�섯鱇�)">(4)쨢¾켹��굶퉞멎トㅱ(�섯鱇�)</option>        
        <option value="4;쨢캿τ╁재툫쿍(데ポ��굶퉞멎)">(5)쨢캿τ╁재툫쿍(데ポ��굶퉞멎)</option>
        <option value="5;ㄴ뒈퉞첞쨢챰�^(�|�섟e재툫쿍)">(6)ㄴ뒈퉞첞쨢챰�^(�|�섟e재툫쿍)</option>
        <option value="6;쨢캿τ╁ㄴ뒈퉞첞(�|�셌괜^)">(7)쨢캿τ╁ㄴ뒈퉞첞(�|�셌괜^)</option>
        <option value="7;�|�섟eτ">(8)�|�섟eτ</option>             
        <option value="8;ㄳ쩳ヘ퇹ㅱ">(9)ㄳ쩳ヘ퇹ㅱ</option>             
        <option value="9;튝푉Τ싻ㅱ">(10)튝푉Τ싻ㅱ</option>                                                        
        <option value="10;컃�깽�">(11)컃�깽�</option>     
        <option value="11;�|�섧炯悽�">(12)�|�섧炯悽�</option>                                                                        
      </select>    </td></tr>    
</table>
<table width="80%" align=right><tr><td></td><td align=right>
  <input type="SUBMIT" value=" 촥멕 " class=dataListButton name="btn" onsubmit="btn_onclick" style="cursor:hand">
  <input type="button" value=" 뎡�� " class=dataListButton name="btn1" style="cursor:hand">
</FORM>
</body>
</html>
<!-- #include file="rtgetBRANCHBUSS.inc" -->