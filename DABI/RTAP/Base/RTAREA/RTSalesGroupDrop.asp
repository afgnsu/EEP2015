<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% dim parmkey,aryparmkey,logonid,conn,rs,sql
   parmKey=Request("Key")
   aryParmKey=Split(parmKey &";;;;;;;;;;;;;;;",";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   Set conn=Server.CreateObject("ADODB.Connection")  
   Set rs=server.CreateObject("ADODB.Recordset")
   DSN="DSN=RtLib"
   sql="select sdate,edate from RTSalesGroup where " _
      &" areaid='" & aryparmkey(0) & "' and groupid='" & aryparmkey(1) & "'"
   conn.Open DSN
   rs.Open sql,conn,3,3
      '----�����ӵ����_��������~�פΤ��(�����ˬd�뵲�����ɪ����--�Y�I����edate is null��ܸӵ���ƥثe���ͮĤ��A�H�t�Τ�����I���)
      if not IsNull(rs("SDATE")) then
         SYY=datepart("yyyy",rs("SDate"))
         SMM=right("0" & datepart("m",rs("Sdate")),2)
         SYYMM=SYY & SMM
      else
         SYY=0
         SMM=0
      End if
      if not IsNull(rs("EDATE")) then
         EYY=datepart("yyyy",rs("EDate"))
         EMM=right("0" & datepart("m",rs("Edate")),2)
         EYYMM=EYY & EMM
      else
         EYY=datepart("yyyy",now())
         EMM=right("0" & datepart("m",now()),2)
         EYYMM=EYY & EMM
      End if
   rs.close
   set rs=nothing    
      '----�ˬd�ӲէO��ͮĤ���ܺI�������A�O�_�����뵲�O��(�H�ҰϤΦ~�פ���ܤ뵲������Ū���뵲����)
       Set rs2=server.CreateObject("ADODB.Recordset")
       sql2="SELECT COUNT(*) AS CNT FROM RTClosingCTl " _
           &"WHERE LTRIM(STR(cyy)) + RIGHT('0' + LTRIM(STR(cmm)), 2) >= '" & Syymm & "' AND " _
           &"LTRIM(STR(cyy)) + RIGHT('0' + LTRIM(STR(cmm)), 2) <= '" & EYYMM & "' AND closing = 'Y' "
       rs2.Open sql2,conn           
       '---�ӵ����ʸ�Ƥ��w���뵲�O���ɡA���i�R��
       if rs2("cnt") > 0 then
          endpgm="3"
       '---���`�A�R�����]�ͮĤ�ܺI��餤�L�뵲�O���^
       else
          endpgm="1"
       end if
       rs2.close
       set rs2=nothing
    '----�R�����
    if endpgm="1" then
       sql="delete  from  RTSalesGroup where areaid='" & aryparmkey(0) & "' and groupid='" & aryparmkey(1) & "' " 
       conn.Execute sql 
    end if
    conn.Close

%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�~�ȲէO��Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
       winP.focus()              
    elseif frm1.htmlfld.value="3" then 
       msgbox "�ӲէO���ͮĤ���ܺI�������A�w����뵲�B�z�A�G���i�@�o" & "  " & errmsg
    end if
    window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="RTFaqDropK.asp">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>">
</form>
</html>