<%
  Dim search1,parm,vk
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="RT�I�u�O�Ω��Ӫ�C�L�M�P(�ȪA��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�C�L�M�P"
  functionOptProgram="Verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="none;none;none;���ϦW��;�Τ�W��;�q��;�a�};�зǬI�u�O;�I�u�ɧU�O;�I�u�ɧU����;�C�L�帹;�|�p�f�֤�;none"
  sqlDelete="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, c.RADDR1, a.SETFEE, a.SETFEEDIFF, a.SETFEEDESC, a.PAYDTLPRTNO, a.ACCCFMDAT, a.paydtldat" _
            & "FROM RTObj h INNER JOIN RTEmployee g ON h.CUSID = g.CUSID RIGHT OUTER JOIN " _
            & "RTCust a INNER JOIN RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
            & "RTObj c ON a.CUSID = c.CUSID INNER JOIN RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN " _
            & "RTObj e ON d.CUSID = e.CUSID ON g.EMPLY = a.ACCCFMUSR LEFT OUTER JOIN " _
            & "RTObj f ON a.PROFAC = f.CUSID " _
            & "WHERE (GETDATE() BETWEEN d.TDAT AND ISNULL(d.EXDAT, '9999/12/31')) " _
            & "and a.cusid<>'*' "  
  dataTable="b"
  numberOfKey=3
  dataProg="/webap/rtap/base/rtcmty/rtcustd.asp"
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
     searchShow="�w�C�L"
  End If   
  sqlList="SELECT  a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, c.RADDR1, a.SETFEE, a.SETFEEDIFF, a.SETFEEDESC, a.PAYDTLPRTNO, a.ACCCFMDAT, a.paydtldat " _
            & "FROM RTObj h INNER JOIN RTEmployee g ON h.CUSID = g.CUSID RIGHT OUTER JOIN " _
            & "RTCust a INNER JOIN RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
            & "RTObj c ON a.CUSID = c.CUSID INNER JOIN RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN " _
            & "RTObj e ON d.CUSID = e.CUSID ON g.EMPLY = a.ACCCFMUSR LEFT OUTER JOIN " _
            & "RTObj f ON a.PROFAC = f.CUSID " _
            & "WHERE (GETDATE() BETWEEN d.TDAT AND ISNULL(d.EXDAT, '9999/12/31')) " _
            & "and a.cusid<>'*' and a.PAYDTLPRTNO ='"  & aryparmkey(0) & "'"
  session("paycanprtno")=aryparmkey(0)
 End sub
%>