<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�i�f�沧�ʪ��p�d��"
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
  formatName="�i�f�渹;���ʶ���;�i�f��;�i�f�t��;�禬��;���ʤ��;���ʧO;���ʤH��"
  sqlDelete="SELECT RTSTOCKTRANSLOG.STOCKNO, RTSTOCKTRANSLOG.ENTRYNO, " _
           &"RTSTOCKTRANSLOG.STOCKDAT, RTObj.SHORTNC, " _
           &"RTObj_1.SHORTNC AS Expr1, RTSTOCKTRANSLOG.TRANSDAT, " _
           &"RTCode.CODENC, RTObj_2.SHORTNC AS Expr2 " _
           &"FROM RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"RTObj_2.CUSID = RTEmployee_1.CUSID INNER JOIN " _
           &"RTSTOCKTRANSLOG INNER JOIN " _
           &"RTObj ON RTSTOCKTRANSLOG.FACTORY = RTObj.CUSID INNER JOIN " _
           &"RTEmployee ON " _
           &"RTSTOCKTRANSLOG.CHECKUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID INNER JOIN " _
           &"RTCode ON RTSTOCKTRANSLOG.TRANSCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON " _
           &"RTEmployee_1.EMPLY = RTSTOCKTRANSLOG.TRANSUSR " _
           &"WHERE RTSTOCKTRANSLOG.STOCKNO='*' "       

  dataTable="RTSTOCKGOODSH"
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
     searchQry=" AND RTSTOCKTRANSLOG.STOCKNO ='" & ARYPARMKEY(0) & "' "
     searchShow="����"
  End If
  sqlList="SELECT RTSTOCKTRANSLOG.STOCKNO, RTSTOCKTRANSLOG.ENTRYNO, " _
           &"RTSTOCKTRANSLOG.STOCKDAT, RTObj.SHORTNC, " _
           &"RTObj_1.SHORTNC AS Expr1, RTSTOCKTRANSLOG.TRANSDAT, " _
           &"RTCode.CODENC, RTObj_2.SHORTNC AS Expr2 " _
           &"FROM RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_1 ON " _
           &"RTObj_2.CUSID = RTEmployee_1.CUSID INNER JOIN " _
           &"RTSTOCKTRANSLOG INNER JOIN " _
           &"RTObj ON RTSTOCKTRANSLOG.FACTORY = RTObj.CUSID INNER JOIN " _
           &"RTEmployee ON " _
           &"RTSTOCKTRANSLOG.CHECKUSR = RTEmployee.EMPLY INNER JOIN " _
           &"RTObj RTObj_1 ON RTEmployee.CUSID = RTObj_1.CUSID INNER JOIN " _
           &"RTCode ON RTSTOCKTRANSLOG.TRANSCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON " _
           &"RTEmployee_1.EMPLY = RTSTOCKTRANSLOG.TRANSUSR " _
           &"WHERE RTSTOCKTRANSLOG.STOCKNO ='" & ARYPARMKEY(0) & "' " &searchQry &" " 
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>