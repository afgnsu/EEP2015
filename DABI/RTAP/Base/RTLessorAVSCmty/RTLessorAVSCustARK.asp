<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="AVS-City�޲z�t��"
  title="AVS-City�Τ��������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �R  �b ;�R�b����;�b�ک���"
  functionOptProgram="RTLessorAVSCustARClear.asp;RTLessorAVSCustARClearK.asp;RTLessorAVSCustARDTLK.ASP"
  functionOptPrompt="Y;N;N"
  functionoptopen="2;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�����b�ڽs��;AR/AP;���Ӷ�����;���R���B;�w�R���B;���R���B;�R�߭n���@;�R�߭n���G;�R�߭n���T;none;none;���ͤ�;�R�b��;�@�o��"
  sqlDelete="SELECT  RTLessorAVSCustAR.CUSID, " _
                &"RTLessorAVSCustAR.BATCHNO, " _
                &"RTCode.CODENC, RTLessorAVSCustAR.PERIOD, RTLessorAVSCustAR.AMT, RTLessorAVSCustAR.REALAMT, RTLessorAVSCustAR.AMT - RTLessorAVSCustAR.REALAMT, " _
                &"RTLessorAVSCustAR.COD1, RTLessorAVSCustAR.COD2, RTLessorAVSCustAR.COD3, " _
                &"RTLessorAVSCustAR.COD4, RTLessorAVSCustAR.COD5, RTLessorAVSCustAR.CDAT, " _
                &"RTLessorAVSCustAR.MDAT, RTLessorAVSCustAR.CANCELDAT " _
                &"FROM    RTLessorAVSCustAR LEFT OUTER JOIN " _
                &"RTCode ON RTLessorAVSCustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where RTLessorAVSCUSTLOG.COMQ1=0 "
  dataTable="RTLessorAVSCUSTLOG"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=350,height=160,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="500"
  diaHeight="500"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTLessorAVScustARS.ASP"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  set connXX=server.CreateObject("ADODB.connection")
  set rsXX=server.CreateObject("ADODB.recordset")
  dsnxx="DSN=XXLIB"
  sqlxx="select * from usergroup where userid='" & Request.ServerVariables("LOGON_USER") & "'"
  connxx.Open dsnxx
  rsxx.Open sqlxx,connxx
  if not rsxx.EOF then
     usergroup=rsxx("group")
  else
     usergroup=""
  end if
  rsxx.Close
  connxx.Close
  set rsxx=nothing
  set connxx=nothing
  '----
 set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyH ON " _
       &"RTCounty.CUTID = RTLessorAVSCmtyH.CUTID RIGHT OUTER JOIN RTLessorAVSCust ON RTLessorAVSCmtyH.COMQ1 = RTLessorAVSCust.COMQ1 " _
       &"where RTLessorAVSCust.cusid='" & ARYPARMKEY(2) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTLessorAVSCmtyLine ON  " _
       &"RTCounty.CUTID = RTLessorAVSCmtyLine.CUTID RIGHT OUTER JOIN " _
       &"RTLessorAVSCust ON RTLessorAVSCmtyLine.COMQ1 = RTLessorAVSCust.COMQ1 AND " _
       &"RTLessorAVSCmtyLine.LINEQ1 = RTLessorAVSCust.LINEQ1 " _
       &"where RTLessorAVSCust.cusid='" & ARYPARMKEY(2) & "'"
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township")
     if rsyy("village") <> "" then
         COMaddr= COMaddr & rsyy("village") & rsyy("cod1")
     end if
     if rsyy("NEIGHBOR") <> "" then
         COMaddr= COMaddr & rsyy("NEIGHBOR") & rsyy("cod2")
     end if
     if rsyy("STREET") <> "" then
         COMaddr= COMaddr & rsyy("STREET") & rsyy("cod3")
     end if
     if rsyy("SEC") <> "" then
         COMaddr= COMaddr & rsyy("SEC") & rsyy("cod4")
     end if
     if rsyy("LANE") <> "" then
         COMaddr= COMaddr & rsyy("LANE") & rsyy("cod5")
     end if
     if rsyy("ALLEYWAY") <> "" then
         COMaddr= COMaddr & rsyy("ALLEYWAY") & rsyy("cod7")
     end if
     if rsyy("NUM") <> "" then
         COMaddr= COMaddr & rsyy("NUM") & rsyy("cod8")
     end if
     if rsyy("FLOOR") <> "" then
         COMaddr= COMaddr & rsyy("FLOOR") & rsyy("cod9")
     end if
     if rsyy("ROOM") <> "" then
         COMaddr= COMaddr & rsyy("ROOM") & rsyy("cod10")
     end if
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select * from RTLessorAVSCUST  where CUSID='" & ARYPARMKEY(2) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     CUSNC=rsYY("CUSNC")
     comq1xx=rsyy("comq1")
     lineq1xx=rsyy("lineq1")
  else
     CUSNC=""
     comq1xx=""
     lineq1xx=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry="  RTLessorAVSCustAR.CUSID='" & ARYPARMKEY(2) & "' AND RTLessorAVSCustAR.CANCELDAT IS NULL "
     searchShow="�D�u�J"& comq1xx & "-" & lineq1xx & ",���ϡJ" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�Ǹ��J" & aryparmkey(0) & ",�Τ�W�١J" & CUSNC
  ELSE
     SEARCHFIRST=FALSE
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
  'Response.Write "user=" & Request.ServerVariables("LOGON_USER")
  'Ū���n�J�b�����s�ո��
  'Response.Write "GP=" & usergroup
  '-------------------------------------------------------------------------------------------
  'userlevel=2:���~�Ȥu�{�v==>�u��ݩ��ݪ��ϸ��
  'DOMAIN:'T','C','K'�_���n�ҰϤH��(�ȪA,�޳N)�u��ݩ����Ұϸ��
 ' Response.Write "DOMAIN=" & domain & "<BR>"
  Domain=Mid(Emply,1,1)
  select case Domain
         case "T"
            DAreaID="<>'*'"
         case "P"
            DAreaID="='A1'"                        
         case "C"
            DAreaID="='A2'"         
         case "K"
            DAreaID="='A3'"         
         case else
            DareaID="=''"
  end select
  '�����D�ޥiŪ���������
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31  then DAreaID="<>'*'"
  
         sqlList="SELECT  RTLessorAVSCustAR.CUSID, " _
                &"RTLessorAVSCustAR.BATCHNO, " _
                &"RTCode.CODENC, RTLessorAVSCustAR.PERIOD, RTLessorAVSCustAR.AMT, RTLessorAVSCustAR.REALAMT,case when RTLessorAVSCustAR.CANCELDAT is not null then 0 else RTLessorAVSCustAR.AMT - RTLessorAVSCustAR.REALAMT end, " _
                &"RTLessorAVSCustAR.COD1, RTLessorAVSCustAR.COD2, RTLessorAVSCustAR.COD3, " _
                &"RTLessorAVSCustAR.COD4, RTLessorAVSCustAR.COD5, RTLessorAVSCustAR.CDAT, " _
                &"RTLessorAVSCustAR.MDAT, RTLessorAVSCustAR.CANCELDAT " _
                &"FROM    RTLessorAVSCustAR LEFT OUTER JOIN " _
                &"RTCode ON RTLessorAVSCustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where RTLessorAVSCustAR.CUSID='" & ARYPARMKEY(2) & "' and " & searchqry & " ORDER BY RTLessorAVSCustAR.cdat "


  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>