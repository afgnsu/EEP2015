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
   SET RSWW=Server.CreateObject("ADODB.RECORDSET")   
   DSN="DSN=RtLib"
   connXX.Open DSN
 '  On Error Resume Next
   endpgm="1"
   sqlxx="select * FROM RTEBTCUSTCHG WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) 
   RSWW.OPEN SQLXX,CONNxx
   IF RSWW.EOF THEN
      ENDPGM="8"
   ELSEIF ISNULL(RSWW("TRANSCHKDAT")) THEN
      ENDPGM="7"
   ELSEIF NOT ISNULL(RSWW("DROPDAT")) THEN   
      ENDPGM="9"
   END IF
  ' RSXX.CLOSE
   IF ENDPGM="1" THEN
     sqlxx="select * FROM RTEBTCUSTCHGsndwork WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
     RSXX.OPEN SQLXX,CONNxx
     '��w�@�o�ɡA���i���槹�u���שΥ����u����
     IF LEN(TRIM(RSXX("DROPDAT"))) <> 0 THEN
        ENDPGM="3"
 '    elseif LEN(TRIM(RSXX("CLOSEDAT"))) <> 0 OR LEN(TRIM(RSXX("UNCLOSEDAT"))) <> 0 then
 '       endpgm="4"
     elseif LEN(TRIM(RSXX("REALENGINEER"))) = 0 AND LEN(TRIM(RSXX("REALCONSIGNEE"))) = 0 then
        endpgm="6"
     elseif LEN(TRIM(RSXX("BONUSCLOSEYM"))) <> 0 OR LEN(TRIM(RSXX("STOCKCLOSEYM"))) <> 0 then
        endpgm="5"
     ELSE
        sqlyy="select max(SEQ) as SEQ FROM RTEBTCUSTCHGsndworklog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3)& " and prtno='" & key(4) & "' "
        rsyy.Open sqlyy,connxx
      
        if len(trim(rsyy("SEQ"))) > 0 then
           SEQ=rsyy("SEQ") + 1
        else
           SEQ=1
        end if
        rsyy.close
        sqlyy="insert into RTEBTCUSTCHGsndworklog " _
           &"SELECT   COMQ1, LINEQ1, CUSID,ENTRYNO,PRTNO, " & SEQ & ", getdate(), 'F','" &  v(0) & "', " _
           &"SENDWORKDAT, PRTUSR, ASSIGNENGINEER,ASSIGNCONSIGNEE, REALENGINEER, REALCONSIGNEE, DROPDAT, 'AVS�ΤᲧ�ʧ��u����'," _
           &"CLOSEDAT, BONUSCLOSEYM, BONUSCLOSEDAT, " _
           &"BONUSCLOSEUSR, BONUSFINCHK, STOCKCLOSEYM, STOCKCLOSEDAT, " _
           &"STOCKCLOSEUSR, STOCKFINCHK, MDF1,MDF2, HOSTNO,HOSTPORT, MEMO, PRTDAT,UNCLOSEDAT,DROPUSR,CLOSEUSR  " _
           &"FROM RTEBTCUSTCHGsndwork where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
     ' Response.Write sqlyy
        CONNXX.Execute sqlyy     
        If Err.number > 0 then
           endpgm="2"
           errmsg=cstr(Err.number) & "=" & Err.description
        else
           SQLXX=" update RTEBTCUSTCHGsndwork set CLOSEdat=getdate(),CLOSEUSR='" & V(0) & "' where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' "
           connxx.Execute SQLXX
           If Err.number > 0 then
              endpgm="2"
            '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
              errmsg=cstr(Err.number) & "=" & Err.description
              sqlyy="delete * FROM RTEBTCUSTCHGsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' AND SEQ=" & SEQ
              CONNXX.Execute sqlyy 
           else
            '���u���סA����s�ΤᲧ�ʥD��FINISHDAT
              SQLXX=" update RTEBTCUSTCHG set FINISHdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) 
              connxx.Execute SQLXX
            '���u���סA����s�Τ�D�ɡJCHGCOD1:��s�Τ���,CHGCOD2:��s�˾��a�},CHGCOD3:��s�����q��
                        '��s�e�����ͫȤ�D��RTEBTCUST���ʰO��
            IF RSWW("CHGCOD1")=1 AND RSWW("CHGCOD2")=1 AND RSWW("CHGCOD3")=1 THEN 
               CHGCOD="AL"
            ELSEIF RSWW("CHGCOD1")=1 AND RSWW("CHGCOD2")=1 AND RSWW("CHGCOD3")<>1 THEN 
               CHGCOD="DM"
            ELSEIF RSWW("CHGCOD1")=1 AND RSWW("CHGCOD2")<>1 AND RSWW("CHGCOD3")=1 THEN 
               CHGCOD="DT"
            ELSEIF RSWW("CHGCOD1")<>1 AND RSWW("CHGCOD2")=1 AND RSWW("CHGCOD3")=1 THEN 
               CHGCOD="MT"
            ELSEIF RSWW("CHGCOD1")=1 AND RSWW("CHGCOD2")<>1 AND RSWW("CHGCOD3")<>1 THEN 
               CHGCOD="CD"
            ELSEIF RSWW("CHGCOD1")<>1 AND RSWW("CHGCOD2")=1 AND RSWW("CHGCOD3")<>1 THEN 
               CHGCOD="CM"
            ELSEIF RSWW("CHGCOD1")=1 AND RSWW("CHGCOD2")<>1 AND RSWW("CHGCOD3")=1 THEN 
               CHGCOD="CT"                                             
            END IF
            
            sqlyy="select max(ENTRYNO) as ENTRYNO FROM RTEBTCUSTlog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "
            rsyy.Open sqlyy,connxx
      
            if len(trim(rsyy("ENTRYNO"))) > 0 then
               ENTRYNO=rsyy("ENTRYNO") + 1
            else
               ENTRYNO=1
            end if
            rsyy.close
            sqlyy="insert into RTEBTCUSTlog " _
                 &"SELECT " _
                 &"COMQ1, LINEQ1, CUSID, " & ENTRYNO & ", GETDATE(),'" & CHGCOD & "','" & V(0) & "'," _  
                 &"CUSNC, SOCIALID, CUTID1, TOWNSHIP1, VILLAGE1, " _
                 &"COD11, NEIGHBOR1, COD12, STREET1, COD13, SEC1, COD14, LANE1, COD15, " _
                 &"TOWN1, ALLEYWAY1, COD16, NUM1, COD17, FLOOR1, COD18, ROOM1, " _
                 &"COD19, CUTID2, TOWNSHIP2, VILLAGE2, COD21, NEIGHBOR2, COD22, " _
                 &"STREET2, COD23, SEC2, COD24, LANE2, COD25, TOWN2, ALLEYWAY2, " _
                 &"COD26, NUM2, COD27, FLOOR2, COD28, ROOM2, COD29, CUTID3, " _
                 &"TOWNSHIP3, VILLAGE3, COD31, NEIGHBOR3, COD32, STREET3, COD33, SEC3, " _
                 &"COD34, LANE3, COD35, TOWN3, ALLEYWAY3, COD36, NUM3, COD37, FLOOR3, " _
                 &"COD38, ROOM3, COD39, BIRTHDAY, CONTACT, MOBILE, EMAIL, CONTACTTEL, " _
                 &"PAYTYPE, AVSPMCODE, DIALERPMCODE, DIALERPAYTYPE, AGENTNAME, " _
                 &"AGENTTEL, AGENTSOCIAL, CUTID4, TOWNSHIP4, VILLAGE4, NEIGHBOR4, " _
                 &"STREET4, SEC4, LANE4, TOWN4, ALLEYWAY4, NUM4, FLOOR4, ROOM4, " _
                 &"RCVD, APPLYDAT, APPLYTNSDAT, APPLYAGREE, PROGRESSID, FINISHDAT, " _
                 &"DOCKETDAT, TRANSDAT, STRBILLINGDAT, RZONE1, RZONE2, RZONE3, " _
                 &"RZONE4, AREAID, GROUPID, SALESID, COD41, COD42, COD43, COD44, COD45, " _
                 &"COD46, COD47, COD48, COD49, DROPDAT, FREECODE, OVERDUE, " _
                 &"CUSTAPPLYDAT, OLDSERVICECUTDAT, AVSNO, EUSR, EDAT, UUSR, UDAT, " _
                 &"TRANSNOAPPLY, TRANSNODOCKET, CASETYPE, MEMO, CANCELDAT, " _
                 &"CANCELUSR, TNSCUSTCASE, MOVETOCOMQ1, MOVETOLINEQ1, " _
                 &"MOVEFROMCOMQ1, MOVEFROMLINEQ1, MOVETODAT, MOVEFROMDAT, " _ 
                 &"ENDBILLINGDAT " _
                 &"FROM RTEBTCUST where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' "  
            connxx.Execute SQLYY        
              '(�ܧ�Τ���)
              IF RSWW("CHGCOD1")=1 THEN
                '��s�Τ�W��
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CUSNC=RTEBTCUSTCHG.NCUSNC " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NCUSNC <> '' " 
                 connxx.Execute SQLXX
                '��s�X�ͤ��
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.BIRTHDAY=RTEBTCUSTCHG.NBIRTHDAY " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NBIRTHDAY <> '' "                     
                 connxx.Execute SQLXX
                '��semail
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.EMAIL=RTEBTCUSTCHG.NEMAIL " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NEMAIL <> '' "                     
                 connxx.Execute SQLXX
                '��s�p���H�m�W
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CONTACT=RTEBTCUSTCHG.NCONTACT " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NCONTACT <> '' "                     
                 connxx.Execute SQLXX
                '��s�p���H�q��
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CONTACTTEL=RTEBTCUSTCHG.NCONTACTTEL " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NCONTACTTEL <> '' "                     
                 connxx.Execute SQLXX
                '��s��ʹq��
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.MOBILE=RTEBTCUSTCHG.NMOBILE " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NMOBILE <> '' "                     
                 connxx.Execute SQLXX
                 '��s�����Ҹ�
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.SOCIALID=RTEBTCUSTCHG.NSOCIALID " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3)  & " AND RTEBTCUSTCHG.NSOCIALID <> '' " 
                 connxx.Execute SQLXX  
                 '��s���y�a�}
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CUTID2=RTEBTCUSTCHG.NCUTID2," _
                    &"RTEBTCUST.TOWNSHIP2=RTEBTCUSTCHG.NTOWNSHIP2,RTEBTCUST.VILLAGE2=RTEBTCUSTCHG.NVILLAGE2, " _
                    &"RTEBTCUST.COD21=RTEBTCUSTCHG.NCOD21, RTEBTCUST.NEIGHBOR2= RTEBTCUSTCHG.NNEIGHBOR2,RTEBTCUST.COD22=RTEBTCUSTCHG.NCOD22," _
                    &"RTEBTCUST.STREET2=RTEBTCUSTCHG.NSTREET2,RTEBTCUST.COD23=RTEBTCUSTCHG.NCOD23,RTEBTCUST.SEC2=RTEBTCUSTCHG.NSEC2," _
                    &"RTEBTCUST.COD24=RTEBTCUSTCHG.NCOD24,RTEBTCUST.LANE2=RTEBTCUSTCHG.NLANE2, RTEBTCUST.COD25= RTEBTCUSTCHG.NCOD25," _
                    &"RTEBTCUST.TOWN2=RTEBTCUSTCHG.NTOWN2, RTEBTCUST.ALLEYWAY2= RTEBTCUSTCHG.NALLEYWAY2,RTEBTCUST.COD26=RTEBTCUSTCHG.NCOD26," _
                    &"RTEBTCUST.NUM2=RTEBTCUSTCHG.NNUM2,RTEBTCUST.COD27=RTEBTCUSTCHG.NCOD27,RTEBTCUST.FLOOR2=RTEBTCUSTCHG.NFLOOR2," _
                    &"RTEBTCUST.COD28=RTEBTCUSTCHG.NCOD28,RTEBTCUST.ROOM2=RTEBTCUSTCHG.NROOM2,RTEBTCUST.COD29=RTEBTCUSTCHG.NCOD29 " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NCUTID2 <> '' "             
                 connxx.Execute SQLXX  
                 '��s�b�H�a�}
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CUTID3=RTEBTCUSTCHG.NCUTID3," _
                    &"RTEBTCUST.TOWNSHIP3=RTEBTCUSTCHG.NTOWNSHIP3,RTEBTCUST.VILLAGE3=RTEBTCUSTCHG.NVILLAGE3, " _
                    &"RTEBTCUST.COD31=RTEBTCUSTCHG.NCOD31, RTEBTCUST.NEIGHBOR3= RTEBTCUSTCHG.NNEIGHBOR3,RTEBTCUST.COD32=RTEBTCUSTCHG.NCOD32," _
                    &"RTEBTCUST.STREET3=RTEBTCUSTCHG.NSTREET3,RTEBTCUST.COD33=RTEBTCUSTCHG.NCOD33,RTEBTCUST.SEC3=RTEBTCUSTCHG.NSEC3," _
                    &"RTEBTCUST.COD34=RTEBTCUSTCHG.NCOD34,RTEBTCUST.LANE3=RTEBTCUSTCHG.NLANE3, RTEBTCUST.COD35= RTEBTCUSTCHG.NCOD35," _
                    &"RTEBTCUST.TOWN3=RTEBTCUSTCHG.NTOWN3, RTEBTCUST.ALLEYWAY3= RTEBTCUSTCHG.NALLEYWAY3,RTEBTCUST.COD36=RTEBTCUSTCHG.NCOD36," _
                    &"RTEBTCUST.NUM3=RTEBTCUSTCHG.NNUM3,RTEBTCUST.COD37=RTEBTCUSTCHG.NCOD37,RTEBTCUST.FLOOR3=RTEBTCUSTCHG.NFLOOR3," _
                    &"RTEBTCUST.COD38=RTEBTCUSTCHG.NCOD38,RTEBTCUST.ROOM3=RTEBTCUSTCHG.NROOM3,RTEBTCUST.COD39=RTEBTCUSTCHG.NCOD39 " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3) & " AND RTEBTCUSTCHG.NCUTID3 <> '' "             
                  connxx.Execute SQLXX              
              end if
              '(����)
              IF RSWW("CHGCOD3")=1 THEN
                 '��s�����q��               
                 '����RTEBTCUSTEXT���ʰO�����
                 sqlyy="select max(SEQ) as SEQ FROM RTEBTCUSTEXTlog WHERE comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=1 "
                 rsyy.Open sqlyy,connxx
                 if len(trim(rsyy("SEQ"))) > 0 then
                    SEQ=rsyy("SEQ") + 1
                 else
                    SEQ=1
                 end if                 
                 sqlyy="insert into RTEBTCUSTEXTlog " _
                     &"SELECT " _
                     &"COMQ1, LINEQ1, CUSID, ENTRYNO, " & SEQ & ", GETDATE(), 'F','" & V(0) & "', TELNO, DIALERPAYTYPE, SRVTYPE, SDATE, DROPDAT, CHKDAT, TRANSDAT, EUSR, EDAT, UUSR, UDAT, CBCCONTRACTNO, EMCONTRACTNO " _
                     &"FROM RTEBTCUSTEXT where comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' and ENTRYNO=1 "  
                 connxx.Execute SQLYY
                 '��s���[�A�ȥD��
                 SQLXX=" update RTEBTCUSTEXT set   " _
                    &"RTEBTCUSTEXT.TELNO=RTEBTCUSTCHG.NTELNO " _
                    &"FROM " _
                    &"RTEBTCUSTEXT INNER JOIN RTEBTCUSTCHG ON RTEBTCUSTEXT.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUSTEXT.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUSTEXT.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3)  & " AND RTEBTCUSTCHG.NTELNO <> '' " 
                 connxx.Execute SQLXX    
              end if              
              '(����)
              IF RSWW("CHGCOD2")=1 THEN
                 '��s�˾��a�}
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.CUTID1=RTEBTCUSTCHG.NCUTID1,RTEBTCUST.TOWNSHIP1=RTEBTCUSTCHG.NTOWNSHIP1, RTEBTCUST.VILLAGE1=RTEBTCUSTCHG.NVILLAGE1, RTEBTCUST.COD11=RTEBTCUSTCHG.NCOD11, RTEBTCUST.NEIGHBOR1=RTEBTCUSTCHG.NNEIGHBOR1, " _
                    &"RTEBTCUST.COD12=RTEBTCUSTCHG.NCOD12, RTEBTCUST.STREET1=RTEBTCUSTCHG.NSTREET1, RTEBTCUST.COD13=RTEBTCUSTCHG.NCOD13, RTEBTCUST.SEC1=RTEBTCUSTCHG.NSEC1,RTEBTCUST.COD14=RTEBTCUSTCHG.NCOD14, RTEBTCUST.LANE1=RTEBTCUSTCHG.NLANE1," _
                    &"RTEBTCUST.COD15=RTEBTCUSTCHG.NCOD15, RTEBTCUST.TOWN1=RTEBTCUSTCHG.NTOWN1,RTEBTCUST.ALLEYWAY1=RTEBTCUSTCHG.NALLEYWAY1, RTEBTCUST.COD16=RTEBTCUSTCHG.NCOD16, RTEBTCUST.NUM1=RTEBTCUSTCHG.NNUM1,RTEBTCUST.COD17=RTEBTCUSTCHG.NCOD17, " _
                    &"RTEBTCUST.FLOOR1=RTEBTCUSTCHG.NFLOOR1,RTEBTCUST.COD18=RTEBTCUSTCHG.NCOD18, RTEBTCUST.ROOM1=RTEBTCUSTCHG.NROOM1,RTEBTCUST.COD19=RTEBTCUSTCHG.NCOD19, RTEBTCUST.RZONE1=RTEBTCUSTCHG.NRZONE1 " _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3)  & " AND RTEBTCUSTCHG.NCUTID1 <> '' " 
                 connxx.Execute SQLXX                
                 '��s���X���ϤΥD�u�Ǹ����,��˾��a�}�Τ��Ƨ�s�@�o��(���İh���קK�h����W�[)
                 SQLXX=" update RTEBTCUST set   " _
                    &"RTEBTCUST.MOVETOCOMQ1=RTEBTCUSTCHG.NCOMQ1,RTEBTCUST.MOVETOLINEQ1=RTEBTCUSTCHG.NLINEQ1,RTEBTCUST.MOVETODAT=GETDATE() ,rtebtcust.canceldat=getdate()" _
                    &"FROM " _
                    &"RTEBTCUST INNER JOIN RTEBTCUSTCHG ON RTEBTCUST.COMQ1 = RTEBTCUSTCHG.COMQ1 AND " _
                    &"RTEBTCUST.LINEQ1 = RTEBTCUSTCHG.LINEQ1 AND RTEBTCUST.CUSID = RTEBTCUSTCHG.CUSID " _
                    &"where RTEBTCUSTCHG.comq1=" & KEY(0) & " and RTEBTCUSTCHG.lineq1=" & key(1) & " AND RTEBTCUSTCHG.CUSID='" & KEY(2) & "' AND RTEBTCUSTCHG.ENTRYNO=" & KEY(3)  & " AND RTEBTCUSTCHG.NLINEQ1 >0 AND RTEBTCUSTCHG.NCOMQ1 >0 " 
                 connxx.Execute SQLXX         
                 '���J�����ϥD�u���W�[�ӥΤ�O��
                 SQLXX=" INSERT INTO RTEBTCUST " _
                    &"SELECT " & RSWW("NCOMQ1") & "," & RSWW("NLINEQ1") & ",'" & KEY(2) & "',"  _
                    &"CUSNC, SOCIALID, CUTID1, TOWNSHIP1, VILLAGE1, COD11, NEIGHBOR1, COD12, STREET1, COD13, SEC1, COD14, LANE1, COD15, " _
                    &"TOWN1, ALLEYWAY1, COD16, NUM1, COD17, FLOOR1, COD18, ROOM1,  COD19, CUTID2, TOWNSHIP2, VILLAGE2, COD21, NEIGHBOR2, COD22, " _
                    &"STREET2, COD23, SEC2, COD24, LANE2, COD25, TOWN2, ALLEYWAY2,  COD26, NUM2, COD27, FLOOR2, COD28, ROOM2, COD29, CUTID3, " _
                    &"TOWNSHIP3, VILLAGE3, COD31, NEIGHBOR3, COD32, STREET3, COD33, SEC3, COD34, LANE3, COD35, TOWN3, ALLEYWAY3, COD36, NUM3, COD37, FLOOR3, " _
                    &"COD38, ROOM3, COD39, BIRTHDAY, CONTACT, MOBILE, EMAIL, CONTACTTEL,  PAYTYPE, AVSPMCODE, DIALERPMCODE, DIALERPAYTYPE, AGENTNAME, " _
                    &"AGENTTEL, AGENTSOCIAL, CUTID4, TOWNSHIP4, VILLAGE4, NEIGHBOR4, STREET4, SEC4, LANE4, TOWN4, ALLEYWAY4, NUM4, FLOOR4, ROOM4, " _
                    &"RCVD, APPLYDAT, APPLYTNSDAT, APPLYAGREE, PROGRESSID, FINISHDAT, DOCKETDAT, TRANSDAT, STRBILLINGDAT, RZONE1, RZONE2, RZONE3, " _
                    &"RZONE4, AREAID, GROUPID, SALESID, COD41, COD42, COD43, COD44, COD45, COD46, COD47, COD48, COD49, DROPDAT, FREECODE, OVERDUE, " _
                    &"CUSTAPPLYDAT, OLDSERVICECUTDAT, AVSNO, EUSR, EDAT, UUSR, UDAT,TRANSNOAPPLY, TRANSNODOCKET, CASETYPE, MEMO, NULL, " _
                    &"CANCELUSR, TNSCUSTCASE, 0, 0," & KEY(0) & "," & KEY(1) & ", MOVETODAT, GETDATE(),ENDBILLINGDAT, CONTACTTELZIP, CONTACTTELZIP2, CUSTLINEADJFLG,PAYONCEFLAG,SECONDIDTYPE,SECONDNO,GTMONEY,GTVALID,GTSERIAL,IDNUMBERTYPE " _
                    &"FROM " _
                    &"RTEBTCUST " _
                    &"where RTEBTCUST.comq1=" & KEY(0) & " and RTEBTCUST.lineq1=" & key(1) & " AND RTEBTCUST.CUSID='" & KEY(2) & "' " 
                
                 connxx.Execute SQLXX                                                               
                 '�W�[�s�Τ᪺���[�A����
                 SQLXX=" INSERT INTO RTEBTCUSTEXT " _
                    &"SELECT " &  RSWW("NCOMQ1") & "," & RSWW("NLINEQ1") & ",'" & KEY(2) & "',1,'" & RSWW("NTELNO") & "'," _
                    &"DIALERPAYTYPE, SRVTYPE, SDATE, DROPDAT, CHKDAT, TRANSDAT, EUSR, EDAT, UUSR, UDAT, CBCCONTRACTNO, EMCONTRACTNO,TELZIP " _
                    &"FROM RTEBTCUSTEXT " _
                    &"WHERE RTEBTCUSTEXT.comq1=" & KEY(0) & " and RTEBTCUSTEXT.lineq1=" & key(1) & " AND RTEBTCUSTEXT.CUSID='" & KEY(2) & "' AND RTEBTCUSTEXT.ENTRYNO=1 " 
               '  response.Write sqlxx
               '  response.end   
                 connxx.Execute SQLXX   
                 
              end if
              SQLXX=" update RTEBTCUSTCHG set FINISHdat=getdate(),UUSR='" & V(0) & "',UDAT=GETDATE()  where comq1=" & KEY(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) 
              connxx.Execute SQLXX              
              If Err.number > 0 then
                 endpgm="2"
               '�o�Ϳ��~�ɡA�R�������ɩҷs�W�����ʸ��
                 errmsg=cstr(Err.number) & "=" & Err.description
                 sqlyy="delete * FROM RTEBTCUSTCHGsndworklog WHERE comq1=" & key(0) & " and lineq1=" & key(1) & " AND CUSID='" & KEY(2) & "' AND ENTRYNO=" & KEY(3) & " and prtno='" & key(4) & "' AND SEQ=" & SEQ
                 CONNXX.Execute sqlyy 
              ELSE
                 endpgm="1"
                 errmsg=""
              END IF
           end if      
        end if
     END IF
   RSXX.CLOSE
   END IF
   RSWW.CLOSE
   connXX.Close
   set rsyy=nothing
   SET RSXX=NOTHING
   set connXX=nothing
   
%> 
<HTML>
<Head>
<script language=vbscript>
 sub window_onload()
    if frm1.htmlfld.value="1" then
       msgbox "AVS�ΤᲧ�ʵ��u�T�{�槹�u���צ��\",0
       Set winP=window.Opener
       Set docP=winP.document       
       docP.all("keyform").Submit
       winP.focus()              
       window.CLOSE
    elseIF frm1.htmlfld.value="3" then
       msgbox "��w�@�o�ɡA���i���槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close       
    elseIF frm1.htmlfld.value="4" then
       msgbox "�����ʵ��u��w���u���שΥ����u���סA���i���ư��槹�u���שΥ����u����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close           
    elseIF frm1.htmlfld.value="5" then
       msgbox "�����ʵ��u��w�뵲�A���i����" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close      
    elseIF frm1.htmlfld.value="6" then
       msgbox "�����ʵ��u�槹�u�ɡA��������J��ڬI�u�H���ι�ڬI�u�g�P��" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                  
    elseIF frm1.htmlfld.value="7" then
       msgbox "�����ʸ�Ʃ|���VEBT�ӽСA���i����Τ�ݬI�u�ε��u�浲�ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                   
    elseIF frm1.htmlfld.value="8" then
       msgbox "�L�k��즹���ʵ��u�檺���ʥD�ɡA�L�k���槹�u���ק@�~" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                    
    elseIF frm1.htmlfld.value="9" then
       msgbox "���ʥD�ɤw�@�o�A���i���槹�u���ק@�~�A�u��N�����u��@�o�C" & "  " & frm1.htmlfld1.value
       Set winP=window.Opener
       winP.focus()
       window.close                     
    else
       msgbox "�L�k����ΤᲧ�ʵ��u�槹�u���ק@�~,���~�T��" & "  " & frm1.htmlfld1.value
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