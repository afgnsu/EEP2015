<%@ Language=VBScript %>
<% 
   Set conn=Server.CreateObject("ADODB.Connection")  
   SET RS=Server.CreateObject("ADODB.RECORDSET")  
   SET RSXX=Server.CreateObject("ADODB.RECORDSET")
   DSN="DSN=RtLib"
   conn.Open DSN
   '�g�P
   sql="SELECT  count(*) AS RSCOUNT " _
        &"FROM            RTEBTCUSTSNDWORK INNER JOIN " _
        &"                RTEBTCUST ON RTEBTCUSTSNDWORK.COMQ1 = RTEBTCUST.COMQ1 AND " _
        &"                RTEBTCUSTSNDWORK.LINEQ1 = RTEBTCUST.LINEQ1 AND " _
        &"                RTEBTCUSTSNDWORK.CUSID = RTEBTCUST.CUSID INNER JOIN " _
        &"                RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
        &"                RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN " _
        &"                RTEBTCMTYH ON " _
        &"                RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1  LEFT OUTER JOIN " _
        &"                RTObj RTObj_2 ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
        &"                RTObj RTObj_1 INNER JOIN " _
        &"                RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY LEFT OUTER JOIN " _
        &"                RTObj RTObj_3 ON " _
        &"                RTEBTCMTYLINE.CONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN " _
        &"                RTArea INNER JOIN " _
        &"                RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
        &"                RTEBTCUST.AREAID = RTSalesGroup.AREAID AND " _
        &"                RTEBTCUST.GROUPID = RTSalesGroup.GROUPID " _
        &"WHERE           (RTEBTCUSTSNDWORK.DROPDAT IS NULL) AND (RTEBTCUST.CANCELDAT IS NULL) and (RTEBTCUST.freecode <> 'Y' ) and " _
        &"                (RTEBTCUSTSNDWORK.UNCLOSEDAT IS NULL) AND " _
        &"                (RTEBTCUSTSNDWORK.CLOSEDAT IS NULL) AND (DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) > 6) AND LEN(LTRIM(RTOBJ_3.SHORTNC)) > 0 " 
   RS.Open SQL,CONN
   rscount1=rs("RSCOUNT")
   RS.CLOSE
   sql="SELECT  CASE WHEN RTOBJ_3.SHORTNC IS NULL OR RTOBJ_3.SHORTNC ='' THEN RTAREA.AREANC ELSE RTOBJ_3.SHORTNC END AS �Ұ�, " _
        &"CASE WHEN RTOBJ_2.SHORTNC IS NULL OR RTOBJ_2.SHORTNC = '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC END as �w�w�˾��H��, " _
        &"RTEBTCUSTSNDWORK.SENDWORKDAT as ���u���, RTEBTCUSTSNDWORK.PRTNO as ���u�渹,RTEBTCMTYH.COMN as ���ϦW��,RTEBTCUST.CUSNC as �Τ�W��, " _
        &"DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) as �w���u��� " _
        &"FROM            RTEBTCUSTSNDWORK INNER JOIN " _
        &"                RTEBTCUST ON RTEBTCUSTSNDWORK.COMQ1 = RTEBTCUST.COMQ1 AND " _
        &"                RTEBTCUSTSNDWORK.LINEQ1 = RTEBTCUST.LINEQ1 AND " _
        &"                RTEBTCUSTSNDWORK.CUSID = RTEBTCUST.CUSID INNER JOIN " _
        &"                RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
        &"                RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN " _
        &"                RTEBTCMTYH ON " _
        &"                RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1  LEFT OUTER JOIN " _
        &"                RTObj RTObj_2 ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
        &"                RTObj RTObj_1 INNER JOIN " _
        &"                RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY LEFT OUTER JOIN " _
        &"                RTObj RTObj_3 ON " _
        &"                RTEBTCMTYLINE.CONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN " _
        &"                RTArea INNER JOIN " _
        &"                RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
        &"                RTEBTCUST.AREAID = RTSalesGroup.AREAID AND " _
        &"                RTEBTCUST.GROUPID = RTSalesGroup.GROUPID " _
        &"WHERE           (RTEBTCUSTSNDWORK.DROPDAT IS NULL) AND (RTEBTCUST.CANCELDAT IS NULL) and (RTEBTCUST.freecode <> 'Y' ) and  " _
        &"                (RTEBTCUSTSNDWORK.UNCLOSEDAT IS NULL) AND " _
        &"                (RTEBTCUSTSNDWORK.CLOSEDAT IS NULL) AND (DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) > 6) AND LEN(LTRIM(RTOBJ_3.SHORTNC)) > 0 " _
        &"order by  CASE WHEN RTOBJ_3.SHORTNC IS NULL OR RTOBJ_3.SHORTNC ='' THEN RTAREA.AREANC ELSE RTOBJ_3.SHORTNC END, " _
        &"CASE WHEN RTOBJ_2.SHORTNC IS NULL OR RTOBJ_2.SHORTNC = '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC END ,RTEBTCMTYH.COMN, RTEBTCUSTSNDWORK.SENDWORKDAT "
   RS.Open SQL,CONN
   CNT=0
   dim setupman(200)
   DIM SETUPMAN2(200)
   Set jmail = Server.CreateObject("Jmail.Message")
   jmail.charset="BIG5"
   jmail.from = "MIS@cbbn.com.tw"
   Jmail.fromname="�F��AVS�t�Φ۰�ĵ�ܳq��"
   jmail.Subject = "AVS�Τ�˾��W�L6�ѥH�W�����ש���"
   jmail.priority = 1  
   IF NOT RS.EOF THEN
      body="<html><body><table border=1 width=""80%""> " 
      DO until RS.EOF
         CNT=CNT+1
         FROMEMAIL="MIS@CBBN.COM.TW"
         IF CNT=1 THEN  
            BODY=BODY & "<tr><H3>�F��AVS�Τ�˾��W�L6�ѥ����׳q��--�g�P</h3></td></tr>" _
                &"<tr><td bgcolor=lightblue align=center>�Ұ�</td><td bgcolor=lightblue align=center>�w�w�˾��H��</td>"_
                &"<td bgcolor=lightblue align=center>���u���</td><td bgcolor=lightblue align=center>���u�渹</td>"_
                &"<td bgcolor=lightblue align=center>���ϦW��</td><td bgcolor=lightblue align=center>�Τ�W��</td>"_
                &"<td bgcolor=lightblue align=center>�w���u���</td></tr>"
         END IF
         BODY=BODY & "<tr>" _
             &"<td bgcolor=pink align=left>" &RS("�Ұ�") &"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�w�w�˾��H��")  &"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���u���")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���u�渹")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���ϦW��")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�Τ�W��")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�w���u���")&"</td></TR>" 
         RS.MoveNext
       loop
       body=body & "<tr><td colspan=7>�@�p " & rscount1 & " �� </td></tr>"
       BODY=BODY & "</table><P>"
   END IF    
   rs.close  
   '���P
   sql="SELECT  COUNT(*) AS RSCOUNT " _
        &"FROM            RTEBTCUSTSNDWORK INNER JOIN " _
        &"                RTEBTCUST ON RTEBTCUSTSNDWORK.COMQ1 = RTEBTCUST.COMQ1 AND " _
        &"                RTEBTCUSTSNDWORK.LINEQ1 = RTEBTCUST.LINEQ1 AND " _
        &"                RTEBTCUSTSNDWORK.CUSID = RTEBTCUST.CUSID INNER JOIN " _
        &"                RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
        &"                RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN " _
        &"                RTEBTCMTYH ON " _
        &"                RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1  LEFT OUTER JOIN " _
        &"                RTObj RTObj_2 ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
        &"                RTObj RTObj_1 INNER JOIN " _
        &"                RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY LEFT OUTER JOIN " _
        &"                RTObj RTObj_3 ON " _
        &"                RTEBTCMTYLINE.CONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN " _
        &"                RTArea INNER JOIN " _
        &"                RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
        &"                RTEBTCUST.AREAID = RTSalesGroup.AREAID AND " _
        &"                RTEBTCUST.GROUPID = RTSalesGroup.GROUPID " _
        &"WHERE           (RTEBTCUSTSNDWORK.DROPDAT IS NULL) AND (RTEBTCUST.CANCELDAT IS NULL) and (RTEBTCUST.freecode <> 'Y' ) and " _
        &"                (RTEBTCUSTSNDWORK.UNCLOSEDAT IS NULL) AND " _
        &"                (RTEBTCUSTSNDWORK.CLOSEDAT IS NULL) AND (DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) > 6) AND (LEN(LTRIM(RTOBJ_3.SHORTNC)) = 0 or rtobj_3.shortnc is null) " 
   RS.Open SQL,CONN
   rscount2=RS("RSCOUNT")
   RS.CLOSE
   sql="SELECT  CASE WHEN RTOBJ_3.SHORTNC IS NULL OR RTOBJ_3.SHORTNC ='' THEN RTAREA.AREANC ELSE RTOBJ_3.SHORTNC END AS �Ұ�, " _
        &"CASE WHEN RTOBJ_2.SHORTNC IS NULL OR RTOBJ_2.SHORTNC = '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC END as �w�w�˾��H��, " _
        &"RTEBTCUSTSNDWORK.SENDWORKDAT as ���u���, RTEBTCUSTSNDWORK.PRTNO as ���u�渹,RTEBTCMTYH.COMN as ���ϦW��,RTEBTCUST.CUSNC as �Τ�W��, " _
        &"DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) as �w���u���,rtemployee.email as �H�c " _
        &"FROM            RTEBTCUSTSNDWORK INNER JOIN " _
        &"                RTEBTCUST ON RTEBTCUSTSNDWORK.COMQ1 = RTEBTCUST.COMQ1 AND " _
        &"                RTEBTCUSTSNDWORK.LINEQ1 = RTEBTCUST.LINEQ1 AND " _
        &"                RTEBTCUSTSNDWORK.CUSID = RTEBTCUST.CUSID INNER JOIN " _
        &"                RTEBTCMTYLINE ON RTEBTCUST.COMQ1 = RTEBTCMTYLINE.COMQ1 AND " _
        &"                RTEBTCUST.LINEQ1 = RTEBTCMTYLINE.LINEQ1 INNER JOIN " _
        &"                RTEBTCMTYH ON " _
        &"                RTEBTCMTYLINE.COMQ1 = RTEBTCMTYH.COMQ1  LEFT OUTER JOIN " _
        &"                RTObj RTObj_2 ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNCONSIGNEE = RTObj_2.CUSID LEFT OUTER JOIN " _
        &"                RTObj RTObj_1 INNER JOIN " _
        &"                RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID ON " _
        &"                RTEBTCUSTSNDWORK.ASSIGNENGINEER = RTEmployee.EMPLY LEFT OUTER JOIN " _
        &"                RTObj RTObj_3 ON " _
        &"                RTEBTCMTYLINE.CONSIGNEE = RTObj_3.CUSID LEFT OUTER JOIN " _
        &"                RTArea INNER JOIN " _
        &"                RTSalesGroup ON RTArea.AREAID = RTSalesGroup.COMPLOCATION ON " _
        &"                RTEBTCUST.AREAID = RTSalesGroup.AREAID AND " _
        &"                RTEBTCUST.GROUPID = RTSalesGroup.GROUPID " _
        &"WHERE           (RTEBTCUSTSNDWORK.DROPDAT IS NULL) AND  (RTEBTCUST.CANCELDAT IS NULL) and (RTEBTCUST.freecode <> 'Y' ) and " _
        &"                (RTEBTCUSTSNDWORK.UNCLOSEDAT IS NULL) AND " _
        &"                (RTEBTCUSTSNDWORK.CLOSEDAT IS NULL) AND (DATEDIFF(day, RTEBTCUSTSNDWORK.SENDWORKDAT, GETDATE()) > 6) AND (LEN(LTRIM(RTOBJ_3.SHORTNC)) = 0 or rtobj_3.shortnc is null) " _
        &"order by  CASE WHEN RTOBJ_3.SHORTNC IS NULL OR RTOBJ_3.SHORTNC ='' THEN RTAREA.AREANC ELSE RTOBJ_3.SHORTNC END, " _
        &"CASE WHEN RTOBJ_2.SHORTNC IS NULL OR RTOBJ_2.SHORTNC = '' THEN RTOBJ_1.CUSNC ELSE RTOBJ_2.SHORTNC END ,RTEBTCMTYH.COMN, RTEBTCUSTSNDWORK.SENDWORKDAT "
   RS.Open SQL,CONN
   CNT=0
   i=0
   dim ary(10)
   IF NOT RS.EOF THEN
      body=body & "<p><table border=1 width=""80%""> " 
      prvman=""
      DO until RS.EOF
         if rs("�Ұ�")="�x�_" then ary(0)=1
         if rs("�Ұ�")="���" then ary(1)=1
         if rs("�Ұ�")="�x��" then ary(2)=1
         if rs("�Ұ�")="����" then ary(3)=1
         CNT=CNT+1
         FROMEMAIL="MIS@CBBN.COM.TW"
         IF CNT=1 THEN  
            BODY=BODY & "<tr><H3>�F��AVS�Τ�˾��W�L6�ѥ����׳q��--���P</h3></td></tr>" _
                &"<tr><td bgcolor=lightblue align=center>�Ұ�</td><td bgcolor=lightblue align=center>�w�w�˾��H��</td>"_
                &"<td bgcolor=lightblue align=center>���u���</td><td bgcolor=lightblue align=center>���u�渹</td>"_
                &"<td bgcolor=lightblue align=center>���ϦW��</td><td bgcolor=lightblue align=center>�Τ�W��</td>"_
                &"<td bgcolor=lightblue align=center>�w���u���</td></tr>"
         END IF
         BODY=BODY & "<tr>" _
             &"<td bgcolor=pink align=left>" &RS("�Ұ�") &"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�w�w�˾��H��")  &"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���u���")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���u�渹")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("���ϦW��")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�Τ�W��")&"</td>" _
             &"<td bgcolor=pink align=left>" &RS("�w���u���")&"</td></TR>" 
         
         RS.MoveNext
       LOOP  
       I=0
       body=body & "<tr><td colspan=7>�@�p " & rscount2 & " �� </td></tr>"
       BODY=BODY & "</table><P><U>�аl�ܥΤ�˾��i��</U></body></html>"  
       jmail.HTMLBody = BODY
       JMail.AddRecipient "mis@cbbn.com.tw","��T��"
    '   JMail.AddRecipient "andyjkuo@cbbn.com.tw","����z"
    '   JMail.AddRecipient "jimmy@cbbn.com.tw","����}�D��"
    '   JMail.AddRecipient "kowei@cbbn.com.tw","�L�i�¥D��"
    '   JMail.AddRecipient "jacqueline@cbbn.com.tw","�g�P�~�U���f"
    '   JMail.AddRecipient "tiffany01@cbbn.com.tw","�g�P�~�U���f"
   END IF         
   IF RSCOUNT1 > 0 OR RSCOUNT2 > 0 THEN
      IF RSCOUNT2 > 0 THEN
         if ary(0)=1 or ary(1)=1 then
    '        JMail.AddRecipient "thomas@cbbn.com.tw","�G�a���D��"
         end if
         if ary(0)=1 then
    '        JMail.AddRecipient "monica@cbbn.com.tw","�x�_�~�U"
         end if
         if ary(1)=1 then
    '        JMail.AddRecipient "lilu@cbbn.com.tw","���~�U"
         end if         
         if ary(2)=1 then
    '        JMail.AddRecipient "rom@cbbn.com.tw","���ʸΥD��"
    '        JMail.AddRecipient "elaine@cbbn.com.tw","�x���~�U"
    '        JMail.AddRecipient "sally@cbbn.com.tw","�x���~�U"
         end if                  
         if ary(3)=1 then
    '        JMail.AddRecipient "joe@cbbn.com.tw","��j�y�ժ�"
    '        JMail.AddRecipient "feng@cbbn.com.tw","�����~�U"
         end if                        
      END IF
      jmail.Send ( "219.87.146.239" )   
   END IF
   rs.Close
   conn.Close
   set rs=nothing
   set conn=nothing
%>
