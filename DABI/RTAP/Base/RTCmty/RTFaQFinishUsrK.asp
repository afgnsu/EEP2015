<%
parmKey=Request("Key")
aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
%>
<HTML>
<HEAD>
<META name=VI60_DTCScriptingPlatform content="Server (ASP)">
<META name=VI60_defaultClientScript content=VBScript>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
<TITLE>�w�����u��ܲM��</TITLE>
</HEAD>
<BODY style="BACKGROUND: lightblue">
<SCRIPT LANGUAGE="VBScript">
  Sub window_onload()
      k1=document.all("key1").value
      k2=document.all("key2").value
      prog="RTFaQFinishUsr.asp"
      'showopt="Y;Y;Y;Y"��ܹ�ܤ�����n��ܪ�����(�~�Ȥu�{�v;�ȪA�H��;�޳N��;�t��)
      showopt="Y;Y;Y;Y"
      prog=prog & "?showopt=" & showopt      
      FUsr=Window.showModalDialog(prog,"Dialog","dialogWidth:590px;dialogHeight:480px;")  
      'Fusrid(0)=���פH���u���μt�ӥN��  fusrid(1)=�u����W�@�e�����q�X����W��(�L�䥦�@��) fusrid(2)="1"���~��"2"���޳N"3"���t��"4"���ȪA(�@����Ʀs������줧�̾�)
      if Fusr <> "N" then
         FUsrID=Split(Fusr,";")      
         prog="RTFaQFinishK.asp?FUSR=" & Fusrid(0) & ";" & Fusrid(2) & "&key=" & k1 &";" & k2
         Window.Open prog
      End if
      Set winP=window.Opener
      Set docP=winP.document
      docP.all("keyform").Submit
      winP.focus()             
      window.close
  End Sub
</SCRIPT>
</BODY>
<input type=text name=key1 value="<%=aryparmkey(0)%>" style="display:none">
<input type=text name=key2 value="<%=aryparmkey(1)%>" style="display:none">
</HTML>
