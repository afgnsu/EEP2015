<!-- #include virtual="/Webap/include/EmployeeRef.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<%
    logonid=session("userid")
    Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")
  Domain=Mid(V(0),1,1)
  select case Domain
         case "T"
            DAreaID="='A1'"
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"
'--------------
    Dim rs,i,conn
    Dim search1Opt,search2Opt,search6Opt
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    Set rs=Server.CreateObject("ADODB.Recordset")
'--------- �~���Ұ�
    sql="SELECT RTArea.AREAID AS AreaID,RTArea.AREANC AS AreaNC, RTCounty.CUTID AS CutID, " _
           &"RTCounty.CUTNC AS CutNC " _
           &"FROM RTCounty INNER JOIN (RTArea INNER JOIN RTAreaCty ON RTArea.AREAID = " _
           &"RTAreaCty.AREAID and rtarea.areaid" & DareaID & ") ON RTCounty.CUTID = RTAreaCty.CUTID " _
           &"WHERE (((RTArea.AREATYPE)='1')) " _
           &"ORDER BY RTArea.AREAID, RTCounty.CUTID "
    rs.Open sql,conn

    preAreaID=""
    areaCnt=0
    search1Opt="<option value="";����"" selected>����</option>" &vbCrLf
    s=""
    Do While Not rs.Eof
       If preAreaID <> rs("AreaID") Then
          If areaCnt > 0 Then
             s=s &"</select>""" &vbCrLf      
          End If
          areaCnt=areaCnt + 1
          s=s &"aryCty(" &areaCnt &")=""<select name=""""search2"""" size=""""1"""">" _   
              &"<option value="""";����"""">����</option>"
          search1Opt=search1Opt &"<option value=""" &rs("AreaID") &";" &rs("AreaNC") &""">"  _
                                &rs("AreaNC") &"</option>" &vbCrLf

          preAreaID=rs("AreaID")
       End If
       s=s &"<option value=""""='" &rs("CutID") &"';" &rs("CutNC") &""""">" _
                             &rs("CutNC") &"</option>"    
       rs.MoveNext
    Loop 
    If areaCnt > 0 Then
       s=s &"</select>""" &vbCrLf
       s="Dim aryCty(" &areaCnt &")" &vbCrLf _
        &"aryCty(0)=""<select name=""""search2""""><option value=""""<>'*';����"""">����</option></select>""" &vbCrLf &s     
    End If     
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
%>
<html>
<head>
<link REL="stylesheet" HREF="/WebUtilityV4/DBAUDI/dataList.css" TYPE="text/css">
<link REL="stylesheet" HREF="dataList.css" TYPE="text/css">
<script language="VBScript">
Sub btn_onClick()
  dim aryStr,s,t,r
  aryStr=Split(document.all("search1").value,";")
  s2=aryStr(0)
  arystr=split(document.all("search2").value,";")
  S3=aryStr(0)
  S1=document.all("key1").value
  if len(trim(s1))=0 then
     msgbox "�~�פ����줣�i�ť�!"
  else
     prog="RTMonthCustP.asp" & "?PARM=" & S1 & ";" & S2 & ";" & S3
     Scrxx=window.screen.width
     Scryy=window.screen.height - 30
     StrFeature="top=0,left=0,scrollbars=yes,status=yes," _
            &"location=no,menubar=no,width=" & scrxx & "px" _
            &",height=" & scryy & "px" 
     Set diagWindow=window.open(prog,"",StrFeature)
  end if
End Sub
' -------------------------------------------------------------------------------------------- 
</script>
</head>
<body>
<form name=frm1 method=post action=rtcmtyprts.asp>
<table width="50%" align="center">
  <tr class=dataListTitle align=center>���ϥΤ��Ʋέp��</td><tr>
</table>
<table width="50%" border=1 cellPadding=0 cellSpacing=0 align="center">
<tr><td class=dataListHead width="40%">�~�פ��</td>
    <td width="60%"  bgcolor="silver">
<input type="text" name="key1" size="6"  maxlength="6" class="dataListEntry" >
     </td>
</tr>
<tr><td class=dataListHead width="40%">�Ұ�</td>
    <td width="60%"  bgcolor="silver">
      <select name="search1" size="1" class=dataListEntry>
      <%=search1Opt%>
      </select>
    </td></tr>
<tr><td class=dataListHead width="40%">�������O</td>
    <td width="60%" bgcolor="silver" >
      <select name="search2" size="1" class=dataListEntry>
        <option value=";����" selected>����</option>
        <option value="01;���T����">���T����</option>
        <option value="02;�F�T����">�F�T����</option>
        <option value="03;���U����">���U����</option>        
        <option value="04;���T�Υ��U����">���T�Υ��U����</option>        
      </select>
    </td></tr>
</table>
<table width="50%" align=right><tr><TD></td><td align="left">
  <input type="button" value=" �C�L " class=dataListButton name="btn" style="cursor:hand">
</td></tr></table>
</form>
</body>
</html>