/****** SSMS 中 SelectTopNRows 命令的指令碼  ******/
INSERT INTO RTLessorAVSCust
( [COMQ1]
      ,[LINEQ1]
      ,[CUSID]
      ,[CUSNC]
      ,[SOCIALID]
      ,[CUTID1]
      ,[TOWNSHIP1]
      ,[RADDR1]
      ,[RZONE1]
      ,[CUTID2]
      ,[TOWNSHIP2]
      ,[RADDR2]
      ,[RZONE2]
      ,[CUTID3]
      ,[TOWNSHIP3]
      ,[RADDR3]
      ,[RZONE3]
      ,[BIRTHDAY]
      ,[CONTACTTEL]
      ,[MOBILE]
      ,[EMAIL]
      ,[COCONTACT]
      ,[COCONTACTTEL]
      ,[COTELEXT]
      ,[COCONTACTMOBILE]
      ,[COBOSS]
      ,[COBOSSID]
      ,[COKIND]
      ,[PAYTYPE]
      ,[RCVD]
      ,[APPLYDAT]
      ,[PROGRESSID]
      ,[FINISHDAT]
      ,[DOCKETDAT]
      ,[STRBILLINGDAT]
      ,[AREAID]
      ,[GROUPID]
      ,[SALESID]
      ,[DROPDAT]
      ,[FREECODE]
      ,[OVERDUE]
      ,[EUSR]
      ,[EDAT]
      ,[UUSR]
      ,[UDAT]
      ,[MEMO]
      ,[CANCELDAT]
      ,[CANCELUSR]
      ,[IP11]
      ,[MAC]
      ,[PERIOD]
      ,[DUEDAT]
      ,[IDNUMBERTYPE]
      ,[SECONDIDTYPE]
      ,[SECONDNO]
      ,[GTMONEY]
      ,[GTVALID]
      ,[GTSERIAL]
      ,[DEVELOPERID]
      ,[PAYCYCLE]
      ,[CREDITCARDTYPE]
      ,[CREDITBANK]
      ,[CREDITCARDNO]
      ,[CREDITNAME]
      ,[CREDITDUEM]
      ,[CREDITDUEY]
      ,[NEWBILLINGDAT]
      ,[PORT]
      ,[EQUIP]
      ,[ADJUSTDAY]
      ,[RCVMONEY]
      ,[CPEKIND]
      ,[BATCHNO]
      ,[CDAT]
      ,[SECONDCASE]
      ,[IP12]
      ,[IP13]
      ,[IP14]
      ,[RCVMONEYFLAG1]
      ,[RCVMONEYFLAG2]
      ,[SETMONEY]
      ,[CASEKIND]
      ,[GTEQUIP]
      ,[GTPRTDAT]
      ,[GTPRTUSR]
      ,[USERRATE]
	  , COMTYPE)
SELECT [COMQ1]
      ,[LINEQ1]
      ,[CUSID]
      ,[CUSNC]
      ,[SOCIALID]
      ,[CUTID1]
      ,[TOWNSHIP1]
      ,[RADDR1]
      ,[RZONE1]
      ,[CUTID2]
      ,[TOWNSHIP2]
      ,[RADDR2]
      ,[RZONE2]
      ,[CUTID3]
      ,[TOWNSHIP3]
      ,[RADDR3]
      ,[RZONE3]
      ,[BIRTHDAY]
      ,[CONTACTTEL]
      ,[MOBILE]
      ,[EMAIL]
      ,[COCONTACT]
      ,[COCONTACTTEL]
      ,[COTELEXT]
      ,[COCONTACTMOBILE]
      ,[COBOSS]
      ,[COBOSSID]
      ,[COKIND]
      ,[PAYTYPE]
      ,[RCVD]
      ,[APPLYDAT]
      ,[PROGRESSID]
      ,[FINISHDAT]
      ,[DOCKETDAT]
      ,[STRBILLINGDAT]
      ,[AREAID]
      ,[GROUPID]
      ,[SALESID]
      ,[DROPDAT]
      ,[FREECODE]
      ,[OVERDUE]
      ,[EUSR]
      ,[EDAT]
      ,[UUSR]
      ,[UDAT]
      ,[MEMO]
      ,[CANCELDAT]
      ,[CANCELUSR]
      ,[IP11]
      ,[MAC]
      ,[PERIOD]
      ,[DUEDAT]
      ,[IDNUMBERTYPE]
      ,[SECONDIDTYPE]
      ,[SECONDNO]
      ,[GTMONEY]
      ,[GTVALID]
      ,[GTSERIAL]
      ,[DEVELOPERID]
      ,[PAYCYCLE]
      ,[CREDITCARDTYPE]
      ,[CREDITBANK]
      ,[CREDITCARDNO]
      ,[CREDITNAME]
      ,[CREDITDUEM]
      ,[CREDITDUEY]
      ,[NEWBILLINGDAT]
      ,[PORT]
      ,[EQUIP]
      ,[ADJUSTDAY]
      ,[RCVMONEY]
      ,[CPEKIND]
      ,[BATCHNO]
      ,[CDAT]
      ,[SECONDCASE]
      ,[IP12]
      ,[IP13]
      ,[IP14]
      ,[RCVMONEYFLAG1]
      ,[RCVMONEYFLAG2]
      ,[SETMONEY]
      ,[CASEKIND]
      ,[GTEQUIP]
      ,[GTPRTDAT]
      ,[GTPRTUSR]
      ,[USERRATE]
	  , '8'
  FROM [RTLibN].[dbo].[RTLessorCust]