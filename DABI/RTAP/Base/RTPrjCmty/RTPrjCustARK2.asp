<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�M�׺޲z�t��"
  title="�M�ץΤ��������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �R  �b ;�R�b����;�b�ک���"
  functionOptProgram="RTPrjCustARClear.asp;RTPrjCustARClearK.asp;RTPrjCustARDTLK.ASP"
  functionOptPrompt="Y;N;N"
  functionoptopen="2;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�����b�ڽs��;AR/AP;���Ӷ�����;���R���B;�w�R���B;���R���B;�R�߭n���@;�R�߭n���G;�R�߭n���T;none;none;���ͤ�;�R�b��;�@�o��"
  sqlDelete="SELECT  RTPrjCustAR.CUSID, " _
                &"RTPrjCustAR.BATCHNO, " _
                &"RTCode.CODENC, RTPrjCustAR.PERIOD, RTPrjCustAR.AMT, RTPrjCustAR.REALAMT, RTPrjCustAR.AMT - RTPrjCustAR.REALAMT, " _
                &"RTPrjCustAR.COD1, RTPrjCustAR.COD2, RTPrjCustAR.COD3, " _
                &"RTPrjCustAR.COD4, RTPrjCustAR.COD5, RTPrjCustAR.CDAT, " _
                &"RTPrjCustAR.MDAT, RTPrjCustAR.CANCELDAT " _
                &"FROM    RTPrjCustAR LEFT OUTER JOIN " _
                &"RTCode ON RTPrjCustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where RTPrjCUSTLOG.COMQ1=0 "
  dataTable="RTPrjCUSTLOG"
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
  searchProg="RTPrjcustARS2.ASP"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTPrjCmtyH ON " _
       &"RTCounty.CUTID = RTPrjCmtyH.CUTID RIGHT OUTER JOIN RTPrjCust ON RTPrjCmtyH.COMQ1 = RTPrjCust.COMQ1 " _
       &"where RTPrjCust.cusid='" & ARYPARMKEY(0) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select RTCounty.CUTNC+RTPrjCmtyLine.township+RTPrjCmtyLine.raddr as comaddr from RTCounty RIGHT OUTER JOIN RTPrjCmtyLine ON  " _
       &"RTCounty.CUTID = RTPrjCmtyLine.CUTID RIGHT OUTER JOIN " _
       &"RTPrjCust ON RTPrjCmtyLine.COMQ1 = RTPrjCust.COMQ1 AND " _
       &"RTPrjCmtyLine.LINEQ1 = RTPrjCust.LINEQ1 " _
       &"where RTPrjCust.cusid='" & ARYPARMKEY(0) & "'"

  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMaddr=rsyy("comaddr")
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select * from RTPrjCUST  where CUSID='" & ARYPARMKEY(0) & "' "
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
     searchQry="  RTPrjCustAR.CUSID='" & ARYPARMKEY(0) & "' AND RTPrjCustAR.CANCELDAT IS NULL "
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
  
         sqlList="SELECT  RTPrjCustAR.CUSID, " _
                &"RTPrjCustAR.BATCHNO, " _
                &"RTCode.CODENC, RTPrjCustAR.PERIOD, RTPrjCustAR.AMT, RTPrjCustAR.REALAMT,case when RTPrjCustAR.CANCELDAT is not null then 0 else RTPrjCustAR.AMT - RTPrjCustAR.REALAMT end, " _
                &"RTPrjCustAR.COD1, RTPrjCustAR.COD2, RTPrjCustAR.COD3, " _
                &"RTPrjCustAR.COD4, RTPrjCustAR.COD5, RTPrjCustAR.CDAT, " _
                &"RTPrjCustAR.MDAT, RTPrjCustAR.CANCELDAT " _
                &"FROM    RTPrjCustAR LEFT OUTER JOIN " _
                &"RTCode ON RTPrjCustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where  RTPrjCustAR.CUSID='" & ARYPARMKEY(0) & "' AND " & searchqry & " ORDER BY RTPrjCustAR.cdat "

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>