<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<%
if not Session("passed") then
   Response.Redirect "http://www.cbbn.com.tw/Consignee/logon.asp"
end if

Sub SrEnvironment()
  on error resume next
  company="���T�e�W�����ѥ��������q"
  system="Hi-Building�޲z�t��"
  title="Hi-Building���ϤΫȤ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  'V=split(SrAccessPermit,";")
  'AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  'ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"  
  buttonEnable="N;N;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  'If V(1)="Y" then
  '   accessMode="U"
  'Else
     accessMode="I"
  'End IF
  DSN="DSN=RTLib"
  formatName="���ϦW��;�g�P��" 
  sqlDelete="SELECT RTCmty.COMN, RTCode.CODENC FROM RTCmty LEFT OUTER JOIN " _
           &"RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' " _
           &"ORDER BY  RTCmty.COMN "
  dataTable="RTCmty"
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=480,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=4
  keyListPageSize=60
  searchProg="ConsigneeALLhbCmtyS.asp"
' Open search program when first entry this keylist
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  
  If searchQry="" Then
     searchQry=" RTCMTY.Comq1<>0 and rtCMTY.RCOMDROP IS NULL "
    ' searchShow="����(���t�h���B�M�P�B���i�ظm��)"
    searchShow="����"
  ELSE
     SEARCHFIRST=FALSE
  End If
  
  sqllist="SELECT RTCmty.COMN, RTCode.CODENC FROM RTCmty LEFT OUTER JOIN " _
           &"RTCode ON RTCmty.COMTYPE = RTCode.CODE AND RTCode.KIND = 'B3' " _
           &"WHERE " &  searchqry & " " _           
           &"ORDER BY  RTCmty.COMN "
 
'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>
