<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�t��499�Τ��������I�b�ڬd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �R  �b ;�R�b����;�b�ک���"
  functionOptProgram="RTSparq499CustARClear.asp;RTSparq499CustARClearK.asp;RTSparq499CustARDTLK.ASP"
  functionOptPrompt="N;N;N"
  functionoptopen="2;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�����b�ڽs��;AR/AP;���Ӷ�����;���R���B;�w�R���B;���R���B;�R�߭n���@;�R�߭n���G;�R�߭n���T;none;none;���ͤ�;�R�b��;�@�o��"
  sqlDelete="SELECT  RTSparq499CustAR.CUSID, " _
                &"RTSparq499CustAR.BATCHNO, " _
                &"RTCode.CODENC, RTSparq499CustAR.PERIOD, RTSparq499CustAR.AMT, RTSparq499CustAR.REALAMT, RTSparq499CustAR.AMT - RTSparq499CustAR.REALAMT, " _
                &"RTSparq499CustAR.COD1, RTSparq499CustAR.COD2, RTSparq499CustAR.COD3, " _
                &"RTSparq499CustAR.COD4, RTSparq499CustAR.COD5, RTSparq499CustAR.CDAT, " _
                &"RTSparq499CustAR.MDAT, RTSparq499CustAR.CANCELDAT " _
                &"FROM    RTSparq499CustAR LEFT OUTER JOIN " _
                &"RTCode ON RTSparq499CustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where RTSparq499CUSTLOG.COMQ1=0 "
  dataTable="RTSparq499CUSTLOG"
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
  searchProg="RTSparq499custARS2.ASP"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTSparq499CmtyH ON " _
       &"RTCounty.CUTID = RTSparq499CmtyH.CUTID RIGHT OUTER JOIN RTSparq499Cust ON RTSparq499CmtyH.COMQ1 = RTSparq499Cust.COMQ1 " _
       &"where RTSparq499Cust.cusid='" & ARYPARMKEY(0) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTSparq499CmtyLine ON  " _
       &"RTCounty.CUTID = RTSparq499CmtyLine.CUTID RIGHT OUTER JOIN " _
       &"RTSparq499Cust ON RTSparq499CmtyLine.COMQ1 = RTSparq499Cust.COMQ1 AND " _
       &"RTSparq499CmtyLine.LINEQ1 = RTSparq499Cust.LINEQ1 " _
       &"where RTSparq499Cust.cusid='" & ARYPARMKEY(0) & "'"
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township") & rsyy("RADDR")
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select * from RTSparq499CUST  where CUSID='" & ARYPARMKEY(0) & "' "
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
     searchQry="  RTSparq499CustAR.CUSID='" & ARYPARMKEY(0) & "' AND RTSparq499CustAR.CANCELDAT IS NULL "
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
  
         sqlList="SELECT  RTSparq499CustAR.CUSID, " _
                &"RTSparq499CustAR.BATCHNO, " _
                &"RTCode.CODENC, RTSparq499CustAR.PERIOD, RTSparq499CustAR.AMT, RTSparq499CustAR.REALAMT,case when RTSparq499CustAR.CANCELDAT is not null then 0 else RTSparq499CustAR.AMT - RTSparq499CustAR.REALAMT end, " _
                &"RTSparq499CustAR.COD1, RTSparq499CustAR.COD2, RTSparq499CustAR.COD3, " _
                &"RTSparq499CustAR.COD4, RTSparq499CustAR.COD5, RTSparq499CustAR.CDAT, " _
                &"RTSparq499CustAR.MDAT, RTSparq499CustAR.CANCELDAT " _
                &"FROM    RTSparq499CustAR LEFT OUTER JOIN " _
                &"RTCode ON RTSparq499CustAR.ARTYPE = RTCode.CODE AND " _
                &"RTCode.KIND = 'N2' " _
                &"where  RTSparq499CustAR.CUSID='" & ARYPARMKEY(0) & "' AND " & searchqry & " ORDER BY RTSparq499CustAR.cdat "

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>