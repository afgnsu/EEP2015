<%
    key=request("key")
    keyary=split(key,";")
    Dim rs,conn
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")    
    today=datevalue(now())

'------�ˬd�ӫȤ�O�_�w�㧹�u���פ�ζ}�l�p�O��A�Y���h���i����

    sql="SELECT	* " _
	   &"FROM	RTLessorAVSCust " _
       &"where  cusid ='" & keyary(0) &"' "
'response.write "sql="& sql
    rs.Open sql,conn
    if rs.EOF then
       endpgm="2"
    elseif len(rs("strbillingdat"))=0 or len(rs("finishdat"))=0 then
       endpgm="3"
    else    
       endpgm="1"
    end if
'---------------------------------------------------------
    rs.close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>AVS City �˾����u���ק@��</TITLE>
<SCRIPT language=VBScript>
Sub cmdSure_onClick
  'Randomize  
  'accessmode="U"
  'key:key(0)=���Ͻs�� key(1)=�Ȥ�s�� key(2)=���� key(3)=���ʶ���
  if keyform.htmlfld.value="1" then
     search1=document.all("search1").value
     search2= document.all("search2").value
     search3= document.all("keyary1").value
     search4= document.all("keyary2").value
     'prog="RTLessorAVSCustSNDWORKF.asp?V=" &Rnd() &"&accessMode=" &accessMode &"&key=" &search &"&"
     prog="RTLessorAVSCustSNDWORKF.asp?key=" & search3 &";"& search4 &";"& search1 &";"& search2 &";"
     Scrxx=window.screen.width
     Scryy=window.screen.height - 30
     StrFeature="Top=0,left=0,scrollbars=yes,status=yes," _
               &"location=no,menubar=no,width=" & scrxx & "px" _
               &",height=" & scryy & "px"
    'Set diagWindow=Window.Open(prog,"diag",strFeature)
    Window.Open prog,"diag",strFeature 
    'window.open pgm 
    'window.close
   elseif keyform.htmlfld.value="2" then
     msgbox "�Ȥ��Ƨ䤣��A���ˬd�Ȥ��ɸ�ƬO�_�w�Q�R��!"
   elseif keyform.htmlfld.value="3" then
     msgbox "���Ȥ᧹�u���פ�ζ}�l�p�O��w��A�����\���楻�@�~!"
   else
     msgbox "�{������o�Ͳ��`�A�гq����T�H��!"
   end if
End Sub

Sub cmdcancel_onClick
  Dim winP,docP
  Set winP=window.Opener
'  Set docP=winP.document
'  winP.focus()
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
</SCRIPT>
</HEAD>

<OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E" codeBase=http://www.cbbn.com.tw/stock/EF2KDT.CAB#version=9,0,0,3 
	height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270"></OBJECT>

<BODY style="background:lightblue">
<!--form name=keyform�O���F�t�X�Ҳլ[�c�һ�-->
<form name="keyform">
<DIV align=Center><i><font face="�ө���" size="5" color="#FF00FF">AVS City �˾����u����</font></i> </DIV>
<!-- <DIV align=Center><i><font face="�ө���" size="3" color="#FF00FF">�����Ȥ��Ʋ���</font></i> </DIV> -->
<P></P>

<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>
	<tr><td ALIGN="RIGHT"><font face="�з���">�п�J���u���פ�:</font></td>
		<td><input type="text" name="search1" align=right class=dataListEntry value="<%=today%>" readonly>
   			<input type="button" id="B1" name="B1" height=100% width=100% style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>
	<tr><td ALIGN="RIGHT"><font face="�з���">�п�J�}�l�p�O��:</font></td>
		<td><input type="text" name="search2" align=right class=dataListEntry value="<%=today%>" readonly>
   			<input type="button" id="B2" name="B2" height=100% width=100% style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>

</table>

<p><center><font face="�ө���">
 <INPUT TYPE="button" VALUE="�e�X" ID="cmdSure"   
 style="font-family: �ө���; color: #FF0000;cursor:hand"> 
  <INPUT TYPE="button" VALUE="����" ID="cmdcancel"   
 style="font-family: �ө���; color: #FF0000;cursor:hand">
 </center>
 
  <HR><P>
  <center>
  <input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
    <input type="text" name=keyary1 style=display:none value="<%=keyary(0)%>">
    <input type="text" name=keyary2 style=display:none value="<%=keyary(1)%>">
  </form>
</BODY> 
</HTML>