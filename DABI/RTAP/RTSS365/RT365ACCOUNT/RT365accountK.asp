<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�]�T���ݥ�Ĺ�b����Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=""
  functionOptProgram=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="�b��;�K�X;�b����<BR>��(��);�Ȥᨭ����;�Ȥ�W��;�榸;�������;�b���}�q��;�b��<br>����;�b�����P��;�b�����Ĥ�;�Z��<br>�Ѽ�"
sqlDelete="SELECT RT365ACCOUNT.SS365ACCOUNT, RT365ACCOUNT.SS365PWD, "_
         &"RT365ACCOUNT.ACCOUNTLIFE, ISNULL(RTCustADSL.SOCIALID, '') , " _ 
         &"ISNULL(RTObj.SHORTNC, '') , ISNULL(RT365ACCOUNT.ENTRYNO, '') " _
         &",RT365ACCOUNT.USEDAT,rt365account.applydat, " _ 
         &"RT365ACCOUNT.TYPE, RT365ACCOUNT.DROPDAT, " _
         &"rt365account.deadline, " _
         &"case when rt365account.applydat is not null then DateDiff(day,getdate(),case when rt365account.type = '399' and rt365account.applydat is not null then dateadd(month,3,rt365account.applydat) " _
         &"when rt365account.type = '599' and rt365account.applydat is not null then dateadd(month,15,rt365account.applydat) " _
         &"when rt365account.type = '1199' and rt365account.applydat is not null then dateadd(month,24,rt365account.applydat) end) else 0 end " _                  
         &"FROM RT365ACCOUNT LEFT OUTER JOIN " _
         &"RTCustADSL ON RT365ACCOUNT.CUSID = RTCustADSL.CUSID AND " _
         &"RT365ACCOUNT.ENTRYNO = RTCustADSL.ENTRYNO LEFT OUTER JOIN " _
         &"RTObj ON RT365ACCOUNT.CUSID = RTObj.CUSID " _
         &"WHERE RT365ACCOUNT.SS365ACCOUNT = '*' "
  dataTable="RT365account"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=1
  dataProg="RT365accountD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature="width=400,height=200,scrollbars=yes"
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="rt365accounts.asp"
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" and RT365account.ss365account='*' "
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT RT365ACCOUNT.SS365ACCOUNT, RT365ACCOUNT.SS365PWD, "_
         &"RT365ACCOUNT.ACCOUNTLIFE, ISNULL(RTCustADSL.SOCIALID, '') , " _ 
         &"ISNULL(RTObj.SHORTNC, ''), ISNULL(RT365ACCOUNT.ENTRYNO, '') " _
         &",RT365ACCOUNT.USEDATE ,rt365account.applydat, " _ 
         &"RT365ACCOUNT.TYPE, RT365ACCOUNT.DROPDAT, " _
         &"rt365account.deadline, " _
         &"case when rt365account.applydat is not null then DateDiff(day,getdate(),case when rt365account.type = '399' and rt365account.applydat is not null then dateadd(month,3,rt365account.applydat) " _
         &"when rt365account.type = '599' and rt365account.applydat is not null then dateadd(month,15,rt365account.applydat) " _
         &"when rt365account.type = '1199' and rt365account.applydat is not null then dateadd(month,24,rt365account.applydat) end) else 0 end " _         
         &"FROM RT365ACCOUNT LEFT OUTER JOIN " _
         &"RTCustADSL ON RT365ACCOUNT.CUSID = RTCustADSL.CUSID AND " _
         &"RT365ACCOUNT.ENTRYNO = RTCustADSL.ENTRYNO LEFT OUTER JOIN " _
         &"RTObj ON RT365ACCOUNT.CUSID = RTObj.CUSID " _
         &"WHERE rt365account.ss365account <> '*' " & searchqry _
         &" order by rt365account.ss365account  "
' Response.Write "sql=" & SQLLIST
End Sub
%>
