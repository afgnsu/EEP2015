<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�h�f�沧�ʪ��p�d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�h�f�渹;���ʶ���;�h�f��;�h�f�t��;��h��;���ʤ��;���ʧO;���ʤH��"
  sqlDelete="SELECT RTSTOCKRTNTRANSLOG.RETURNNO, RTSTOCKRTNTRANSLOG.ENTRYNO, " _
           &"RTSTOCKRTNTRANSLOG.RETURNDAT, RTObj.SHORTNC, " _
           &"RTObj_1.SHORTNC AS Expr1, RTSTOCKRTNTRANSLOG.TRANSDAT, " _
           &"RTCode.CODENC, RTObj_2.SHORTNC AS Expr2 " _
           &"FROM RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"RTObj_2.CUSID = RTEmployee_1.CUSID INNER JOIN " _
           &"RTSTOCKRTNTRANSLOG INNER JOIN " _
           &"RTObj ON RTSTOCKRTNTRANSLOG.FACTORY = RTObj.CUSID INNER JOIN " _
           &"RTEmployee ON " _
           &"RTSTOCKRTNTRANSLOG.CHECKUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID INNER JOIN " _
           &"RTCode ON RTSTOCKRTNTRANSLOG.TRANSCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON " _
           &"RTEmployee_1.EMPLY = RTSTOCKRTNTRANSLOG.TRANSUSR " _
           &"WHERE RTSTOCKRTNTRANSLOG.RETURNNO='*' "       

  dataTable=""
  userDefineDelete="Yes"  
  extTable=""
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
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
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
     searchQry=" AND RTSTOCKRTNTRANSLOG.RETURNNO ='" & ARYPARMKEY(0) & "' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKRTNTRANSLOG.RETURNNO, RTSTOCKRTNTRANSLOG.ENTRYNO, " _
           &"RTSTOCKRTNTRANSLOG.RETURNDAT, RTObj.SHORTNC, " _
           &"RTObj_1.SHORTNC AS Expr1, RTSTOCKRTNTRANSLOG.TRANSDAT, " _
           &"RTCode.CODENC, RTObj_2.SHORTNC AS Expr2 " _
           &"FROM RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"RTObj_2.CUSID = RTEmployee_1.CUSID INNER JOIN " _
           &"RTSTOCKRTNTRANSLOG INNER JOIN " _
           &"RTObj ON RTSTOCKRTNTRANSLOG.FACTORY = RTObj.CUSID INNER JOIN " _
           &"RTEmployee ON " _
           &"RTSTOCKRTNTRANSLOG.CHECKUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID INNER JOIN " _
           &"RTCode ON RTSTOCKRTNTRANSLOG.TRANSCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON " _
           &"RTEmployee_1.EMPLY = RTSTOCKRTNTRANSLOG.TRANSUSR " _
           &"WHERE RTSTOCKRTNTRANSLOG.RETURNNO ='" & ARYPARMKEY(0) & "' " &searchQry &" " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>