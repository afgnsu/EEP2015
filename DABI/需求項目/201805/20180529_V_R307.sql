SELECT * FROM V_RT307 
WHERE unino <> ''

DROP VIEW V_RT307 
GO

CREATE VIEW V_RT307  AS 
SELECT          B.CODENC, A.paytype, A.belongnc, A.qty, A.unino, A.invtitle, A.COMN, A.CUSNC, A.raddr, A.CONTACTTEL, 
                            A.DOCKETDAT, A.rcvmoneydat, A.STRBILLINGDAT, A.duedat, A.memo, A.paytype2, A.casetype, A.rcvnc, A.rcvmoney, 
                            A.setnc, A.setmoney, A.gtnc, A.GTMONEY, A.returnnc, A.returnmoney, A.gtserial
FROM              (SELECT          '02' AS paytype, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS belongnc, 1 AS qty, SPACE(60) AS unino, 
                                                        SPACE(200) AS invtitle, d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP2 + b.RADDR2 AS raddr, 
                                                        b.CONTACTTEL, b.DOCKETDAT, b.DOCKETDAT AS rcvmoneydat, b.STRBILLINGDAT, NULL AS duedat, 
                                                        '�M�ת���' AS memo, '' AS paytype2, '�M�ת���' AS casetype, '' AS rcvnc, 0 AS rcvmoney, '' AS setnc, 
                                                        0 AS setmoney, '�O�Ҫ�' AS gtnc, b.GTMONEY, '' AS returnnc, 0 AS returnmoney, '' AS gtserial
                            FROM               dbo.RTPrjCust AS b INNER JOIN
                                                        dbo.RTPrjCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTPrjCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = d.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = d.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID2
                            WHERE           (b.CANCELDAT IS NULL) AND (b.DROPDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP2 + b.RADDR2 AS Expr5, b.CONTACTTEL, 
                                                        b.DOCKETDAT, a.RCVMONEYDAT, NULL AS Expr6, NULL AS Expr7, '�M�ת��Ϻ���' AS Expr8, 
                                                        '' AS Expr9, '�M�ת���' AS Expr10, '�����O' AS Expr11, a.MOVEAMT, '�]�w�O' AS Expr12, a.SETAMT, 
                                                        '�]�ƶO' + ISNULL(i.CODENC, '') AS Expr13, a.EQUIPAMT, '' AS Expr14, 0 AS Expr15, '' AS Expr16
                            FROM              dbo.RTPrjCustRepair AS a INNER JOIN
                                                        dbo.RTPrjCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTPrjCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTPrjCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = d.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = d.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID2 LEFT OUTER JOIN
                                                        dbo.RTCode AS i ON i.CODE = a.EQUIP AND i.KIND = 'P2'
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL) AND (a.FINISHDAT IS NOT NULL)
                            UNION ALL
                            SELECT          b.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, b.STRBILLINGDAT, b.DUEDAT, 'ET�s�Ӹ�' AS Expr7, b.PAYTYPE AS Expr8, 
                                                        'ET' AS Expr9, '�����O' AS Expr10, i.AMT, '�w�˶O' AS Expr11, b.SETMONEY, '�O�Ҫ�' AS Expr12, 
                                                        b.GTMONEY, '' AS Expr13, 0 AS Expr14, '' AS Expr15
                            FROM              dbo.RTLessorCustSndwork AS a INNER JOIN
                                                        dbo.RTLessorCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorCmtyH AS d ON d.COMQ1 = c.COMQ1 INNER JOIN
                                                        dbo.RTLessorCustAR AS i ON i.BATCHNO = a.BATCHNO LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.DROPDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, a.STRBILLINGDAT, b.DUEDAT, 'ET�_��' AS Expr7, a.PAYTYPE AS Expr8, 
                                                        'ET' AS Expr9, '�����O' AS Expr10, a.AMT, '�_���O' AS Expr11, a.RETURNMONEY, '' AS Expr12, 
                                                        0 AS Expr13, '' AS Expr14, 0 AS Expr15, '' AS Expr16
                            FROM              dbo.RTLessorCustReturn AS a INNER JOIN
                                                        dbo.RTLessorCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, a.STRBILLINGDAT, b.DUEDAT, 'ET���' AS Expr7, a.PAYTYPE AS Expr8, 
                                                        'ET' AS Expr9, '�����O' AS Expr10, a.AMT, '' AS Expr11, 0 AS Expr12, '' AS Expr13, 0 AS Expr14, 
                                                        '' AS Expr15, 0 AS Expr16, '' AS Expr17
                            FROM              dbo.RTLessorCustCont AS a INNER JOIN
                                                        dbo.RTLessorCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, NULL AS Expr7, NULL AS Expr8, 'ET����' AS Expr9, b.PAYTYPE AS Expr10, 
                                                        'ET' AS Expr11, '�����O' AS Expr12, a.MOVEAMT, '�]�w�O' AS Expr13, a.SETAMT, 
                                                        '�]�ƶO' + ISNULL(i.CODENC, '') AS Expr14, a.EQUIPAMT, '' AS Expr15, 0 AS Expr16, '' AS Expr17
                            FROM              dbo.RTLessorCustRepair AS a INNER JOIN
                                                        dbo.RTLessorCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3 LEFT OUTER JOIN
                                                        dbo.RTCode AS i ON i.CODE = a.EQUIP AND i.KIND = 'P2'
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL)
                            UNION ALL
                            SELECT          b.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, UNINO AS Expr3, INVTITLE AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, b.STRBILLINGDAT, b.DUEDAT, 'AVS�s�Ӹ�' AS Expr7, b.PAYTYPE AS Expr8, 
                                                        'AVS' AS Expr9, '�����O' AS Expr10, i.AMT, '�w�˶O' AS Expr11, b.SETMONEY, '�O�Ҫ�' AS Expr12, 
                                                        b.GTMONEY, '' AS Expr13, 0 AS Expr14, '' AS Expr15
                            FROM              dbo.RTLessorAVSCustSndwork AS a INNER JOIN
                                                        dbo.RTLessorAVSCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorAVSCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorAVSCmtyH AS d ON d.COMQ1 = c.COMQ1 INNER JOIN
                                                        dbo.RTLessorAVSCustAR AS i ON i.BATCHNO = a.BATCHNO LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.DROPDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, a.STRBILLINGDAT, b.DUEDAT, 'AVS���' AS Expr7, a.PAYTYPE AS Expr8, 
                                                        'AVS' AS Expr9, '�����O' AS Expr10, a.AMT, '' AS Expr11, 0 AS Expr12, '' AS Expr13, 0 AS Expr14, 
                                                        '' AS Expr15, 0 AS Expr16, '' AS Expr17
                            FROM              dbo.RTLessorAVSCustCont AS a INNER JOIN
                                                        dbo.RTLessorAVSCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorAVSCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorAVSCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2, '' AS Expr3, '' AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, a.STRBILLINGDAT, b.DUEDAT, 'AVS�_��' AS Expr7, a.PAYTYPE AS Expr8, 
                                                        'AVS' AS Expr9, '�����O' AS Expr10, a.AMT, '�_���O' AS Expr11, a.RETURNMONEY, '' AS Expr12, 
                                                        0 AS Expr13, '' AS Expr14, 0 AS Expr15, '' AS Expr16
                            FROM              dbo.RTLessorAVSCustReturn AS a INNER JOIN
                                                        dbo.RTLessorAVSCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorAVSCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorAVSCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL)
                            UNION ALL
                            SELECT          a.PAYTYPE, ISNULL(e.SHORTNC, ISNULL(g.CUSNC, '')) AS Expr1, 1 AS Expr2,  UNINO AS Expr3, INVTITLE AS Expr4, 
                                                        d.COMN, b.CUSNC, ISNULL(h.CUTNC, '') + b.TOWNSHIP3 + b.RADDR3 AS Expr5, 
                                                        CASE b.mobile WHEN '' THEN b.contacttel ELSE b.mobile END AS Expr6, b.DOCKETDAT, 
                                                        a.RCVMONEYDAT, NULL AS Expr7, NULL AS Expr8, 'AVS����' AS Expr9, b.PAYTYPE AS Expr10, 
                                                        'AVS' AS Expr11, '�����O' AS Expr12, a.MOVEAMT, '�]�w�O' AS Expr13, a.SETAMT, 
                                                        '�]�ƶO' + ISNULL(i.CODENC, '') AS Expr14, a.EQUIPAMT, '' AS Expr15, 0 AS Expr16, '' AS Expr17
                            FROM              dbo.RTLessorAVSCustRepair AS a INNER JOIN
                                                        dbo.RTLessorAVSCust AS b ON a.CUSID = b.CUSID INNER JOIN
                                                        dbo.RTLessorAVSCmtyLine AS c ON c.COMQ1 = b.COMQ1 AND c.LINEQ1 = b.LINEQ1 INNER JOIN
                                                        dbo.RTLessorAVSCmtyH AS d ON d.COMQ1 = c.COMQ1 LEFT OUTER JOIN
                                                        dbo.RTObj AS e ON e.CUSID = c.CONSIGNEE LEFT OUTER JOIN
                                                        dbo.RTEmployee AS f INNER JOIN
                                                        dbo.RTObj AS g ON g.CUSID = f.CUSID ON f.EMPLY = c.SALESID LEFT OUTER JOIN
                                                        dbo.RTCounty AS h ON h.CUTID = b.CUTID3 LEFT OUTER JOIN
                                                        dbo.RTCode AS i ON i.CODE = a.EQUIP AND i.KIND = 'P2'
                            WHERE          (b.CANCELDAT IS NULL) AND (a.CANCELDAT IS NULL) AND (a.FINISHDAT IS NOT NULL)) 
                            AS A LEFT OUTER JOIN
                            dbo.RTCode AS B ON B.KIND = 'M9' AND B.CODE = A.paytype
SELECT * FROM V_RT307
WHERE unino <> ''