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
  title="RT���u��C�L�M�P(�ȪA��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�浧�M�P;�����M�P"
  functionOptPrompt="Y"
  functionOptProgram="verify2.asp;verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="none;none;none;���ϦW��;�Τ�W;�q��;�a�};�������B;�o�]��;���u�渹;�C�L��;�C�L��;���u��"
  sqlDelete="SELECT b.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, Rtrim(IsNull(a.cutid1,'')) + rtrim(IsNull(a.TOWNSHIP1,''))+rtrim(IsNull(a.RADDR1,'')) as addr1, a.ar, a.reqdat, a.insprtno, a.insprtdat, a.insprtusr, a.finishdat " _
             & "FROM RTObj h INNER JOIN RTEmployee g ON h.CUSID = g.CUSID RIGHT OUTER JOIN RTCust a INNER JOIN " _
             & "RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
             & "RTObj c ON a.CUSID = c.CUSID INNER JOIN " _
             & "RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN "_
             & "RTObj e ON d.CUSID = e.CUSID ON " _
             & "g.EMPLY = a.FINCFMUSR LEFT OUTER JOIN " _
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
   sqlList="SELECT b.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, Rtrim(IsNull(a.cutid1,'')) + rtrim(IsNull(a.TOWNSHIP1,''))+rtrim(IsNull(a.RADDR1,'')) as addr1, a.ar, a.reqdat, a.insprtno, a.insprtdat, a.insprtusr, a.finishdat "_
            & "FROM RTObj h INNER JOIN RTEmployee g ON h.CUSID = g.CUSID RIGHT OUTER JOIN RTCust a INNER JOIN " _
            & "RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
            & "RTObj c ON a.CUSID = c.CUSID INNER JOIN " _
            & "RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN "_
            & "RTObj e ON d.CUSID = e.CUSID ON " _
            & "g.EMPLY = a.FINCFMUSR LEFT OUTER JOIN " _
            & "RTObj f ON a.PROFAC = f.CUSID " _
            & "WHERE (GETDATE() BETWEEN d.TDAT AND ISNULL(d.EXDAT, '9999/12/31')) " _
            & "and a.cusid<>'*' and a.insprtno='" &aryparmkey(0) & "'"
 session("workcanprtno")=aryparmkey(0)
End Sub
%>