<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->

<%
Set conn=Server.CreateObject("ADODB.Connection")
    conn.open "DSN=RTLib"
    conn.Execute("usp_ATableDesc '" & aryparmkey(0) & "'")
    conn.Close
Set conn=Nothing

Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="Table����ƺ��@��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y"
  buttonEnable="Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="none;�Ǹ�;���W��(�^);���W��(��);������O;�D��;Null;�w�]��;Identity;�Ƶ�"
  sqlDelete="SELECT tbName, colOrdinal, colName, colNameC, colDataType, " &_
			"       colIsKey, colIsNull, colDefault, colIsIdentity, colDesc " &_
            "FROM   AColumnList WHERE tbName ='*' " 
  dataTable=" AColumnList"
  numberOfKey=2
  dataProg="RTColumnD.asp"  
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
  keyListPageSize=80
  'searchProg="rtctysearch.asp"
  'If searchQry="" Then
     searchQry=" tbName='" & aryparmkey(0) & "'"
  '   searchShow=FrGetctyDesc(aryParmKey(0))       
  'End If
  sqlList="SELECT tbName, colOrdinal, colName, colNameC, colDataType, colIsKey, " &_
          "       colIsNull, colDefault, colIsIdentity, colDesc " &_
          "  FROM AColumnList WHERE " & searchQry & " " &_
          " ORDER BY colOrdinal "
'Response.Write sqlList
End Sub
%>
