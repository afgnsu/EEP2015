<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
%>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzDataList.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=2
  title="�ȶD�B�z���I����"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CASENO,entryno,logdate,logdesc,logusr,logfac,logdropdate,logdropusr,logusrrole " _
             &"FROM RTfaqD1 WHERE CASENO=0 "
  sqlList="SELECT CASENO,entryno,logdate,logdesc,logusr,logfac,logdropdate,logdropusr,logusrrole " _
         &"FROM RTfaqD1 WHERE  " 
  userDefineKey="Yes"
  userDefineData="Yes"
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(dspkey(1))=0 then
       dspkey(1)=0
    end if
    if len(dspkey(6))=0 then
       dspkey(6)=Null
    end if    
    if not Isdate(dspkey(2)) and len(dspkey(2)) > 0 then
       formValid=False
       message="�B�z������~"     
    elseif len(dspkey(2)) = 0 then
       formvalid=False
       message="�B�z������o�ť�"       
    elseif len(trim(dspkey(4))) > 0 and len(trim(dspkey(5))) > 0  then
       formValid=False
       message="�B�z�H���P�B�z�t�Ӥ��i�P�ɿ�J"           
    elseif len(trim(dspkey(4))) = 0 and len(trim(dspkey(5))) = 0  then
       formValid=False
       message="�B�z�H���P�B�z�t�Ӥ��i�P�ɪť�"                  
    elseif len(dspkey(3)) = 0 then
       formvalid=False
       message="�B�z���I���o�ť�"               
    end if

End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveXScript()%>
   <SCRIPT Language="VBScript">
   Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
       clickTD="TD" & clickid       
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(0)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
   End Sub 
   Sub SrSelonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
       prog="RTFaQFinishUsr.asp"
       'showopt="Y;Y;Y;Y"��ܹ�ܤ�����n��ܪ�����(�~�Ȥu�{�v;�ȪA�H��;�޳N��;�t��)
       if clickkey="KEY4" then
          showopt="Y;Y;Y;N"
       elseif clickkey="KEY5" then
          showopt="N;N;N;Y"
       else
          showopt="N;N;N;N"
       end if
       prog=prog & "?showopt=" & showopt
       FUsr=Window.showModalDialog(prog,"Dialog","dialogWidth:590px;dialogHeight:480px;")  
      'Fusrid(0)=���פH���u���μt�ӥN��  fusrid(1)=�u����W�@�e�����q�X����W��(�L�䥦�@��) fusrid(2)="1"���~��"2"���޳N"3"���t��"4"���ȪA(�@����Ʀs������줧�̾�)
       if Fusr <> "N" then
         '���M�����
         document.all("key4").value=""
         document.all("key5").value=""
         document.all("key8").value=""
         FUsrID=Split(Fusr,";")   
         '�t�Ө�8��,��l��6��   
         if Fusrid(2)="3"  then 
            document.all(clickkey).value =  left(Fusrid(0),8)
         else
            document.all(clickkey).value =  left(Fusrid(0),6)
         end if 
         document.all("key8").value= Fusrid(2)
       End if
    '   Set winP=window.Opener
    '   Set docP=winP.document
    '   docP.all("keyform").Submit
    '   winP.focus()             
    '   window.close
   End Sub    
   
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
          if len(trim(document.all("key4").value))=0 and len(trim(document.all("key5").value))=0 then
             document.all("key8").value= ""
          end if
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
   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"   codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()
 %>
      <table width="80%" border=1 cellPadding=0 cellSpacing=0>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" height="23"><font  color="#FFFFFF">�ץ�s��</font></td>
    <td width="26%" bgcolor="#c0c0c0" height="23"><!--webbot
      bot="Validation" B-Value-Required="TRUE" I-Minimum-Length="10"
      I-Maximum-Length="10" --><input name="key0" size="20" class="dataListdata" value="<%=dspkey(0)%>" maxlength="10" <%=keyprotect%> readonly></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" height="23"><font  color="#FFFFFF">����</font></td>
    <td width="25%" bgcolor="#c0c0c0" height="23">
    <input name="key1" size="1" class="dataListdata" <%=keyprotect%> readonly value="<%=dspkey(1)%>"></td>
  </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    If IsDate(dspKey(6)) or Ucase(trim(dataprotect))="READONLY" Then
       fieldPa=" class=""dataListData"" readonly "
       fieldpb=""
       fieldpc=""
       fieldpd=""
    Else
       fieldPa=""
       fieldpb=" onclick=""SrBtnOnClick"" "
       fieldpc=" onclick=""SrSelOnClick"" "       
       fieldpD=" onclick=""SrClear"" "              
    End If
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
 '--------------
 %>
<table border="1" width="100%" cellspacing="0" cellpadding="0" >
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead"><font  color="#FFFFFF">�B�z���</font></td>
    <td width="36%" bgcolor="#c0c0c0" ><input name="key2" <%=dataprotect%> size="20" <%=fieldpa%> class="dataListentry" value="<%=dspkey(2)%>" >
     <input type="button" id="B2"  name="B2"  width="100%" style="Z-INDEX: 1"  value="...."  <%=fieldpb%>> </td>
    <td width="15%" bgcolor="#006666" class="DataListHead"><font  color="#FFFFFF">�B�z�H��</font></td>
    <td width="35%" bgcolor="#c0c0c0" ><input name="key4"  <%=dataprotect%>  size="20"  <%=fieldpa%> class="dataListentry" value="<%=dspkey(4)%>" readonly>
     <input type="button" id="B4"  name="B4"  width="100%" style="Z-INDEX: 1"  value="...."  <%=fieldpc%>>
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C4"  name="C4"   style="Z-INDEX: 1"  <%=fieldpD%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >
               </td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead"><font  color="#FFFFFF">�B�z�t��</font></td>
    <td width="36%" bgcolor="#c0c0c0" id="TD5" ><input name="key5"  <%=dataprotect%> size="20"  maxlength="8" <%=fieldpa%>  class="dataListentry" value="<%=dspkey(5)%>" readonly>
     <input type="button" id="B5"  name="B5"  width="100%" style="Z-INDEX: 1"  value="...."  <%=fieldpc%>>
                    <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C5"  name="C5"   style="Z-INDEX: 1"  <%=fieldpD%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut">
                    </td>
    <td width="15%" bgcolor="#006666" class="DataListHead"><font  color="#FFFFFF">�B�z�H������</font></td>
    <td width="35%" bgcolor="#c0c0c0" ><input name="key8"  <%=dataprotect%>  size="20" maxlength="1"  <%=fieldpa%>  class="dataListdata" value="<%=dspkey(8)%>" readonly></td>
  </tr>
  <tr>
    <td width="14%" bgcolor="#006666" class="datalisthead" ><font color="#FFFFFF">�@�o���</font></td>
    <td width="36%" bgcolor="#c0c0c0" ><input name="key6" size="20"  <%=fieldpa%>  class="dataListdata" value="<%=dspkey(6)%>" readonly ></td>
    <td width="15%" bgcolor="#006666" class="DataListHead" ><font color="#FFFFFF">�@�o�H��</font></td>
    <td width="35%" bgcolor="#c0c0c0" ><input name="key7" size="20" class="dataListData" value="<%=dspkey(7)%>" readonly ></td>
  </tr>
  <tr>
    <td width="100%" colspan="4" bgcolor="#a4bcdb" height="11">
      <p align="center"><font  color="#000000" >�B�z���I</font></p>
    </td>
  </tr>
  <tr>
    <td width="100%" colspan="4" bgcolor="#c0c0c0"  height="117">
      <p align="center"><TEXTAREA cols="80%" name="key3" rows=20  <%=fieldpa%> class="dataListentry" value="<%=dspkey(3)%>"><%=dspkey(3)%></TEXTAREA></p><p>
    </td>
  </tr>
</table></center>
<% 
End Sub 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->