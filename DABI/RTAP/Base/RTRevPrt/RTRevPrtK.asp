<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="RT���ک��Ӫ�C�L(�޳N��)"
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
  formatName="none;none;none;���ϦW��;�Ȥ�;�a�};���ڪ��B;���ڤ�;�I�u�t��;�]�ȽT�{;�C�L�帹"
  sqlDelete="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC,Rtrim(IsNull(a.cutid1,'')) + rtrim(IsNull(a.TOWNSHIP1,''))+rtrim(IsNull(a.RADDR1,'')) as addr1, a.ACTRCVAMT, a.SCHDAT,  f.CUSNC, a.finrdfmdat,a.RCVDTLNO " _
           & "FROM   RTCust a, RTCmty b, RTObj c, RTCmtySale d, RTObj e, RTObj f " _
           & "WHERE  a.COMQ1 = b.COMQ1 " _
           & "AND a.CUSID = c.CUSID " _
           & "AND a.COMQ1 =d.COMQ1  AND GetDate() Between d.TDAT AND IsNull(d.EXDAT, '9999/12/31') " _
           & "AND d.CUSID = e.CUSID " _
           & "AND a.PROFAC *= f.CUSID and a.settype in ('2','3') " _
           & "and a.cusid='*' " 
  dataTable=""
  extTable=""
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
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTRevPrtS.asp"
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
     searchQry=" and (a.PROFAC <> '*') AND (a.rcvdtlno = '') and (a.actrcvamt > 0) " & ";;;<>'*'"
     searchShow="�I�u�t�ӡG�����@���ڪ��p�G�w���ڡ@�C�L���p�G���C�L"
  End If
  X=split(searchqry,";")
  '---�C�L�帹�ť�"
  '---�Ұ��v����
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="='A1'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T90076" or _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"  
  sqlList="SELECT a.comq1,a.cusid,a.entryno,b.COMN, c.CUSNC,Rtrim(IsNull(a.cutid1,'')) + rtrim(IsNull(a.TOWNSHIP1,''))+rtrim(IsNull(a.RADDR1,'')) as addr1, a.ACTRCVAMT, a.SCHDAT, f.CUSNC, a.finrdfmdat,a.rcvdtlno " _
           &"FROM RTCust a INNER JOIN " _
           &"RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
           &"RTObj c ON a.CUSID = c.CUSID INNER JOIN " _
           &"RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN " _
           &"RTObj e ON d.CUSID = e.CUSID INNER JOIN " _
           &"RTAreaCty G ON b.CUTID = G.CUTID INNER JOIN " _
           &"RTArea H ON G.AREAID = H.AREAID AND  " _
           &"H.areatype = '1' LEFT OUTER JOIN " _
           &"RTObj f ON a.PROFAC = f.CUSID " _
           &"WHERE GETDATE() BETWEEN d.TDAT AND ISNULL(d.EXDAT, '9999/12/31') AND " _
           &"a.SETTYPE IN ('2', '3') AND a.PROFAC <> '*' AND a.RCVDTLNO = '' AND " _
           &"a.ACTRCVAMT > 0 AND G.areaid " & DAreaID & "  " &  X(0) &" " _
           &"ORDER BY B.COMN "
  sqlstr= "FROM RTCust a INNER JOIN " _
           &"RTCmty b ON a.COMQ1 = b.COMQ1 INNER JOIN " _
           &"RTObj c ON a.CUSID = c.CUSID INNER JOIN " _
           &"RTCmtySale d ON a.COMQ1 = d.COMQ1 INNER JOIN " _
           &"RTObj e ON d.CUSID = e.CUSID INNER JOIN " _
           &"RTAreaCty G ON b.CUTID = G.CUTID INNER JOIN " _
           &"RTArea H ON G.AREAID = H.AREAID AND  " _
           &"H.areatype = '1' LEFT OUTER JOIN " _
           &"RTObj f ON a.PROFAC = f.CUSID " _
           &"WHERE GETDATE() BETWEEN d.TDAT AND ISNULL(d.EXDAT, '9999/12/31') AND " _
           &"a.SETTYPE IN ('2', '3') AND a.PROFAC <> '*' AND a.RCVDTLNO = '' AND " _
           &"a.ACTRCVAMT > 0 AND G.areaid " & DAreaID & "  " & X(0) 
 session("SQLSTRREVPRT")=replace(SQLstr,"'","""")
 session("ExistPrtNo")= X(2)
'Response.Write "SQL=" & sqllist
 '---X(1):���ڪ�C�Lrcvdtlno(='':���C�L;<>'':�w�C�L;<>'*':����)
 '---X(2):���ڪ�帹rcvdtlno(<>'*':�L�帹)
 '---X(3):�t��profac(<>'*':����)
 '---��j�M����:(1)�C�L���A��"�w�C�L�B�C�L�帹���ť�"�ɤ��i�C�L(2)�t�Ӭ������B�C�L�帹���ťծ�,���i�C�L
 '---��j�M����:(3)�t�Ӭ�����,���i�C�L
 '90/03/20�קאּ�t�ӥ����ɤ��i�C�L
 ' if X(3)="<>'*'" or (X(3)="<>'*'" and X(2)="<>'*'") then 
  if X(2)="<>'*'" then
     ButtonEnable="N;N;Y;Y;Y;N"
  end if
End Sub
%>
