<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�Ҩ餽�q��~���򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  functionOptName=""
  functionOptProgram=""
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;N"
  'buttonEnable="Y;Y;Y;Y;Y;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;��~���N��;�m�W;�X�ͤ��;�ʧO;�p���q��;��ʹq��;�q�l�l��H�c"
  sqlDelete="SELECT RTBussMan.STOCKID, RTBussMan.BRANCH, RTBussMan.CUSID, RTObj.CUSNC," _ 
           &"RTBussMan.BIRTHDAY, case RTBussMan.SEX when 'M' then '�k' when 'F' then '�k' end as SEXNC, RTBussMan.CONTACT, " _
           &"RTBussMan.MOBIL, RTBussMan.EMAIL " _
           &"FROM RTBussMan INNER JOIN " _
           &"RTObj ON RTBussMan.CUSID = RTObj.CUSID " _ 
           &"WHERE (stockid='*') "
  dataTable="RTBussMan"
  numberOfKey=3
  userDefineDelete="Yes"    
  dataProg="RTobjStockBranchBussD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=False
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="self"
  searchShow=FrGetStockBussDesc(aryParmKey(0),aryparmkey(1))
  searchQry="rtbussman.stockid='" &aryParmKey(0) &"' and rtbussman.branch='" & aryparmKey(1) & "'"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  sqlList="SELECT RTBussMan.STOCKID, RTBussMan.BRANCH, RTBussMan.CUSID, RTObj.CUSNC," _ 
           &"RTBussMan.BIRTHDAY, case RTBussMan.SEX when 'M' then '�k' when 'F' then '�k' end as SEXNC, RTBussMan.CONTACT, " _
           &"RTBussMan.MOBIL, RTBussMan.EMAIL " _
           &"FROM RTBussMan INNER JOIN " _
           &"RTObj ON RTBussMan.CUSID = RTObj.CUSID " _
           &"WHERE " & searchQry & " " _
           &"ORDER BY stockid "
End Sub
Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  Set rs=Server.CreateObject("ADODB.recordset")  
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(1)) > 0 Then
     delSql="DELETE  FROM RTObjLink WHERE CUSTYID='09' AND CUSID IN " &extDeleList(3) &" "
     conn.Execute delSql
     SelSql="Select * FROM RTObjLink WHERE  CUSID IN " &extDeleList(3) &" "
     rs.Open selsql,conn
     '��objlink�w�L�ӹ�H�N�X�䥦���s��,�~�R����H�D��(�H�קK�ӹ�H���䥦��H
     '���O��,�o�N��H�D�ɧR�������~
     if rs.EOF then     
        delSql="DELETE  FROM RTObj WHERE CUSID IN " &extDeleList(3) &" " 
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
<!-- #include file="RTGetStockBussDesc.inc" -->