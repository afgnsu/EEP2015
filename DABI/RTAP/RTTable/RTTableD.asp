<!-- #include virtual="/WebUtilityV4/DBAUDI/zzDataList.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLIB"
  numberOfKey=1
  title="Table�򥻸�ƺ��@"
  formatName="Table�W��(�^);Table�W��(��);Owner;���O;�Ƶ�"
  sqlFormatDB="SELECT tbName, tbNameC, tbOwner, tbType, tbDesc " _
             &"FROM ATableList WHERE tbName ='*' "
  sqlList="SELECT tbName, tbNameC, tbOwner, tbType, tbDesc " _
         &"FROM ATableList WHERE "
  userDefineData="Yes"
  userDefineKey="Yes"
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'    set conn=server.CreateObject("ADODB.connection")
'    set rs=server.CreateObject("ADODB.recordset")
'    DSN="DSN=Rtlib"
'    sql="select * from rtcounty where CUTID='" & dspkey(0) & "'"
'    conn.Open dsn
'    rs.Open sql,dsn,1,1
'    if not rs.EOF and dspmode = "�s�W" then
'       formvalid=False
'       message="��ƭ���"
'    end if
'    rs.Close
'    conn.Close
'    set rs=nothing
'    set conn=nothing    

'    If dspKey(0)="" Then
'       formValid=False
'       message="�п�J�����N�X"
'    End If
'    If dspKey(1)="" Then
'       formValid=False
'       message="�п�J�����W��"
'    End If
    'If dspKey(2)="" Then
    '   formValid=False
    '   message="�п�J�Ұ����O"
    'End If
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
    'Select case dspkey(2)
    ' case "1"
    '   status1="Checked"
    ' case "2"
    '   status2="Checked"
    ' case else
    '   status1=""
    '   status2=""
    'End Select
'    logonid=session("userid")
'    logonid=session("userid")
'    if dspmode="�s�W" then
'        if len(trim(dspkey(2))) < 1 then
'           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
'                V=split(rtnvalue,";")  
'                EUsrNc=V(1) 
'                dspkey(2)=V(0)
'       else
'           Call SrGetEmployeeRef(rtnvalue,2,dspkey(2))
'               V=split(rtnvalue,";")      
'                EUsrNc=V(1)
'        End if  
'       dspkey(3)=datevalue(now())
'    else
'        if Len(trim(dspkey(4))) < 1 then
'           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
'                V=split(rtnvalue,";")  
'                UUsrNc=V(1)
'                DSpkey(4)=V(0)
'        else
'           Call SrGetEmployeeRef(rtnvalue,2,dspkey(4))
'                V=split(rtnvalue,";")      
'                UUsrNc=V(1)
'        End if         
'        if len(trim(dspkey(2)))=0 then
'           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
'                V=split(rtnvalue,";")  
'                EUsrNc=V(1) 
'                dspkey(2)=V(0)
'        else
'           Call SrGetEmployeeRef(rtnvalue,2,dspkey(2))
'                V=split(rtnvalue,";")      
'                EUsrNc=V(1)
'        End if  
'        dspkey(5)=datevalue(now())  
'   end if
%>   
     <table border=1 cellPadding=0 cellSpacing=0 width="100%" align=center>
     <tr>
     <td width="20%" class=dataListHead><%=aryKeyName(1)%></td>
     <td width="80%" bgcolor=silver>
        <input class=dataListEntry name="key1" maxlength=30 size=30 style="TEXT-ALIGN:left" 
			   value="<%=dspkey(1)%>"></td></tr>
			   
     <tr>
     <td width="20%" class=dataListHead><%=aryKeyName(2)%></td>
     <td width="80%" bgcolor=silver>
     <input class=dataListData name="key2" maxlength=15 size=20 style="TEXT-ALIGN:left" 
		    value="<%=dspkey(2)%>" readOnly ></td></tr>
     
     <tr>
     <td width="20%" class=dataListHead><%=aryKeyName(3)%></td>
     <td width="80%" bgcolor=silver>
     <input class=dataListData name="key3" maxlength=10 size=20 style="TEXT-ALIGN: left" 
            value="<%=dspkey(3)%>" readOnly></td></tr> 
     
     <tr>
     <td width="20%" class=dataListHead><%=aryKeyName(4)%></td>
     <td width="80%" bgcolor=silver>
     <input class=dataListEntry  name="key4" maxlength=100 size=70 style="TEXT-ALIGN: left "
            value="<%=dspkey(4)%>"></td></tr>    
            
     </table>
     </TABLE>

<%End Sub%>

<%Sub SrGetUserDefineKey()
%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
      <table width="100%">
       <tr><td width="30%" class=dataListHead>Table�W��(�^)</td><td width="70%" bgcolor=silver>
           <input class=dataListData type="text" name="key0"
                 <%=keyProtect%> size="30" value="<%=dspKey(0)%>" maxlength="30"></td></tr>
      </table>
<%End Sub%>

