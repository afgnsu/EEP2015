<%
  Dim search1,parm,vk,debug36,search2
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="RT���u��C�L�M�P(�ȪA��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�Ȥ����"
  functionOptPrompt="N"
  functionOptProgram="RTworkCpK.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="���u�渹;�C�L�H��;�C�L���;�Ȥᵧ��;���u���"
  sqlDelete="SELECT RTCust.insprtno, RTObj.CUSNC, RTCust.insprtdat, COUNT(RTCust.CUSID), " _
           &"RTCust.FINISHDAT " _
           &"FROM RTEmployee LEFT OUTER JOIN RTObj " _
           &"ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
           &"RTCust ON RTEmployee.EMPLY = RTCust.insprtusr " _
           &"WHERE RTCust.insprtno = '*' " 
  'response.write "sql=" &sqldelete
  dataTable="b"
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
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=40
 
  searchProg="rtwcansearch.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and RTCust.insprtno <>'' "
     searchShow="�w�C�L"
  End If   
  sqlList="SELECT RTCust.insprtno, RTObj.CUSNC, RTCust.insprtdat, COUNT(RTCust.CUSID) " _
         &"FROM RTEmployee LEFT OUTER JOIN RTObj " _
         &"ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
         &"RTCust ON RTEmployee.EMPLY = RTCust.insprtusr " _
         &"WHERE RTCust.insprtno <> '' " & searchqry _
         &"group by RTCust.insprtno, RTObj.CUSNC, RTCust.insprtdat " _
         &" order by RTCust.insprtno desc "
 'Response.Write "SQL=" & SQllist
End Sub
%>