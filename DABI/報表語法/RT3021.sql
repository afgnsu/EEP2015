SELECT BATCH, b.cusnc, b.cusnc + case when len(b.cusnc)>4 then ' �z�n�I' else ' ����/�k�h�z�n�I' end as mydear, a.duedat,d.comn, b.applydat, b.birthday, b.contacttel
, b.mobile, b.socialid, b.email, g.codenc, b.rzone3, dateadd(d,1, a.duedat) as newBillingDat
,case b.casekind when '01' then '2. �g�٫��@�@�@���uú(1,197��)�@���b�~ú(2,100��)�@���~ú(4,000��)' 
when '02' then '2. �M�~���@�@�@���uú(1,410��)�@���b�~ú(2,700��)�@���~ú(4,800��)' else '' end as payselect
, '��' + h.codenc + ' -- ' + g.codenc+'('+ convert(varchar(6), b.rcvmoney) +'��)'  as casepay, isnull(e.cutnc, '')+ b.township2+b.raddr2 as addr2
, isnull(f.cutnc, '')+ b.township3+b.raddr3 as addr3 , i.*, '��' + j.codenc+'('+ convert(varchar(6), j.PARM1) +'��)'  as casepayd
FROM RTLessorAVSCustBillingPrtSub a 
inner join RTLessorAVSCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 and a.cusid = b.cusid
inner join RTLessorAVSCmtyLine c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 
inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1 
left outer join RTCounty e on e.cutid = b.cutid2 
left outer join RTCounty f on f.cutid = b.cutid3 
left outer join RTCode g on g.code = b.paycycle and g.kind ='M8' 
left outer join RTCode h on h.code = b.casekind and h.kind ='O9' 
left outer join RTLessorAVSCustBillingBarcode i on i.NOTICEID=a.NOTICEID and i.CASEKIND=a.CASEKIND --and i.PAYCYCLE=a.PAYCYCLE
left outer join RTCode j on j.code = i.PAYCYCLE and j.kind ='M8' 
WHERE b.freecode<>'Y' --and BATCH='20160516'
order by BATCH

--select * from RTLessorAVSCustBillingPrtSub
--select * from RTLessorAVSCustBillingPrt
--select noticeid, count(*) as qq from RTLessorAVSCustBillingBarcode group by noticeid having count(*)=1
--select * from RTLessorAVSCustBillingBarcode 
--SELECT * FROM RTCode WHERE kind ='M8' and code='02'

SELECT b.cusnc, b.cusnc + case when len(b.cusnc)>4 then ' �z�n�I' else ' ����/�k�h�z�n�I' end as mydear, a.duedat,d.comn, b.applydat, b.birthday, b.contacttel
, b.mobile, b.socialid, b.email, g.codenc, b.rzone3, dateadd(d,1, a.duedat) as newBillingDat
,case b.casekind when '01' then '2. �g�٫��@�@�@���uú(1,197��)�@���b�~ú(2,100��)�@���~ú(4,000��)' 
when '02' then '2. �M�~���@�@�@���uú(1,410��)�@���b�~ú(2,700��)�@���~ú(4,800��)' else '' end as payselect
, '��' + h.codenc + ' -- ' + g.codenc+'('+ convert(varchar(6), b.rcvmoney) +'��)'  as casepay, isnull(e.cutnc, '')+ b.township2+b.raddr2 as addr2
, isnull(f.cutnc, '')+ b.township3+b.raddr3 as addr3 , i.*, '��' + j.codenc+'('+ convert(varchar(6), j.PARM1) +'��)'  as casepayd
FROM RTLessorAVSCustBillingPrtSub a 
inner join RTLessorAVSCust b on a.comq1 = b.comq1 and a.lineq1 = b.lineq1 and a.cusid = b.cusid
inner join RTLessorAVSCmtyLine c on b.comq1 = c.comq1 and b.lineq1 = c.lineq1 
inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1 
left outer join RTCounty e on e.cutid = b.cutid2 
left outer join RTCounty f on f.cutid = b.cutid3 
left outer join RTCode g on g.code = b.paycycle and g.kind ='M8' 
left outer join RTCode h on h.code = b.casekind and h.kind ='O9' 
left outer join RTLessorAVSCustBillingBarcode i on i.NOTICEID=a.NOTICEID and i.CASEKIND=a.CASEKIND --and i.PAYCYCLE=a.PAYCYCLE
left outer join RTCode j on j.code = i.PAYCYCLE and j.kind ='M8' 
WHERE b.freecode<>'Y' 
order by b.cusnc
