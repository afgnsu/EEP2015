<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM Conn
   Set Conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   Conn.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTLessorAVSCust WHERE CUSID='" & KEY(2) & "' "
   sqlyy="select * FROM RTLessorAVScmtyline WHERE comq1=" & KEY(0) & " and lineq1=" & KEY(1)
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,Conn
   RSyy.OPEN SQLyy,Conn
   if rsyy.eof then
      xxlinegroup=""
   else
      xxlinegroup=rsyy("linegroup")
   end if
   rsyy.close
   if xxlinegroup="" then
      sqlyy="select max(ip14) as ip14 from RTLessorAVScust where comq1=" & key(0) & " and lineq1=" & key(1) & " and ltrim(rtrim(ip11))='192' and ltrim(rtrim(ip12))='168' and ltrim(rtrim(ip13))='6' "
   else
      sqlyy="select max(ip14) as ip14 from RTLessorAVScust inner join RTLessorAVScmtyline on RTLessorAVScust.comq1=RTLessorAVScmtyline.comq1 and RTLessorAVScust.lineq1=RTLessorAVScmtyline.lineq1 where linegroup='" & xxlinegroup & "'  and ltrim(rtrim(ip11))='192' and ltrim(rtrim(ip12))='168' and ltrim(rtrim(ip13))='6' "
   end if
   rsyy.open SQLyy,Conn
   endpgm="1"
   '���Τ�w��IP��ơA���i���Ƥ��t
   IF LEN(TRIM(RSXX("IP11"))) <> 0 or LEN(TRIM(RSXX("IP12"))) <> 0 or LEN(TRIM(RSXX("IP13"))) <> 0 or LEN(TRIM(RSXX("IP14"))) <> 0 tHEN
      ENDPGM="3"
   '���Τ�w�@�o�A���i���tIP�C
   elseif LEN(TRIM(RSXX("CANCELDAT"))) <> 0 then
      endpgm="4"  
   '�Lip�i���t
   elseif RSyy("ip14") = "254" then
      endpgm="6"        
   '���D�u(�ΥD�u�s��)�U���Τ�IP�w�����o��A�L�k������tIP�@�~
   elseif LEN(TRIM(RSXX("DROPDAT"))) <> 0 then
      endpgm="5"        
   ELSE
     '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorAVSCustAutoIP " & KEY(0) & "," & KEY(1) & ",'" & key(2) & "','" & V(0) & "'" 
      Set ObjRS = conn.Execute(strSP)
      If Err.number = 0 then
         ENDPGM="1"
         ERRMSG=""
         'conn.CommitTrans
      else
         ENDPGM="2"
         errmsg=cstr(Err.number) & "=" & Err.description
         'conn.rollbackTrans
      end if         

   END IF
   RSXX.CLOSE
   RSYY.CLOSE
   Conn.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   set Conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City�Τ�IP���t���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Τ�w��IP��ơA���i���Ƥ��t" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Τ�w�@�o�A���i���tIP�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���Τ�w�h���A���i���tIP�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="6" then
       msgbox "���D�u(�ΥD�u�s��)�U���Τ�IP�w�����o��A�L�k������tIP�@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
   else
       msgbox "�L�k����Τ�IP���t�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVSCustAUTOIP.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>