<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="ADSL�u�W�ӽи�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�m�W;����;�ʧO;�q��(H);�q��(O);����;���;�a�};�ӽк���;�ӽФ�;E-MAIL"
  sqlDelete="SELECT  RTApplyADSL.SERNO, RTApplyADSL.CUSNC,RTApplyADSL.HOUSENAME, " _
           &"CASE WHEN RTApplyADSL.SEX = 'M' THEN '�k' ELSE '�k' END AS SEXC, " _
           &"RTApplyADSL.HOME, RTApplyADSL.OFFICE, RTApplyADSL.EXTENSION, " _
           &"RTApplyADSL.MOBILE, RTCounty.CUTNC + RTApplyADSL.RADDR, " _
           &"CASE WHEN RTApplyADSL.APPLYTYPE = 'A1' THEN '���ɫ�599' WHEN RTApplyADSL.APPLYTYPE " _
           &"= 'A2' THEN '���ɫ�399' WHEN RTApplyADSL.APPLYTYPE = 'A3' THEN '�зǫ�1199' " _
           &"ELSE '' END, RTApplyADSL.EDAT, RTApplyADSL.EMAIL " _
           &"FROM RTApplyADSL INNER JOIN " _
           &"RTCounty ON RTApplyADSL.COUNTY = RTCounty.CUTID " _
           &"where rtapplyadsl.cusnc='*' " _
           &"order by RTApplyADSL.EDAT desc" 
  dataTable="RTAPPLYADSL"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=1
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" RTAPPLYADSL.CUSNC<>'*' "
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT  RTApplyADSL.SERNO, RTApplyADSL.CUSNC,RTApplyADSL.HOUSENAME, " _
           &"CASE WHEN RTApplyADSL.SEX = 'M' THEN '�k' ELSE '�k' END AS SEXC, " _
           &"RTApplyADSL.HOME, RTApplyADSL.OFFICE, RTApplyADSL.EXTENSION, " _
           &"RTApplyADSL.MOBILE, RTCounty.CUTNC + RTApplyADSL.RADDR, " _
           &"CASE WHEN RTApplyADSL.APPLYTYPE = 'A1' THEN '���ɫ�599' WHEN RTApplyADSL.APPLYTYPE " _
           &"= 'A2' THEN '���ɫ�399' WHEN RTApplyADSL.APPLYTYPE = 'A3' THEN '�зǫ�1199' " _
           &"ELSE '' END, RTApplyADSL.EDAT, RTApplyADSL.EMAIL " _
           &"FROM RTApplyADSL INNER JOIN " _
           &"RTCounty ON RTApplyADSL.COUNTY = RTCounty.CUTID order by RTApplyADSL.EDAT desc" 
'  Response.Write "sql=" & SQLLIST
End Sub
%>
