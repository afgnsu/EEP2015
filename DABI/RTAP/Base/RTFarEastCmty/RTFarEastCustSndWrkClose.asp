<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlYY="select * FROM RTfareastCUST WHERE comq1=" & KEY(1) & " and lineq1=" & key(2) & " and cusid='" & key(3) & "' "
   RSYY.OPEN SQLYY,CONNxx
   sqlxx="select * FROM RTfareastSndWrk WHERE wrkno ='" & KEY(0) & "' "
   RSXX.OPEN SQLXX,CONNxx
   wrktyp = RSXX("wrktyp")
   workingdat = RSXX("workingdat")
   finishdat = RSXX("finishdat")
   endpgm="1"
   if wrktyp="02" and LEN(workingdat) = 0 then
      endpgm="6"
   elseif wrktyp="03" and LEN(workingdat) = 0 then
      endpgm="7"
   elseif wrktyp="04" and LEN(workingdat) = 0 then
      endpgm="8"
   elseif wrktyp="05" and LEN(workingdat) = 0 then
      endpgm="9"

   elseif wrktyp="02" and (not isnull(RSYY("finishdat"))) then
      endpgm="10"
   elseif wrktyp="03" and (not isnull(RSYY("overduedat"))) then
      endpgm="11"
   elseif wrktyp="04" and (not isnull(RSYY("dropdat"))) then
      endpgm="12"
   elseif wrktyp="05" and isnull(RSYY("dropdat")) then
      endpgm="13"
   elseif wrktyp="03" and (not isnull(RSYY("dropdat"))) then
      endpgm="14"
   elseif wrktyp="03" and isnull(RSYY("finishdat")) then
      endpgm="15"
   elseif wrktyp="04" and isnull(RSYY("finishdat")) then
      endpgm="16"

   elseif LEN(TRIM(RSXX("finishdat"))) = 0 then
      endpgm="3"
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("closedat"))) <> 0 then
      endpgm="5"      
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="update RTfareastSndWrk set closedat=getdate(),closeusr='" &V(0)& "' where wrkno='" &key(0)&"' "
      if wrktyp ="02" then
			strSP = strSP & " update RTfareastCust set finishdat='" & finishdat &"' where comq1=" &key(1)&" and lineq1 = " &key(2)&" and cusid = '" &key(3) &"' "
      elseif wrktyp ="03" then
			strSP = strSP & " update RTfareastCust set overduedat='" & workingdat &"' where comq1=" &key(1)&" and lineq1 = " &key(2)&" and cusid = '" &key(3) &"' "
      elseif wrktyp ="04" then
			strSP = strSP & " update RTfareastCust set dropdat='" & workingdat &"' where comq1=" &key(1)&" and lineq1 = " &key(2)&" and cusid = '" &key(3) &"' "
      elseif wrktyp ="05" then
			strSP = strSP & " update RTfareastCust set overduedat=null, dropdat = null where comq1=" &key(1)&" and lineq1 = " &key(2)&" and cusid = '" &key(3) &"' "
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
   RSYY.CLOSE
   connXX.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���Ǥj�e�W���ϫ��Ȥᬣ�u�浲�צ��\",0
       Set winP=window.Opener
       Set docP=winP.document
       docP.all("keyform").Submit
    elseIF frm1.htmlfld.value="3" then
       msgbox "�Ȥᬣ�u�楼���u�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="4" then
       msgbox "�Ȥᬣ�u��w�@�o�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="5" then
       msgbox "�Ȥᬣ�u��w���סA���i���е��סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="6" then
       msgbox "���u��L[�w�w�˾���]�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="7" then
       msgbox "���u��L[�w�w����]�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="8" then
       msgbox "���u��L[�w�w�h����]�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="9" then
       msgbox "���u��L[�w�w�_����]�A���i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener

    elseIF frm1.htmlfld.value="10" then
       msgbox "�Ȥ�w�˾����u�A�˾����u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="11" then
       msgbox "�Ȥ�w��PORT�A���u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="12" then
       msgbox "�Ȥ�w�h���A�h�����u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="13" then
       msgbox "�Ȥ᥼�h���A�_�����u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="14" then
       msgbox "�Ȥ�w�h���A���u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="15" then
       msgbox "�Ȥ᥼�˾����u�A���u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    elseIF frm1.htmlfld.value="16" then
       msgbox "�Ȥ᥼�˾����u�A�h�����u�椣�i���סC" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener

    else
       msgbox "�L�k����Ȥᬣ�u�浲�ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
    end if
    winP.focus()
    window.CLOSE
 end sub
</script> 
</head>  
<form name=frm1 method=post action="" ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>