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
  title="RT�I�u�O�Ω��Ӫ�C�L�M�P(�޳N��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�Ȥ����"
  functionOptPrompt="N"
  functionOptProgram="RTpaypcK.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  
  DSN="DSN=RTLIb"
  formatName="�I�ڪ�帹;�C�L��;�C�L��;�Ȥᵧ��;�I�u�O�`�B;�ɧU�O�`�B;�X�p;�|�p�f�֤�;�|�p�f�֭�"
  sqlDelete="SELECT RTCust.PAYDTLPRTNO, RTCust.paydtldat, RTObj.CUSNC, COUNT(RTCust.CUSID), " _
           &"SUM(RTCust.SETFEE), sum(rtcust.setfeediff),SUM(RTCust.SETFEE)+sum(rtcust.setfeediff),RTCust.acccfmDAT, RTObj1.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
           &"RTCust ON RTEmployee.EMPLY = RTCust.paydtlusr ON  " _
           &"RTEmployee1.EMPLY = RTCust.acccfmusr " _
           &"WHERE RTCust.PAYDTLPRTNO = '*' " 
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
 
  searchProg="RTPayPcS.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" and rtcust.PAYDTLPRTNO <>'' "
     searchShow="�w�C�L"
  End If   
  sqlList="SELECT RTCust.PAYDTLPRTNO, RTCust.paydtldat, RTObj.CUSNC, COUNT(RTCust.CUSID), " _
           &"SUM(RTCust.SETFEE), sum(rtcust.setfeediff),SUM(RTCust.SETFEE)+sum(rtcust.setfeediff),RTCust.acccfmDAT, RTObj1.CUSNC " _
           &"FROM RTEmployee RTEmployee1 LEFT OUTER JOIN " _
           &"RTObj RTObj1 ON RTEmployee1.CUSID = RTObj1.CUSID RIGHT OUTER JOIN " _
           &"RTEmployee LEFT OUTER JOIN " _
           &"RTObj ON RTEmployee.CUSID = RTObj.CUSID RIGHT OUTER JOIN " _
           &"RTCust ON RTEmployee.EMPLY = RTCust.paydtlusr ON  " _
           &"RTEmployee1.EMPLY = RTCust.acccfmusr " _
           &"WHERE RTCust.PAYDTLPRTNO <> '' " & searchqry _
           &"group by RTCust.PAYDTLPRTNO, RTCust.paydtldat,  RTObj.CUSNC,RTCust.acccfmDAT, RTObj1.CUSNC " _
           &"order by RTCust.PAYDTLPRTNO desc "
          'Response.Write "SQL=" & SQllist
End Sub
%>