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
   sqlxx="select * FROM hbcmtyarrangesndwork WHERE comq1=" & KEY(0) & " and comtype='" & key(1)  & "' and prtno='" & key(2) & "' "
   'IF1S
   IF ENDPGM="" THEN
      'RESPONSE.Write SQLXX
   '  RESPONSE.END
     RSXX.OPEN SQLXX,CONNxx
     endpgm="1"
     '��w�@�o�ɡA���i���槹�u���שΥ����u���ת���
     'IF2S
     IF not isnull(RSXX("DROPDAT")) THEN
        ENDPGM="4"
     elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("AUDITDAT"))) <> 0 then
        endpgm="5"
     elseif isnull(RSXX("CLOSEDAT")) then
   '  response.Write "aaa"
   '  response.end
        endpgm="3"      
     ELSE
        sqlyy="select max(entryno) as entryno FROM hbcmtyarrangesndworklog WHERE comq1=" & KEY(0) & " and comtype='" & key(1)  & "' and prtno='" & key(2) & "' "
        rsyy.Open sqlyy,connxx
        'IF3-1S
        if len(trim(rsyy("entryno"))) > 0 then
           entryno=rsyy("entryno") + 1
        else
           entryno=1
        end if
        'IF3-1E
        rsyy.close
        set rsyy=nothing
        '���u���ת���
        'IF3-2S
        IF LEN(TRIM(RSXX("CLOSEDAT"))) > 0 THEN
        sqlyy="insert into hbcmtyarrangesndworklog " _
           &"SELECT    COMQ1, COMTYPE, PRTNO, " & ENTRYNO & ", getdate(), 'FR','" &  v(0) & "', " _
           &" SNDDAT, ASSIGNENGINEER, ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, " _
           &" CLOSEDAT, EUSR, EDAT, UUSR, UDAT, CLOSEUSR, DROPUSR, EQUIPCUTID, EQUIPTOWNSHIP, EQUIPADDR, ERZONE, " _
           &" PRTDAT, PRTUSR, MEMO, BONUSCLOSEYM, BONUSCLOSEDAT, BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, " _
           &" STOCKCLOSEDAT, STOCKCLOSEUSR, STOCKFINCHK " _
           &" FROM hbcmtyarrangesndwork where comq1=" & key(0) & " and comtype='" & key(1) & "' and prtno='" & key(2) & "' "
        END IF
        'IF3-2E
     ' Response.Write sqlyy
        CONNXX.Execute sqlyy     
        'IF3-3S
        If Err.number > 0 then
           endpgm="2"
           errmsg=cstr(Err.number) & "=" & Err.description
        else
           '���u���ת���
           'IF4-1S
           IF LEN(TRIM(RSXX("CLOSEDAT"))) > 0 THEN
              SQLXX=" update hbcmtyarrangesndwork set CLOSEdat=NULL,CLOSEUSR='' where comq1=" & key(0) & " and comtype='" & key(1) & "' and prtno='" & key(2) & "' "
              connxx.Execute SQLXX
              'IF5-1S
              If Err.number > 0 then
                 endpgm="2"
                '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                 errmsg=cstr(Err.number) & "=" & Err.description
                 sqlyy="delete * FROM hbcmtyarrangesndworklog where comq1=" & key(0) & " and comtype='" & key(1) & "' and prtno='" & key(2) & "' AND ENTRYNO=" & ENTRYNO
                 CONNXX.Execute sqlyy 
                 endpgm="1"
                 errmsg=""
              end if      
              'IF5-1E
             END IF
           'IF4-1E
        end if
        'IF3-3E
     END IF
     'IF2E
     RSXX.CLOSE
   END IF
   'IF1E
   connXX.Close
   SET RSXX=NOTHING
   set connXX=nothing
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "���Ͼ�u���u�槹�u���ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "����u���u��|�����סA���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "����u���u��w�@�o�A���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="5" then
       msgbox "����u���u��w�뵲�Τw�f��(�мf�֤H���Ѱ��f�ֱ���)�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close              
    else
       msgbox "�L�k�����u�u�槹�u���ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=rtebtcmtylinesndworkdrop.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>