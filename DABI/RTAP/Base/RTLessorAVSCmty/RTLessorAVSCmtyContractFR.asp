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
   sqlxx="select * FROM RTLessorAVSCmtyContract WHERE comq1=" & KEY(0) & " AND CONTRACTNO='" & KEY(1) & "' "
   'RESPONSE.Write SQLXX
 '  RESPONSE.END
   RSXX.OPEN SQLXX,Conn
   endpgm="1"
   '��Τ�w���סA���i�����@�o==>�����ĵ��ת���覡
   IF ISNULL(RSXX("closedat")) THEN
      ENDPGM="3"
   elseif LEN(TRIM(RSXX("CANCELdat"))) <> 0 then
      endpgm="4"
   elseif LEN(TRIM(RSXX("CONTDAT"))) <> 0 or RSXX("CONTcnt") > 0 then
      endpgm="5"      
   ELSE
      XXBATCHNO=RSXX("BATCHNO")
      IF LEN(TRIM(XXBATCHNO)) > 0 THEN
         SQLYY="Select * from RTLessorAVSCmtyAR WHERE BATCHNO='" & XXBATCHNO & "'"
         RSYY.OPEN SQLYY,CONN
         IF NOT RSYY.EOF THEN
            IF NOT ISNULL(RSYY("MDAT")) OR RSYY("REALAMT") > 0 THEN
               ENDPGM="6"
            ELSE
              '�I�sstore procedure��s�����ɮ�
               strSP="usp_RTLessorAVSCmtyContractFR " & key(0) & ",'" & key(1) & "','" & V(0) & "'" 
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
          ELSE
             ENDPGM="7"
          END IF
   END IF
   RSXX.CLOSE
   Conn.Close
   SET RSXX=NOTHING
   set Conn=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS-City���ϦX����Ƶ��ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "�����ϦX����Ʃ|�����סA���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����ϦX����Ƥw�@�o�A���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close          
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����ϦX����Ƥw�s�b�����ơA���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close        
    elseIF frm1.htmlfld.value="6" then
       msgbox "�����ϦX����Ƥ����I�b�ڤw�R�b�A���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="7" then
       msgbox "�䤣�즹���ϦX����Ƥ����I�b�ڡA���i���ת���" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                             
    else
       msgbox "�L�k������ϦX����Ƶ��ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorAVSCmtyContractFR.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>