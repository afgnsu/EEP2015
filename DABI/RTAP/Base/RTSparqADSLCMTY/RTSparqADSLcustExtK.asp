<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Sparq* �޲z�t��"
  title="�Ȥ���[�A�ȸ�ƺ��@"
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
  formatName="none;none;none;none;���[�A��;�q��;�ͮĤ��;�I����"
  sqlDelete="SELECT RTSparqADSLcustext.COMQ1, RTSparqADSLcustext.CUSID, " _
           &"RTSparqADSLcustext.ENTRYNO, RTSparqADSLcustext.TELNO, RTCode.CODENC, RTSparqADSLcustext.TELNO, " _
           &"RTSparqADSLcustext.SDATE, RTSparqADSLcustext.DROPDAT " _
           &"FROM RTSparqADSLcustext LEFT OUTER JOIN " _
           &"RTCode ON RTSparqADSLcustext.SRVTYPE = RTCode.CODE AND " _
           &"RTCode.KIND = 'E7'" _
           &"WHERE RTSparqADSLcustext.cusid<>'*' "
  dataTable="RTSparqADSLcustext"
  extTable=""
  numberOfKey=4
  dataProg="RTSparqADSLcustextD.asp"
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
  colSplit=2
  keyListPageSize=40
  searchProg="self"
  searchShow="����"
  searchQry=" RTSparqADSLcustext.COMQ1=" & aryparmkey(0) & " and RTSparqADSLcustext.cusid='" & aryparmkey(1) & "' " 
  sqlList="SELECT RTSparqADSLcustext.COMQ1, RTSparqADSLcustext.CUSID, " _
         &"RTSparqADSLcustext.ENTRYNO, RTSparqADSLcustext.TELNO, RTCode.CODENC, RTSparqADSLcustext.TELNO, " _
         &"RTSparqADSLcustext.SDATE, RTSparqADSLcustext.DROPDAT " _
         &"FROM RTSparqADSLcustext LEFT OUTER JOIN " _
         &"RTCode ON RTSparqADSLcustext.SRVTYPE = RTCode.CODE AND " _
         &"RTCode.KIND = 'E7'" _
         &"WHERE " &searchQry
'Response.Write "sql=" & SQLLIST         
End Sub
%>
