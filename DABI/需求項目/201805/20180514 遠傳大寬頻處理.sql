SELECT * FROM RTBillCharge

SELECT * FROM RTCode 
WHERE KIND = 'O9'

SELECT * FROM RTCode 
WHERE KIND = 'M8'

--�s�W���Ǥj�e�W���
INSERT INTO RTCode
(KIND, CODE, CODENC, EUSR, EDAT, UUSR, UDAT, PARM1)
VALUES 
('L5', '10', '���Ǥj�e�W', '', GETDATE() , '', NULL, 'B')

--�s�W���O����
INSERT INTO RTBillCharge
(CASETYPE, CASEKIND, PAYCYCLE, PERIOD, AMT, AMT2, DROPAMT, DROPAMT2, MEMO, BILLCOD)
VALUES
('10', '54', '06', 1, 0, 0, 0, 0, '����/20M/��ú', ''),
('10', '54', '02', 12, 0, 0, 0, 0, '����/20M/�~ú', ''),
('10', '54', '03', 24, 0, 0, 0, 0, '����/20M/��~ú', ''),
('10', '55', '06', 1, 0, 0, 0, 0, '����/40M/��ú', ''),
('10', '55', '02', 12, 0, 0, 0, 0, '����/40M/�~ú', ''),
('10', '55', '03', 24, 0, 0, 0, 0, '����/40M/��~ú', ''),
('10', '56', '06', 1, 0, 0, 0, 0, '����/70M/��ú', ''),
('10', '56', '02', 12, 0, 0, 0, 0, '����/70M/�~ú', ''),
('10', '56', '03', 24, 0, 0, 0, 0, '����/70M/��~ú', '')