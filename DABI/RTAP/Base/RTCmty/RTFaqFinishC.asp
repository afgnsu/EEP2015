<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<HTML>
<HEAD>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>SD Analysis criteria</TITLE>
<SCRIPT language=VBScript>
Sub cmdSure_onClick
  If Category.value <> "" Then
     t=" �Ұ� " & Category.Value
  End If
  if Len(trim(search7.value)) = 0 then search7.value="2000/01/01"
  if Len(trim(search8.value)) = 0 then search7.value="9999/12/31"
  if IsDate(Search7.value) and Isdate(Search8.value) then
     t=t & " and  ���u��� >= '" & search7.value + " 00:00:00.000" & "' and ���u��� <= '" & search8.value + " 23:59:59.999" & "'"
  end if
  returnvalue=t
  window.close
End Sub

sub b1_onclick()
	if isdate(document.all("search7").value) then
		objEF2KDT.varDefaultDateTime=document.all("search7").value
	end if
	call objEF2KDT.show(1)
	if objEF2KDT.strDateTime <> "" then
	    document.all("search7").value = objEF2KDT.strDateTime
	end if
end sub

sub b2_onclick()
	if isdate(document.all("search8").value) then
		objEF2KDT.varDefaultDateTime=document.all("search8").value
	end if
	call objEF2KDT.show(1)
	if objEF2KDT.strDateTime <> "" then
	    document.all("search8").value = objEF2KDT.strDateTime
	end if
end sub

</SCRIPT>
</HEAD>
<OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E" codeBase=http://w3c.intra.cbbn.com.tw/webap/activex/EF2KDT.CAB#version=9,0,0,3 
	height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270"></OBJECT>

<BODY style="background:lightblue">
<DIV align=Center><i><font face="�з���" size="5" color="#FF00FF">HI-Building�ȶD�B�z���u�H����ܵe��</font></i> </DIV>
<table align="center" width="90%" border=0 cellPadding=0 cellSpacing=0>
  <tr><td><font face="�з���">�п�ܧ��u�H�� :</font></td>
<td><font face="�з���"><SELECT size="1" name="Category"  
        style="width:200;">
<% 
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))  
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T89018" or Ucase(emply)="P92010" or _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89008" or Ucase(emply)="T89020" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"
  
    DSN="DSN=rtlib" 
    sql="Select areaid,areanc from rtarea where areatype='1' and areaid " & DAreaid 
    Set conn=Server.CreateObject("ADODB.Connection") 
    conn.Open DSN 
    Set rs=Server.CreateObject("ADODB.Recordset") 
    rs.Open sql,conn 
    dftSel=" SELECTED" 
    if DAreaid = "<>'*'" then
       Response.Write "<OPTION value=""<>'*'""" & dftSel & ">����</OPTION>"  & vbCRLF
    end if 
    dftSel="" 
    Do While Not rs.Eof  
       Response.Write "<OPTION value=""='" & rs("areanc") & "'""" _ 
                      & dftSel & ">" & rs("areanc") & "</OPTION>" & vbCRLF 
       rs.MoveNext  
    Loop  
    rs.Close 
    Set rs=Nothing 
    Set conn=Nothing 
'���u��--default���t�Τ��

    Edate=DateValue(Now())    
%>  
</SELECT>  
 </font></td><tr>
  <tr><td><font face="�з���">�п�J�d�ߤ����u��� :</font></td>
<td><input type="text" size="10" maxlength="10" name="search7" align=right class=dataListEntry value="<%=Sdate%>" readonly> 
    <input type="button" id="B1" name="B1" height=100% width=100% style="Z-INDEX: 1" value="....">
    �� 
   <input type="text" size="10" maxlength="10" name="search8" align=right class=dataListEntry value="<%=Edate%>" readonly>
   <input type="button" id="B2" name="B2" height=100% width=100% style="Z-INDEX: 1" value="....">
</td></tr>
</table> 
<p><font face="�з���">�� <INPUT TYPE="button" VALUE="�d��" ID="cmdSure"   
 style="font-family: �з���; color: #FF0000;cursor:hand">  
 �t�αN�̱z������~���ҰϡA�H�ҰϡB�����O�B�~�ȭ��i�}�}�o�ƶq���ϯä��R�Ϫ�C</font></p> 
<p><font face="�з���">�z�i�̧Ʊ�i�{�����פδ��q��(�����B�~�ȭ��E�E�E��)�A�ϥηƹ��A�Ѹ�ƲM��N���Ԧܼϯä��R��������m�C</font></p> 
<p>�@</p> 
</BODY> 
</HTML>