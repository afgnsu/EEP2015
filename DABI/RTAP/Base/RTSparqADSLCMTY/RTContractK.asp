<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="���ϦX����ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�ɡ@�U"
  functionOptProgram="RTContractGrantK.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�X���y����;���Ϭy����;�X����H;�X���s��;�X���_��;�X������;�@�o"
  sqlDelete="SELECT HBCONTRACTH.CTNO, HBCONTRACTH.CTOBJECT, HBCONTRACTH.CTOBJNAME, "_
			&"HBCONTRACTH.CONTRACTNO +'-'+ convert(varchar(4),hbcontracth.volume) +'-'+ convert(varchar(3),hbcontracth.pagecnt), "_
			&"HBCONTRACTH.CTSTRDAT, HBCONTRACTH.CTENDDAT, "_
			&"case when HBCONTRACTH.DROPDAT IS NOT NULL then 'Y' else '' end "_
			&"FROM HBCONTRACTH LEFT OUTER JOIN HBContractTreeL2 "_
			&"ON HBCONTRACTH.CTproperty = HBContractTreeL2.PROPERTYID "_
			&"AND HBCONTRACTH.CTTree1 = HBContractTreeL2.CATEGORY1 "_
			&"AND HBCONTRACTH.CTTree2 = HBContractTreeL2.CATEGORY2 "_
			&"WHERE (HBCONTRACTH.CTNO = 0) "
  dataTable="HBContractH"
  extTable=""
  numberOfKey=1
  dataProg="RTContractD.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage=""
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  searchQry="HBContractH.CTOBJECT=" &aryParmKey(0) &" "
  sqlList="SELECT HBCONTRACTH.CTNO, HBCONTRACTH.CTOBJECT, HBCONTRACTH.CTOBJNAME, "_
			&"HBCONTRACTH.CONTRACTNO +'-'+ convert(varchar(4),hbcontracth.volume) +'-'+ convert(varchar(3),hbcontracth.pagecnt), "_
			&"HBCONTRACTH.CTSTRDAT, HBCONTRACTH.CTENDDAT, "_
			&"case when HBCONTRACTH.DROPDAT IS NOT NULL then 'Y' else '' end "_
			&"FROM HBCONTRACTH LEFT OUTER JOIN HBContractTreeL2 "_
			&"ON HBCONTRACTH.CTproperty = HBContractTreeL2.PROPERTYID "_
			&"AND HBCONTRACTH.CTTree1 = HBContractTreeL2.CATEGORY1 "_
			&"AND HBCONTRACTH.CTTree2 = HBContractTreeL2.CATEGORY2 "_
			&"WHERE (HBCONTRACTH.CTNO <> 0) and HBCONTRACTH.CTNO <> 0 "_
			&"AND	HBCONTRACTH.CTproperty ='A' AND HBCONTRACTH.CTTree2 in ('04') "_
            &"AND " &searchQry

'Response.Write "SQL=" & SQLlist            
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
