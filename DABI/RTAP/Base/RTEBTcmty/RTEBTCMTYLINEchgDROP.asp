<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   DSN="DSN=RtLib"
   connXX.Open DSN
   endpgm="1"
 '  On Error Resume Next
   '�@�o�����ˬd
   '�����ʳ椤���s���ϥD�u(�Y�s���ϥD�u���u���Y�ѥ����ʳ�Ҳ���,�G���o�@�o)�w���q�ɡA�Y���i�@�o
   sqlxx="select * FROM RTEBTCMTYLINECHG WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND PRTNO='" & KEY(2) & "' "
   rsxx.Open sqlxx,connxx
   DROPDAT=rsxx("DROPDAT")
   UPDEBTCHKDAT=rsxx("UPDEBTCHKDAT")
   FINISHDAT=rsxx("FINISHDAT")
   NCOMQ1=0
   NLINEQ1=0
   NCOMQ1=RSXX("NCOMQ1")
   NLINEQ1=RSXX("NLINEQ1")
   RSXX.CLOSE
   IF NCOMQ1 > 0 OR NLINEQ1 > 0 THEN
      sqlxx="select * FROM RTEBTCMTYLINE WHERE comq1=" & NCOMQ1 & " and lineq1=" & NLINEQ1 
      RSXX.Open SQLXX,CONNXX
      IF NOT RSXX.EOF THEN
         IF LEN(TRIM(RSXX("UPDEBTCHKDAT"))) > 0 OR LEN(TRIM(RSXX("ADSLAPPLYDAT"))) > 0 THEN
            ERRFLG="Y"
         ELSE
            ERRFLG="N"
         END IF
      ELSE
         ERRFLG="N"
      END IF
      RSXX.CLOSE
   END IF
IF ERRFLG="Y" THEN
   ENDPGM="6"   
ELSE
   if LEN(TRIM(DROPDAT)) > 0 OR NOT ISNULL(DROPDAT) then
     endpgm="3"
   ELSEif LEN(TRIM(UPDEBTCHKDAT)) > 0  OR NOT ISNULL(UPDEBTCHKDAT) then
     endpgm="4"
   ELSEif LEN(TRIM(FINISHDAT)) > 0  OR NOT ISNULL(FINISHDAT) then
     endpgm="5"     
   else
     sqlXX="select max(ENTRYNO) as ENTRYNO FROM RTEBTCMTYLINECHGLOG WHERE comq1=" & KEY(0) & " and lineq1=" & key(1)  & " AND PRTNO='" & KEY(2) & "' " 
     rsXX.Open sqlXX,connxx
     if len(trim(rsXX("ENTRYNO"))) > 0 then
        ENTRYNO=rsXX("ENTRYNO") + 1
     else
        ENTRYNO=1
     end if
     rsXX.close
     '���Ͳ��ʰO��
     sqlXX="insert into RTEBTCMTYLINECHGlog " _
          &"select  COMQ1, LINEQ1, PRTNO," & ENTRYNO & ", GETDATE(),'C','" & V(0) & "', " _
          &"APPLYDAT, PRTDAT, PRTUSR, CHGCOD1, CHGCOD2, CHGCOD3, NCOMQ1, " _
          &"NLINEQ1, UPDEBTCHKDAT, UPDEBTTNSDAT, UPDEBTTNSNO, EBTREPLYDAT, " _
          &"EBTREPLYSTS, EUSR, EDAT, UUSR, UDAT, MEMO, FINISHDAT, DOCKETDAT, " _
          &"TRANSDAT,TRANSNO, EBTREPLYFHDAT, EBTREPLYFHSTS,DROPDAT,DROPUSR " _
          &"FROM RTEBTCMTYLINECHG where comq1=" & key(0) & " and lineq1=" & key(1) & " and PRTNO='" & key(2) & "' "
    ' Response.Write sqlyy
     CONNXX.Execute sqlXX    
     If Err.number > 0 then
        endpgm="2"
        errmsg=cstr(Err.number) & "=" & Err.description
     else
        SQLXX=" update RTEBTCMTYLINECHG set dropdat=getdate(),dropUSR='" & V(0) & "' where comq1=" & KEY(0) & " and lineq1=" & key(1) & " and PRTNO='" & key(2) & "' "
        connxx.Execute SQLXX
        If Err.number > 0 then
           endpgm="2"
           '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
           errmsg=cstr(Err.number) & "=" & Err.description
           sqlXX="delete * FROM RTEBTCMTYLINECHGlog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " and PRTNO='" & key(2) & "' and entryno=" & ENTRYNO 
           CONNXX.Execute sqlXX
        else
           endpgm="1"
           errmsg=""
        end if      
      end if
      
      '=====(�������ʤ������ϥD�u�����X���ϧǸ��B�D�u�Ǹ��M���β��ʬ�������==================
      IF NCOMQ1>0 or NLINEQ1 > 0 THEN
         sqlXX="select max(ENTRYNO) as ENTRYNO FROM RTEBTCMTYLINELOG WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
         rsXX.Open sqlXX,connxx
         if len(trim(rsXX("ENTRYNO"))) > 0 then
            ENTRYNO=rsXX("ENTRYNO") + 1
         else
            ENTRYNO=1
         end if
         rsXX.close
         '���Ͳ��ʰO��(�D�u���X����)
         sqlXX="insert into RTEBTCMTYLINElog " _
           &"SELECT  COMQ1, LINEQ1," & ENTRYNO & ", GETDATE(),'DO','" & V(0) & "', " _
           &" CONSIGNEE, AREAID, GROUPID, SALESID, LINEIP, GATEWAY, " _
           &"SUBNET, DNSIP, PPPOEACCOUNT, PPPOEPASSWORD, LINETEL, LINERATE, " _
           &"CUTID, TOWNSHIP, VILLAGE, COD1, NEIGHBOR, COD2, STREET, COD3, SEC," _ 
           &"COD4, LANE, COD5, TOWN, COD6, ALLEYWAY, COD7, NUM, COD8, FLOOR, " _
           &"COD9, ROOM, COD10, ADDROTHER, RZONE, CUTID1, TOWNSHIP1, RADDR1, " _
           &"RZONE1, CUTID2, TOWNSHIP2, RADDR2, RZONE2, RCVDAT, INSPECTDAT, " _
           &"AGREE, UNAGREEREASON, TECHCONTACT, TECHENGNAME, CONTACT1, " _
           &"CONTACT2, CONTACTMOBILE, CONTACTTEL, CONTACTEMAIL, CONTACTTIME1, " _
           &"CONTACTTIME2, UPDEBTCHKDAT, UPDEBTCHKUSR, UPDEBTDAT, " _
           &"EBTREPLYDAT, EBTREPLAYCODE, PROGRESSID, HINETNOTIFYDAT, " _
           &"ADSLAPPLYDAT, APPLYUPLOADDAT, APPLYUPLOADUSR, APPLYUPLOADTNS, " _
           &"EBTERRORCODE, SUPPLYRANGE, COBOSS, COBOSSENG, COID, COBOSSID, " _
           &"APPLYNAMEC, APPLYNAMEE, ENGADDR, CONTACTSTRTIME, " _
           &"CONTACTENDTIME, ADSLAPPLYUSR, APPLYPRTNO, MEMO, APPLYNO, " _
           &"SCHAPPLYDAT, CHTRCVD, SUGGESTTYPE, REPEATREASON, EUSR, EDAT, " _
           &"UUSR, UDAT, TELCOMROOM, DROPDAT, TRANSNOAPPLY, TRANSNODOCKET, " _
           &"LOANNAME, LOANSOCIAL, LOCKDAT,NULL,'', CANCELDAT, CANCELUSR,MOVETOCOMQ1,MOVETOLINEQ1,MOVETODAT,MOVEFROMCOMQ1,MOVEFROMLINEQ1,MOVEFROMDAT  " _
           &"FROM RTEBTCMTYLINE where comq1=" & key(0) & " and lineq1=" & key(1)  
        ' Response.Write sqlyy
         CONNXX.Execute sqlXX    
         If Err.number > 0 then
            endpgm="2"
            errmsg=cstr(Err.number) & "=" & Err.description
         else
            SQLXX=" update RTEBTCMTYLINE set movetocomq1=0,movetolineq1=0,movetodat=null where comq1=" & KEY(0) & " and lineq1=" & key(1) 
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlXX="delete * FROM RTEBTCMTYLINElog WHERE comq1=" & key(0) & " and lineq1=" & key(1)  & " and entryno=" & ENTRYNO 
               CONNXX.Execute sqlXX
            else
               endpgm="1"
               errmsg=""
            end if      
         end if
         '=====(�������ʤ����s���ϥD�u�����J���ϧǸ��B�D�u�Ǹ��M���β��ʬ�������==================
         sqlXX="select max(ENTRYNO) as ENTRYNO FROM RTEBTCMTYLINELOG WHERE comq1=" & ncomq1 & " and lineq1=" & nlineq1
         rsXX.Open sqlXX,connxx
         if len(trim(rsXX("ENTRYNO"))) > 0 then
            ENTRYNO=rsXX("ENTRYNO") + 1
         else
            ENTRYNO=1
         end if
         rsXX.close
         '���Ͳ��ʰO��(�D�u���X����)
         sqlXX="insert into RTEBTCMTYLINElog " _
           &"SELECT  COMQ1, LINEQ1," & ENTRYNO & ", GETDATE(),'DI','" & V(0) & "', " _
           &" CONSIGNEE, AREAID, GROUPID, SALESID, LINEIP, GATEWAY, " _
           &"SUBNET, DNSIP, PPPOEACCOUNT, PPPOEPASSWORD, LINETEL, LINERATE, " _
           &"CUTID, TOWNSHIP, VILLAGE, COD1, NEIGHBOR, COD2, STREET, COD3, SEC," _ 
           &"COD4, LANE, COD5, TOWN, COD6, ALLEYWAY, COD7, NUM, COD8, FLOOR, " _
           &"COD9, ROOM, COD10, ADDROTHER, RZONE, CUTID1, TOWNSHIP1, RADDR1, " _
           &"RZONE1, CUTID2, TOWNSHIP2, RADDR2, RZONE2, RCVDAT, INSPECTDAT, " _
           &"AGREE, UNAGREEREASON, TECHCONTACT, TECHENGNAME, CONTACT1, " _
           &"CONTACT2, CONTACTMOBILE, CONTACTTEL, CONTACTEMAIL, CONTACTTIME1, " _
           &"CONTACTTIME2, UPDEBTCHKDAT, UPDEBTCHKUSR, UPDEBTDAT, " _
           &"EBTREPLYDAT, EBTREPLAYCODE, PROGRESSID, HINETNOTIFYDAT, " _
           &"ADSLAPPLYDAT, APPLYUPLOADDAT, APPLYUPLOADUSR, APPLYUPLOADTNS, " _
           &"EBTERRORCODE, SUPPLYRANGE, COBOSS, COBOSSENG, COID, COBOSSID, " _
           &"APPLYNAMEC, APPLYNAMEE, ENGADDR, CONTACTSTRTIME, " _
           &"CONTACTENDTIME, ADSLAPPLYUSR, APPLYPRTNO, MEMO, APPLYNO, " _
           &"SCHAPPLYDAT, CHTRCVD, SUGGESTTYPE, REPEATREASON, EUSR, EDAT, " _
           &"UUSR, UDAT, TELCOMROOM, DROPDAT, TRANSNOAPPLY, TRANSNODOCKET, " _
           &"LOANNAME, LOANSOCIAL, LOCKDAT,NULL,'', CANCELDAT, CANCELUSR,MOVETOCOMQ1,MOVETOLINEQ1,MOVETODAT,MOVEFROMCOMQ1,MOVEFROMLINEQ1,MOVEFROMDAT " _
           &"FROM RTEBTCMTYLINE where comq1=" & NCOMQ1 & " and lineq1=" & NLINEQ1
        ' Response.Write sqlyy
         CONNXX.Execute sqlXX    
         If Err.number > 0 then
            endpgm="2"
            errmsg=cstr(Err.number) & "=" & Err.description
         else
            SQLXX=" update RTEBTCMTYLINE set moveFROMcomq1=0,moveFROMlineq1=0,moveFROMdat=null where comq1=" & NCOMQ1 & " and lineq1=" & NLINEQ1 
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlXX="delete * FROM RTEBTCMTYLINElog WHERE comq1=" & NCOMQ1 & " and lineq1=" & NLINEQ1  & " and entryno=" & ENTRYNO 
               CONNXX.Execute sqlXX
            else
               endpgm="1"
               errmsg=""
            end if      
         end if
          
       END IF 
    END IF
 END IF
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "�D�u���ʸ�Ƨ@�o���\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����D�u���ʸ�Ƥw�Q�@�o�A���i���Ч@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����D�u���ʤw�VEBT���X�ӽСA���i�@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close    
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����D�u���ʤw���u�A���i�@�o" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                 
    elseIF frm1.htmlfld.value="6" then
       msgbox "�������ʤ����s���ϥD�u�w���X�u�������ӽЩνu���w���q�A���i�@�o�����ʸ��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    else
       msgbox "�L�k����D�u���ʸ�Ƨ@�o,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post  ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>