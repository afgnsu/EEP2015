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
  title="RT�I�u�O�ΥI�ڼf�ֽT�{"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�Ȥ����"
  functionOptPrompt="N"
  functionOptProgram="RTpaycfmkeylist.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="�I�ڪ�帹;�C�L�H��;�C�L���;�Ȥᵧ��;�зǬI�u�O�`�B;�I�u�ɧU�O�`�B;�|�p�f�֤��;�|�p�f�֤H��"
  sqlDelete="SELECT  RTCust.PAYDTLPRTNO, RTObj1.CUSNC, RTCust.PAYDTLDAT, COUNT(RTCust.CUSID), " _
         &"SUM(RTCust.SETFEE), SUM(RTCust.SETFEEDIFF), RTCust.ACCCFMDAT, RTObj.CUSNC " _
         &"FROM  RTEmployee RTEmployee1 LEFT OUTER JOIN " _
         &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
         &"RTCust ON RTEmployee1.EMPLY = RTCust.PAYDTLUSR LEFT OUTER JOIN " _
         &"RTObj RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
         &"RTCust.ACCCFMUSR = RTEmployee.EMPLY " _
         &"WHERE rtcust.PAYDTLPRTNO = '*' "
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
  colSplit=1
  keyListPageSize=20  
 
  searchProg="rtPAYsearch.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and rtcust.acccfmdat is null "
     searchShow="���f��"
  End If   
  sqlList="SELECT  RTCust.PAYDTLPRTNO, RTObj1.CUSNC, RTCust.PAYDTLDAT, COUNT(RTCust.CUSID), " _
         &"SUM(RTCust.SETFEE), SUM(RTCust.SETFEEDIFF), RTCust.ACCCFMDAT, RTObj.CUSNC " _
         &"FROM  RTEmployee RTEmployee1 LEFT OUTER JOIN " _
         &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
         &"RTCust ON RTEmployee1.EMPLY = RTCust.PAYDTLUSR LEFT OUTER JOIN " _
         &"RTObj RIGHT OUTER JOIN " _
         &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON  " _
         &"RTCust.ACCCFMUSR = RTEmployee.EMPLY " _
         &"WHERE rtcust.PAYDTLPRTNO <> '' " & searchqry _
         &" GROUP BY RTCust.PAYDTLPRTNO, RTOBJ1.CUSNC, RTCust.paydtldat, RTCust.acccfmdat,rtobj.cusnc order by RTCust.PAYDTLPRTNO desc "
 'Response.Write "SQL=" & SQllist
End Sub
%>