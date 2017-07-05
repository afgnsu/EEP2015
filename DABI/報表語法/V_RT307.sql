CREATE VIEW V_RT307 as 
SELECT B.CODENC, A.*
FROM
	(	select '02' as paytype, isnull(e.shortnc, isnull(g.cusnc, '')) AS belongnc, 1 AS qty, '' AS unino, '' AS invtitle
	, d.comn, b.cusnc, isnull(h.cutnc,'')+ b.township2+b.raddr2 AS raddr,
			b.contacttel, b.docketdat, b.docketdat AS rcvmoneydat, b.strbillingdat, null AS duedat, 
			'�M�ת���' AS memo, '' AS paytype2, '�M�ת���' AS casetype,
			 '' AS rcvnc, 0 AS rcvmoney, '' AS setnc, 0 AS setmoney, '�O�Ҫ�' AS gtnc, b.gtmoney, '' AS returnnc, 0 AS returnmoney, '' AS gtserial
		from	RTPrjCust b 
			inner join RTPrjCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
			inner join RTPrjCmtyH d on d.comq1 = c.comq1
			left outer join RTObj e on e.cusid = d.consignee
			left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = d.salesid
			left outer join RTCounty h on  h.cutid  = b.cutid2
		where	b.canceldat is null and b.dropdat is null
			-- �M�ת��Ϻ��צ���
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township2+b.raddr2,
		b.contacttel, b.docketdat, a.rcvmoneydat, null, null,
		'�M�ת��Ϻ���', '', '�M�ת���',
		 '�����O', a.moveamt, '�]�w�O', a.setamt, '�]�ƶO'+isnull(i.codenc,''), a.equipamt, '', 0,''
	from	RTPrjCustRepair a
		inner join RTPrjCust b on a.cusid = b.cusid
		inner join RTPrjCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTPrjCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = d.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = d.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid2
		left outer join RTCode i on i.code = a.equip and i.kind ='P2'
	where	b.canceldat is null and a.canceldat is null
	and	a.finishdat is not null

	-- ET�Ӹ�
	union all
	select  b.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat,  a.rcvmoneydat, b.strbillingdat, b.duedat, 
		'ET�s�Ӹ�', b.paytype, 'ET',
		 '�����O', i.amt, '�w�˶O', b.setmoney, '�O�Ҫ�', b.gtmoney, '', 0,''
	from	RTLessorCustSndwork a
		inner join RTLessorCust b on a.cusid = b.cusid
		inner join RTLessorCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorCmtyH d on d.comq1 = c.comq1
		inner join RTLessorCustAR i on i.batchno = a.batchno
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.dropdat is null
	-- ET�_��
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, a.strbillingdat, b.duedat, 
		'ET�_��', a.paytype, 'ET',
		 '�����O', a.amt, '�_���O', a.returnmoney, '', 0, '', 0,''
	from	RTLessorCustReturn a
		inner join RTLessorCust b on a.cusid = b.cusid
		inner join RTLessorCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.canceldat is null
	-- ET���
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, a.strbillingdat, b.duedat, 
		'ET���', a.paytype, 'ET',
		 '�����O', a.amt, '', 0, '', 0, '', 0,''
	from	RTLessorCustCont a
		inner join RTLessorCust b on a.cusid = b.cusid
		inner join RTLessorCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.canceldat is null
	-- ET���צ���
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, null, null,
		'ET����', b.paytype, 'ET',
		 '�����O', a.moveamt, '�]�w�O', a.setamt, '�]�ƶO'+isnull(i.codenc,''), a.equipamt, '', 0,''
	from	RTLessorCustRepair a
		inner join RTLessorCust b on a.cusid = b.cusid
		inner join RTLessorCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
		left outer join RTCode i on i.code = a.equip and i.kind ='P2'
	where	b.canceldat is null and a.canceldat is null
	-- AVS�Ӹ�
	union all
	select  b.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, b.strbillingdat, b.duedat, 
		'AVS�s�Ӹ�', b.paytype, 'AVS',
		 '�����O', i.amt, '�w�˶O', b.setmoney, '�O�Ҫ�', b.gtmoney, '', 0,''
	from	RTLessorAVSCustSndwork a
		inner join RTLessorAVSCust b on a.cusid = b.cusid
		inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1
		inner join RTLessorAVSCustAR i on i.batchno = a.batchno
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.dropdat is null
	-- AVS���
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, a.strbillingdat, b.duedat, 
		'AVS���', a.paytype, 'AVS',
		 '�����O', a.amt, '', 0, '', 0, '', 0,''
	from	RTLessorAVSCustCont a
		inner join RTLessorAVSCust b on a.cusid = b.cusid
		inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.canceldat is null
	-- AVS�_��
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, a.strbillingdat, b.duedat, 
		'AVS�_��', a.paytype, 'AVS',
		 '�����O', a.amt, '�_���O', a.returnmoney, '', 0, '', 0,''
	from	RTLessorAVSCustReturn a
		inner join RTLessorAVSCust b on a.cusid = b.cusid
		inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
	where	b.canceldat is null and a.canceldat is null
	-- AVS���צ���
	union all
	select  a.paytype,	isnull(e.shortnc, isnull(g.cusnc, '')), 1, '', '', comn, b.cusnc, isnull(h.cutnc,'')+ b.township3+b.raddr3,
		case  b.mobile  when ''  then  b.contacttel else b.mobile end, b.docketdat, a.rcvmoneydat, null, null,
		'AVS����', b.paytype, 'AVS',
		 '�����O', a.moveamt, '�]�w�O', a.setamt, '�]�ƶO'+isnull(i.codenc,''), a.equipamt, '', 0,''
	from	RTLessorAVSCustRepair a
		inner join RTLessorAVSCust b on a.cusid = b.cusid
		inner join RTLessorAVSCmtyLine c on c.comq1 = b.comq1 and c.lineq1 = b.lineq1
		inner join RTLessorAVSCmtyH d on d.comq1 = c.comq1
		left outer join RTObj e on e.cusid = c.consignee
		left outer join RTEmployee f inner join RTObj g on g.cusid = f.cusid on f.emply = c.salesid
		left outer join RTCounty h on  h.cutid  = b.cutid3
		left outer join RTCode i on i.code = a.equip and i.kind ='P2'
	where	b.canceldat is null and a.canceldat is null
	and	a.finishdat is not null
) A
LEFT JOIN rtcode B ON B.kind ='M9' AND B.CODE = A.paytype