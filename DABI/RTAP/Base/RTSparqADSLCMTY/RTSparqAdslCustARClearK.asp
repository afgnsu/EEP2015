<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��399�޲z�t��"
  title="�t��399�Τ�����(�I)�b�ڨR�b���Ӭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�R�b����"
  functionOptProgram="RTSparqAdslCustARClearRTN.asp"
  functionOptPrompt="Y"
  functionoptopen="1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;����;�R�b���B;�R�b���;�R�b�H��;������;����H��"
  sqlDelete="SELECT CUSID, BATCHNO, SEQ,REALAMT,MDAT,RTOBJ.CUSNC , CANCELDAT, RTOBJ_1.CUSNC AS CUSNC1 " _
           &"FROM  RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID " _
           &"RIGHT OUTER JOIN RTSparqAdslCustARClear ON RTEmployee_1.EMPLY = RTSparqAdslCustARClear.CANCELUSR LEFT OUTER JOIN " _
           &"RTObj INNER JOIN RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON RTSparqAdslCustARClear.MUSR = RTEmployee.EMPLY " _
           &"where RTSparqAdslCustARClear.cusid='' "
  dataTable="RTSparqAdslCustARClear"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="500"
  diaHeight="500"
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=2
  keyListPageSize=50
  searchProg="self"
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
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTSparqAdslCmty ON " _
       &"RTCounty.CUTID = RTSparqAdslCmty.CUTID RIGHT OUTER JOIN RTSparqAdslCust ON RTSparqAdslCmty.cutyid = RTSparqAdslCust.COMQ1 " _
       &"where RTSparqAdslCust.cusid='" & ARYPARMKEY(0) & "'"
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTCounty RIGHT OUTER JOIN RTSparqAdslCmty ON  " _
       &"RTCounty.CUTID = RTSparqAdslCmty.CUTID RIGHT OUTER JOIN " _
       &"RTSparqAdslCust ON RTSparqAdslCmty.cutyid = RTSparqAdslCust.COMQ1 " _
       &"where RTSparqAdslCust.cusid='" & ARYPARMKEY(0) & "'"
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township") & rsyy("ADDR")
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select b.cusnc, a.comq1 from RTSparqAdslCUST a " &_
		"inner join RTObj b on a.cusid = b.cusid Where a.CUSID='" & ARYPARMKEY(0) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     CUSNC=rsYY("CUSNC")
     comq1xx=rsyy("comq1")
  else
     CUSNC=""
     comq1xx=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSparqAdslCustARClear.CUSID='" & ARYPARMKEY(0) & "' AND RTSparqAdslCustARClear.BATCHNO='" & ARYPARMKEY(1) & "'"
     searchShow="�D�u�J"& comq1xx & ",���ϡJ" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�Ǹ��J" & aryparmkey(0) & ",�Τ�W�١J" & CUSNC & ",�b�ڽs���J" & ARYPARMKEY(1)
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
  
         sqlList="SELECT  " _
                &"RTSparqAdslCustARClear.CUSID, RTSparqAdslCustARClear.BATCHNO, " _
                &"RTSparqAdslCustARClear.SEQ, RTSparqAdslCustARClear.REALAMT, " _
                &"RTSparqAdslCustARClear.MDAT, RTObj_2.SHORTNC, " _
                &"RTSparqAdslCustARClear.CANCELDAT, RTObj_1.SHORTNC AS Expr1 " _
                &"FROM    RTSparqAdslCustARClear LEFT OUTER JOIN " _
                &"RTObj RTObj_1 INNER JOIN " _
                &"RTEmployee RTEmployee_1 ON RTObj_1.CUSID = RTEmployee_1.CUSID ON " _
                &"RTSparqAdslCustARClear.CANCELUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTObj RTObj_2 INNER JOIN " _
                &"RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
                &"RTSparqAdslCustARClear.MUSR = RTEmployee_2.EMPLY " _
                &"where " & searchqry & " ORDER BY RTSparqAdslCustARCLEAR.SEQ "


  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>