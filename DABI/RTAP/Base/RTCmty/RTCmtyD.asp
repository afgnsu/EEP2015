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
  title="���ϰ򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT COMQ1, COMQ2, COMN, WORKPLACE, CUTID, TOWNSHIP, ADDR, COMCNT, "_
			 &"PSDAT, CUSIP, SETIP, NETIP, SCHDAT, SURVYDAT, ASSESS, AGREE, "_
			 &"UNAGREEDESC, T1PETITION, RACKARRIVE, COTARRIVE, COTPOSITION, "_
			 &"T1ARRIVE, DSUARRIVE, ROUTERARRIVE, T1APPLY, RCOMDROP, FINISHPRTD, "_
			 &"FISNSHPRTUSR, PAYPRTD, PAYPRTSEQ, PAYPRTUSR, ACCOUNTCFM, "_
			 &"ACCOUNTUSR, ACTUALPAYD, INVOICE, DROPDESC, SCHDESC, EUSR, EDAT, "_
			 &"UUSR, UDAT, APPLYCNT, REQDAT, HBNO, COMTYPE, T1NO, HINET, "_
			 &"TELECOMTYPE, COTSETDAT, COTSETFAC, WORKD, COMAGREE, AGREENO, "_
			 &"CONTRACT, CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, "_
			 &"REMITAGREE, REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, "_
			 &"REMITNAME, COPYREMIT, CONNECTTYPE, HBNO2, POWERBILL, "_
			 &"SUBSIDYDAT, T1NO2, T1ATTACHTEL, CUSIP2, SETIP2, NETIP2, TECOMNOTE, "_
			 &"RESET, RESETDESC, NETIP3, PSDAT2, CUTID1, TOWNSHIP1, ADDR1, "_
			 &"DEVELOPERID, PSDAT3, FIBEROPENDAT, HBNO3, T1NO3, FIBERNETIP1, "_
			 &"FIBERNETIP2, FIBERGWIP, FIBEREQIP, PSDAT4, OPENDAT4, HBNO4, ATTACHTEL4, "_
			 &"LINERATE4, GATEWAYIP4, CUTID4, TOWNSHIP4, ADDR4, FIBERONLINE, LINERATE, PRETRANSCASE, "_
			 &"CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
			 &"FROM RTCmty WHERE Comq1=0 "
  sqlList    ="SELECT COMQ1, COMQ2, COMN, WORKPLACE, CUTID, TOWNSHIP, ADDR, COMCNT, "_
			 &"PSDAT, CUSIP, SETIP, NETIP, SCHDAT, SURVYDAT, ASSESS, AGREE, "_
			 &"UNAGREEDESC, T1PETITION, RACKARRIVE, COTARRIVE, COTPOSITION, "_
			 &"T1ARRIVE, DSUARRIVE, ROUTERARRIVE, T1APPLY, RCOMDROP, FINISHPRTD, "_
			 &"FISNSHPRTUSR, PAYPRTD, PAYPRTSEQ, PAYPRTUSR, ACCOUNTCFM, "_
			 &"ACCOUNTUSR, ACTUALPAYD, INVOICE, DROPDESC, SCHDESC, EUSR, EDAT, "_
			 &"UUSR, UDAT, APPLYCNT, REQDAT, HBNO, COMTYPE, T1NO, HINET, "_
			 &"TELECOMTYPE, COTSETDAT, COTSETFAC, WORKD, COMAGREE, AGREENO, "_
			 &"CONTRACT, CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, "_
			 &"REMITAGREE, REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, "_
			 &"REMITNAME, COPYREMIT, CONNECTTYPE, HBNO2, POWERBILL, "_
			 &"SUBSIDYDAT, T1NO2, T1ATTACHTEL, CUSIP2, SETIP2, NETIP2, TECOMNOTE, "_
			 &"RESET, RESETDESC, NETIP3, PSDAT2, CUTID1, TOWNSHIP1, ADDR1, "_
			 &"DEVELOPERID, PSDAT3, FIBEROPENDAT, HBNO3, T1NO3, FIBERNETIP1, "_
			 &"FIBERNETIP2, FIBERGWIP, FIBEREQIP, PSDAT4, OPENDAT4, HBNO4, ATTACHTEL4, "_
			 &"LINERATE4, GATEWAYIP4, CUTID4, TOWNSHIP4, ADDR4, FIBERONLINE, LINERATE, PRETRANSCASE, "_
			 &"CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
			 &"FROM RTCmty WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=2
  userDefineRead="Yes"
  userDefineSave="Yes"  
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    If len(dspKey(0)) <= 0 Then
       dspkey(0)=0
    End If
    If len(dspKey(1)) <= 0 Then
       dspkey(1)=0
    End If    
    if len(dspkey(7)) <= 0 then
       dspkey(7)=0
    end if
    if len(dspkey(41)) <= 0 then
       dspkey(41)=0
    end if        
    if len(dspkey(14)) <= 0 then
       dspkey(14)=0
    end if           
    if len(dspkey(67)) <= 0 then
       dspkey(67)=0
    end if
    If Not IsNumeric(dspKey(1)) and len(dspkey(1)) > 0 Then
       formValid=False
       message="�п�J���ϧǸ�"
    elseif len(dspkey(2)) < 1 Then
       formValid=False
       message="�п�J���ϦW��"       
       
    elseif Len(Trim(dspKey(4)))<1  Then
       formValid=False
       message="�п�J�����ζm��ϸ��"
    elseif (dspKey(65)="01" or dspKey(65)="04") and not IsDate(dspKey(8)) Then
       formValid=False
       message="�п�J�T�w��e����"
    elseif (dspKey(65)="02" or dspKey(65)="03") and Len(Trim(dspKey(78)))=0 and Len(Trim(dspKey(83)))=0 Then
       formValid=False
       message="�п�J�p�q��Υ��֨�e����"
    elseif dspKey(65)="05" and not IsDate(dspKey(91)) Then
       formValid=False
       message="�п�JADSL599�e����"
    elseif (dspKey(15)="N" OR dspKey(15)="H" ) And Len(Trim(dspKey(16)))<1 Then
       formValid=False
       message="�п�J�M�P(�Ƚw)����"
    elseif IsDate(dspKey(25)) And Len(Trim(dspKey(35)))<1 Then
       formValid=False
       message="�п�J�h������"
    elseif Not IsNumeric(dspkey(7)) and len(dspkey(7)) > 0 then
       formValid=False
       message="�����`��ƿ��~"    
    elseif not IsNumeric(dspkey(41)) and len(dspkey(41)) > 0 then
       formValid=False
       message="�Ӹ˼ƿ��~"    
    elseif not Isdate(dspkey(13)) and len(dspkey(13)) > 0 then
       formValid=False
       message="�ɬd������~"       
    elseif not IsNumeric(dspkey(14)) and len(dspkey(14)) > 0 then
       formValid=False
       message="�������B���~"             
    elseif not Isdate(dspkey(17)) and len(dspkey(17)) > 0 then
       formValid=False
       message="T1�ӽФ�����~"   
    elseif not Isdate(dspkey(18)) and len(dspkey(18)) > 0 then
       formValid=False
       message="RACK/���d��������~"       
    elseif not Isdate(dspkey(19)) and len(dspkey(19)) > 0 then
       formValid=False
       message="COT��������~"               
    elseif not Isdate(dspkey(21)) and len(dspkey(21)) > 0 then
       formValid=False
       message="T1��������~"               
    elseif not Isdate(dspkey(22)) and len(dspkey(22)) > 0 then
       formValid=False
       message="DSU��������~"              
    elseif not Isdate(dspkey(23)) and len(dspkey(23)) > 0 then
       formValid=False
       message="T1�}�q������~"      
    elseif not Isdate(dspkey(24)) and len(dspkey(24)) > 0 then
       formValid=False
       message="ROUTER��������~"     
    elseif not Isdate(dspkey(25)) and len(dspkey(25)) > 0 then
       formValid=False
       message="���ϰh��������~"            
    elseif len(dspkey(44)) < 1 Then
       formValid=False
       message="�п�J�������O"              
    elseif IsDate(dspKey(8)) Then
       dspKey(12)=DateAdd("d",45,dspKey(8))                                  
    end if
    '�s�����A�PHB���X�����Y�ˬd
 '   if dspkey(65)="01" then '�T�w��599
 '      if len(trim(dspkey(43))) = 0 then
 '         formValid=False
 '         message="�T�w��599������HB���X���i�ť�"        
 '      end if
 '   elseif dspkey(65)="02" then '�p�q��599
 '      if len(trim(dspkey(66))) = 0 then
 '         formValid=False
 '         message="�p�q�����HB���X���i�ť�"        
 '      end if    
 '   elseif dspkey(65)="03" then '�T�w��599+�p�q��599
 '      if len(trim(dspkey(43))) = 0 or len(trim(dspkey(66))) = 0then
 '         formValid=False
 '         message="�T�w��599������HB���X�έp�q�����HB���X�Ҥ��i�ť�"        
 '      end if
 '   end if
    'ADSL����default="N"...HB==>51DEFAULT="Y",53DEFAULT="N"
    if len(trim(dspkey(51)))=0 then dspkey(51)=""
    if len(trim(dspkey(53)))=0 then dspkey(53)=""
    if len(trim(dspkey(58)))=0 then dspkey(58)=""
    if len(trim(dspkey(100)))=0 then dspkey(100)=""
    if trim(dspkey(51))<>"Y" then
       dspkey(52)=""
    end if
    if trim(dspkey(53))<>"Y" then
       dspkey(54)=""
    end if     
    if trim(dspkey(58))<>"Y" then
       dspkey(59)=""
    end if        
    '---�Y�X���s�����ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�P�N�ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�P�N�ѽs������X���s��
    ',(��)�״ڦP�N�ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�P�N�ѽs������״ڽs��    
    if trim(dspkey(51))="Y" and len(trim(dspkey(52)))=0 and trim(dspkey(53))="Y" and len(trim(dspkey(54))) > 0 then
       dspkey(52)="BA" & mid(dspkey(54),3,5)
    elseif trim(dspkey(51))="Y" and len(trim(dspkey(52)))=0 and trim(dspkey(58))="Y" and len(trim(dspkey(59))) > 0 then
       dspkey(52)="BA" & mid(dspkey(59),3,5)
    end if    
    '---�Y�P�N�ѽs�����ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�X���ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�X���ѽs������P�N�ѽs��    
    if trim(dspkey(53))="Y" and len(trim(dspkey(54)))=0 and trim(dspkey(51))="Y" and len(trim(dspkey(52))) > 0 then
       dspkey(54)="BB" & mid(dspkey(52),3,5)
    elseif trim(dspkey(53))="Y" and len(trim(dspkey(54)))=0 and trim(dspkey(58))="Y" and len(trim(dspkey(59))) > 0 then
       dspkey(54)="BB" & mid(dspkey(59),3,5)   
    end if
    '---�Y(�״ڦP�N�ѽs��)���ȥB���Ѭ�"��"==>����e�w�s�b���X
    ',�B�X���ѽs�����ťեB�Хܬ�"��"==>��s�W���X,�h�ᤩ�X���ѽs������P�N�ѽs��    
    if trim(dspkey(58))="Y" and len(trim(dspkey(59)))=0 and trim(dspkey(51))="Y" and len(trim(dspkey(52))) > 0 then
       dspkey(59)="BC" & mid(dspkey(52),3,5)
    elseif trim(dspkey(58))="Y" and len(trim(dspkey(59)))=0 and trim(dspkey(53))="Y" and len(trim(dspkey(54))) > 0 then
       dspkey(59)="BC" & mid(dspkey(54),3,5)
    end if    
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
   End Sub 
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
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

   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY82").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key82").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub

   Sub Srcounty4onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY104").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key105").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub
   Sub SrBankOnClick()
       prog="RTGetBank.asp"
       prog=prog & "?KEY=" & document.all("KEY60").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key60").value =  trim(Fusrid(0))
       End if
       end if
   End Sub
   Sub SrBankBranchOnClick()
       prog="RTGetBankBranch.asp"
       prog=prog & "?KEY=" & document.all("KEY60").VALUE & ";"
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key61").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
       End if       
       end if
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
Sub SrGetUserDefineKey()%>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="20%" class=dataListHead>���ɬy����</td><td width="80%"  bgcolor="silver">
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
        if len(trim(dspkey(37))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(37)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(37))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(38)=datevalue(now())
    else
        if len(trim(dspkey(39))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(39)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(39))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(37))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(40)=datevalue(now())
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
    If IsDate(dspKey(26)) Then
       fieldPa=" class=""dataListData"" readonly "
    Else
       fieldPa=""
    End If
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸�� |</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''	   :tags2.classname='dataListTagsOn'">COT�o�]�w��</span> 
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>        

<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr><td width="20%" class=dataListHead>���ϧǸ�</td>
    <td width="25%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(1)%>" size="15" class=dataListEntry></td>
    <td width="20%" class=dataListHead>���ϦW��</td>
    <td width="35%" bgcolor="silver">
        <input type="text" name="key2" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(2)%>" size="25" class=dataListEntry></td></tr>

<tr><td class=dataListHead>��B�B</td>
    <td bgcolor="silver">
              <%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1    Then  
       sql="SELECT * FROM FTTBCHTSERVICEPOINT "
       If len(trim(dspkey(3))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(��B�B)</option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(��B�B)</option>"  
          sx=""
       end if     
    Else
       sql="SELECT * FROM FTTBCHTSERVICEPOINT WHERE CHTID='" & dspkey(3) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CHTID")=dspkey(3) Then sx=" selected "
       s=s &"<option value=""" &rs("CHTID") &"""" &sx &">" &rs("CHTNAME") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key3" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
        <%=s%>
   </select>
               </td>
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B3' " 
        '  Response.Write "SQL=" & SQL
       If len(trim(dspkey(44))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B3' AND CODE='" & dspkey(44) & "'"
       '   Response.Write "SQL=" & SQL
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(44) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>                  
    <td class=dataListHead>�������O</td><td>
    <select name="key44"  <%=fieldRole(1)%> <%=dataProtect%>  class=dataListEntry size="1" 
            style="text-align:left;" maxlength="2"><%=s%></select>       </td>
</tr>  

<tr><td class=dataListHead>���ϳW�Ҥ��</td>
    <td bgcolor="silver">
        <input type="text" name="key7" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(7)%>" size="15" class=dataListEntry></td>
    <td class=dataListHead>�Ӹ˼�</td>
    <td bgcolor="silver"><input type="text" name="key41" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="8"
               value="<%=dspKey(41)%>" size="15" class=dataListEntry>
                    </td></tr>  

<tr><td class=dataListHead>�s�����A</td> 
    <td bgcolor="silver">
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D2' " 
       If len(trim(dspkey(65))) < 1 Then
          sx=" selected " 
       '   s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
        '  s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D2' AND CODE='" & dspkey(65) & "'"
       '   Response.Write "SQL=" & SQL
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(65) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>                  
    <select name="key65"  <%=fieldRole(1)%> <%=dataProtect%>  class=dataListEntry size="1" 
            style="text-align:left;" maxlength="2" ID="Select1"><%=s%></select></td>
	<td WIDTH="15%" class="dataListHEAD" height="23">�G�u�t�d�H</td>
	<td width="35%"><input type="text" name="key82"value="<%=dspKey(82)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text36">
			<input type="BUTTON" id="B82" name="B82" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C82" name="C82" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=name%></font></td></tr>

<% IF DSPKEY(100)="Y" THEN CHECK100=" CHECKED "%>
<tr><td class=dataListHead>�w����</td> 
    <td><input type="checkbox" name="key100" <%=fieldRole(1)%><%=dataProtect%> value="Y" <%=CHECK100%> READONLY bgcolor="silver"></TD>
    
<td class="dataListHEAD" height="23">ADSL�D�u�W�e</td>
	<td height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then
       sql="SELECT CODE, CODENC FROM RTCODE WHERE KIND='D3' "
       If len(trim(dspkey(101))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"
          sx=""
       end if
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' AND CODE='" & dspkey(101) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(101) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key101" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
        <%=s%>
   </select>
</tr>

<tr><td class=dataListHead>�w�p������</td> 
	<td height="23" bgcolor="silver" colspan=3>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then
       sql="SELECT CODE, CODENC FROM RTCODE WHERE KIND='O8' "
       If len(trim(dspkey(102))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(�w�p������)</option>"
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(�w�p������)</option>"
          sx=""
       end if
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='O8' AND CODE='" & dspkey(102) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(102) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key102" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
        <%=s%>
   </select>
</tr>

<tr><td class=dataListHead>�]�Ʀa�}</td>
    <td colspan=3 bgcolor="silver">
<%  Call SrGetCountyTownShip(accessMode,sw,Len(Trim(fieldRole(1) &dataProtect)),dspKey(4),dspKey(5),s,t)%>
        <select name="key4" <%=fieldRole(1)%><%=dataProtect%> size="1" 
                onChange="SrRenew()"
               style="text-align:left;" maxlength="8" class=dataListEntry><%=s%></select>
        <select name="key5" <%=fieldRole(1)%><%=dataProtect%> size="1"  
               style="text-align:left;" maxlength="8" class=dataListEntry><%=t%></select> 
        <input type="text" name="key6" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="80" maxlength="60"
               value="<%=dspKey(6)%>" class=dataListEntry></td></tr>
               
<tr><td class=dataListHead>���Ϧa�}</td>
    <td colspan=3 bgcolor="silver">
<%  Call SrGetCountyTownShip(accessMode,sw,Len(Trim(fieldRole(1) &dataProtect)),dspKey(79),dspKey(80),s,t)%>
        <select name="key79" <%=fieldRole(1)%><%=dataProtect%> size="1" onChange="SrRenew()"
               style="text-align:left;" maxlength="8" class=dataListEntry><%=s%></select>
        <select name="key80" <%=fieldRole(1)%><%=dataProtect%> size="1"  
               style="text-align:left;" maxlength="8" class=dataListEntry><%=t%></select> 
        <input type="text" name="key81" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="80" maxlength="60"
               value="<%=dspKey(81)%>" class=dataListEntry></td></tr>

<tr><td class="dataListHEAD" height="23">����Reset�覡</td>
    <td height="23" bgcolor="silver" colspan=3>
	<%
		s=""
		sx=" selected "
		If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then  
	       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' " 
		Else
	       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' AND CODE='" & dspkey(75) & "'"
		End If
		rs.Open sql,conn
		Do While Not rs.Eof
	       If rs("CODE")=dspkey(75) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
		      rs.MoveNext
		sx=""
		Loop
		rs.Close%>         
	 <select size="1" name="key75" <%=fieldpg%><%=fieldpa%><%=dataProtect%> class="dataListEntry">
		    <%=s%>
	 </select>
	<font size =2 >�@Reset�Ƶ�</font>
		<input  class="dataListENTRY" type="text" size="85" maxlength="50" name="key76" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(76)%>"></td></tr>
<%
	name=""
	if dspkey(82) <> "" then
		sqlxx=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
			 &"where rtemployee.emply='" & dspkey(82) & "' "
		rs.Open sqlxx,conn
		if rs.eof then
			name="(��H�ɧ䤣�ӭ��u)"
		else
			name=rs("cusnc")
		end if
		rs.close
	end if
%>
<tr style="display:none" >                                 
        <td width="17%" class="dataListHead" height="23">��J�H��</td>                                 
        <td width="35%" height="23" bgcolor="silver"><input type="text" name="key37" size="15" value="<%=dspKey(37)%>" readonly class="dataListData"><%=EusrNC%></td>                                 
        <td width="10%" class="dataListHead" height="23">��J���</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key38" size="15" value="<%=dspKey(38)%>" readonly class="dataListData"></td>                                 
      </tr>                                 
      <tr style="display:none" >                                 
        <td width="17%" class="dataListHead" height="23">���ʤH��</td>                                 
        <td width="35%" height="23" bgcolor="silver"><input type="text" name="key39" size="15" value="<%=dspKey(39)%>" readonly class="dataListData"><%=UUsrNc%></td>                                 
        <td width="10%" class="dataListHead" height="23">���ʤ��</td>                                 
        <td width="40%" colspan="3" height="23" bgcolor="silver"><input type="text" name="key40" size="15" value="<%=dspKey(40)%>" readonly class="dataListData"></td>                                 
      </tr>      

	<tr><td  bgcolor="orange" colspan="4" align="center"><font color="black">�T�w��599���ϸ�T</font></td></tr>
	<tr><td class=dataListHead>�e����(�T�w��)</td> 
		<td bgcolor="silver"> 
			<input type="text" name="key8" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(8)%>"   class="dataListEntry" ID="Text4">
               <input type="button" id="B8" name="B8" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
		<td class=dataListHead>�����ADSL�����q��</td> 
    	<td  bgcolor="silver"><input type="text" name="key70" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(70)%>" size="15" class=dataListEntry></td></tr>
    
    <tr><td class=dataListHead>�T�w��HB���X</td>
    <td><input type="text" name="key43" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(43)%>" size="15" class=dataListEntry ID="Text2"></td>
	<td class=dataListHead>�T�w��q���s��</td> 
    <td  bgcolor="silver"><input type="text" name="key45" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(45)%>" size="15" class=dataListEntry ID="Text6"></td></tr>
               
       
      <tr><td width="21%" class="dataListHead">�Τ�IP</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key9" size="20" value="<%=dspKey(9)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td>
          <td width="22%" class="dataListHead">����IP</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key10" size="20" value="<%=dspKey(10)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td></tr>
      <tr><td width="21%" class="dataListHead">IP���q</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key11" size="20" value="<%=dspKey(11)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td>
          <td width="22%" class="dataListHead">COT IP(ATU-R IP)</td>
          <td width="31%" bgcolor="silver"><input type="text" name="ext0" size="20" value="<%=extdb(0)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td></tr>
          
       <tr><td  bgcolor="orange" colspan="4" align="center"><font color="black">�p�q��599���ϸ�T</font></td></tr>
    <tr><td class=dataListHead>�e����(�p�q��)</td>                
    <td bgcolor="silver"> 
        <input type="text" name="key78" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(78)%>"   class="dataListEntry" ID="Text5">
               <input type="button" id="B78" name="B78" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
               </td>
	    <td class=dataListHead>�p�q��D�u���q��</td>
		<td><input type="text" name="key46" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(46)%>"   class="dataListEntry" ID="Text1">
               <input type="button" id="B46"  name="B46" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>    

		<tr><td class=dataListHead>�p�q��HB���X</td>
			<td><input type="text" name="key66" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(66)%>" size="15" class=dataListEntry ID="Text3"></td>               
			<td class=dataListHead>�p�q��q���s��</td> 
			<td bgcolor="silver"><input type="text" name="key69" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(69)%>" size="15" class=dataListEntry ID="Text7"></td></tr>   

      <tr><td width="21%" class="dataListHead">�Τ�IP</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key71" size="20" value="<%=dspKey(71)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td>
          <td width="22%" class="dataListHead">����IP</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key72" size="20" value="<%=dspKey(72)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td></tr>
      <tr><td width="21%" class="dataListHead">IP���q1</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key73" size="20" value="<%=dspKey(73)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td>
          <td width="22%" class="dataListHead">ROUTER IP</td>
          <td width="31%" bgcolor="silver"><input type="text" name="ext1" size="20" value="<%=extdb(1)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td></tr>
      <tr><td width="22%" class="dataListHead">IP���q2</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key77" size="20" value="<%=dspKey(77)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="25" class="dataListEntry"</td></tr>
 
 	<tr><td bgcolor="orange" colspan="4" align="center"><font color="black">ADSL599���ϥD�u��T</font></td></tr>
    <tr><td class=dataListHead>�e����(ADSL)</td>                
		<td bgcolor="silver">
			<input type="text" name="key91" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="15" maxlength="10" 
				value="<%=dspKey(91)%>"   class="dataListEntry">
			<input type="button" id="B91" name="B91" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
	    <td class=dataListHead>�D�u���q��(ADSL)</td>
		<td><input type="text" name="key92" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="15" maxlength="10" 
				value="<%=dspKey(92)%>"   class="dataListEntry">
			<input type="button" id="B92"  name="B92" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>
	<tr><td class=dataListHead>HB���X(ADSL)</td>
		<td bgcolor="silver"><input type="text" name="key93" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" maxlength="10"
				value="<%=dspKey(93)%>" size="15" class=dataListEntry></td>
		<td class=dataListHead>�����q��(ADSL)</td> 
		<td bgcolor="silver"><input type="text" name="key94" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" maxlength="15"
			value="<%=dspKey(94)%>" size="15" class=dataListEntry></td></tr>
	<tr><td width="21%" class="dataListHead">�D�u�t�v(ADSL)</td>
		<% aryOption=Array("", "8M","12M")
   		s=""
   		If Len(Trim(fieldRole(1) &dataProtect)) < 1 Then
      		For i = 0 To Ubound(aryOption)
				If dspKey(95)=aryOption(i) Then
					sx=" selected "
				Else
             		sx=""
          		End If
				s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      		Next
   		Else
      		s="<option value=""" &dspKey(95) &""">" &dspKey(95) &"</option>"
   		End If%>
        <td  height="32" bgcolor="silver"><select size="1" name="key95" <%=fieldpg%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry">
	        <%=s%></select></td>                                     
		<td width="22%" class="dataListHead">Router IP(ADSL)</td>
		<td width="31%" bgcolor="silver"><input type="text" name="key96" size="20" value="<%=dspKey(96)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry"></td></tr>

	<tr><td class=dataListHead>�D�u�]�Ʀa�}(ADSL)</td>
    	<td colspan=3 bgcolor="silver">
		<% Call SrGetCountyTownShip(accessMode,sw,Len(Trim(fieldRole(1) &dataProtect)),dspKey(97),dspKey(98),s,t) %>
        <select name="key97" <%=fieldRole(1)%><%=dataProtect%> size="1" onChange="SrRenew()"
               style="text-align:left;" maxlength="8" class=dataListEntry><%=s%></select>
        <select name="key98" <%=fieldRole(1)%><%=dataProtect%> size="1"  
               style="text-align:left;" maxlength="8" class=dataListEntry><%=t%></select> 
        <input type="text" name="key99" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="80" maxlength="60"
               value="<%=dspKey(99)%>" class=dataListEntry></td></tr>

	<tr><td bgcolor="orange" colspan="4" align="center"><font color="black">���֥D�u���ϸ�T</font></td></tr>
    <tr><td class=dataListHead>�e����(����)</td>                
		<td bgcolor="silver">
			<input type="text" name="key83" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="15" maxlength="10" 
				value="<%=dspKey(83)%>"   class="dataListEntry" ID="Text10">
			<input type="button" id="B83" name="B83" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
	    <td class=dataListHead>���֥D�u���q��</td>
		<td><input type="text" name="key84" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="15" maxlength="10" 
				value="<%=dspKey(84)%>"   class="dataListEntry" ID="Text11">
			<input type="button" id="B84"  name="B84" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>    

	<tr><td class=dataListHead>����HB���X</td>
		<td bgcolor="silver"><input type="text" name="key85" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" maxlength="10"
				value="<%=dspKey(85)%>" size="15" class=dataListEntry ID="Text12"></td>               
		<td class=dataListHead>���ֹq���s��</td> 
		<td bgcolor="silver"><input type="text" name="key86" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" maxlength="15"
			value="<%=dspKey(86)%>" size="15" class=dataListEntry ID="Text13"></td></tr>
 
	<tr><td width="21%" class="dataListHead">����IP���q1</td>
		<td width="26%" bgcolor="silver"><input type="text" name="key87" size="20" value="<%=dspKey(87)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry" ID="Text14"></td>
		<td width="22%" class="dataListHead">Gateway IP</td>
		<td width="31%" bgcolor="silver"><input type="text" name="key89" size="20" value="<%=dspKey(89)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry" ID="Text15"></td></tr>
	<tr><td width="22%" class="dataListHead">����IP���q2</td>
		<td width="31%" bgcolor="silver"><input type="text" name="key88" size="20" value="<%=dspKey(88)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="25" class="dataListEntry ID="Text16""</td>
		<td width="22%" class="dataListHead">���֥D��IP</td>
		<td width="31%" bgcolor="silver"><input type="text" name="key90" size="20" value="<%=dspKey(90)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="20" class="dataListEntry" ID="Text16"></td></tr>

	<tr><td bgcolor="orange" colspan="4" align="center"><font color="black">�X�����p</FONT></td></tr>
	<tr><td width="8%" height="23" class="dataListHead" >�ظm�P�N��</td>                     
		<td width="20%" height="23" bgcolor="silver">
            <% 
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo1=""
                 rdo2=""
              Else
                 rdo1=" disabled "
                 rdo2=" disabled "
              End If            
                If dspKey(51)="Y" Then rdo1=" checked "    
                If dspKey(51)="N" Then rdo2=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO1%> name="key51" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio1"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO2%> name="key51" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio2"><font size=2>�K</font>                         
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(56))) < 1 Then
          sx=" selected " 
             s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(56) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(56) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="key56" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select2">
                    <%=S%>
               </select>                         
           �P�N�ѽs��                    
               <input  class="dataListdata" readonly type="text" name="key52" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(52)%>" ID="Text8"></td>          
           <td width="8%" height="23" class="dataListHead" >�X�@���w��</td>                     
           <td width="20%" height="23" bgcolor="silver">
            <%  
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo3=""
                 rdo4=""
              Else
                 rdo3=" disabled "
                 rdo4=" disabled "
              End If            
                If dspKey(53)="Y" Then rdo3=" checked "    
                If dspKey(53)="N" Then rdo4=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO3%> name="key53" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio3"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO4%> name="key53" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio4"><font size=2>�L</font>                           
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(57))) < 1 Then
          sx=" selected " 
             s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(57) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(57) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="key57" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select3">
                    <%=S%>
               </select>                        
               �X���s��        
               <input  class="dataListdata" readonly type="text" name="key54" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(54)%>" ID="Text9"></td>          
       
        </tr>            

 
       <tr><td  bgcolor="orange" colspan="4" align="center"><font color="black">���q�ɧU�״ڸ�T</font></td></tr>        
      
      <tr><td width="21%" class="dataListHead">���q�ɧU�P�N��</td>
          <td width="20%" height="23" bgcolor="silver">
            <% 
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo5=""
                 rdo6=""
              Else
                 rdo5=" disabled "
                 rdo6=" disabled "
              End If            
                If dspKey(58)="Y" Then rdo5=" checked "    
                If dspKey(58)="N" Then rdo6=" checked " %>                          
        
               <input type="radio" value="Y" <%=RDO5%> name="key58" <%=fieldpg%><%=fieldpa%><%=dataProtec%>><font size=2>��</font>
               <input type="radio" value="N" <%=RDO6%> name="key58" <%=fieldpg%><%=fieldpa%><%=dataProtect%>><font size=2>�L</font>                         
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false))  Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' " 
       If len(trim(dspkey(64))) < 1 Then
          sx=" selected " 
             s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D1' AND CODE='" & dspkey(64) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(64) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
               <select name="key64" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry">
                    <%=S%>
               </select>


           <td width="8%" height="23" class="dataListHead">���q�ɧU�P�N�ѽs��</td>
           <td width="8%" height="23" bgcolor="silver">
               <input  class="dataListEntry" type="text" name="key59" <%=fieldpa%><%=dataProtec%> value="<%=dspkey(59)%>"></td>
      </tr>

      <tr><td width="21%" class="dataListHead">�״ڻȦ�</td>
          <td width="26%" bgcolor="silver">
			<%
				name=""
				if dspkey(60) <> "" then
					sqlxx=" select headnc from rtbank where headno='" & dspkey(60) & "' order by headnc "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(�Ȧ�W��)"
					else
						name=rs("headnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="key60"value="<%=dspKey(60)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="3" maxlength="3" readonly class="dataListDATA">
			<input type="BUTTON" id="B60" name="B60" style="Z-INDEX: 1"  value="...." onclick="SrBankOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C60" name="C60" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>

			<td width="21%" class="dataListHead">�״ڤ���</td>
			<td width="26%" bgcolor="silver">
			<%
				name=""
				if dspkey(61) <> "" then
					sqlxx=" select branchnc from rtbankbranch where headno='" & dspkey(60) & "' and branchno='" & dspkey(61) & "' "
					rs.Open sqlxx,conn
					if rs.eof then
						name="(����W��)"
					else
						name=rs("branchnc")
					end if
					rs.close
				end if
			%>
			<input type="text" name="key61"value="<%=dspKey(61)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="5" maxlength="4" readonly class="dataListDATA">
			<input type="BUTTON" id="B61" name="B61" style="Z-INDEX: 1"  value="...." onclick="SrBankBranchOnClick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C61" name="C61" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
			<font size=2><%=name%></font></td>
      </tr>

	  <tr><td width="22%" class="dataListHead">�״ڱb��</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key62" size="15" value="<%=dspkey(62)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="15" class="dataListEntry"></td>
		  <td width="21%" class="dataListHead">�״ڤ�W</td>
          <td width="26%" colspan="3" bgcolor="silver"><input type="text" name="key63" size="38" value="<%=dspKey(63)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </TR>

      <tr>
          <td width="22%" class="dataListHead">�䲼���Y</td>
          <td width="31%" bgcolor="silver" colspan=3><input type="text" name="key103" size="80" value="<%=dspkey(103)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="60" class="dataListEntry"></td>
      </TR>

<%
	s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(104))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty4onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(104) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(104) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
	<tr><td class=dataListhead>�䲼�H�e�a�}</td>
    	<td colspan="3" bgcolor="silver">
			<select size="1" name="key104"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        	
        	<input type="text" name="key105" size="8" value="<%=dspkey(105)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m��)
			<input type="button" id="B105" name="B105" width="100%" style="Z-INDEX: 1" value="..." <%=SXX3%> >
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C105" name="C105" style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        	
        	<input type="text" name="key106" size="70" value="<%=dspkey(106)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>
	</tr>

       <tr><td width="21%" class="dataListHead">�q�O�ɧU���B</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key67" size="10" value="<%=dspKey(67)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="10" class="dataListEntry"></td>
      <td width="21%" class="dataListHead">�q�O�ɧU�_��</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key68" size="10" value="<%=dspKey(68)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="10" class="dataListEntry">
      <input type="button" id="B68"  name="B68" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
      </TR>
      </table> 
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
      <tr><td width="22%" class="dataListHead">�w�w�}�q��</td>
          <td width="31%" colspan="3" bgcolor="silver"><input type="text" name="key12" size="15" value="<%=dspKey(12)%>" readonly class="dataListData"></td></tr>
      <tr><td width="21%" class="dataListHead">�ɬd���</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key13" size="15" value="<%=dspKey(13)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" readonly>
                           <input type="button" id="B13"  name="B13" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">�������B</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key14" size="15" value="<%=dspKey(14)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="15" class="dataListEntry"></td></tr>
      <tr><td width="21%" class="dataListHead">�P�N�w��</td>
<%  dim seld1, seld2
    If Len(Trim(fieldRole(17) &dataProtect)) < 1 Then
       seld1=""
       seld2=""
       seld3=""       
    Else
       seld1=" disabled "
       seld2=" disabled "
       seld3=" disabled "       
    End If
    If Trim(dspKey(15))="" Then dspKey(15)="Y"
    If dspKey(15)="Y" Then seld1=" checked "    
    If dspKey(15)="N" Then seld2=" checked " 
    If dspKey(15)="H" Then seld3=" checked " %>                          
        <td width="26%"  bgcolor="silver"><input type="radio" value="Y" <%=seld1%> name="key15" <%=fieldRole(22)%>>�P�N<input type="radio" name="key15" value="N" <%=seld2%><%=fieldRole(17)%><%=dataProtect%>>���P�N<input type="radio" name="key15" value="H" <%=seld3%><%=fieldRole(17)%><%=dataProtect%>>�Ƚw</td>
          <td width="22%" class="dataListHead">COT�ظm���A</td>
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B6' " 
        '  Response.Write "SQL=" & SQL
       If len(trim(dspkey(47))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B6' AND CODE='" & dspkey(47) & "'"
       '   Response.Write "SQL=" & SQL
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(47) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>           
          <td width="31%" bgcolor="silver"><select name="key47"  <%=fieldRole(1)%> <%=dataProtect%>  class=dataListEntry size="1" 
            style="text-align:left;" maxlength="2"><%=s%></select> </td>�@    
�@    </tr>
      <tr><td width="21%" class="dataListHead">�M�P(�Ƚw)����</td>
          <td width="79%" colspan="3" bgcolor="silver"><input type="text" name="key16" size="65" value="<%=dspKey(16)%>" <%=fieldPa%><%=fieldRole(17)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </tr>
      <tr><td width="21%" class="dataListHead">T1�ӽФ��</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key17" size="15" value="<%=dspKey(17)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input type="button" id="B17"  name="B17" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">RACK/���d�����</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key18" size="15" value="<%=dspKey(18)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B18"  name="B18" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>
      <tr><td width="21%" class="dataListHead">COT�����</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key19" size="15" value="<%=dspKey(19)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B19"  name="B19" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">COT��m</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key20" size="15" value="<%=dspKey(20)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> maxlength="30" class="dataListEntry">
                           </td></tr>
      <tr><td width="21%" class="dataListHead">T1�����</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key21" size="15" value="<%=dspKey(21)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input type="button" id="B21"  name="B21" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">DSU�����</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key22" size="15" value="<%=dspKey(22)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B22"  name="B22" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td></tr>
      <tr><td width="21%" class="dataListHead">ROUTER�����</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key23" size="15" value="<%=dspKey(23)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input type="button" id="B23"  name="B23" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">T1�}�q���</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key24" size="15" READONLY value="<%=dspKey(24)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListDATA" >
              </td></tr>
      <tr><td width="21%" class="dataListHead">���ϰh�����</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key25" size="15" value="<%=dspKey(25)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B25"  name="B25" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"></td>
          <td width="22%" class="dataListHead">COT�ظm�o�]���</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key50" size="15" value="<%=dspKey(50)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                          <input type="button" id="B50"  name="B50" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> </td></tr>      
      </tr>
      <tr><td width="21%" class="dataListHead">COT�ظm�t��</td>
          <td width="26%" bgcolor="silver">

<%  Call SrGetSupp(accessMode,sw,Len(Trim(fieldRole(1) &dataProtect)),dspKey(4),dspkey(49),v)%>                
    <select name="key49"  <%=fieldRole(5)%> <%=dataProtect%>  class=dataListEntry size="1" 
            style="text-align:left;" maxlength="2"><%=V%></select></td>
          <td width="22%" class="dataListHead">COT�ظm�������</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key48" size="15" value="<%=dspKey(48)%>" <%=fieldPa%><%=fieldRole(5)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                          <input type="button" id="B48"  name="B48" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> </td></tr>      
      </tr>      
      <tr><td width="21%" class="dataListHead">�i�׻���</td>
          <td width="79%" colspan="3" bgcolor="silver"><input type="text" name="key36" size="65" value="<%=dspKey(36)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </tr>      
      <tr><td width="21%" class="dataListHead">�h������</td>
          <td width="79%" colspan="3" bgcolor="silver"><input type="text" name="key35" size="65" value="<%=dspKey(35)%>" <%=fieldRole(1)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </tr>      
      <tr><td width="21%" class="dataListHead">���u���ӦC�L���</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key26" size="15" value="<%=dspKey(26)%>" readonly maxlength="10" class="dataListData"></td>
          <td width="22%" class="dataListHead">���u���ӦC�L�H��</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key27" size="15" value="<%=dspKey(27)%>" readonly class="dataListData"></td></tr>
      <tr><td width="21%" class="dataListHead">�ۥI�B���ӦC�L���</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key28" size="15" value="<%=dspKey(28)%>" readonly class="dataListData"></td>
          <td width="22%" class="dataListHead">�ۥI�B���ӦC�L�y����</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key29" size="15" value="<%=dspKey(29)%>" readonly class="dataListData"></td></tr>
      <tr><td width="21%" class="dataListHead">�ۥI�B���ӦC�L�H��</td>
          <td width="79%" colspan="3" bgcolor="silver"><input type="text" name="key30" size="15" value="<%=dspKey(30)%>" readonly class="dataListData"></td>
      </tr>
      <tr><td width="21%" class="dataListHead">�|�p�f�֤��</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key31" size="15" value="<%=dspKey(31)%>" readonly class="dataListData"></td>
          <td width="22%" class="dataListHead">�|�p�f�֤H��</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key32" size="15" value="<%=dspKey(32)%>" readonly class="dataListData"></td></tr>
      <tr><td width="21%" class="dataListHead">�ۥI�B���ɤ��</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key33" size="15" value="<%=dspKey(33)%>" readonly class="dataListData"></td>
          <td width="22%" class="dataListHead">�o�����</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key34" size="15" value="<%=dspKey(34)%>" readonly class="dataListData"></td></tr>
    </table> 
<!--
 <table border="0" width="100%" cellpadding="0" cellspacing="0" id="tag3" style="display: none"> 
     <TR><TD><center><img src="/webap/image/worker.gif"></img><P><MARQUEE>�I�u��.......</MARQUEE></center></TD></TR>
     </TABLE>
</td><td>&nbsp</td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>
-->  
  </div> 
<% 
End Sub 
Sub SrReadExtDB()
   '�T�w��599
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open "SELECT snmpip FROM RTsnmp WHERE comq1=" &dspKey(0) &" and comkind='1' ",conn
    if rs.eof or rs.bof then
       extdb(0)=""
    else 
       extDB(0)=rs("snmpip")
    end if
    rs.Close
    '�p�q��599
    rs.Open "SELECT snmpip FROM RTsnmp WHERE comq1=" &dspKey(0) &" and comkind='3' ",conn
    if rs.eof or rs.bof then
       extdb(1)=""
    else 
       extDB(1)=rs("snmpip")
    end if
    rs.Close
    conn.Close    
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
    Dim conn,rs
' Smode A:add U:update
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
'------ RTsnmp ---------------------------------------------------
'�T�w��599
    rs.Open "SELECT * FROM RTsnmp WHERE comq1=" &dspKey(0) &" and comkind='1' ",conn,3,3
    If rs.Eof Or rs.Bof Then
          rs.AddNew
          rs("comq1")=dspKey(0)
          rs("comkind")="1"
          rs("snmpip")=extdb(0)
          rs("calcom")=""
     '     rs("pccount")=0
    else
       rs("snmpip")=extdb(0)
    End If
    rs.Update
    rs.close
'�T�w��599
    rs.Open "SELECT * FROM RTsnmp WHERE comq1=" &dspKey(0) &" and comkind='3' ",conn,3,3
    If rs.Eof Or rs.Bof Then
          rs.AddNew
          rs("comq1")=dspKey(0)
          rs("comkind")="3"
          rs("snmpip")=extdb(1)
          rs("calcom")=""
     '     rs("pccount")=0
    else
       rs("snmpip")=extdb(1)
    End If
    rs.Update
    rs.Close    
end sub
' --------------------------------------------------------------------------------------------  
%>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->
<!-- #include file="RTGetSupp.inc" -->