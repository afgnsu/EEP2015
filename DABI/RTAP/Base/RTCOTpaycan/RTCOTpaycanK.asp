 <%
  Dim search1,parm,vk
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtilityv3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="COT�ظm�ۥI�B�f�ֺM�P"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�ۥI�B�f�ֺM�P"
  functionOptProgram="Verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="none;���ϦW��;�������B;�P�N�w��;T1�}�q���;�C�L�帹;�C�L���;�C�L�H��;�f�֤��;�f�֤H��"
  sqlDelete="SELECT a.comq1,a.COMN, a.ASSESS, a.AGREE, a.T1APPLY, a.PAYPRTSEQ, a.PAYPRTD, e.CUSNC, a.ACCOUNTCFM,c.CUSNC "_
             & "FROM RTEmployee b INNER JOIN RTObj c ON b.CUSID = c.CUSID " _
             & "RIGHT OUTER JOIN RTObj e INNER JOIN RTEmployee d ON e.CUSID = d.CUSID " _
             & "INNER JOIN RTCmty a ON d.EMPLY = a.PAYPRTUSR ON b.EMPLY = a.ACCOUNTUSR " _
             & "WHERE  a.COMN <>'*' "
  'response.write "sql=" &sqlDelete &"<br>"
  dataTable="rtCMTY"
  numberOfKey=1
  dataProg="/webap/rtap/base/rtcmty/rtcmtyd.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchFirst=false
  If searchQry="" Then
     searchQry=""
     searchShow="�w�f��"
  End If   

   sqlList="SELECT a.comq1,a.COMN, a.ASSESS, a.AGREE, a.T1APPLY, a.PAYPRTSEQ, a.PAYPRTD,  e.CUSNC, a.ACCOUNTCFM, c.CUSNC "_
          & "FROM RTEmployee b INNER JOIN RTObj c ON b.CUSID = c.CUSID " _
          & "RIGHT OUTER JOIN RTObj e INNER JOIN RTEmployee d ON e.CUSID = d.CUSID " _
          & "INNER JOIN RTCmty a ON d.EMPLY = a.PAYPRTUSR ON b.EMPLY = a.ACCOUNTUSR " _
          & "WHERE  a.COMN <>'*' and a.payprtseq='" &aryparmkey(0) & "'"
   session("COTcanprtno")=aryparmkey(0)
  'Response.Write "SQLlist=" & SQllist
End Sub

%>