<!-- #include virtual="/WebUtilityV3/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include virtual="/Webap/include/RTcountyref.inc" -->
<!-- #include virtual="/Webap/include/RTarearef.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->

<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLIB"
  numberOfKey=2
  title="�~���ҰϻP�����O���Y���@"
  formatName="�ҰϥN�X;�����N�X;�ͮĤ��;�I����;��J�H��;��J���;���ʤH��;���ʤ��"
  sqlFormatDB="SELECT AREAID,CUTID,TDAT,EXDAT,eusr,edat,uusr,udat " _
             &"FROM RTAreacty WHERE areaid='*' and cutid='*' ;"
  sqlList="SELECT AREAID,CUTID,TDAT,EXDAT,eusr,edat,uusr,udat " _
             &"FROM RTAreacty WHERE " 
  userDefineData="Yes"
  userDefineKey="Yes"
  datatable="rtareacty"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'RECORD CHECK
    set conn=server.CreateObject("ADODB.connection")
    set rs=server.CreateObject("ADODB.recordset")
    DSN="DSN=Rtlib"
    sql="select * from rtareacty where areaid='" & dspkey(0) & "'" & " AND " & "cutid='" & dspkey(1) & "'"
    conn.Open dsn
    rs.Open sql,dsn,1,1
    if rs.recordcount > 0 and dspmode = "�s�W" then
       formvalid=False
       message="��ƭ���"
    end if
    rs.Close
    conn.Close
    set rs=nothing
    set conn=nothing    
' -------------------------------------------------------------------------------------------- 
'DATA CHECK    
'Check AREAID EXIST   
'-----------------------------------------------------------------
' OPT=2:��(areaTID)�P�_�ҰϥN�X�O�_�s�b
'-----------------------------------------------------------------
' rtnvalue="Y"��s�b
'-----------------------------------------------------------------          
    Call SrGetareaRef(rtnvalue,2,dspkey(0))
    RTN1=rtnvalue
'Check CUTID EXIST   
'-----------------------------------------------------------------
' OPT=2:��(CUTID)�P�_�����N�X�O�_�s�b
'-----------------------------------------------------------------
' rtnvalue="Y"��s�b
'-----------------------------------------------------------------          
    Call SrGetcountyRef(rtnvalue,2,dspkey(1))
    RTN2=rtnvalue
    If dspKey(0)="" Then
       formValid=False
       message="�п�J�ҰϥN�X"
    elseif  dspKey(1)="" Then
       formValid=False
       message="�п�J�����N�X"
    elseif dspKey(2)="" Then
       formValid=False
       message="�п�J�ͮĤ��"
    elseif not ISDATE(dspkey(2)) then
       formvalid=false
       message="�����ƿ��~"
    elseif UCASE(RTN1) ="" then
       formvalid=false
       message="�ҰϥN�X���s�b�A�Ц��ҰϥN�X���@�@�~�s�W"
    elseif UCASE(RTN1) ="2" then
       formvalid=false
       message="���ҰϥN�X��(�I�u�Ұ�),�����\��J"       
    elseif UCASE(RTN2) <>"Y" then
       formvalid=false
       message="�����N�X���s�b�A�Цܿ����N�X���@�@�~�s�W"   
    end if   
End Sub

Sub SrGetUserDefineData()
'Get Employee Name and EmployID   
'-----------------------------------------------------------------
' OPT=1:��(logon user)Ū�����u�������
' OPT=2:��(�u��)Ū���������
'-----------------------------------------------------------------
' V(0)=Emply(�u��)
' V(1)=cusnc(��H�W��)
' V(2)=shortnc(��H²��)
'-----------------------------------------------------------------
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(4))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(4)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(4))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(5)=datevalue(now())
    else
        if Len(trim(dspkey(6))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(6)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(6))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        if len(trim(dspkey(4)))=0 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(4)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(4))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
        dspkey(7)=datevalue(now())  
   end if
%>   
     <table border=1 cellPadding=0 cellSpacing=0 width="100%" align=center>
     <tr><td width="35%" class=dataListHead><%=aryKeyName(2)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key2" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN:  left"  
     value="<%=dspkey(2)%>"></td></tr>
     
     <tr><td width="35%" class=dataListHead><%=aryKeyName(3)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key3" <%=dataprotect%> maxlength=10 size=10 style="TEXT-ALIGN: left" value
            ="<%=dspkey(3)%>"></td></tr>   
            
     <tr><td width="35%" class=dataListHead><%=aryKeyName(4)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry  name="key4" <%=dataprotect%> maxlength=6 size=10 style="TEXT-ALIGN: left; dataProtect: "
            value="<%=dspkey(4)%>" readOnly><%=EUsrNC%></td></tr>  
              
     <tr><td width="35%" class=dataListHead><%=aryKeyName(5)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key5" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(5)%>" readOnly></td></tr>
            
     <tr><td width="35%" class=dataListHead><%=aryKeyName(6)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key6" maxlength=6 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(6)%>" readOnly><%=UusrNc%></td></tr>
            
     <tr><td width="35%" class=dataListHead><%=aryKeyName(7)%></td><td width="65%" bgcolor=silver>
     <input class=dataListEntry name="key7" maxlength=10 size=10    
            style="TEXT-ALIGN: left" value="<%=dspkey(7)%>" readOnly></td></tr></table></TABLE>
<%End Sub%>

<%Sub SrGetUserDefineKey() 
'Get RTCounty Name   
'-----------------------------------------------------------------
' OPT=1:��(CUTID)Ū�������W��
'-----------------------------------------------------------------
' V(0)=cutnc(�����W��)
'-----------------------------------------------------------------   
     if dspmode <> "�s�W" then
        Call SrGetcountyRef(rtnvalue,1,dspkey(1))
        V=split(rtnvalue,";")      
        cutnc=V(0)
'Get RTArea Name   
'-----------------------------------------------------------------
' OPT=1:��(areaTID)Ū���ҰϦW��
'-----------------------------------------------------------------
' V(0)=areanc(�ҰϦW��)
'-----------------------------------------------------------------           
        Call SrGetareaRef(rtnvalue,1,dspkey(0))
        V=split(rtnvalue,";")      
        areanc=V(0)   
     end if
     if areanc="" then
        areanc="&nbsp;"
     end if
     if cutnc="" then
        cutnc="&nbsp;"
     end if          
 %>     
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%" border=1 cellPadding=0 cellSpacing=0>
       <tr><td width="50%" class=dataListHead>�ҰϥN�X</td><td width="15%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key0"
                 <%=keyProtect%> size="2" value="<%=dspKey(0)%>" maxlength="2" ></td>
                 <td width="35%" align="left" bgcolor=silver><%=areanc%></td></tr>
       <tr><td width="50%" class=dataListHead>�����N�X</td><td width="15%" bgcolor=silver>
           <input class=dataListEntry type="text" name="key1"
                 <%=keyProtect%> size="2" value="<%=dspKey(1)%>" maxlength="2" ></td>
                 <td width="35%" align="left" bgcolor=silver><%=cutnc%></td></tr>                 
      </table>
<%
End Sub%>
<!-- #include file="RTGetAreaDesc.inc" -->

