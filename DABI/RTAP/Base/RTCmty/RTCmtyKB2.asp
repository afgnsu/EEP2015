<%
  Dim LRAR,LRActRcvAmt
%>
<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyListB.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="RT�w�˵o�]�i�׬d��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  buttonEnable="N;N;Y;Y;N;N"
  accessMode="I"
  DSN="DSN=RTLib"
  formatName="none;�m�W;��<br>��;������<br>�r��;�}�o<br>����;�ӽФ��;�����<br>�ɤ��;" _
            &"�o�]���;�I�u�t��;���u���;�Ѽ�;���u��<br>�����;����<br>���B;�ꦬ<br>���B;" _
            &"�J�b���;�i��<br>���p;ĵ<br>��"
  DCTypes="003;200;003;200;200;135;135;135;200;135;200;135;003;003;135;200;200"
  sqlDelete="SELECT RTCust.COMQ1, RTObj.SHORTNC, RTCust.ENTRYNO, RTCust.CUSID, " _
           &"RTCust.CUSTYPE, RTCust.RCVD, RTCust.EDAT, RTCust.REQDAT, RTObj_1.SHORTNC, " _
           &"RTCust.FINISHDAT, RTCust.DOCKETDAT, RTCust.AR, RTCust.ACTRCVAMT, " _
           &"RTCust.INCOMEDAT, RTCust.DROPDESC, RTCust.NOTE " _
           &"FROM (RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID) " _
           &"INNER JOIN RTObj AS RTObj_1 ON RTCust.PROFAC = RTObj_1.CUSID " _
           &"WHERE (((RTCust.COMQ1)=0)) "
  dataTable="RTCust"
  userDefineList="Yes"
  numberOfKey=1
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  goodMorning=False
  goodMorningImage=""
  searchProg="RtcmtyS2.asp"
  If SearchQry="" then
     searchShow=FrGetCmtyDesc(aryParmKey(0))
     searchQry="RTCust.COMQ1=" &aryParmKey(0) &" "
  End if
  sqlList="SELECT RTCust.COMQ1, RTObj.SHORTNC, RTCust.ENTRYNO, RTCust.CUSID, " _
           &"RTCust.CUSTYPE, RTCust.RCVD, RTCust.EDAT, RTCust.REQDAT, RTObj_1.SHORTNC, " _
           &"RTCust.FINISHDAT, RTCust.DOCKETDAT, RTCust.AR, RTCust.ACTRCVAMT, " _
           &"RTCust.INCOMEDAT, RTCust.DROPDESC, RTCust.NOTE " _
           &"FROM (RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID) " _
           &"LEFT OUTER JOIN RTObj AS RTObj_1 ON RTCust.PROFAC = RTObj_1.CUSID " _
           &"WHERE " &searchQry
 '  Response.Write "SQL=" & SQllist
End Sub
Sub SrUserDefineProcess()
  Dim DZ
  LRAR=LRAR + DB(11)
  LRActRcvAmt=LRActRcvAmt + DB(12)
  DC(0)=DB(0)
  DC(1)=DB(1)
  DC(2)=DB(2)
  DC(3)=DB(3)
  DC(4)=DB(4)
  DC(5)=DB(5)
  DC(6)=DB(6)
  DC(7)=DB(7)
  DC(8)=DB(8)
  DC(9)=DB(9)
  DC(10)=""
  If IsDate(DB(7)) And IsDate(DB(9)) Then DC(10)=Cstr(DateDiff("d",DateValue(DB(7)),DateValue(DB(9)))+1)
  DC(11)=DB(10)
  DC(12)=DB(11)
  DC(13)=DB(12)
  DC(14)=DB(13)
  If IsDate(DB(9)) Then
     DC(15)="�w���u"
  ElseIf Trim(DB(14)) <> "" Then
     DC(15)="�M�P"
  ElseIf Not IsDate(DB(7)) Then
     DC(15)="���o�]"
  Else 
     DC(15)="�����u"
  End If
  DC(16)=""
  If Trim(DB(15)) <> "" Then DC(16)="<input type=radio checked>"
  Call SrAddListEntry(DC,"T",DCType)
  If TLR Then
     DC(0)="":DC(1)="":DC(2)="�X�p":DC(3)="":DC(4)="":DC(5)="":DC(6)="":DC(7)=""
     DC(8)="":DC(9)="":DC(10)="":DC(11)=""
     DC(12)=LRAR
     DC(13)=LRActRcvAmt
     DC(14)="":DC(15)="":DC(16)=""
     DZ=Split("200;200;200;200;200;200;200;200;200;200;200;200;003;003;200;200;200",";")     
     Call SrAddListEntry(DC,"T",DZ)
  End If
End Sub
%>
<!-- #include file="RTGetCmtyDesc.inc" -->