<%
  Dim search1,parm,vk,debug36
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
  title="COT�ظm�ۥI�B���Ӫ�C�L�M�P"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�C�L�M�P"
  functionOptProgram="Verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="���ϦW��;�������B;�P�N�w��;T1�}�q���;�C�L�帹;�f�֤��"
  sqlDelete="SELECT COMN, ASSESS, AGREE, T1APPLY, PAYPRTSEQ, ACCOUNTCFM FROM RTCmty WHERE COMN <>'*' "
             
  'response.write "sql=" &sqlDelete &"<br>"
  debug36=true
  dataTable="rtCMTY"
  numberOfKey=1
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTCOTpcans.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and payprtseq is null and COMN='*'"& ";"
     searchShow="���C�L"
  End If   
  v=split(searchqry,";")
  '---�C�L�帹�ť�"
  if len(trim(V(1)))=0 then
     V(0)=" and payprtseq is null and COMN='*'"
  end if 
  sqlList="SELECT COMN, ASSESS, AGREE, T1APPLY, PAYPRTSEQ, ACCOUNTCFM FROM RTCmty WHERE COMN <>'*' " &V(0)
  session("COTcanpprtno")=V(1)
'Response.Write "SQLlist=" & SQllist
End Sub
%>