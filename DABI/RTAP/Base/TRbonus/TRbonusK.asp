<%
  Dim search1,parm,vk,debug36,search2
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="�~�Z�����f�ֽT�{"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�����f��"
  functionOptPrompt="Y"
  functionOptProgram="verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="none;�~��;���;�m�W;�~�Z����;�����`�B;�p����ϼ�;�p����;���ɤ�;���ɤH��;�J�b��;�J�b�H��"
  sqlDelete="SELECT CUSID,CYY,CMM,BONUS,MINUS,TOTCUT,TRDAT,TRUSR,ACDAT,ACUSR " _
            & "FROM RTSalesBonus
  'response.write "sql=" &sqldelete
  dataTable="b"
  numberOfKey=1
  dataProg="None"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20  
  
 
  searchProg="TRbonusS.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and a.rcvdtlno is null and a.cusid='*' " & ";"
     searchShow="���f��"
  End If   
  v=split(searchqry,";")
  '---�C�L�帹�ť�"
  if len(trim(V(1)))=0 then
     V(0)=" and a.rcvdtlno is null and a.cusid='*' "
  end if 
  
   sqlList="SELECT CUSID,CYY,CMM,BONUS,MINUS,TOTCUT,TRDAT,TRUSR,ACDAT,ACUSR " _
            & "FROM RTSalesBonus " &V(0)
 session("revcfmprtno")=V(1)
 'Response.Write "SQL=" & SQllist
End Sub
%>