<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���Ϻީe�|��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;¾�ȦW��;�m�W;�p���q��;��ʹq��"
  sqlDelete="SELECT [RTSparqCmtySp].[COMQ1], [RTSparqCmtySp].[SERNO], [RTCode].[CODENC], " _
           &"[RTSparqCmtySp].[SPNAME], [RTSparqCmtySp].[CONTACT], [RTSparqCmtySp].[MOBILE] " _
           &"FROM RTSparqCmtySp INNER JOIN RTCode ON [RTSparqCmtySp].[TITLE]=[RTCode].[CODE] " _
           &"WHERE [RTCode].[KIND]='XX' "
  dataTable="RTSparqCmtySp"
  extTable=""
  numberOfKey=2
  dataProg="RTCmtySpD.asp"
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
  searchQry="RTSparqCmtySp.COMQ1=" &aryParmKey(0) &" "
  sqlList="SELECT [RTSparqCmtySp].[COMQ1], [RTSparqCmtySp].[SERNO], [RTCode].[CODENC], " _
           &"[RTSparqCmtySp].[SPNAME], [RTSparqCmtySp].[CONTACT], [RTSparqCmtySp].[MOBILE] " _
           &"FROM RTSparqCmtySp INNER JOIN RTCode ON [RTSparqCmtySp].[TITLE]=[RTCode].[CODE] " _
           &"WHERE [RTCode].[KIND]='A1' AND " &searchQry
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->
