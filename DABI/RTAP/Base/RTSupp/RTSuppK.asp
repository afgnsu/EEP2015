<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�t�Ӱ򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�M��;�d���Ұ�"
  functionOptProgram="RTSuppTechK.asp;RTSuppDutyK.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�t�ӥN�X;²��;���q�q��;�p���H;�p���q��;�ǯu�q��;�I�u�էO;�зǬI�u�O"
  sqlDelete="SELECT RTObj.CUSID, RTObj.SHORTNC,RTSupp.Tel,RTSupp.CONT,RTSupp.CONTTEL, " _
         &"RTSupp.FAX, RTSupp.TEAM,RTSupp.StdFee " _
         &"FROM RTObj INNER JOIN " _
         &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID INNER JOIN " _
         &"RTObjKind ON RTObjLink.CUSTYID = RTObjKind.CUSTYID INNER JOIN " _
         &"RTSupp ON RTObjLink.CUSID = RTSupp.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON RTObj.CUTID1 = RTCounty.CUTID " _
         &"WHERE (RTObjKind.CUSTYID = '04') and (RTobj.CUSID='*') "
  dataTable="RTSupp"
  userDefineDelete="Yes"  
  extTable="RTObj;RTObjLink"
  numberOfKey=1
  dataProg="RTSuppD.asp"
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
  searchProg="RTSuppS.asp"
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
     searchQry=" RTObj.CUSID<>'*' "
     searchShow="����"
  End If
  sqlList="SELECT RTObj.CUSID, RTObj.SHORTNC,RTSupp.Tel,RTSupp.CONT,RTSupp.CONTTEL, " _
         &"RTSupp.FAX, RTSupp.TEAM,RTSupp.StdFee  " _
         &"FROM RTObj INNER JOIN " _
         &"RTObjLink ON RTObj.CUSID = RTObjLink.CUSID INNER JOIN " _
         &"RTObjKind ON RTObjLink.CUSTYID = RTObjKind.CUSTYID INNER JOIN " _
         &"RTSupp ON RTObjLink.CUSID = RTSupp.CUSID LEFT OUTER JOIN " _
         &"RTCounty ON RTObj.CUTID1 = RTCounty.CUTID " _
         &"WHERE (RTObjKind.CUSTYID = '04') AND " &searchQry &" " _
         &"ORDER BY RTObj.ShortNC "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  Set rs=Server.CreateObject("ADODB.recordset")  
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(1)) > 0 Then
     delSql="DELETE  FROM RTSuppCty WHERE CUSID IN " &extDeleList(1) &" "
     conn.Execute delSql     
     delSql="DELETE  FROM RTSuppTec WHERE CUSID IN " &extDeleList(1) &" "
     conn.Execute delSql     
     delSql="DELETE  FROM RTObjLink WHERE CUSTYID='04' AND CUSID IN " &extDeleList(1) &" "
     conn.Execute delSql
     SelSql="Select * FROM RTObjLink WHERE  CUSID IN " &extDeleList(1) &" "
     rs.Open selsql,conn
     '��objlink�w�L�ӹ�H�N�X�䥦���s��,�~�R����H�D��(�H�קK�ӹ�H���䥦��H
     '���O��,�o�N��H�D�ɧR�������~
     if rs.EOF then                 
        delSql="DELETE  FROM RTObj WHERE CUSID IN " &extDeleList(1) &" " 
        conn.Execute delSql
     end if
     rs.close
  End If
  conn.Close
  set rs=nothing
  set conn=nothing
  objectcontext.setcomplete  
End Sub
%>