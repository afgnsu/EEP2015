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
   '���o�D�uIP
   endpgm="1"
   sqlxx="select * FROM RTSparq499Cmtyline WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
   rsxx.Open sqlxx,connxx
   if rsxx.EOF then
      endpgm="8"
   elseIF len(trim(rsxx("LINEIPSTR1")))=0 then
      endpgm="9"
   elseif ISNULL(rsxx("ADSLOPENDAT")) OR len(trim(rsxx("ADSLOPENDAT"))) = 0 then
      endpgm="11"
   else
      ip1=rsxx("LINEIPSTR1")
      ip2=rsxx("LINEIPSTR2")
      ip3=rsxx("LINEIPSTR3")
      ip4=rsxx("LINEIPSTR4")
      ipe=rsxx("LINEIPend")
      '�_�l�i��ip��ip1+1�A�Ĥ@��ip����ΡA�˼ƲĤ@��ip��atu-R�A�˼ƲĤG��IP��IDSLAM
      strip=cint(TRIM(ip4))+1
      '�I��i��IP���_�lIP+7 (�@8��IP)
      ENDIP=CINT(TRIM(STRIP))+7
   end if
   rsxx.close
if endpgm = "1" then
   NEWIP4=""
   for I=strip to endip 
       SQLXX="SELECT COUNT(*) AS CNT FROM RTSparq499Cust WHERE CUSTIP1=" & IP1 & " AND CUSTIP2=" & IP2 & " AND CUSTIP3=" & IP3 & " AND CUSTIP4=" & CSTR(I) 
       RSXX.Open SQLXX,CONNXX
       CNT=RSXX("CNT")
       RSXX.CLOSE
       IF CNT = 0 THEN
          NEWIP4=CSTR(i)
          EXIT FOR
       END IF
   next
   IF NEWIP4="" THEN
      endpgm="10"
   END IF
END IF
if endpgm = "1" then
 '  On Error Resume Next
   sqlxx="select * FROM RTSparq499Cust WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��Τ�w��ip�ɡA���i���Ш��o
   IF LEN(TRIM(RSXX("CUSTIP1"))) <> 0 THEN
      ENDPGM="3"
   '��Τ�w�@�o�ɡA���i���o
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   '��Τ�w�h���ɡA���i���o
   elseif LEN(TRIM(RSXX("DROPdat"))) <> 0 then
      endpgm="5"
   '��Τ�w���u�ɡA���i���o(���w���M)
   elseif LEN(TRIM(RSXX("FINISHdat"))) <> 0 then
      endpgm="6"
   '��Τ�w�����ɡA���i���o(���w���M)
   elseif LEN(TRIM(RSXX("DOCKETdat"))) <> 0 then
      endpgm="7"
   ELSE
      sqlyy="select max(entryno) as entryno FROM RTSparq499Custlog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
      rsyy.Open sqlyy,connxx
      
      if len(trim(rsyy("entryno"))) > 0 then
         entryno=rsyy("entryno") + 1
      else
         entryno=1
      end if
      rsyy.close
      set rsyy=nothing
      sqlyy="insert into RTSparq499Custlog(COMQ1, LINEQ1, CUSID, entryno, chgdat, chgcode,chgusr, CUSNC, " _
           &"FIRSTIDTYPE, SOCIALID, SECONDIDTYPE,SECONDNO, BIRTHDAY, EMAIL, CONTACTTEL, MOBILE, CUTID1, TOWNSHIP1, " _
           &"RADDR1, RZONE1, CUTID2, TOWNSHIP2, RADDR2, RZONE2, CUTID3, TOWNSHIP3, RADDR3, RZONE3, COCONTACT, COCONTACTTEL, " _
           &"COCONTACTTELEXT, COMOBILE, COBOSS, COBOSSSOCIAL, TRADETYPE, EUSR, EDAT, UUSR, UDAT, AREAID, GROUPID, SALESID, " _
           &"CASETYPE, FREECODE, PMCODE, PAYTYPE, AGENTNAME, AGENTSOCIAL, AGENTTEL, RCVD, APPLYDAT, FINISHDAT, DOCKETDAT," _
           &"TRANSDAT, DROPDAT, CANCELDAT, CANCELUSR, OVERDUE, MEMO, MOVETOCOMQ1, MOVETOLINEQ1, MOVEFROMCOMQ1, " _
           &"MOVEFROMLINEQ1, MOVETODAT, MOVEFROMDAT, NCICCUSNO, CUSTIP1, CUSTIP2, CUSTIP3, CUSTIP4,sphnno) " _
           &"SELECT  COMQ1, LINEQ1, CUSID, " & ENTRYNO & ", getdate(), 'IP','" & v(0) & "', CUSNC, " _
           &"FIRSTIDTYPE, SOCIALID, SECONDIDTYPE,SECONDNO, BIRTHDAY, EMAIL, CONTACTTEL, MOBILE, CUTID1, TOWNSHIP1, " _
           &"RADDR1, RZONE1, CUTID2, TOWNSHIP2, RADDR2, RZONE2, CUTID3, TOWNSHIP3, RADDR3, RZONE3, COCONTACT, COCONTACTTEL, " _
           &"COCONTACTTELEXT, COMOBILE, COBOSS, COBOSSSOCIAL, TRADETYPE, EUSR, EDAT, UUSR, UDAT, AREAID, GROUPID, SALESID, " _
           &"CASETYPE, FREECODE, PMCODE, PAYTYPE, AGENTNAME, AGENTSOCIAL, AGENTTEL, RCVD, APPLYDAT, FINISHDAT, DOCKETDAT," _
           &"TRANSDAT, DROPDAT, CANCELDAT, CANCELUSR, OVERDUE, MEMO, MOVETOCOMQ1, MOVETOLINEQ1, MOVEFROMCOMQ1, " _
           &"MOVEFROMLINEQ1, MOVETODAT, MOVEFROMDAT, NCICCUSNO, CUSTIP1, CUSTIP2, CUSTIP3, CUSTIP4,sphnno " _
           &"FROM RTSparq499Cust where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
     ' Response.Write sqlyy
      CONNXX.Execute sqlyy     
      If Err.number > 0 then
         endpgm="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      else
         SQLXX=" update RTSparq499Cust set CUSTIP1=" & IP1 & ",CUSTIP2=" & IP2 & ",CUSTIP3=" & IP3 & ",CUSTIP4=" & NEWIP4 & "  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
         connxx.Execute SQLXX
         If Err.number > 0 then
            endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
            errmsg=cstr(Err.number) & "=" & Err.description
            sqlyy="delete * FROM RTSparq499Custlog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & ENTRYNO
            CONNXX.Execute sqlyy 
         else
            endpgm="1"
            errmsg=""
         end if      
      end if
   END IF
   RSXX.CLOSE
 end if
 connXX.Close
 SET RSXX=NOTHING
 set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�Τ�IP���o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���Τ�w���oIP�A���i���Ш��o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���Τ�w�@�o�A���i����IP���o�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="5" then
       msgbox "���Τ�w�h���A���i����IP���o�@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "���Τ�w���u�ɡA���i���o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close     
    elseIF frm1.htmlfld.value="7" then
       msgbox "���Τ�w�����ɡA���i���o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close     
    elseIF frm1.htmlfld.value="8" then
       msgbox "�䤣��Τ���ݥD�u���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close            
    elseIF frm1.htmlfld.value="9" then
       msgbox "���Τ���ݥD�uIP���q�|���إߡA�L�k�o��Τ�IP" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    elseIF frm1.htmlfld.value="10" then
       msgbox "���Τ���ݥD�u��IP�w�����o��A�L�k�o��Τ�IP" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                
    elseIF frm1.htmlfld.value="11" then
       msgbox "���Τ���ݥD�u�|�����q�A���o�o��Τ�IP" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                       
    else
       msgbox "�L�k����Τ�IP���o�@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtsparq499custcancel.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>