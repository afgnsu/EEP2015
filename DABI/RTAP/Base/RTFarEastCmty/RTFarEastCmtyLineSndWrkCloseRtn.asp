<%@ Language=VBScript %>
<% KEY=SPLIT(REQUEST("KEY"),";")
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM RTfareastSndWrk WHERE wrkno ='" & KEY(0) & "' "
   RSXX.OPEN SQLXX,CONNxx
   wrktyp = RSXX("wrktyp")
   endpgm="1"
   IF ISNULL(RSXX("closedat"))   THEN
      ENDPGM="3"
  ELSE
      strSP="update RTfareastSndWrk set closedat=null, closeusr='' where wrkno ='" & KEY(0) & "' "
      if wrktyp ="10" then		'�i�u
			strSP = strSP & "update RTfareastCmtyLine set hardwaredat=null where comq1=" &key(1)&" and lineq1 = " &key(2)
      elseif wrktyp ="07" then	'�M�u
			strSP = strSP & "update RTfareastCmtyLine set dropdat=null, dropkind='' where comq1=" &key(1)&" and lineq1 = " &key(2)
	  end if

      Set ObjRS = connXX.Execute(strSP)
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
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���Ǥj�e�W���ϫ��D�u���u�浲�ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�D�u���u��|�����סA���i���浲�ת���C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    else
       msgbox "�L�k����D�u���u�浲�ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action="" ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>