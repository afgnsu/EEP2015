<%@ Language=VBScript %>
<% KEY=SPLIT(REQUEST("KEY"),";")
   DIM CONNXX
   Set connXX=Server.CreateObject("ADODB.Connection")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")  
   SET RSyy=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   sqlxx="select * FROM KTSCUSTTELD1 WHERE CUSID='" & KEY(0) & "' and PNO='" & key(1) & "' and ENTRYNO=" & key(2) 
   RSXX.OPEN SQLXX,CONNxx,3,3
   endpgm="1"
   '��s���פ�
   IF LEN(TRIM(RSXX("FINISHDAT"))) = 0 OR ISNULL(RSXX("FINISHDAT")) THEN
      RSXX("FINISHDAT")=NOW()
      RSXX.UPDATE
      If Err.number > 0 then
      ELSE
         IF RSXX("AORD")="A" THEN
            sqlyy="select max(ENTRYNO) as ENTRYNO FROM KTSCUSTD1 WHERE CUSID='" & KEY(0) & "' "
            rsyy.Open sqlyy,connxx
            if len(trim(rsyy("ENTRYNO"))) > 0 then
               ENTRYNO=rsyy("ENTRYNO") + 1
            else
               ENTRYNO=1
            end if                 
            RSYY.CLOSE   
            '�s�ӽСJ�N�w���ת��ӽйq�ܼg�J�Ȥ�q���ɤ�
            SQLXX="INSERT INTO KTSCUSTD1(CUSID,ENTRYNO,TEL11,TEL12,APPLYDAT,APPLYNO) SELECT CUSID," & ENTRYNO & ",TEL11,TEL12,GETDATE(),PNO " _
                 &"FROM KTSCUSTTELD1 WHERE CUSID='" & KEY(0) & "' and PNO='" & key(1) & "' and ENTRYNO=" & key(2) 
            CONNXX.EXECUTE SQLXX
         ELSE
            '�@�o�J�N�w���ת��@�o�q�ܱq�Ȥ�q���ɤ���s�@�o��Χ@�o�ӽг渹
            SQLXX="UPDATE KTSCUSTD1 SET DROPDAT=" & NOW & ",DROPNO='" & RSXX("PNO") & "' WHERE CUSID='" & KEY(0) & "' AND TEL11='" & RSXX("TEL11") & "' AND TEL12='" & RSXX("TEL12") & "' "
            CONNXX.EXECUTE SQLXX
         END IF
      END IF
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
     Set winP=window.Opener
     Window.Opener.document.all("keyForm").Submit
     winP.focus()
     window.close
</script> 
</head>  
</html>