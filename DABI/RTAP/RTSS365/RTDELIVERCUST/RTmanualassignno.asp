<%
key=request("key")
keyary=split(key,";")
stat=request("stat")
XXCUSID=KEYARY(0)
xxentryno=keyary(1)
accountXX=request("search1")
USEDATEXX=request("search2")
errflag=""
if stat="Y" and errflag<>"Y" then
'   logonid=session("userid")
'   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
'         V=split(rtnvalue,";")
   Set conn=Server.CreateObject("ADODB.Connection")  
   set rs=server.CreateObject("ADODB.recordset")
   set rs2=server.CreateObject("ADODB.recordset")
   set rs3=server.CreateObject("ADODB.recordset")   
   DSN="DSN=RtLib"
   conn.Open DSN
   RS3.OPEN "select * from rtCUSTADSL where cusid='" & XXCUSID & "' and entryno=" & XXENTRYNO,CONN 
   IF LEN(TRIM(RS3("SS365")))=0 THEN
         CTYPE="399"
   ELSE
         CTYPE="599"
   END IF
   rs3.close
   set rs3=nothing
'------------------------------------------------------------------------------------------------------------------------   
   '�p��rt365account�ɤ��̤j�Ǹ�
   YY=cstr(datepart("yyyy",now()))
   mm=right(cstr("0" & cstr(datepart("m",now()))),2)
   dd=right(cstr("0" & cstr(datepart("d",now()))),2)
   YYMMDD=yy & mm & dd
   Set rsc=Server.CreateObject("ADODB.Recordset")
   sqlstr2="select max(batchno) AS batchno from rt365account where  batchno like '" & yymmdd & "%'" 
   rsc.open sqlstr2,conn
   newbatchno=""
   if len(rsc("batchno")) > 0 then
      Newbatchno=yymmdd & right("000" + cstr(cint(mid(rsc("batchno"),9,3)) + 1),3)
   else
      Newbatchno=yymmdd & "001"
   end if           
'------------------------------------------------------------------------------------------------------------------------   
   '�ˬd�b����ƬO�_�s�b(��ʵ�����,���ˬd�ӱb���O�_�s�b�άO�_����,�ö��ˬd������399��599�O�_�P�ӫȤ�ӽФ���׬ۦP
   sql="select * from rt365account where SS365ACCOUNT='" & ACCOUNTXX & "'"
   rs.Open sql,conn,1,1
   if RS.EOF then
      endpgm="3"
      errmsg="��J���b�����s�b�b����Ʈw��,���ˬd��J���b���αb�������!"
      errflag="Y"
   elseif len(trim(rs("cusid"))) > 0 then
      endpgm="3"
      errmsg="���b���w�Q�ϥ�,�Ȥᬰ:" & rs("cusid")
      errflag="Y"      
 ' 900920 : ����399�P599�b��,�]������399���Ȥ�Ҩϥ�599�b���N��
 '  elseif ctype <> rs("type") then
 '     endpgm="3"
 '     errmsg="��J���b����:" & rs("type") & "����,���Ȥ�ӽФ���׬�:" & ctype & "����!"       
 '     errflag="Y"      
   end if         
   rs.close
   '------------------------------------------------------------------------------------------------------------------------
   if errflag <> "Y" then
      sql="select * from rt365account where cusid='" & keyary(0) & "' and entryno=" & keyary(1) & " and dropdat is null "
      rs.Open sql,conn,1,1
      if not rs.EOF then
         endpgm="3"
         errmsg="�ӥΤ�w���L�b���B�ӱb���|���M�P;�b����:" & rs("ss365account")
      else
         sql="SELECT * FROM RT365ACCOUNT WHERE ss365account='" & accountxx & "'"
         rs2.Open sql,conn,3,3
         if rs2.recordcount = 0 then
            endpgm="4"
            errmsg="�b������ɤw�L�䥦�b���i�Ѩϥ�,���ˬd�b�����!"
         else
            rs2("cusid")=xxcusid
            rs2("entryno")=xxentryno
            rs2("usedate")=now()
            rs2("batchno")=newbatchno
            rs2.update
         end if
         rs2.close               
      end if
   end if
end if
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
<!--
Sub btn_onClick()
  s1=document.all("search1").value
  errcode=""
  if len(trim(s1))=0 then
     msgbox "�b�����i�ť�,�z�i�H��ܨ����ο�J�b�����!",vbexclamation+vbokonly,"����ˬd�T��"
     errcode="1"
     document.all("stat").value="N"
  elseif len(trim(s1)) < 11 then
     msgbox "��J���b�����פ���,�b����������11��,�z��J" & len(trim(s1)) & "��!",vbexclamation+vbokonly,"����ˬd�T��"
     errcode="1"
     document.all("stat").value="N"
  end if
  if errcode="" then
     document.all("stat").value="Y"
     window.document.all("frm1").submit
 
     Dim winP,docP
     Set winP=window.Opener
     Set docP=winP.document
 '    docP.all("keyform").Submit
 '    winP.focus()
 '    window.close
  end if
End Sub
Sub btn1_onClick()
     Dim winP,docP
     Set winP=window.Opener
     Set docP=winP.document
   '  docP.all("keyform").Submit
     winP.focus()
     window.close
End Sub
Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="search" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
End Sub 
Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="search" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
       end if
End Sub   
Sub ImageIconOver()
       self.event.srcElement.style.borderBottom = "black 1px solid"
       self.event.srcElement.style.borderLeft="white 1px solid"
       self.event.srcElement.style.borderRight="black 1px solid"
       self.event.srcElement.style.borderTop="white 1px solid"   
End Sub
   
Sub ImageIconOut()
       self.event.srcElement.style.borderBottom = ""
       self.event.srcElement.style.borderLeft=""
       self.event.srcElement.style.borderRight=""
       self.event.srcElement.style.borderTop=""
End Sub      
-->
</script>
</head>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"     codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<body>
<center>
<form method=post name="frm1" action="rtmanualassignno.asp">
<input type="hidden" name="key" value="<%=key%>">
<input type="hidden" name="CUSXX" value="<%=XXCUSID%>">
<input type="hidden" name="ENTRYXX" value="<%=XXENTRYNO%>">
<input type="hidden" name="stat" value="<%=STAT%>">
<input type="hidden" name="ERRFLAG" value="<%=ERRFLAG%>">
<table width="70%" align="center">
  <tr class=dataListTitle align=center>�п�J���ݥ�Ĺ��ʱb���������X</td><tr>
</table>
<table width="70%" border=1 cellPadding=0 cellSpacing=0>
<tr><td class=dataListHead width="30%">�b��</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search1" size="11" maxlength="11" class=dataListEntry value="<%=ACCOUNTXX%>">
    </td></tr>
<tr><td class=dataListHead width="30%">�������</td>
    <td width="70%" bgcolor="silver" >
    <input type=text name="search2" size="11" maxlength="11" readonly class=dataListEntry  value="<%=USEDATEXX%>">
          <input type="button" id="B2"  name="B2" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">                          
 <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C2"  name="C2"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="Srclear" >  </td>            
    </td></tr>    
</table>
<table width="70%" align=center><tr ><td bgcolor="silver" width="30%">�T��</td><td  bgcolor="silver" width="70%"><%=errmsg%></td></tr>
<table width="70%" align=center><tr><td></td><td align=center>
  <input type="button" value=" �T�{ " class=dataListButton name="btn" style="cursor:hand">
  <input type="button" value=" ���� " class=dataListButton name="btn1" style="cursor:hand">
</table>
</table>
</form>
</body>
</html>