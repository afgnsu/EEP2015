<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���ݰ��O��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;����;���u�m�W;�a�ݩm�W;���O�O"
  sqlDelete="SELECT a.CUSID, a.ENTRYNO, b.cusnc, FAMNAME, HEALTHINS " &_
			"FROM	RTEmpFamIns a inner join RTObj b on a.cusid = b.cusid " &_
			"where a.CUSID='*' "
  dataTable="RTEmpFamIns"
  userDefineDelete=""  
  extTable=""
  numberOfKey=2
  dataProg="RTEmpFamInsD.asp"
  datawindowFeature=""
  searchWindowFeature=""
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=100
  searchProg="self"
  searchFirst=false
  'searchShow=FrGetAreaDesc(aryParmKey(0))  
  searchQry=" a.cusid ='" & aryparmkey(0) & "'"  
  sqlList="SELECT a.CUSID, a.ENTRYNO, b.cusnc, FAMNAME, HEALTHINS " &_
			"FROM	RTEmpFamIns a inner join RTObj b on a.cusid = b.cusid " &_
			"where " &searchQry 
'Response.Write "SQL=" &sqllist           
End Sub
%>
