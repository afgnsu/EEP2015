<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="RT�I�u�O��I���Ӫ�C�L(�޳N��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & v(3)
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�C�L�T�{"
  functionOptProgram="Verify.asp"
  functionOptPrompt="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=FALSE
  formatName="none;none;none;���ϦW��;�Ȥ�;���u��;�J�b��;�m�u�榬���;�зǬI�u�O;�I�u�ɧU�O;���ڤJ�b��;�|�p�T�{��;�C�L�帹"
  sqlDelete="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.finishdat, a.incomedat,a.docketdat,a.setfee, a.setfeediff,a.incomedat, a.acccfmdat,a.paydtlprtNO " _
           & "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID and a.settype='3' " _
           & "and a.cusid='*' " 
  dataTable=""
  extTable=""
  numberOfKey=3
  dataProg="/webap/rtap/base/rtcmty/RTcustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTSetFeePrtS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  If searchQry="" Then
     searchQry=" (a.PROFAC <> '*') and (a.paydtldat is null) AND (a.paydtlprtno <> '*')  and (a.docketdat is not null) and (a.incomedat is not null)" & ";;;<>'*';�G�w�J�b"
     searchShow="�I�u�t�ӡG�����@�|�p�f�֡G�����@�C�L���p�G���C�L  �m�u��G�w����  ���ڤJ�b�G�w�J�b"
  End If
  X=split(searchqry,";")
  '---�C�L�帹�ť�"
  sqlList="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC, a.finishdat, a.incomedat,a.docketdat,a.setfee, a.setfeediff, a.incomedat,a.acccfmdat,a.paydtlprtNO " _
           & "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID  and a.settype='3'  AND " &X(0) &" " _
           &"ORDER BY B.COMN "
  sqlstr=  "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID  and a.settype='3'  AND " &X(0)
 'Response.Write "SQL=" & SQLlist
 session("SQLSTRREVPRT")=replace(SQLstr,"'","""")
 session("ExistPrtNo")= X(2) 
' Response.Write "SQL=" & session("sqlstrrevprt") & "<BR>"
 '---X(1):�I�u�O�I�ڪ�C�Lpaydtlprtno(='':���C�L;<>'':�w�C�L;<>'*':����)
 '---X(2):���ڪ�帹paydtlprtno(<>'*':�L�帹)
 '---X(3):�t��profac(<>'*':����)
 '---��j�M����:(1)�C�L���A��"�w�C�L�B�C�L�帹���ť�"�ɤ��i�C�L(2)�t�Ӭ������B�C�L�帹���ťծ�,���i�C�L
 '---��j�M����:(3)�t�Ӭ�����,���i�C�L
  if (X(1)="�G����" and X(3)="<>'*'") or (X(3)="<>'*'") or (X(4)<>"�G�w�J�b") then
     ButtonEnable="N;N;Y;Y;Y;N"
  end if
End Sub
%>
