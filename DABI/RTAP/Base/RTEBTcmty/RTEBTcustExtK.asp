<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�Τ���[�A�ȸ�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="���ʰO��"
  functionOptProgram="RTEBTCUSTEXTLOGK.ASP"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;����;none;���[�A��;�q��;��O���;�ӽФ��;CBC�X���s��;EM�X���s��;�I����;���ɼf�֤�;�q�l���ɤ�"
  sqlDelete="SELECT RTEBTCUSTEXT.COMQ1, RTEBTCUSTEXT.LINEQ1, RTEBTCUSTEXT.CUSID, RTEBTCUSTEXT.ENTRYNO,RTEBTCUSTEXT.TELNO, RTCode_2.CODENC AS Expr1, " _
         &"RTEBTCUSTEXT.TELNO, RTCode_1.CODENC, RTEBTCUSTEXT.SDATE, RTEBTCUSTEXT.CBCCONTRACTNO, RTEBTCUSTEXT.EMCONTRACTNO, " _
         &"RTEBTCUSTEXT.DROPDAT,RTEBTCUSTEXT.chkdat, RTEBTCUSTEXT.transdat FROM RTEBTCUSTEXT INNER JOIN RTCode RTCode_1 ON RTEBTCUSTEXT.DIALERPAYTYPE = RTCode_1.CODE AND " _
         &"RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUSTEXT.SRVTYPE = RTCode_2.CODE AND RTCode_2.KIND = 'E7' " _
           &"WHERE RTEBTcustext.COMQ1=0 "
  dataTable="RTEBTcustext"
  extTable=""
  numberOfKey=5
  dataProg="RTEBTcustextD.asp"
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
  keyListPageSize=25
  searchProg="self"
  searchShow="����"
  searchQry=" RTEBTcustext.COMQ1=" & aryparmkey(0) & " and RTEBTcustext.LINEQ1=" & aryparmkey(1) & " and RTEBTcustext.CUSID='" &  aryparmkey(2) & "' " 
  sqlList="SELECT RTEBTCUSTEXT.COMQ1, RTEBTCUSTEXT.LINEQ1, RTEBTCUSTEXT.CUSID, RTEBTCUSTEXT.ENTRYNO,RTEBTCUSTEXT.TELNO, RTCode_2.CODENC AS Expr1, " _
         &"RTEBTCUSTEXT.TELNO, RTCode_1.CODENC, RTEBTCUSTEXT.SDATE, RTEBTCUSTEXT.CBCCONTRACTNO, RTEBTCUSTEXT.EMCONTRACTNO, " _
         &"RTEBTCUSTEXT.DROPDAT,RTEBTCUSTEXT.chkdat, RTEBTCUSTEXT.transdat FROM RTEBTCUSTEXT INNER JOIN RTCode RTCode_1 ON RTEBTCUSTEXT.DIALERPAYTYPE = RTCode_1.CODE AND " _
         &"RTCode_1.KIND = 'G7' LEFT OUTER JOIN RTCode RTCode_2 ON RTEBTCUSTEXT.SRVTYPE = RTCode_2.CODE AND RTCode_2.KIND = 'E7' " _
         &"WHERE " &searchQry
'Response.Write "sql=" & SQLLIST         
End Sub
%>
