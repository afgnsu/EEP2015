<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�Ȥ�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"  
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  accessMode="U"
  DSN="DSN=RTLib"
  formatName="none;�Ȥ�N��;�榸;�Ȥ�W��;�}�o����;�u������;�ӽФ��;�p���q��;���q�q��"
  sqlDelete="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.CUSNC, RTCust.CUSTYPE, " _
           &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME, " _
           &"RTCust.OFFICE + ' ' + RTCust.EXTENSION  AS Office " _
           &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
           &"WHERE RTCust.COMQ1=0 " _
           &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
  dataTable="RTCust"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=3
  dataProg="RTCustD.asp"
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
  keyListPageSize=12
  searchProg="self"
  searchShow=FrGetCmtyDesc(aryParmKey(0))
  searchQry="RTCust.COMQ1=" &aryParmKey(0) &" "
  sqlList="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.CUSNC, RTCust.CUSTYPE, " _
           &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME, " _
           &"RTCust.OFFICE+' '+ RTCust.EXTENSION  AS Office " _
           &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
           &"WHERE " &searchQry &" " _
           &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
End Sub
Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(2)) > 0 Then
     delSql="DELETE  FROM RTObjLink WHERE CUSTYID='05' AND CUSID IN " &extDeleList(2) &" "
     conn.Execute delSql  
     SelSql="Select * FROM RTObjLink WHERE  CUSID IN " &extDeleList(2) &" "
     rs.Open selsql,conn
     '��objlink�w�L�ӹ�H�N�X�䥦���s��,�~�R����H�D��(�H�קK�ӹ�H���䥦��H
     '���O��,�o�N��H�D�ɧR�������~
     if rs.EOF then                    
        delSql="DELETE  FROM RTObj WHERE CUSID IN " &extDeleList(2) &" " 
        conn.Execute delSql
     end if
  End If
  conn.Close
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->