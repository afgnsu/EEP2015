<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���ݥ�Ĺ�Ȥ�q�ܳX�ͰO��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  functionOptOpen="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�Ȥ�W��;�榸;�q�X��;�b������;�q�X�H��;���N��;�@�o���"
sqlDelete="SELECT RTSS365tel.CUSID, RTSS365tel.ENTRYNO, RTSS365tel.SEQ1, RTObj.SHORTNC, RTSS365tel.ENTRYNO, " _
         &"RTSS365tel.TELVISITDAT,RTSS365tel.ACCOUNTRCV , rtobj_1.cusnc, " _
         &"case when RTSS365tel.CONTENTSCORE='1' then '�D�`���N' when RTSS365tel.CONTENTSCORE='2' then '���N' " _
         &" when RTSS365tel.CONTENTSCORE='3' then '�i����' when RTSS365tel.CONTENTSCORE='4' then '�����N' " _
         &" when RTSS365tel.CONTENTSCORE='5' then '�D�`�����N' end, " _
         &"RTSS365tel.DROPDAT " _
         &"FROM RTObj RTObj_1 RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTSS365tel ON RTEmployee.EMPLY = RTSS365tel.VISITMAN LEFT OUTER JOIN " _
         &"RTObj ON RTSS365tel.CUSID = RTObj.CUSID " _
         &"where rtss365tel.cusid='*'"
  dataTable="RTss365Tel"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=3
  dataProg="RTTelVisitD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=480,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchFirst=False
  If searchQry="" Then
     searchQry=" RTSS365Tel.CUSID='" & aryparmkey(0) & "' and rtss365tel.entryno=" & aryparmkey(1) 
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT RTSS365tel.CUSID, RTSS365tel.ENTRYNO, RTSS365tel.SEQ1, RTObj.SHORTNC, RTSS365tel.ENTRYNO, " _
         &"RTSS365tel.TELVISITDAT,RTSS365tel.ACCOUNTRCV , rtobj_1.cusnc, " _
         &"case when RTSS365tel.CONTENTSCORE='1' then '�D�`���N' when RTSS365tel.CONTENTSCORE='2' then '���N' " _
         &" when RTSS365tel.CONTENTSCORE='3' then '�i����' when RTSS365tel.CONTENTSCORE='4' then '�����N' " _
         &" when RTSS365tel.CONTENTSCORE='5' then '�D�`�����N' end, " _
         &"RTSS365tel.DROPDAT " _
         &"FROM RTObj RTObj_1 RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj_1.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
         &"RTSS365tel ON RTEmployee.EMPLY = RTSS365tel.VISITMAN LEFT OUTER JOIN " _
         &"RTObj ON RTSS365tel.CUSID = RTObj.CUSID " _
         &"where " & searchQry 
 'Response.Write "sql=" & SQLLIST
End Sub
%>
