<%@ Language=VBScript %>
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<% KEY=SPLIT(REQUEST("KEY"),";")
   logonid=session("userid")
   Call SrGetEmployeeRef(Rtnvalue,1,logonid)
         V=split(rtnvalue,";")  
   DIM conn
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   SET RSZZ=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   conn.Open DSN
   ' conn.BEGINTrans(���STORE PROCEDURE������TRANSACTION�BCOMMIT�BROLLBACK)
   '�]����STORE PROCEDURE��OPEN�ӦhTABLE�ɡAASP�L�k����CURSOR�ӷ|�o�Ϳ��~(�����A�i�H�NBEGIN�BCOMMIT�BROLLBACK��MARK�����ð����Y��)
   sqlxx="select * FROM RTLessorCMTYLINEsndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " and prtno='" & key(2) & "' "
   sqlYY="select * FROM RTLessorCMTYLINE WHERE comq1=" & KEY(0) & " and lineq1=" & key(1)
   sqlZZ="select COUNT(*) AS CNT FROM RTLessorCUST WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND canceldat is null and dropdat is null and finishdat is not null "
   RSxx.Open SQLxx,conn
   RSYY.Open SQLYY,conn
   RSzz.Open SQLzz,conn
   endpgm="1"
  '��w�@�o�ɡA���i���槹�u���שΥ����u����
   IF not isnull(RSXX("DROPDAT")) THEN
      ENDPGM="4"
   elseif isnull(RSXX("CLOSEDAT")) and isnull(RSXX("UNCLOSEDAT")) then
      endpgm="3"
   '�䤣��D�u�D�ɸ��      
   elseif rsyy.eof then
      endpgm="6"      
   '���ת���ɡA�Y�D�u�ɤ����A�ëD�w�����q��A�h��ܸ�Ʀ����`      
   elseif rsxx("sndkind")="ST"  AND ( ISNULL(RSYY("ADSLAPPLYDAT")) AND ISNULL(RSYY("CONTAPPLYDAT")) ) THEN
      endpgm="7"    
   ELSEIF RSZZ("CNT") > 0 AND rsxx("sndkind")="ST" THEN
      endpgm="8"   
   ELSE
      '�I�sstore procedure��s�����ɮ�
      strSP="usp_RTLessorCmtylineSndworkFR " & key(0) & "," & key(1) & ",'" & key(2) & "','" & V(0) & "'" 
     ' response.write strSP
      Set ObjRS = conn.Execute(strSP)
      If Err.number = 0 then
         ENDPGM="1"
         ERRMSG=""
      else
         ENDPGM="2"
         errmsg=cstr(Err.number) & "=" & Err.description
      end if         
   END IF
   RSXX.CLOSE
   RSyy.CLOSE
   RSzz.CLOSE
   conn.Close
   SET RSXX=NOTHING
   SET RSYY=NOTHING
   SET RSzz=NOTHING
   set conn=nothing
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "ET-City�D�u���u�槹�u/�����u���ת��ন�\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "���D�u���u��|�����סA���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "���D�u���u��w�@�o�A���i���浲�ת���@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="6" then
       msgbox "�L�k��즹�D�u���u�椧�D�ɸ�ơA�нT�{ET-City�D�u�D�ɸ�ƥ��`" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="7" then
       msgbox "�D�u�ɥثe�����A�ëD[�w���q]�A�����u�������[�зǤu�{]������A�]���L�k����C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close             
    elseIF frm1.htmlfld.value="8" then
       msgbox "�����u����ݥD�u�w���w���u���Τ�A�]���������[�зǤu�{]����@�~�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                        
    else
       msgbox "�L�k����D�u���u�槹�u���ת���@�~,���~�T��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close
    end if
   ' window.close    
 end sub
</script> 
</head>  
<form name=frm1 method=post action=RTLessorcmtylinesndworkfr.asp ID="Form1">
<input type="text" name=HTMLfld style=display:none value="<%=endpgm%>" ID="Text1">
<input type="text" name=HTMLfld1 style=display:none value="<%=errmsg%>" ID="Text2">
</form>
</html>