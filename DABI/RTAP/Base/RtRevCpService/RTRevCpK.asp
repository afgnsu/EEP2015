<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="RT���ڪ�C�L�M�P(�ȪA��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  functionOptName="�浧�M�P;�C�L�M�P"
  functionOptProgram="Verify2.asp;Verify.asp"
  session("rtrevcpk")=search2
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
     accessMode="I"
  'End IF
  
  DSN="DSN=RTLIb"
  formatName="none;none;none;���ϦW��;�Ȥ�;�q��;�a�};���ڪ��B;���ڤ�;���Ϥu�{�v;�]�ȽT�{;�C�L�帹;none"
  sqlDelete="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, c.RADDR1, a.ACTRCVAMT, a.SCHDAT, e.CUSNC, a.finrdfmdat, a.RCVDTLNO, a.rcvdtldat " _
           & "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID " _
           & "and a.cusid<>'*' " 
  dataTable=""
  'response.write "SQL+=" & sqldelete & "<BR>"           
  'dataTable="b"
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
  
  '----------------------------------------------------------------------------------------
  
  searchProg="self"
  searchFirst=false
  If searchQry="" Then
     searchQry=""
     searchShow="�w�C�L"
  End If   
    
  sqlList="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.HOME, c.RADDR1, a.ACTRCVAMT, a.SCHDAT, e.CUSNC, a.finrdfmdat, a.rcvdtlno, a.rcvdtldat " _
           & "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID  AND " _
           & "a.cusid<>'*' and a.rcvdtlno='" &aryparmkey(0) & "'" _
           & " ORDER BY B.COMN "
  session("RevCpKprtno")=aryparmkey(0)
 ' response.write "SQL=" & sqlList
End Sub


%>