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
   sqlxx="select * FROM RTEBTCMTYLINE WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,CONNxx
   endpgm="1"
   '��(�ӽаe��渹�Bip�B�D�u�ӽФ�B�D�u�ӽ����ɤ�B�����q�ܡB���q�鵥���@���)�����ťծɡA��ܥثe���A���e��ӽФ��A�����]���i������e���
   IF LEN(TRIM(RSXX("APPLYPRTNO"))) <> 0 or LEN(TRIM(RSXX("lineIP"))) <> 0 or LEN(TRIM(RSXX("UPDEBTCHKDAT"))) <> 0  or LEN(TRIM(RSXX("LINETEL"))) <> 0 or LEN(TRIM(RSXX("ADSLAPPLYDAT"))) <> 0 THEN
      ENDPGM="3"
   ELSE
      sqlyy="select TOP 1 * FROM RTEBTCMTYLINEapplylog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1)  & " ORDER BY ENTRYNO "
      rsyy.Open sqlyy,connxx
      IF RSyy("CHGCODE") <> "RT" THEN
         ENDPGM="4"
         rsyy.close
      eLse
         '�Ȧs�ŦX���󤧲��ʸ�Ƥ��e�A�H����UPD �D�ɮɨϥ�
         'progressid=rsyy("progressid")
         linetel=rsyy("linetel")
         updebtchkdat=rsyy("updebtchkdat")
         updebtchkusr=rsyy("updebtchkusr")
         updebtdat=rsyy("updebtdat")
         ebtreplydat=rsyy("ebtreplydat")
         ebtreplaycode=rsyy("ebtreplaycode")
         HINETNOTIFYDAT=rsyy("HINETNOTIFYDAT")
         EBTERRORCODE=rsyy("EBTERRORCODE")
         APPLYNO=rsyy("APPLYNO")
         SCHAPPLYDAT=rsyy("SCHAPPLYDAT")
         CHTRCVD=rsyy("CHTRCVD")
         SUGGESTTYPE=rsyy("SUGGESTTYPE")
         REPEATREASON=rsyy("REPEATREASON")
         TRANSNOAPPLY=rsyy("TRANSNOAPPLY")
         LINEIP=rsyy("LINEIP")
         GATEWAY=rsyy("GATEWAY")
         SUBNET=rsyy("SUBNET")
         DNSIP=rsyy("DNSIP")
         PPPOEACCOUNT=rsyy("PPPOEACCOUNT")
         PPPOEPASSWORD=rsyy("PPPOEPASSWORD")
         applyprtno=rsyy("applyprtno")
         rsyy.close
         sqlyy="select max(entryno) as entryno FROM RTEBTCMTYLINEapplylog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) 
         rsyy.Open sqlyy,connxx      
      
         if len(trim(rsyy("entryno"))) > 0 then
            entryno=rsyy("entryno") + 1
         else
            entryno=1
         end if
         rsyy.close
         set rsyy=nothing
         '�Ѳ{���D�ɥ����ͤ@�����ʰO���A�A�ӥ��e�Ȧs�����ʸ�Ƨ�s�D��
         sqlyy="insert into RTEBTCMTYLINEapplylog " _
           &"SELECT   COMQ1, LINEQ1, " & entryno & ",getdate(),'RN','" & v(0) & "',CONSIGNEE, AREAID, GROUPID, SALESID, LINEIP, GATEWAY, " _
           &"SUBNET, DNSIP, PPPOEACCOUNT, PPPOEPASSWORD, LINETEL, LINERATE, " _
           &"CUTID, TOWNSHIP, VILLAGE, COD1, NEIGHBOR, COD2, STREET, COD3, SEC, " _
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
           &"SCHAPPLYDAT, CHTRCVD, SUGGESTTYPE, REPEATREASON,EUSR,EDAT,UUSR,UDAT,TELCOMROOM,DROPDAT,TRANSNOAPPLY,TRANSNODOCKET " _
           &"FROM RTEBTCMTYLINE where comq1=" & key(0) & " and lineq1=" & key(1)
        ' Response.Write sqlyy
         CONNXX.Execute sqlyy     
         If Err.number > 0 then
            endpgm="2"
            errmsg=cstr(Err.number) & "=" & Err.description
         else
            SQLXX=" update RTEBTCMTYline set PROGRESSID='RN',LINETEL='" & LINETEL & "',UPDEBTCHKDAT='" & UPDEBTCHKDAT & "',UPDEBTCHKUSR='" & UPDEBTCHKUSR & "',UPDEBTDAT='" & UPDEBTDAT & "'," _
                 &"EBTREPLYDAT='" & EBTREPLYDAT & "',EBTREPLaYCODE='" & EBTREPLAYCODE & "',HINETNOTIFYDAT='" & HINETNOTIFYDAT & "',EBTERRORCODE='" & EBTERRORCODE & "',APPLYNO='" & APPLYNO & "',SCHAPPLYDAT='" & SCHAPPLYDAT & "',CHTRCVD='" & CHTRCVD & "',SUGGESTTYPE='" & SUGGESTTYPE & "'," _
                 &"REPEATREASON='" & REPEATREASON & "',TRANSNOAPPLY='" & TRANSNOAPPLY & "',LINEIP='" & LINEIP &"',GATEWAY='" & GATEWAY & "',SUBNET='" & SUBNET &"',DNSIP='" &DNSIP & "',PPPOEACCOUNT='" & PPPOEACCOUNT & "',PPPOEPASSWORD='" & PPPOEPASSWORD & "',applyprtno='" & applyprtno & "' where comq1=" & KEY(0) & " and lineq1=" & key(1) 
            connxx.Execute SQLXX
            If Err.number > 0 then
               endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
               errmsg=cstr(Err.number) & "=" & Err.description
               sqlyy="delete * FROM RTEBTCMTYLINEapplylog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND ENTRYNO=" & ENTRYNO
               CONNXX.Execute sqlyy 
            else
               endpgm="1"
               errmsg=""
            end if      
         end if
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
       msgbox "�D�u�ӽаe���ƪ���ӽЦ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�D�u�ثe���b�ӽФ��Τw�}�q�A���i����e���ӽаO��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���D�u�̪�@���ӽаO���D[�M���ӽ�]�A�G�L�k�������ӽЧ@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k����D�u����ӽЧ@�~,���~�T���G" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylineclrprtno.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>