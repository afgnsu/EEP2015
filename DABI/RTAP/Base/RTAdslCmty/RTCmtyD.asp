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
  title="ADSL���ϰ򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT  CUTYID, COMN, HBNO, CMTYTEL, IPADDR, EQUIPADDR, TELEADDR, " _
                          &" SETUPADDR, BUSSID, AREAID, GROUPID, SURVYDAT, RCVD, CASESNDWRK, " _
                          &"EQUIPARRIVE, SETENGINEER, SNDWRKPLACE, LINEARRIVE, ADSLAPPLY, " _
                          &"REMARK, WORKPLACE, STOCKID, BRANCH, BUSSMAN, EUSR, EDAT, UUSR, " _
                          &"UDAT, AGREE, RCOMDROP, DROPREASON, COMCNT, COMBUILDING, " _
                          &"COMPOWER, SETUPCONTACT, COMAGREE, AGREENO, CONTRACT, " _
                          &"CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, REMITAGREE, " _
                          &"REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, " _
                          &"COPYREMIT, NOTATION, COMTYPE,linerate,COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC, " _
                          &"DEVELOPERID, FIBERONLINE, CUTID, TOWNSHIP, ADDR, PRETRANSCASE, "_
                          &"CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
                          &"FROM RTcustadslCmty WHERE cutyid=0 "
  sqlList="SELECT  CUTYID, COMN, HBNO, CMTYTEL, IPADDR, EQUIPADDR, TELEADDR, " _
                          &" SETUPADDR, BUSSID, AREAID, GROUPID, SURVYDAT, RCVD, CASESNDWRK, " _
                          &"EQUIPARRIVE, SETENGINEER, SNDWRKPLACE, LINEARRIVE, ADSLAPPLY, " _
                          &"REMARK, WORKPLACE, STOCKID, BRANCH, BUSSMAN, EUSR, EDAT, UUSR, " _
                          &"UDAT, AGREE, RCOMDROP, DROPREASON, COMCNT, COMBUILDING, " _
                          &"COMPOWER, SETUPCONTACT, COMAGREE, AGREENO, CONTRACT, " _
                          &"CONTRACTNO, SIGNETDAT, COPYAGREE, COPYCONTRACT, REMITAGREE, " _
                          &"REMITNO, REMITBANK, BANKBRANCH, REMITACCOUNT, REMITNAME, " _
                          &"COPYREMIT, NOTATION, COMTYPE,linerate,COTPORT1,COTPORT2,MDF1,MDF2,RESET,RESETDESC, "_
                          &"DEVELOPERID, FIBERONLINE, CUTID, TOWNSHIP, ADDR, PRETRANSCASE, "_
                          &"CHECKTITLE, CCUTID, CTOWNSHIP, CADDR " _
                          &"FROM RTcustadslCmty WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=2
  userdefineactivex="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    if len(trim(dspkey(31)))= 0 then dspkey(31)=0
    if len(trim(dspkey(32)))= 0 then dspkey(32)=0
    if len(trim(dspkey(59)))=0 then dspkey(59)=""
    If len(dspKey(0)) <= 0 Then
       dspkey(0)=0
    End If
    if len(dspkey(1)) < 1 Then
       formValid=False
       message="�п�J���ϦW��"      
    ELSEIF  len(dspkey(51)) < 1 Then
       formValid=False
       message="�п�J�D�u�t�v"                   
    end if
    if dspkey(28) <> "Y" and dspkey(28) <> "N" then
       dspkey(28)=""
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
   Sub Srbranchonclick()
       prog="RTGetBRANCHD.asp"
       prog=prog & "?KEY=" & document.all("KEY21").VALUE 
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key22").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub         
   Sub SrbranchMANonclick()
       prog="RTGetBRANCHMAND.asp"
       prog=prog & "?KEY=" & document.all("KEY21").VALUE & ";" & document.all("KEY22").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key23").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub        
   Sub Srsalesgrouponclick()
       prog="RTGetsalesgroupD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE 
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key10").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub        
   Sub Srsalesonclick()
       prog="RTGetsalesD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE & ";" & document.all("KEY10").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key8").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub            
   Sub Sr34salesonclick()
       prog="RTGetsalesD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE & ";" & document.all("KEY10").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key34").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub               
   Sub SrWorkmanonclick()
       prog="RTGetworkmanD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE & ";" & document.all("KEY10").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key15").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY58").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key58").value =  trim(Fusrid(0))
       End if
       end if
   End Sub

   Sub Srcounty4onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY65").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key66").value =  trim(Fusrid(0))
          'document.all("key57").value =  trim(Fusrid(1))
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
                EUsrNc=V(1) 
                dspkey(25)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(24))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(25)=datevalue(now())
    else
        if len(trim(dspkey(26))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(27)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(26))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(24))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(27)=now()
    end if      
' -------------------------------------------------------------------------------------------- 
    Dim conn,rs,s,sx,sql,t
 '   If IsDate(dspKey(26)) Then
 '      fieldPa=" class=""dataListData"" readonly "
 '   Else
 '      fieldPa=""
 '   End If
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <!--
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'">�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'">�o�]�w��</span>           
  -->
  <span id="tags1" class="dataListTagsOn">�򥻸�Ƥεo�]�w��</span>
                                                            
  <div class=dataListTagOn> 
<table width="100%">
<tr><td width="2%">&nbsp;</td><td width="96%">&nbsp;</td><td width="2%">&nbsp;</td></tr>
<tr><td>&nbsp;</td><td>        
<table width="100%" border=1 cellPadding=0 cellSpacing=0 id="tag1">
<tr><td width="20%" class=dataListHead>���ϦW��</td>
    <td width="30%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="50"
               value="<%=dspKey(1)%>" size="40" class=dataListEntry></td>
    <td width="20%" class=dataListHead>HB���X</td>
    <td width="30%" bgcolor="silver">
        <input type="text" name="key2" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="30"
               value="<%=dspKey(2)%>" size="20" class=dataListEntry></td></tr>


<tr><td class=dataListHead>�~���Ұ�</td> 
    <td COLSPAN="3" bgcolor="silver">
<%  If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then 
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '1') "
       s="<option value="""" >(�~���Ұ�)</option>"
    Else
       sql="SELECT AREAID, AREANC FROM RTArea WHERE (AREATYPE = '1') "
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
           <select size="1" name="key9" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry">                                            
              <%=s%>
           </select>
    <input type="text" name="key10" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(10)%>"   readonly class="dataListEntry">
         <input type="button" id="B10"  name="B10"   width="100%" style="Z-INDEX: 1"  value="...." readonly onclick="SrsalesGrouponclick()"  >  
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
         <% NAME=""
             if dspkey(8) <> "" then
              sql=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
                   &"where rtemployee.emply='" & dspkey(8) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("cusnc")
              end if
              rs.close
           end if
           IF NAME="" AND DSPKEY(8) <> "" THEN
              sql=" select * from rtobj where rtobj.cusid='" & dspkey(8) & "' "
              rs.Open sql,conn
              if rs.eof then
                 name=""
              else
                 name=rs("shortnc")
              end if
              rs.close
           END IF
          %>
    <input type="text" name="key8" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="10" maxlength="10" 
               value="<%=dspKey(8)%>"  readonly class="dataListEntry">
           <input type="button" id="B8"  name="B8"   width="100%" style="Z-INDEX: 1"  value="...." onclick="Srsalesonclick()"  >                  
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C8"  name="C8"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear"><font size=2><%=NAME%></font></TD>               
</tr>   
<tr STYLE="DISPLAY:NONE"><td class=dataListHead STYLE="DISPLAY:NONO">���</td> 
<%    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1 Then 
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID,RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '06') AND RTOBJ.CUSID NOT IN ('70770184', '47224065') "
       s="<option value="""" >(�Ҩ餽�q)</option>"
    Else
       sql="SELECT RTObj.CUSNC, RTObjLink.CUSTYID, RTObj.CUSID,RTObj.SHORTNC " _
          &"FROM RTObj INNER JOIN " _
          &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID " _
          &"WHERE (RTObjLink.CUSTYID = '06') AND RTOBJ.CUSID NOT IN ('70770184', '47224065') "
       s="<option value="""" >(�Ҩ餽�q)</option>"
    End If
    rs.Open sql,conn
    If rs.Eof Then s="<option value="""" >(�Ҩ餽�q)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CUSID")=dspkey(21) Then sx=" selected "
       s=s &"<option value=""" &rs("CUSID") &"""" &sx &">" &rs("SHORTNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close        
    %>
    <td COLSPAN="3" bgcolor="silver" STYLE="DISPLAY:NONE">
           <select size="1"  STYLE="DISPLAY:NONE" name="key21" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry">                                            
              <%=s%>
           </select>
    <input  STYLE="DISPLAY:NONE" type="text" name="key22" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(22)%>"   class="dataListEntry">
         <input  STYLE="DISPLAY:NONE" type="button" id="B22"  name="B22"   width="100%" style="Z-INDEX: 1"  value="...." readonly onclick="SrBranchonclick()"  >  
          <IMG  STYLE="DISPLAY:NONE" SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C22"  name="C22"   style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">                
    <input STYLE="DISPLAY:NONE" type="text" name="key23" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="10"
               value="<%=dspKey(23)%>" size="15" class=dataListEntry>
         <input  STYLE="DISPLAY:NONE" type="button" id="B23"  name="B23"   width="100%" style="Z-INDEX: 1"  value="...." onclick="SrBranchmanonclick()"  >                  
          <IMG  STYLE="DISPLAY:NONE" SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C23"  name="C23"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">  
    </td>               
</tr>

<% IF DSPKEY(59)="Y" THEN CHECK59=" CHECKED "%>
<tr><td class=dataListHead>�w����</td> 
    <td><input type="checkbox" name="key59" <%=fieldRole(1)%><%=dataProtect%> value="Y" <%=CHECK59%> READONLY bgcolor="silver"></TD>
    <td class=dataListHead>CHT��B�B</td>
    <td  bgcolor="silver"><input  type="text" name="key20" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="15" maxlength="10" 
               value="<%=dspKey(20)%>"   class="dataListEntry"></TD>
</tr>

<tr><td class=dataListHead>�w�p������</td> 
	<td height="23" bgcolor="silver" colspan=3>
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then
       sql="SELECT CODE, CODENC FROM RTCODE WHERE KIND='O8' "
       If len(trim(dspkey(63))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(�w�p������)</option>"
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(�w�p������)</option>"
          sx=""
       end if
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='O8' AND CODE='" & dspkey(63) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(63) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key63" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
        <%=s%>
   </select>
</tr>


<tr>    <td class=dataListHead>�O�_�i�ظm</td>
    <td  bgcolor="silver">     
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
        <input type="radio" value="Y" <%=rdo1%> name="key28" <%=fieldRole(1)%><%=dataProtect%>><font size=2>�i�ظm
        <input type="radio" value="N" <%=rdo2%>  name="key28" <%=fieldRole(1)%><%=dataProtect%>><font size=2>�L�k�ظm</TD>
	<td class=dataListHead>���i�ظm��]</td> 
    <td bgcolor="silver"><input type="text" name="key19" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="80"
               value="<%=dspKey(19)%>" size="60" class=dataListEntry></td>
</tr>   
<tr>                                 
        <td  class="dataListHead" height="23">���Ϥ��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key31" size="15" value="<%=dspKey(31)%>"  <%=fieldRole(1)%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="23">���ϴɼ�</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key32" size="15" value="<%=dspKey(32)%>"  <%=fieldRole(1)%> class="dataListEntry"></td>                                 
      </tr>                                 
      <tr>                                 
        <td  class="dataListHead" height="23">���Ϲq��</td>                                 
        <td  width="25%" height="23" bgcolor="silver">
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
    <td  class="dataListHead" height="23">�ظm�p���H</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key34" size="10" value="<%=dspKey(34)%>" <%=fieldRole(1)%> class="dataListEntry">                         
     <input type="button" id="B34"  name="B34"   width="100%" style="Z-INDEX: 1"  value="..." onclick="Sr34salesonclick()"  >
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C34"  name="C34"   style="Z-INDEX: 1" onclick="srclear"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" ></td>      
      </tr>    
<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B3' " 
        '  Response.Write "SQL=" & SQL
       If len(trim(dspkey(50))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='B3' AND CODE='" & dspkey(50) & "'"
       '   Response.Write "SQL=" & SQL
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(50) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>                        
<tr><td class=dataListHead>�������O</td> 
    <td  bgcolor="silver">  
      <select name="key50"  <%=fieldRole(1)%> <%=dataProtect%>  class=dataListEntry size="1" 
            style="text-align:left;" maxlength="2"><%=s%></select></td>
<%
	name=""
	if dspkey(58) <> "" then
		sqlxx=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
			 &"where rtemployee.emply='" & dspkey(58) & "' "
		rs.Open sqlxx,conn
		if rs.eof then
			name="(��H�ɧ䤣�ӭ��u)"
		else
			name=rs("cusnc")
		end if
		rs.close
	end if
%>
		<td WIDTH="15%" class="dataListHEAD" height="23">�G�u�t�d�H</td>
		<td width="35%"><input type="text" name="key58"value="<%=dspKey(58)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text36">
			<input type="BUTTON" id="B58" name="B58" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF"  <%=fieldpb%> alt="�M��" id="C58" name="C58" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=name%></font></td></tr>

<tr><td class=dataListHead>���Ϧa�}</td>
    <td colspan=3 bgcolor="silver">
<%  Call SrGetCountyTownShip(accessMode,sw,Len(Trim(fieldRole(1) &dataProtect)),dspKey(60),dspKey(61),s,t)%>
        <select name="key60" <%=fieldRole(1)%><%=dataProtect%> size="1" onChange="SrRenew()"
               style="text-align:left;" maxlength="8" class=dataListEntry><%=s%></select>
        <select name="key61" <%=fieldRole(1)%><%=dataProtect%> size="1"  
               style="text-align:left;" maxlength="8" class=dataListEntry><%=t%></select> 
        <input type="text" name="key62" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="80" maxlength="60"
               value="<%=dspKey(62)%>" class=dataListEntry></td></tr>

<tr><td class=dataListHead>�]�Ʀ�m</td>
    <td colspan="3" bgcolor="silver">
        <input type="text" name="key5" <%=fieldRole(1)%><%=dataProtect%> 
               style="text-align:left;" size="60" maxlength="60"
               value="<%=dspKey(5)%>" class=dataListEntry></td></tr> 
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
    <td COLSPAN="3" bgcolor="silver"><input type="text" name="key49" <%=fieldRole(1)%>
               style="text-align:left;" maxlength="150"
               value="<%=dspKey(49)%>" size="90" maxlength="150"  class=dataListEntry></td>
</tr>   
<tr style="display:none">                                 
        <td  class="dataListHead" height="23">��J�H��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key24" size="15" value="<%=dspKey(24)%>" readonly class="dataListData"><%=EusrNC%></td>                                 
        <td  class="dataListHead" height="23">��J���</td>                                 
        <td  colspan="3" height="23" bgcolor="silver"><input type="text" name="key25" size="15" value="<%=dspKey(25)%>" readonly class="dataListData"></td>                                 
      </tr>                                 
      <tr style="display:none">                                 
        <td  class="dataListHead" height="23">���ʤH��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key26" size="15" value="<%=dspKey(26)%>" readonly class="dataListData"><%=UUsrNc%></td>                                 
        <td  class="dataListHead" height="23">���ʤ��</td>                                 
        <td  colspan="3" height="23" bgcolor="silver"><input type="text" name="key27" size="15" value="<%=dspKey(27)%>" readonly class="dataListData"></td>                                 
      </tr>      
</table> 

    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table3">
       <tr><td bgcolor="lightblue" align="center">������T</td></tr></table>
       <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table4">
       <tr><td class=dataListHead>�M�u���X</td>
    <td bgcolor="silver">
        <input type="text" name="key3" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(3)%>" size="15" class=dataListEntry ID="Text7"></td>

    <td class=dataListHead>IP��}</td><td>
        <input type="text" name="key4" <%=fieldRole(1)%><%=dataProtect%>
               style="text-align:left;" maxlength="15"
               value="<%=dspKey(4)%>" size="15" class=dataListEntry ID="Text8"></td>
</tr>  
<tr>
<td   class="dataListHEAD" height="23">�D�u�W�e</td>               
        <td   height="23" bgcolor="silver">
<%
    s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  Then  
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' " 
       If len(trim(dspkey(51))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & ">(�D�u�t�v)</option>"  
          sx=""
       end if     
    Else
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='D3' AND CODE='" & dspkey(51) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(51) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key51" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select35">                                                                  
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
       sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='K4' AND CODE='" & dspkey(56) & "'"
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CODE")=dspkey(56) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>         
   <select size="1" name="key56" <%=fieldpg%><%=fieldpa%><%=dataProtect%> class="dataListEntry">                                                                  
        <%=s%>
   </select></td>          
        </tr>
          <tr>
         <td  height="23" class="dataListHead">Reset�Ƶ�</td>                     
           <td  height="23" bgcolor="silver" colspan=3>
               <input  class="dataListENTRY" type="text" size="100" maxlength="50" name="key57" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(57)%>" ID="Text9"></td>          
        </tr>                
        
       <tr>
           <td width="20%" height="23" class="dataListHead" >COT PORT</td>                     
           <td width="30%" height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key52" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(52)%>" ID="Text5">
            </td>                              
           <td width="20%" height="23" class="dataListHead" >����PORT��</td>                     
           <td width="30%" height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key53" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(53)%>" ID="Text3"></td>          
          </TR>
          <tr>
           <td  height="23" class="dataListHead" >MDF1</td>                     
           <td  height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text"  size="10" maxlength="10" name="key54" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(54)%>" ID="Text6">
              </td>                              
           <td  height="23" class="dataListHead" >MDF2</td>                     
           <td  height="23" bgcolor="silver">
               <input  class="dataListENTRY"  type="text" size="10" maxlength="10" name="key55" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(55)%>" ID="Text4"></td>          
        </tr>                
       
       </table>           
    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
    <tr><td bgcolor="lightblue" align="center">�I�u�i�ת��p</td></tr></table>
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
          <td  bgcolor="silver"><input type="text" name="key13" size="15" READONLY value="<%=dspKey(13)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B13"  name="B13" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C13"  name="C13"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
          <td class="dataListHead">�]�ƨ���</td>
          <td  bgcolor="silver"><input type="text" name="key14" size="15" READONLY value="<%=dspKey(14)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="30" class="dataListEntry">
                            <input type="button" id="B14"  name="B14" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                            <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td></tr>
      <tr><td  class="dataListHead">�w�ˤu�{�v</td>
          <td  bgcolor="silver"><input type="text" name="key15" size="15" value="<%=dspKey(15)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
            <input type="button" id="B15"  name="B15"   width="100%" style="Z-INDEX: 1"  value="...." onclick="Srworkmanonclick()"  >                  
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C15"  name="C15"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear"> </td>
          <td  class="dataListHead">����B�B��</td>
          <td bgcolor="silver"><input type="text" name="key16" size="15" READONLY value="<%=dspKey(16)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry">
                           <input type="button" id="B16"  name="B16" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C16"  name="C16"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td></tr>
      <tr>
          <td class="dataListHead">�u������</td>
          <td  bgcolor="silver"><input   type="text" name="key17" size="15" READONLY value="<%=dspKey(17)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                           <input  type="button" id="B17"  name="B17" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick">
                           <IMG style="display:none"  SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C17"  name="C17"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>
          <td class="dataListHead">���q���</td>
          <td  bgcolor="silver"><input type="text" name="key18" size="15" READONLY value="<%=dspKey(18)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListDATA" >
                          </td>
      <TR>
      <td  class="dataListHead">�h��(�M�P)��</td>
          <td  colspan="5" bgcolor="silver"><input type="text" name="key29" size="15" READONLY value="<%=dspKey(29)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="10" class="dataListEntry" >
                          <input type="button" id="B29"  name="B29" height="100%" width="100%" style="Z-INDEX: 1" value="...." onclick="SrBtnOnClick"> 
                          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C29"  name="C29"   style="Z-INDEX: 1"  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear"></td>                           
      </TR>
      <tr>
          <td  class="dataListHead">�h��(�M�P)��]</td>
          <td  COLSPAN="3" bgcolor="silver"><input type="text" name="key30" size="90" value="<%=dspKey(30)%>" <%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> maxlength="120" class="dataListEntry" ></td>
      </tr>
    </table> 

<!--
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none"> 
-->
    <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table1">
       <tr><td bgcolor="lightblue" align="center">�X�����p</td></tr></table>
       <table border="1" width="100%" cellpadding="0" cellspacing="0" ID="Table2">
       <tr>
           <td width="8%" height="23" class="dataListHead" >�ظm�P�N��</td>                     
           <td width="15%" height="23" bgcolor="silver">
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
        
               <input type="radio" value="Y" <%=RDO1%> name="key35" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio1"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO2%> name="key35" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio2"><font size=2>�K</font>
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
               <select name="key40" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select1">
                    <%=S%>
               </select>
               </td>                              
           <td width="8%" height="23" class="dataListHead" >�P�N�ѽs��</td>                     
           <td width="8%" height="23" bgcolor="silver">
               <input  class="dataListdata" readonly type="text"  size="7" maxlength="7" name="key36" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(36)%>" ID="Text1"></td>          
           <td width="8%" height="23" class="dataListHead" >�X�@���w��</td>                     
           <td width="15%" height="23" bgcolor="silver">
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
        
               <input type="radio" value="Y" <%=RDO3%> name="key37" <%=fieldRole(4)%><%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio3"><font size=2>��</font>
               <input type="radio" value="N" <%=RDO4%> name="key37" <%=fieldRole(4)%><%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio4"><font size=2>�L</font>
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
               <select name="key41" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry" ID="Select2">
                    <%=S%>
               </select>               
               </td>                              
           <td width="8%" height="23" class="dataListHead" >�X���s��</td>                     
           <td width="5%" height="23" bgcolor="silver">
               <input  class="dataListdata" readonly type="text" size="7" maxlength="7" name="key38" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(38)%>" ID="Text2"></td>          
       
        </tr>                
       </table>    

    <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr><td bgcolor="lightblue" align="center">���q�ɧU�״ڸ�T</td></tr></table>
       <table border="1" width="100%" cellpadding="0" cellspacing="0" >
       <tr>
           <td width="8%" height="23" class="dataListHead" >���q�ɧU�P�N��</td>                     
           <td width="15%"  height="23" bgcolor="silver">
            <% 
              If Len(Trim(fieldRole(4) &dataProtect)) < 1 Then
                 rdo5=""
                 rdo6=""
              Else
                 rdo5=" disabled "
                 rdo6=" disabled "
              End If
  
                If trim(dspKey(42))="Y" Then rdo5=" checked "    
                If trim(dspKey(42))="N" Then rdo6=" checked " %>                          
        
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
    rs.Close%>         
               <select name="key48" <%=fieldpa%><%=FIELDROLE(4)%><%=dataProtect%>  class="dataListEntry">
                    <%=S%>
               </select>
               </td>                              
           <td width="8%" height="23" class="dataListHead">���q�ɧU�P�N�ѽs��</td>
           <td width="8%" height="23" bgcolor="silver">
               <input  class="dataListEntry" type="text"  size="12" maxlength="7" name="key43" <%=fieldpg%><%=fieldpa%><%=dataProtec%> value="<%=dspkey(43)%>"></td>          
        </tr>

      <tr><td width="21%" class="dataListHead">�״ڻȦ�</td>
          <td width="26%" bgcolor="silver">
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

			<td width="21%" class="dataListHead">����W��</td>
			<td width="26%" bgcolor="silver">
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

      <tr><td width="22%" class="dataListHead">�״ڱb��</td>
          <td width="31%" bgcolor="silver"><input type="text" name="key46" size="15" value="<%=dspkey(46)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="15" class="dataListEntry"></td>
		  <td width="21%" class="dataListHead">�״ڤ�W</td>
          <td width="26%" bgcolor="silver"><input type="text" name="key47" size="38" value="<%=dspKey(47)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="50" class="dataListEntry"></td>
      </TR>

      <tr>
          <td width="22%" class="dataListHead">�䲼���Y</td>
          <td width="31%" bgcolor="silver" colspan=3><input type="text" name="key64" size="80" value="<%=dspkey(64)%>" <%=fieldRole(4)%><%=dataProtect%> maxlength="60" class="dataListEntry"></td>
      </TR>

<%
	s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(65))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX3=" onclick=""Srcounty4onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(65) & "' " 
       SXX3=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(65) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
	<tr><td class=dataListhead>�䲼�H�e�a�}</td>
    	<td colspan="3" bgcolor="silver">
			<select size="1" name="key65"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        	
        	<input type="text" name="key66" size="8" value="<%=dspkey(66)%>" maxlength="10" readonly <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m��)
			<input type="button" id="B66" name="B66" width="100%" style="Z-INDEX: 1" value="..." <%=SXX3%> >
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C66" name="C66" style="Z-INDEX: 1" <%=fieldpe%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" onclick="SrClear">
        	
        	<input type="text" name="key67" size="70" value="<%=dspkey(67)%>" maxlength="60" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>
	</tr>

       </table>
</td><td>&nbsp</td></tr>
<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>  
  </div> 
<% 
End Sub 
' --------------------------------------------------------------------------------------------  
%>
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetCountyTownShip.inc" -->