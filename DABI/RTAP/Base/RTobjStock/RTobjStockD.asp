<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->

<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=1
  title="�Ҩ餽�q�򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  sqlFormatDB="SELECT CUSID,TEL,FAX,RURL,email,boss," _
             &"staffcnt,eusr,edat,uusr,udat " _
             &"FROM RTSTOCK WHERE cusid='*' "
  sqlList="SELECT CUSID,TEL,FAX,RURL,email,boss," _
             &"staffcnt,eusr,edat,uusr,udat " _
             &"FROM RTSTOCK WHERE "
  userDefineKey="Yes"
  userDefineData="Yes"
  userDefineSave="Yes"  
  extDBField=14
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
    If len(trim(dspKey(0))) < 1 Then
       formValid=False
       message="�п�J�Ҩ餽�q�N�X"
    End If
    If len(trim(extdb(0))) < 1 Then
       formValid=False
       message="�п�J���q�W��"
    End If
    If len(trim(extdb(1))) < 1 Then
       formValid=False
       message="�п�J���q²��"
    End If
    If not IsNumeric(dspkey(6)) Then
       formValid=False
       message="���q�H�Ƥ����T"
    End If    
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="21%" class=dataListHead>�Ҩ餽�q�N�X</td><td width="79%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0" <%=keyprotect%> size="10" 
           value="<%=dspKey(0)%>" maxlength="8" >(���q�Τ@�s��)</td>
       </tr>
      </table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(7))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(7)=V(0)
                extdb(10)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(7))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(8)=datevalue(now())
       extdb(11)=datevalue(now())
    else
        if len(trim(dspkey(9))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(9)=V(0)
                extdb(12)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(9))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(7))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(10)=datevalue(now())
        extdb(13)=datevalue(now())
    end if

'-----EXTDB DATA RETRIVE
DIM conn,rs,dsn,sql
SET conn=server.CreateObject("ADODB.Connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
SQL="SELECT CUSNC,SHORTNC,CUTID1,TOWNSHIP1,RADDR1,RZONE1,CUTID2," _ 
   &"TOWNSHIP2,RADDR2,RZONE2,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobj where CUSID ='" & dspkey(0) & "'"
conn.Open dsn
rs.Open sql,conn
if not rs.EOF then
   If sw="E" Or (accessMode="A" And sw="") Then 
      if sw="E" then extdb(13)=datevalue(now())
      if sw="" and accessMode="A" then extdb(11)=datevalue(now())
   else
      extdb(0)=rs("cusnc")
      extdb(1)=rs("shortnc")
      extdb(2)=rs("cutid1")
      extdb(3)=rs("township1")
      extdb(4)=rs("raddr1")
      extdb(5)=rs("rzone1")
      extdb(6)=rs("cutid2")
      extdb(7)=rs("township2")
      extdb(8)=rs("raddr2")
      extdb(9)=rs("rzone2")
      extdb(10)=rs("eusr")
      if len(trim(rs("edat"))) > 0 then extdb(11)=datevalue(rs("edat"))
      extdb(12)=rs("uusr")
      if len(trim(rs("udat"))) > 0 then extdb(13)=datevalue(rs("udat")) 
   end if
else
end if
rs.close
%>
<table border="1" width="100%" cellspacing="0" cellpadding="0">
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���q�W��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="ext0" <%=dataprotect%> maxlength=50 size=40 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(0)%>"></td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">²��</font></td>
    <td width="25%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="ext1" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(1)%>"></td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�p���q��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key1"  <%=dataprotect%> maxlength=15 size=15 style="TEXT-ALIGN: left" value
            ="<%=dspkey(1)%>">�@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�ǯu�q��</font></td>
    <td width="25%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key2" <%=dataprotect%> maxlength=15 size=15 style="TEXT-ALIGN: left" value
            ="<%=dspkey(2)%>">�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���q���}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="key3" <%=dataprotect%> maxlength=30 size=30 style="TEXT-ALIGN: left" value
            ="<%=dspkey(3)%>">�@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�q�l�l��</font></td>
    <td width="25%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key4" <%=dataprotect%> maxlength=30 size=25 style="TEXT-ALIGN: left" value
            ="<%=dspkey(4)%>">�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�t�d�H</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key5" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(5)%>">
    �@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���q�H��</font>�@</td>
    <td width="25%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="key6" <%=dataprotect%> maxlength=5 size=5 style="TEXT-ALIGN: left" value
            ="<%=dspkey(6)%>">�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���y�a�}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
 <% s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT * FROM RTCounty ORDER BY CutID "
       If len(trim(extDB(2))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if     
    Else
       sql="SELECT * FROM RTCounty WHERE CutID='" &extdb(2) &"' "
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CutID")=extDB(2) Then sx=" selected "
       s=s &"<option value=""" &rs("CutID") &"""" &sx &">" &rs("CutNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>
    <select class=dataListEntry name="ext2" <%=dataProtect%> size="1" 
                onChange="SrRenew()"
               style="text-align:left;" maxlength="8"><%=s%></select>    
<%  If sw="E" Then
       rs.Open "SELECT * FROM RTCtyTown WHERE CutID='" &extDB(2) &"' ORDER BY TownShip ",conn
       s=""
       sx=" selected "
       If len(trim(extDB(3))) < 1 Then sx=" selected "
       s=s & "<option value=""""" & sx & "></option>"
       Do While Not rs.Eof
          If rs("TownShip")=extDB(3) Then sx=" selected "
          s=s &"<option value=""" &rs("TownShip") &"""" &sx &">" &rs("TownShip") &"</option>"
          rs.MoveNext
          sx=""
       Loop
       rs.Close
    Else
       s="<option value=""" &extDB(3) &""" selected>" &extDB(3) &"</option>"
    End If %>
    <select class=dataListEntry name="ext3" <%=dataProtect%> size="1" 
               style="text-align:left;" maxlength="8"><%=s%></select>   
    <input class=dataListEntry name="ext4" <%=dataprotect%> maxlength=40 size=25 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(4)%>"></td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�l���ϸ�</font></td>
    <td width="25%" bgcolor="#C0C0C0">
     <input class=dataListEntry name="ext5" <%=dataprotect%> maxlength=5 size=5 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(5)%>">�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�q�T�a�}</font></td>
    <td width="45%" bgcolor="#C0C0C0">
 <% s=""
    sx=" selected " 
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)Then 
       sql="SELECT * FROM RTCounty ORDER BY CutID "
       If len(trim(extDB(6))) < 1 Then
          sx=" selected " 
          s=s & "<option value=""""" & sx & "></option>"  
          sx=""
       else
          s=s & "<option value=""""" & sx & "></option>"  
       end if            
    Else
       sql="SELECT * FROM RTCounty WHERE CutID='" &extdb(6) &"' "
    End If
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("CutID")=extDB(6) Then sx=" selected "
       s=s &"<option value=""" &rs("CutID") &"""" &sx &">" &rs("CutNC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close%>
    <select class=dataListEntry name="ext6" <%=dataProtect%> size="1" 
                onChange="SrRenew()"
               style="text-align:left;" maxlength="8"><%=s%></select>
<%  If sw="E" Then
       rs.Open "SELECT * FROM RTCtyTown WHERE CutID='" &extDB(6) &"' ORDER BY TownShip ",conn
       s=""
       sx=" selected "
       If len(trim(extDB(7))) < 1 Then sx=" selected "
       s=s & "<option value=""""" & sx & "></option>"       
       Do While Not rs.Eof
          If rs("TownShip")=extDB(7) Then sx=" selected "
          s=s &"<option value=""" &rs("TownShip") &"""" &sx &">" &rs("TownShip") &"</option>"
          rs.MoveNext
          sx=""
       Loop
       rs.Close
    Else
       s="<option value=""" &extDB(7) &""" selected>" &extDB(7) &"</option>"
    End If %>
    <select class=dataListEntry name="ext7" <%=dataProtect%> size="1" 
               style="text-align:left;" maxlength="8"><%=s%></select>                   
     <input class=dataListEntry name="ext8" <%=dataprotect%> maxlength=40 size=25 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(8)%>">�@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">�l���ϸ�</font></td>
    <td width="25%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="ext9" <%=dataprotect%> maxlength=5 size=5 style="TEXT-ALIGN: left" value
            ="<%=EXTDB(9)%>">�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">��J�H��</font></td>
    <td width="45%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key7" <%=dataprotect%> maxlength=6 size=6 style="TEXT-ALIGN:  left" 
     value="<%=dspkey(7)%>" readOnly><%=EusrNc%>�@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">��J���</font></td>
    <td width="25%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key8"  maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(8)%>"  readOnly>�@</td>
  </tr>
  <tr>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���ʤH��</font></td>
    <td width="35%" bgcolor="#C0C0C0">
    <input class=dataListEntry  name="key9" readOnly size=6 maxlength=6 style="TEXT-ALIGN: left "
            value="<%=dspkey(9)%>"><%=UUsrNC%>�@</td>
    <td width="15%" bgcolor="#008080"><font color="#FFFFFF">���ʤ��</font></td>
    <td width="35%" bgcolor="#C0C0C0">
    <input class=dataListEntry name="key10" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(10)%>" readOnly>�@</td>
    <input class=dataListEntry name="ext10" maxlength=6 size=6    
            style="TEXT-ALIGN: left" value="<%=extdb(10)%>" style="display:none">
    <input class=dataListEntry name="ext11" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=extdb(11)%>" style="display:none">  
    <input class=dataListEntry name="ext12" maxlength=6 size=6    
            style="TEXT-ALIGN: left" value="<%=extdb(12)%>" style="display:none">  
      <input class=dataListEntry name="ext13" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=extdb(13)%>" style="display:none">
  </tr>
</table>
<% conn.close
   set rs=nothing
   set conn=nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'--------------SAVE RTOBJ FILE
Dim conn,rs,dsn,sql
SET conn=server.CreateObject("ADODB.Connection")
set rs=server.CreateObject("ADODB.recordset")
DSN="DSN=RTLIB"
SQL="SELECT cusid,CUSNC,SHORTNC,CUTID1,TOWNSHIP1,RADDR1,RZONE1,CUTID2," _ 
   &"TOWNSHIP2,RADDR2,RZONE2,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobj where CUSID ='" & dspkey(0) & "'"
conn.Open dsn
rs.Open sql,conn,3,3
if not rs.EOF then  
   '--�ѩ��H�򥻸���ɫY�@�θ��,���קK��Ʀ]���o�ϥΪ̿�J�ɭP���lose
   '--�{�H;�G�P�_��ϥΪ̦���J��ƮɦA���N�쥻���
   '===========
   '--?????�O�_�|�y�����N��ƲM��,�o�S�L�k���N���{�H�o��??????
   '+++�A�Ҽ{
   rs("cusnc")    =extdb(0)
   rs("shortnc")  =extdb(1)
   rs("cutid1")   =extdb(2)
   rs("township1")=extdb(3)
   rs("raddr1")   =extdb(4)
   rs("rzone1")   =extdb(5)
   rs("cutid2")   =extdb(6)
   rs("township2")=extdb(7)
   rs("raddr2")   =extdb(8)
   rs("rzone2")   =extdb(9)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
else
   rs.addnew
   rs("cusid")    =dspkey(0)
   rs("cusnc")    =extdb(0)
   rs("shortnc")  =extdb(1)
   rs("cutid1")   =extdb(2)
   rs("township1")=extdb(3)
   rs("raddr1")   =extdb(4)
   rs("rzone1")   =extdb(5)
   rs("cutid2")   =extdb(6)
   rs("township2")=extdb(7)
   rs("raddr2")   =extdb(8)
   rs("rzone2")   =extdb(9)
   rs("eusr")     =dspkey(7)
   rs("edat")     =dspkey(8)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
end if
rs.close
'-----save RTOBJLINK
SQL="SELECT cusid,custyid,EUSR,EDAT,UUSR,UDAT " _
   &"FROM RTobjLink where CUSID ='" & dspkey(0) & "' and custyid='06' " 
rs.Open sql,conn,3,3
if not rs.EOF then
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
else
   rs.addnew
   rs("cusid")    =dspkey(0)
   rs("custyid")  ="06"  
   rs("eusr")     =dspkey(7)
   rs("edat")     =dspkey(8)
   rs("uusr")     =dspkey(9)
   rs("udat")     =dspkey(10)
   rs.update
end if     
rs.close
conn.close
set rs=nothing
set conn=nothing
objectcontext.setcomplete  
End Sub
' -------------------------------------------------------------------------------------------- 
%>
