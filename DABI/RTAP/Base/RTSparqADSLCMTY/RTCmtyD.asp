<%  
  Dim fieldRole,fieldPa
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
%>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzDataList.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=1
  title="�t��ADSL���ϤΫȤ��ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CUTYID, COMN, HBNO, CMTYTEL, IPADDR, EQUIPADDR, TELEADDR, " _
			&"SETUPADDR, BUSSID, AREAID, GROUPID, SURVYDAT, RCVD, CASESNDWRK, " _
			&"EQUIPARRIVE, SETENGINEER, SNDWRKPLACE, LINEARRIVE, ADSLAPPLY, " _
			&"REMARK, WORKPLACE, STOCKID, BRANCH, BUSSMAN, EUSR, EDAT, UUSR, " _
			&"UDAT, AGREE, RCOMDROP, DROPREASON, COMCNT, COMBUILDING, " _
			&"COMPOWER, SETUPCONTACT, COMAGREE, AGREENO, CONTRACT, " _
			&"CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, REMITAGREE, " _
			&"REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, " _
			&"COPYREMIT, NOTATION, CONSIGNEE, HOUSETYPE, CTYCONTACT, " _
			&"CTYCONTACTTEL, CONNECTTYPE, CUTID, TOWNSHIP, ADDR, LINERATE, " _
			&"COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC, DEVELOPERID, CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
			&"FROM RTSparqAdslCmty WHERE cutyid=0 "
  sqlList="SELECT CUTYID, COMN, HBNO, CMTYTEL, IPADDR, EQUIPADDR, TELEADDR, " _
			&"SETUPADDR, BUSSID, AREAID, GROUPID, SURVYDAT, RCVD, CASESNDWRK, " _
			&"EQUIPARRIVE, SETENGINEER, SNDWRKPLACE, LINEARRIVE, ADSLAPPLY, " _
			&"REMARK, WORKPLACE, STOCKID, BRANCH, BUSSMAN, EUSR, EDAT, UUSR, " _
			&"UDAT, AGREE, RCOMDROP, DROPREASON, COMCNT, COMBUILDING, " _
			&"COMPOWER, SETUPCONTACT, COMAGREE, AGREENO, CONTRACT, " _
			&"CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, REMITAGREE, " _
			&"REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, " _
			&"COPYREMIT, NOTATION, CONSIGNEE, HOUSETYPE, CTYCONTACT, " _
			&"CTYCONTACTTEL, CONNECTTYPE, CUTID, TOWNSHIP, ADDR, LINERATE, " _
			&"COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC, DEVELOPERID, CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
			&"FROM RTSparqAdslCmty WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=2
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(trim(dspkey(31)))= 0 then dspkey(31)=0
    if len(trim(dspkey(32)))= 0 then dspkey(32)=0
    '�]�Ʀa�}(����)
    if len(trim(dspkey(5)))= 0 then dspkey(5)=""
    '�~�ȲէO(����)
    if len(trim(dspkey(10)))= 0 then dspkey(10)=""
    '��Ӭ���
    if len(trim(dspkey(22)))= 0 then dspkey(22)=""
    if len(trim(dspkey(23)))= 0 then dspkey(23)=""
    '�ظm�p���H(����)
    if len(trim(dspkey(34)))= 0 then dspkey(34)=""
	'HBNO
    if len(trim(dspkey(2)))= 0 then dspkey(2)=""
    '�O�_�w�ɳt��499
    if len(trim(dspkey(21)))= 0 then dspkey(21)=""
    
    If len(dspKey(0)) <= 0 Then
       dspkey(0)=0
    End If
    if len(dspkey(1)) < 1 Then
       formValid=False
       message="�п�J���ϦW��"
    ELSEIF len(dspkey(12)) < 1 Then
       formValid=False
       message="�п�J�D�u�ӽФ�"
    ELSEIF len(dspkey(54)) < 1 Then
       formValid=False
       message="�п�J�D�u�s���覡"
    ELSEIF len(dspkey(58)) < 1 Then
       formValid=False
       message="�п�J�D�u�t�v"
    end if    
    if dspkey(28) <> "Y" and dspkey(28) <> "N" then
       dspkey(28)=""
    end if
'---�ˬd �������X�O�_������ dspkey(3)---------
    if len(trim(dspkey(3))) > 0 then
       IF LEN(TRIM(dspkey(0))) > 0 THEN
          Set connxx=Server.CreateObject("ADODB.Connection")  
          Set rsxx=Server.CreateObject("ADODB.Recordset")
          DSNXX="DSN=RTLIB"
          connxx.Open DSNxx

	     if LEN(TRIM(DSPKEY(0))) =0 then
	        DSPKEY(0) =0
	     end if   
         sqlXX="SELECT count(*) AS CNT FROM RTsparqAdslcmty where CMTYTEL='" & dspkey(3) & "' and not (cutyid=" & dspkey(0) & ")"
         rsxx.Open sqlxx,connxx
         s=""
         If RSXX("CNT") > 0 Then
            message="�D�u�����q�ܸ��X�w�s�bADSL�䥦���ϡA���i���ƿ�J!"
            formvalid=false
         End If
         rsxx.Close
         Set rsxx=Nothing
         connxx.Close
         Set connxx=Nothing    
       end IF  
    end if  
    'ADSL����default="N"...HB==>DEFAULT="Y"
    if len(trim(dspkey(35)))=0 then dspkey(35)=""
    if len(trim(dspkey(37)))=0 then dspkey(37)=""
    if len(trim(dspkey(42)))=0 then dspkey(42)=""    
    if trim(dspkey(35))<>"Y" then
       dspkey(36)=""
    end if
    if trim(dspkey(37))<>"Y" then
       dspkey(38)=""
    end if     
    if trim(dspkey(42))<>"Y" then
       dspkey(43)=""
    end if         
   
    '---�Y�X���s�����ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�P�N�ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�P�N�ѽs������X���s��
    if trim(dspkey(35))="Y" and len(trim(dspkey(36)))=0 and trim(dspkey(37))="Y" and len(trim(dspkey(38))) > 0 then
       dspkey(36)="AA" & mid(dspkey(38),3,5)
    elseif trim(dspkey(35))="Y" and len(trim(dspkey(36)))=0 and trim(dspkey(42))="Y" and len(trim(dspkey(43))) > 0 then
       dspkey(36)="AA" & mid(dspkey(43),3,5)
    end if
    '---�Y�P�N�ѽs�����ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�X���ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�X���ѽs������P�N�ѽs��    
    if trim(dspkey(37))="Y" and len(trim(dspkey(38)))=0 and trim(dspkey(35))="Y" and len(trim(dspkey(36))) > 0 then
       dspkey(38)="AB" & mid(dspkey(36),3,5)
    elseif trim(dspkey(37))="Y" and len(trim(dspkey(38)))=0 and trim(dspkey(42))="Y" and len(trim(dspkey(43))) > 0 then
       dspkey(38)="AB" & mid(dspkey(43),3,5)       
    end if
    '---�Y�״ڦP�N�ѽs�����ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�X���ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�X���ѽs������P�N�ѽs��    
    if trim(dspkey(42))="Y" and len(trim(dspkey(43)))=0 and trim(dspkey(35))="Y" and len(trim(dspkey(36))) > 0 then
       dspkey(43)="AC" & mid(dspkey(36),3,5)
    elseif trim(dspkey(42))="Y" and len(trim(dspkey(43)))=0 and trim(dspkey(37))="Y" and len(trim(dspkey(38))) > 0 then
       dspkey(43)="AC" & mid(dspkey(38),3,5)              
    end if   
    
    '
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveXScript()%>
   <SCRIPT Language="VBScript">
   Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
   END SUB
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
          '��B�z�H���γB�z�t�ӬҬ��ťծɡA�~�i�M���������
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
   Sub Srsalesonclick()
       prog="RTGetsalesD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE & ";"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key8").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub            
   'Sub SrWorkmanonclick()
   '    prog="RTGetworkmanD.asp"
   '    prog=prog & "?KEY=" & document.all("KEY9").VALUE & ";"
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key15").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub  
   Sub Srcounty3onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY55").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key56").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub
   Sub Srcounty4onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY67").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key68").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY65").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key65").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub
   Sub SrBankOnClick()
       prog="RTGetBank.asp"
       prog=prog & "?KEY=" & document.all("KEY44").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key44").value =  trim(Fusrid(0))
       End if
       end if
   End Sub
   Sub SrBankBranchOnClick()
       prog="RTGetBankBranch.asp"
       prog=prog & "?KEY=" & document.all("KEY44").VALUE & ";"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
			FUsrID=Split(Fusr,";")   
			if Fusrid(2) ="Y" then
				document.all("key45").value =  trim(Fusrid(0))
				'document.all("key57").value =  trim(Fusrid(1))
			End if       
       end if
   End Sub
   Sub checkbox21onclick()
		if document.all("KEY21").checked = true then
			document.all("KEY21").VALUE = "Y"
		else
			document.all("KEY21").VALUE = ""
		end if
   End sub
   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"   codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 >
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()%>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="20%" class=dataListHead>���ϧǸ�</td><td width="80%"  bgcolor="silver">
           <input type="text" name="key0"
                 <%=fieldRole(1)%> readonly size="20" value="<%=dspKey(0)%>" maxlength="8" class=dataListEntry></td></tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(24))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                dspkey(24)=V(0)
        End if  
       dspkey(25)=now()
    else
        if len(trim(dspkey(26))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                DSpkey(26)=V(0)
        End if         
        dspkey(27)=now()
    end if      
' -------------------------------------------------------------------------------------------- 
 '   If IsDate(dspKey(26)) Then
 '      fieldPa=" class=""dataListData"" readonly "
 '   Else
 '      fieldPa=""
 '   End If
    Dim conn,rs,s,sx,sql,t
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN
	%>
                                                            
<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table6">
	<tr><td bgcolor="BDB76B" align="center">�򥻸��</td></tr>
</table>

<table width="100%" border=1 cellPadding=0 cellSpacing=0>

<tr><td width="20%" class=dataListHead>���ϦW��</td>
    <td width="30%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="50"
               value="<%=dspKey(1)%>" size="40" class=dataListEntry></td>
    <td width="20%" class=dataListSearch>�w�ɳt���t��499����</td>
    <td width="30%" bgcolor="silver">
		<%if DSPKEY(21)="Y" THEN checked21=" checked " else checked21="" %>             
		<input type=checkbox name="key21" value="<%=dspKey(21)%>" <%=checked21%> onclick="checkbox21onclick()"
               <%=fieldRole(1)%> <%=dataProtect%> class=dataListEntry><FONT size=2> �Ŀ��w�ɳt</FONT>
	</td>
</tr>

<td class=dataListSearch>�s���覡</td>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G5' " 
       If len(trim(dspkey(54))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='G5' AND CODE='" & dspkey(54) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(54) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>
    <td bgcolor="silver">
   <select size="1" name="key54" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select2">
        <%=s%>
   </select>
   </td>

        <td class="dataListHead" height="23">���Ϲq��</td>                                 
        <td height="23" bgcolor="silver" >
       <% aryOption=Array("","110V","220V")
          s=""
          If Len(Trim(fieldRole(1) &dataProtect)) < 1  Then 
             For i = 0 To Ubound(aryOption)
                If dspKey(33)=aryOption(i) Then
                   sx=" selected "
                Else
                   sx=""
                End If
                s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
             Next
           Else
             s="<option value=""" &dspKey(33) &""">" &dspKey(33) &"</option>"
           End If%>               
   <select size="1" name="key33" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">                                            
        <%=s%>
   </select>
   </td>
</tr>

<tr><td class=dataListHead>CHT��B�B</td>
    <td  bgcolor="silver"><input  type="text" name="key20" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(20)%>"   class="dataListEntry">
	</TD>

    <td  class="dataListHead" height="21">��v����</td>                                    
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' " 
       If len(trim(dspkey(51))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='C2' AND CODE='" & dspkey(51) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(51) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>
        <td height="21" bgcolor="silver">
   <select size="1" name="key51" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select1">                                                                  
        <%=s%>
   </select><font size=2>
   </td>                    
</tr>   

<tr>                                 
        <td  class="dataListHead" height="23">���ϳW�Ҥ��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key31" size="15" value="<%=dspKey(31)%>"  <%=fieldRole(1)%> class="dataListEntry"></td>
        <td  class="dataListHead" height="23">���ϴɼ�</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key32" size="15" value="<%=dspKey(32)%>"  <%=fieldRole(1)%> class="dataListEntry"></td>                                 
</tr>

<tr>                                 
        <td  class="dataListHead" height="23">���ϳs���H</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key52" size="30" value="<%=dspKey(52)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text2"></td>                                 
        <td  class="dataListHead" height="23">���ϳs���q��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key53" size="30" value="<%=dspKey(53)%>"  <%=fieldRole(1)%> class="dataListEntry" ID="Text3"></td>                                 
</tr>           

<tr><td class=dataListHead>�O�_�i�ظm</td>
    <td  bgcolor="silver" colspan=3>
      <%  dim rdo1, rdo2
              If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
                 rdo1=""
                 rdo2=""
              Else
                 rdo1=" disabled "
                 rdo2=" disabled "
              End If
             ' If Trim(dspKey(84))="" Then dspKey()="Y"
              If trim(dspKey(28))="Y" Then 
                 rdo1=" checked "    
              elseIf trim(dspKey(28))="N" Then 
                 rdo2=" checked " 
              elseif trim(dspkey(28))="" then
                 dspkey(28)=""                 
              end if
             %>
        <input type="radio" value="Y" <%=rdo1%> name="key28" <%=fieldRole(1)%><%=dataProtect%> ID="Radio1"><font size=2>�i�ظm
        <input type="radio" value="N" <%=rdo2%>  name="key28" <%=fieldRole(1)%><%=dataProtect%> ID="Radio2"><font size=2>�L�k�ظm, ��]�G
    	<input type="text" name="key19" maxlength="80" value="<%=dspKey(19)%>" size="60" class=dataListEntry  <%=fieldRole(1)%><%=dataProtect%> ></td>
	</TD>
</tr>

<tr><td class=dataListhead>���Ϧa�}</td>
<%
	s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(55))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty3onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(55) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(55) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
    <td colspan="3" bgcolor="silver">
		<select size="1" name="key55"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        <input type="text" name="key56" size="8" value="<%=dspkey(56)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m��)
		<input type="button" id="B3" name="B3" width="100%" style="Z-INDEX: 1" value="..." <%=SXX3%> >        
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C3"  name="C3" style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >          
        <input type="text" name="key57" size="55" value="<%=dspkey(57)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
	</td>
</tr>

<tr><td class=dataListHead>�q�H�Ǧ�m</td> 
    <td colspan="3" bgcolor="silver"> 
        <input type="text" name="key6" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="60" maxlength="60" 
               value="<%=dspKey(6)%>"   class="dataListEntry">
               </td>
</tr>   
<tr><td class=dataListHead>�i�Ѹ˽d��</td> 
    <td COLSPAN="3" bgcolor="silver"><input type="text" name="key7" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="150"
               value="<%=dspKey(7)%>" size="90" class=dataListEntry></td>
</tr>

<tr><td class=dataListHead>�Ƶ�</td> 
	<TD COLSPAN="3" bgcolor ="silver">
		<TEXTAREA  cols="100%"  name="key49" rows=5  MAXLENGTH=500  class="dataListentry"  <%=dataprotect%> value="<%=dspkey(49)%>" ID="Textarea1"><%=dspkey(49)%></TEXTAREA>
   </td>
</tr>

<tr><td class="dataListHead" height="23">���ɤH��</td>
	<td height="23" bgcolor="silver">
		<input type="text" name="key24" size="7" value="<%=dspKey(24)%>" readonly class="dataListData">
		<font size=2><%=SrGetEmployeeName(dspKey(24))%></font>
	</td>
	<td class="dataListHead" height="23">���ɤ��</td>
	<td height="23" bgcolor="silver">
		<input type="text" name="key25" size="25" value="<%=dspKey(25)%>" readonly class="dataListData">
	</td>
</tr>

<tr><td class="dataListHead" height="23">���ʤH��</td>
	<td height="23" bgcolor="silver">
		<input type="text" name="key26" size="7" value="<%=dspKey(26)%>" readonly class="dataListData">
		<font size=2><%=SrGetEmployeeName(dspKey(26))%></font>
	</td>
	<td class="dataListHead" height="23">���ʤ��</td>
	<td height="23" bgcolor="silver">
       	<input type="text" name="key27" size="25" value="<%=dspKey(27)%>" readonly class="dataListData">
	</td>
</tr>
</table> 

<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table5">
	<tr><td bgcolor="BDB76B" align="center">�Z���k��</td></tr>
</table>

<table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
<tr><td width="20%" class=dataListHead>�~���Ұ�</td> 
	<%
	If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then 
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '3') "
       s="<option value="""" >(�~���Ұ�)</option>"
    Else
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '3') "
       s="<option value="""" >(�~���Ұ�)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�~���Ұ�)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("areaid")=dspkey(9) Then sx=" selected "
       s=s &"<option value=""" &rs("areaid") &"""" &sx &">" &rs("areanc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
    %>    
    <td bgcolor="silver" colspan=3>
		<select size="1" name="key9" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry">                                            
			<%=s%>
		</select>

    	<input type="TEXT" name="key8" value="<%=dspKey(8)%>" size="6" readonly class="dataListEntry" <%=fieldRole(1)%> <%=dataProtect%> >
		<input type="BUTTON" id="B8" name="B8" style="Z-INDEX: 1"  value="...." onclick="Srsalesonclick()"  >
		<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C8" name="C8" onclick="SrClear" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" <%=fieldpb%> >
		<font size=2><%=SrGetEmployeeName(dspKey(8))%></font>

	</td>
</tr>

<tr><td width="20%" class=dataListHEAD>�g�P��</td>
    <td width="30%" bgcolor="silver">
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then 
	   sql=	"select c.cusid, c.shortnc " &_
			"from RTConsignee a " &_
			"inner join RTConsigneeCASE b on a.CUSID = b.CUSID " &_
			"inner join RTObj c on c.cusid = a.cusid " &_
			"where	b.caseid ='00' order by c.shortnc " 
       s="<option value="""" >(�g�P��)</option>"
    Else
	   sql=	"select c.cusid, c.shortnc " &_
			"from RTConsignee a " &_
			"inner join RTObj c on c.cusid = a.cusid " &_
			"where	c.cusid='" & dspkey(50) & "' "
		s =""
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�g�P��)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CUSID")=dspkey(50) Then sx=" selected "
       s=s &"<option value=""" &rs("CUSID") &"""" &sx &">" &rs("SHORTNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>
           <select size="1" name="key50" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry">                                            
              <%=s%>
           </select></td>

	<td width="20%" class="dataListHEAD" height="23">�G�u�t�d�H</td>
	<td width="30%" bgcolor="silver"><input type="text" name="key65"value="<%=dspKey(65)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text36">
			<input type="BUTTON" id="B65" name="B65" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C65" name="C65" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=SrGetEmployeeName(dspKey(65))%></font>
	</td>
</tr>

</table>


    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
       <tr><td bgcolor="BDB76B" align="center">������T</td></tr></table>
       <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
       <tr><td class=dataListsearch>�D�u�����q�ܸ��X</td>
    <td bgcolor="silver">
<%
'�ˬd�ӥD�u�����q�ܸ��X�O�_���Τ�B�w�����L(�t�h��),�Y�s�b�ɫh�����protect
sql="SELECT COUNT(*) AS cnt FROM RTSparqAdslCust WHERE (EXTTEL = '" & dspkey(3) & "') AND EXTTEL<>''"
rs.Open sql,conn
on error resume next
If rs("CNT") > 0 Then
   Protect03=" class=datalistdata readonly "
else
   Protect03=" class=datalistentry "
end if
rs.close
%>    
        <input type="text" name="key3" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(3)%>" size="15" <%=Protect03%> ID="Text7" </td>

    <td class=dataListHead>IP��}</td>
    <td bgcolor="silver">
        <input type="text" name="key4" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="19"
               value="<%=dspKey(4)%>" size="22" class=dataListEntry></td>
</tr>  
<tr>
<td   class="dataListHEAD" height="23">�D�u�W�e</td>               
        <td   height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' " 
       If len(trim(dspkey(58))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' AND CODE='" & dspkey(58) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(58) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key58" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">                                                                  
        <%=s%>
   </select>
        </td>
        <td class="dataListHEAD" height="23">����Reset�覡</td>               
        <td height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' " 
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' AND CODE='" & dspkey(63) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(63) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key63" <%=fieldpg%><%=fieldpa%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%>
   </select></td>          
        </tr>
          <tr>
         <td  height="23" class="dataListHead">Reset�Ƶ�</td>                     
           <td  height="23" bgcolor="silver" colspan=3>
               <input  class="dataListENTRY" type="text" size="100" maxlength="100" name="key64" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(64)%>" ID="Text12"></td>
        </tr>                
       <tr>
           <td width="20%" height="23" class="dataListHead" >COT PORT</td>                     
           <td width="30%" height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key59" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(59)%>" ID="Text6">
            </td>                              
           <td width="20%" height="23" class="dataListHead" >����PORT��</td>                     
           <td width="30%" height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key60" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(60)%>" ID="Text9"></td>          
          </TR>
          <tr>
           <td  height="23" class="dataListHead" >MDF1</td>                     
           <td  height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key61" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(61)%>" ID="Text10">
              </td>                              
           <td  height="23" class="dataListHead" >MDF2</td>                     
           <td  height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text" size="10" maxlength="10" name="key62" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(62)%>" ID="Text11"></td>          
        </tr>                
       </table>           
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="BDB76B" align="center">�I�u�i�ת��p</td></tr></table>
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >

      <tr><td width="20%" class="dataListHead">�ɹ���</td>
          <td width="30%" bgcolor="silver"><input type="text" name="key11" size="15" READONLY value="<%=dspKey(11)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input type="button" id="B11"  name="B11" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C11"  name="C11"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
          <td width="20%" class="dataListHead">�u���ӽФ�</td>
          <td width="30%" bgcolor="silver"><input type="text" name="key12" size="15" READONLY value="<%=dspKey(12)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B12"  name="B12" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C12"  name="C121"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td></tr>
      <tr><td  class="dataListHead">���d���u��</td>
          <td bgcolor="silver"><input type="text" name="key13" size="15" READONLY value="<%=dspKey(13)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListDATA">
          <!--
                           <input type="button" id="B13"  name="B13" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C13"  name="C13"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
                           -->
                           </td>
          <td  class="dataListHead">�]�ƨ���</td>
          <td  bgcolor="silver"><input type="text" name="key14" size="15" READONLY value="<%=dspKey(14)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="30" class="dataListDATA">
                           <!--
                            <input type="button" id="B14"  name="B14" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                            <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
                            -->
                            </td></tr>
      <tr><td  class="dataListHead">�w�ˤu�{�v</td>
          <td  bgcolor="silver">
          <input type="text" name="key15" size="6" value="<%=dspKey(15)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListDATA" >
		  <font size=2><%=SrGetEmployeeName(dspKey(15))%></font>
          <!--
            <input type="button" id="B15"  name="B15"   width="100%" style="Z-INDEX: 1"  value="...." onclick="Srworkmanonclick()"  >                  
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C15"  name="C15"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
          -->
           </td>
          <td  class="dataListHead">����B�B��</td>
          <td bgcolor="silver"><input type="text" name="key16" size="15" READONLY value="<%=dspKey(16)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B16"  name="B16" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C16"  name="C16"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td></tr>
      <tr>
          <td  class="dataListHead">�u������</td>
          <td  bgcolor="silver"><input   type="text" name="key17" size="15" READONLY value="<%=dspKey(17)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input  type="button" id="B17"  name="B17" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG style="display:none"  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C17"  name="C17"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
          <td  class="dataListHead">���q���</td>
          <td bgcolor="silver"><input type="text" name="key18" size="15" READONLY value="<%=dspKey(18)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListDATA" >
                          </td>
      <TR>
      <td class="dataListHead">�h��(�M�P)��</td>
          <td  colspan="5" bgcolor="silver"><input type="text" name="key29" size="15" READONLY value="<%=dspKey(29)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                          <input type="button" id="B29"  name="B29" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
                          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C29"  name="C29"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>                           
      </TR>
      <tr>
          <td  class="dataListHead">�h��(�M�P)��]</td>
          <td  COLSPAN="3" bgcolor="silver"><input type="text" name="key30" size="90" value="<%=dspKey(30)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="120" class="dataListEntry" ></td>
      </tr>
    </table> 

        <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table1">
       <tr><td bgcolor="BDB76B" align="center">�X�����p</td></tr></table>
       <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
       <tr>
           <td width="20%" height="23" class="dataListHead" >�ظm�P�N��</td>
           <td width="30%" height="23" bgcolor="silver">
            <% 
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo1=""
                 rdo2=""
              Else
                 rdo1=" disabled "
                 rdo2=" disabled "
              End If
  
                If trim(dspKey(35))="Y" Then rdo1=" checked "    
                If trim(dspKey(35))="N" Then rdo2=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO1%> name="key35" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio3"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO2%> name="key35" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio4"><font size=2>�K</font>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(40))) < 1 Then
          sx=" selected " 
            s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(40) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(40) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="key40" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select3">
                    <%=S%>
               </select>
               </td>                              
           <td width="20%" height="23" class="dataListHead" >�P�N�ѽs��</td>                     
           <td width="30%" height="23" bgcolor="silver">
               <input  class="dataListdata" readonly type="text"  size="7" maxlength="7" name="key36" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(36)%>" ID="Text4">
		   </td>
		 </tr>
		 <tr>
           <td height="23" class="dataListHead" >�X�@���w��</td>                     
           <td height="23" bgcolor="silver">
            <%  
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo3=""
                 rdo4=""
              Else
                 rdo3=" disabled "
                 rdo4=" disabled "
              End If

                If trim(dspKey(37))="Y" Then rdo3=" checked "    
                If trim(dspKey(37))="N" Then rdo4=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO3%> name="key37" <%=fieldRole(4)%><%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio5"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO4%> name="key37" <%=fieldRole(4)%><%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio6"><font size=2>�L</font>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(41))) < 1 Then
          sx=" selected " 
             s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(41) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(41) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="key41" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select4">
                    <%=S%>
               </select>               
               </td>                              
           <td height="23" class="dataListHead" >�X���s��</td>                     
           <td height="23" bgcolor="silver">
               <input  class="dataListdata" readonly type="text" size="7" maxlength="7" name="key38" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(38)%>" ID="Text5"></td>          
       
        </tr>                
       </table>

    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr><td bgcolor="BDB76B" align="center">���q�ɧU�״ڸ�T</td></tr></table>

       <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr><td width="20%" height="23" class="dataListHead" >���q�ɧU�P�N��</td>
           <td width="30%"  height="23" bgcolor="silver">
			<%
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo5=""
                 rdo6=""
              Else
                 rdo5=" disabled "
                 rdo6=" disabled "
              End If
  
                If trim(dspKey(42))="Y" Then rdo5=" checked "    
                If trim(dspKey(42))="N" Then rdo6=" checked "
			%>
			<input type="radio" value="Y" <%=RDO5%> name="key42" <%=fieldpg%><%=fieldpa%><%=dataProtec%>><font size=2>��</font>
			<input type="radio" value="N" <%=RDO6%> name="key42" <%=fieldpg%><%=fieldpa%><%=dataProtect%>><font size=2>�L</font>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(48))) < 1 Then
          sx=" selected " 
            s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(48) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(48) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
               <select name="key48" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry">
                    <%=S%>
               </select>
               </td>
           <td width="20%" height="23" class="dataListHead">�P�N�ѽs��</td>
           <td width="30%" height="23" bgcolor="silver">
               <input class="dataListEntry" type="text"  size="10" maxlength="7" name="key43" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(43)%>"></td>
        </tr>

      <tr><td class="dataListHead">�״ڻȦ�</td>
          <td bgcolor="silver">
			<%
				name=""
				if dspkey(44) <> "" then
					sqlxx=" select headnc from rtbank where headno='" & dspkey(44) & "' order by headnc "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(�Ȧ�W��)"
					else
						name=rs("headnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="key44"value="<%=dspKey(44)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="3" maxlength="3" readonly class="dataListDATA">
			<input type="BUTTON" id="B44" name="B44" style="Z-INDEX: 1"  value="...." onclick="SrBankOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C44" name="C44" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>

			<td class="dataListHead">����W��</td>
			<td bgcolor="silver">
			<%
				name=""
				if dspkey(45) <> "" then
					sqlxx=" select branchnc from rtbankbranch where headno='" & dspkey(44) & "' and branchno='" & dspkey(45) & "' "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(����W��)"
					else
						name=rs("branchnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="key45"value="<%=dspKey(45)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="5" maxlength="4" readonly class="dataListDATA">
			<input type="BUTTON" id="B45" name="B45" style="Z-INDEX: 1"  value="...." onclick="SrBankBranchOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C45" name="C45" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>
      </tr>
      <tr>
          <td class="dataListHead">�״ڱb��</td>
          <td bgcolor="silver"><input type="text" name="key46" size="15" value="<%=dspkey(46)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="15" class="dataListEntry"></td>
      	  <td class="dataListHead">�״ڤ�W</td>
          <td bgcolor="silver"><input type="text" name="key47" size="35" value="<%=dspKey(47)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </TR>
      <tr>
          <td class="dataListHead">�䲼���Y</td>
          <td bgcolor="silver" colspan=3><input type="text" name="key66" size="100" value="<%=dspkey(66)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="100" class="dataListEntry"></td>
      </TR>

<%
	s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(67))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty4onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(67) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(67) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
	<tr><td class=dataListhead>�䲼�H�e�a�}</td>
    	<td colspan="3" bgcolor="silver">
			<select size="1" name="key67"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        	<input type="text" name="key68" size="8" value="<%=dspkey(68)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m��)
			<input type="button" id="B68" name="B68" width="100%" style="Z-INDEX: 1" value="..." <%=SXX3%> >
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C68" name="C68" style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        	<input type="text" name="key69" size="55" value="<%=dspkey(69)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>
	</tr>
              
	</table>
</td><td>&nbsp</td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>  
<% 
End Sub 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->
