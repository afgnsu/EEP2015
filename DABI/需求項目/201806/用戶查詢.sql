SELECT A.COMQ1 AS '社區編號', B.COMN AS '社區名稱', A.LINEQ1 AS '主現代號'
, A.CUSID AS '用戶代號', A.CUSNC AS '用戶名稱', D.CUTNC AS '縣市', A.TOWNSHIP2 AS '鄉鎮', A.RADDR2 AS '地址'
, A.MOBILE AS '手機', A.COMTYPE AS '方案別', E.CODENC AS '方案名稱', A.CASEKIND AS '資費代號', F.CODENC AS '資費名稱'
, A.IP11 AS 'IP位置', A.APPLYDAT AS '用戶申請日', A.FINISHDAT AS '完工日', A.DOCKETDAT AS '報竣日'
, A.STRBILLINGDAT AS '開始計費日', A.NEWBILLINGDAT AS '最近續約計費日', A.DUEDAT AS '到期日', A.FREECODE AS '公關戶'
, A.DROPDAT AS '退租日', A.CANCELDAT AS '作廢日', C.QT_CC AS '客訴次數'
FROM RTLessorAVSCust A
LEFT JOIN RTLessorAVSCmtyH B ON B.COMQ1=A.COMQ1 
LEFT OUTER JOIN V_RT104FAQ C ON C.CUSIDF=A.CUSID
LEFT OUTER JOIN RTCounty D ON D.CUTID=A.CUTID2
LEFT OUTER JOIN RTCode E ON E.KIND='P5' AND E.CODE=A.COMTYPE
LEFT OUTER JOIN RTCode F ON F.KIND='O9' AND F.CODE=A.CASEKIND
WHERE A.DROPDAT IS NULL AND A.CANCELDAT IS NULL
order by ISNULL(A.DROPDAT, '')+ISNULL(A.CANCELDAT, ''), A.IP11