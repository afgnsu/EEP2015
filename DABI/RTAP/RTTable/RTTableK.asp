<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="Table ��줤�^��Ӫ�"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
  buttonEnable="N;N;Y;Y;Y;Y"
  functionOptName=" ��� ; �C�L "
  functionOptProgram="RTColumnK.asp;\rtap\RTTable\RTTableRPT.asp"
  functionOptPrompt="N;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="Table�W��(�^);Table�W��(��);Owner;���O;�Ƶ�"
  sqlDelete="SELECT tbOwner, tbType, tbName, tbNameC, tbDesc" _
         &"FROM ATableList "
  dataTable="ATableList"
  userDefineDelete="Yes"  
  'extTable="RTObj;RTObjLink"
  numberOfKey=1
  dataProg="RTTableD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=440,scrollbars=yes"
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
  searchProg="RTTableS.asp"
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
     searchQry=" tbName <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT tbName, tbNameC, tbOwner, tbType, tbDesc " &_
          "FROM	  ATableList " &_  
          "WHERE " & searchQry &" " &_
          " ORDER BY tbType "
'Response.Write "SQL=" &sqllist           
End Sub

Sub SrRunUserDefineDelete()
  Dim conn,i
  Set conn=Server.CreateObject("ADODB.Connection")
  Set rs=Server.CreateObject("ADODB.recordset")  
  On Error Resume Next  
  conn.Open DSN
  If Len(extDeleList(1)) > 0 Then
     delSql="DELETE FROM AColumnList WHERE tbName IN " &extDeleList(1) &" "
     conn.Execute delSql     
     'SelSql="Select * FROM AColumnList WHERE tbName IN " &extDeleList(1) &" "
     'rs.Open selsql,conn
     '��objlink�w�L�ӹ�H�N�X�䥦���s��,�~�R����H�D��(�H�קK�ӹ�H���䥦��H
     '���O��,�o�N��H�D�ɧR�������~
     'if rs.EOF then                 
     '   delSql="DELETE  FROM RTObj WHERE CUSID IN " &extDeleList(1) &" " 
     '   conn.Execute delSql
     'end if
     'rs.close
  End If
  conn.Close
  set rs=nothing
  set conn=nothing
  objectcontext.setcomplete  
End Sub
%>
