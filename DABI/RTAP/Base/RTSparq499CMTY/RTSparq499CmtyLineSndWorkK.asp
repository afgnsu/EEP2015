<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�t��499�D�u���u���ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;" & V(3)  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=" �C �L ;���u����;�����u����;���ת���; �@ �o ;�@�o����;�]�Ʃ���;���v����"
  functionOptProgram="RTSparq499CmtyLineSndPV.asp;RTSparq499CmtylinesndworkF.asp;RTSparq499CmtylinesndworkUF.asp;RTSparq499CmtylinesndworkFR.asp;RTSparq499Cmtylinesndworkdrop.asp;RTSparq499Cmtylinesndworkdropc.asp;RTSparq499CmtyhardwareK.asp;RTSparq499CmtylinesndworkLOGK.asp"
  functionOptPrompt="N;N;N;N;N;N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;���u�渹;���u���;�C�L�H��;�w�w�I�u��;��ڬI�u��;���u���פ�;�����u���פ�;�@�o��;���������;�����f�֤�;�w�s�����;�w�s�f�֤�"
  sqlDelete="SELECT RTSparq499CmtyLINESNDWORK.COMQ1, RTSparq499CmtyLINESNDWORK.LINEQ1, RTSparq499CmtyLINESNDWORK.PRTNO,rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.lineQ1))  as comqline, RTSparq499CmtyLINESNDWORK.PRTNO, " _
           &"RTSparq499CmtyLINESNDWORK.SENDWORKDAT, RTObj_8.CUSNC, " _
           &"CASE WHEN RTOBJ_6.SHORTNC <> '' THEN RTOBJ_6.SHORTNC ELSE CASE WHEN RTObj.CUSNC <> '' THEN RTObj.CUSNC + '/' ELSE '' END " _
           &"+ CASE WHEN RTObj_1.CUSNC <> '' THEN RTObj_1.CUSNC + '/' ELSE '' END " _
           &"+ CASE WHEN RTObj_2.CUSNC <> '' THEN RTObj_2.CUSNC + '/' ELSE '' END END AS assigneengneer," _
           &"CASE WHEN RTOBJ_7.SHORTNC <> '' THEN RTOBJ_7.SHORTNC ELSE CASE WHEN RTObj_3.CUSNC <> '' THEN RTObj_3.CUSNC + '/' ELSE '' END " _
           &"+ CASE WHEN RTObj_4.CUSNC <> '' THEN RTObj_4.CUSNC + '/' ELSE '' END " _
           &"+ CASE WHEN RTObj_5.CUSNC <> '' THEN RTObj_5.CUSNC + '/' ELSE '' END END AS realengineer, " _
           &"RTSparq499CmtyLINESNDWORK.FINISHDAT,RTSparq499CmtyLINESNDWORK.UNCLOSEDAT,RTSparq499CmtyLINESNDWORK.DROPDAT,RTSparq499CmtyLINESNDWORK.BONUSCLOSEYM, RTSparq499CmtyLINESNDWORK.BONUSFINCHK, RTSparq499CmtyLINESNDWORK.STOCKCLOSEYM, " _
           &"RTSparq499CmtyLINESNDWORK.STOCKFINCHK " _
           &"FROM         RTObj RTObj_6 RIGHT OUTER JOIN " _
           &"RTObj RTObj_8 INNER JOIN " _
           &"RTEmployee RTEmployee_6 ON " _
           &"RTObj_8.CUSID = RTEmployee_6.CUSID RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINESNDWORK ON " _
           &"RTEmployee_6.EMPLY = RTSparq499CmtyLINESNDWORK.PRTUSR LEFT OUTER JOIN " _
           &"RTObj RTObj_7 ON " _
           &"RTSparq499CmtyLINESNDWORK.REALCONSIGNEE = RTObj_7.CUSID ON  " _
           &"RTObj_6.CUSID = RTSparq499CmtyLINESNDWORK.ASSIGNCONSIGNEE LEFT OUTER  JOIN " _
           &"RTObj RTObj_5 INNER JOIN " _
           &"RTEmployee RTEmployee_5 ON RTObj_5.CUSID = RTEmployee_5.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER3 = RTEmployee_5.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_4 INNER JOIN " _
           &"RTObj RTObj_4 ON RTEmployee_4.CUSID = RTObj_4.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER2 = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_3 INNER JOIN " _
           &"RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER1 = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
            &"RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER3 = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
            &"RTEmployee RTEmployee_1 INNER JOIN " _
            &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER2 = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
            &"RTObj INNER JOIN " _
            &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER1 = RTEmployee.EMPLY "
  dataTable="RTSparq499CmtyLINESNDWORK"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTSparq499CmtylinesndworkD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
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
  sqlYY="select * from RTSparq499CmtyH LEFT OUTER JOIN RTCOUNTY ON RTSparq499CmtyH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTSparq499Cmtyline LEFT OUTER JOIN RTCOUNTY ON RTSparq499Cmtyline.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township") & rsyy("raddr")
  else
     COMaddr=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSparq499CmtyLINESNDWORK.ComQ1=" & aryparmkey(0) & " and RTSparq499CmtyLINESNDWORK.lineq1=" & aryparmkey(1) & " "
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN &",�D�u�Ǹ��J" & aryparmkey(1) & ",�D�u��}�J" & COMADDR
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
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT RTSparq499CmtyLINESNDWORK.COMQ1, RTSparq499CmtyLINESNDWORK.LINEQ1, RTSparq499CmtyLINESNDWORK.PRTNO,rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.lineQ1))  as comqline, RTSparq499CmtyLINESNDWORK.PRTNO,  " _
           &"RTSparq499CmtyLINESNDWORK.SENDWORKDAT, RTObj_8.CUSNC, " _
           &"CASE WHEN RTOBJ_6.SHORTNC <> '' THEN RTOBJ_6.SHORTNC ELSE CASE WHEN RTObj.CUSNC <> '' THEN RTObj.CUSNC  ELSE '' END " _
           &"+ CASE WHEN RTObj_1.CUSNC <> '' THEN '/' + RTObj_1.CUSNC ELSE '' END " _
           &"+ CASE WHEN RTObj_2.CUSNC <> '' THEN '/' + RTObj_2.CUSNC ELSE '' END END AS assigneengneer," _
           &"CASE WHEN RTOBJ_7.SHORTNC <> '' THEN RTOBJ_7.SHORTNC ELSE CASE WHEN RTObj_3.CUSNC <> '' THEN RTObj_3.CUSNC ELSE '' END " _
           &"+ CASE WHEN RTObj_4.CUSNC <> '' THEN '/' + RTObj_4.CUSNC  ELSE '' END " _
           &"+ CASE WHEN RTObj_5.CUSNC <> '' THEN '/' + RTObj_5.CUSNC ELSE '' END END AS realengineer, " _
           &"RTSparq499CmtyLINESNDWORK.FINISHDAT,RTSparq499CmtyLINESNDWORK.UNCLOSEDAT,RTSparq499CmtyLINESNDWORK.DROPDAT,RTSparq499CmtyLINESNDWORK.BONUSCLOSEYM, RTSparq499CmtyLINESNDWORK.BONUSFINCHK, RTSparq499CmtyLINESNDWORK.STOCKCLOSEYM, " _
           &"RTSparq499CmtyLINESNDWORK.STOCKFINCHK " _
           &"FROM         RTObj RTObj_6 RIGHT OUTER JOIN " _
           &"RTObj RTObj_8 INNER JOIN " _
           &"RTEmployee RTEmployee_6 ON " _
           &"RTObj_8.CUSID = RTEmployee_6.CUSID RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINESNDWORK ON " _
           &"RTEmployee_6.EMPLY = RTSparq499CmtyLINESNDWORK.PRTUSR LEFT OUTER JOIN " _
           &"RTObj RTObj_7 ON " _
           &"RTSparq499CmtyLINESNDWORK.REALCONSIGNEE = RTObj_7.CUSID ON  " _
           &"RTObj_6.CUSID = RTSparq499CmtyLINESNDWORK.ASSIGNCONSIGNEE LEFT OUTER  JOIN " _
           &"RTObj RTObj_5 INNER JOIN " _
           &"RTEmployee RTEmployee_5 ON RTObj_5.CUSID = RTEmployee_5.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER3 = RTEmployee_5.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_4 INNER JOIN " _
           &"RTObj RTObj_4 ON RTEmployee_4.CUSID = RTObj_4.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER2 = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_3 INNER JOIN " _
           &"RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER1 = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
            &"RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER3 = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
            &"RTEmployee RTEmployee_1 INNER JOIN " _
            &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER2 = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
            &"RTObj INNER JOIN " _
            &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER1 = RTEmployee.EMPLY " _
            &"where " & searchqry
    Else
         sqlList="SELECT RTSparq499CmtyLINESNDWORK.COMQ1, RTSparq499CmtyLINESNDWORK.LINEQ1, RTSparq499CmtyLINESNDWORK.PRTNO,rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499CmtyLINESNDWORK.lineQ1))  as comqline, RTSparq499CmtyLINESNDWORK.PRTNO,  " _
           &"RTSparq499CmtyLINESNDWORK.SENDWORKDAT, RTObj_8.CUSNC, " _
           &"CASE WHEN RTOBJ_6.SHORTNC <> '' THEN RTOBJ_6.SHORTNC ELSE CASE WHEN RTObj.CUSNC <> '' THEN RTObj.CUSNC  ELSE '' END " _
           &"+ CASE WHEN RTObj_1.CUSNC <> '' THEN '/' + RTObj_1.CUSNC ELSE '' END " _
           &"+ CASE WHEN RTObj_2.CUSNC <> '' THEN '/' + RTObj_2.CUSNC  ELSE '' END END AS assigneengneer," _
           &"CASE WHEN RTOBJ_7.SHORTNC <> '' THEN RTOBJ_7.SHORTNC ELSE CASE WHEN RTObj_3.CUSNC <> '' THEN RTObj_3.CUSNC  ELSE '' END " _
           &"+ CASE WHEN RTObj_4.CUSNC <> '' THEN '/' + RTObj_4.CUSNC  ELSE '' END " _
           &"+ CASE WHEN RTObj_5.CUSNC <> '' THEN '/' + RTObj_5.CUSNC  ELSE '' END END AS realengineer, " _
           &"RTSparq499CmtyLINESNDWORK.FINISHDAT,RTSparq499CmtyLINESNDWORK.UNCLOSEDAT,RTSparq499CmtyLINESNDWORK.DROPDAT,RTSparq499CmtyLINESNDWORK.BONUSCLOSEYM, RTSparq499CmtyLINESNDWORK.BONUSFINCHK, RTSparq499CmtyLINESNDWORK.STOCKCLOSEYM, " _
           &"RTSparq499CmtyLINESNDWORK.STOCKFINCHK " _
           &"FROM         RTObj RTObj_6 RIGHT OUTER JOIN " _
           &"RTObj RTObj_8 INNER JOIN " _
           &"RTEmployee RTEmployee_6 ON " _
           &"RTObj_8.CUSID = RTEmployee_6.CUSID RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINESNDWORK ON " _
           &"RTEmployee_6.EMPLY = RTSparq499CmtyLINESNDWORK.PRTUSR LEFT OUTER JOIN " _
           &"RTObj RTObj_7 ON " _
           &"RTSparq499CmtyLINESNDWORK.REALCONSIGNEE = RTObj_7.CUSID ON  " _
           &"RTObj_6.CUSID = RTSparq499CmtyLINESNDWORK.ASSIGNCONSIGNEE LEFT OUTER  JOIN " _
           &"RTObj RTObj_5 INNER JOIN " _
           &"RTEmployee RTEmployee_5 ON RTObj_5.CUSID = RTEmployee_5.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER3 = RTEmployee_5.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_4 INNER JOIN " _
           &"RTObj RTObj_4 ON RTEmployee_4.CUSID = RTObj_4.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER2 = RTEmployee_4.EMPLY LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_3 INNER JOIN " _
           &"RTObj RTObj_3 ON RTEmployee_3.CUSID = RTObj_3.CUSID ON " _
           &"RTSparq499CmtyLINESNDWORK.REALENGINEER1 = RTEmployee_3.EMPLY LEFT OUTER JOIN " _
            &"RTObj RTObj_2 INNER JOIN " _
           &"RTEmployee RTEmployee_2 ON RTObj_2.CUSID = RTEmployee_2.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER3 = RTEmployee_2.EMPLY LEFT OUTER JOIN " _
            &"RTEmployee RTEmployee_1 INNER JOIN " _
            &"RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER2 = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
            &"RTObj INNER JOIN " _
            &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
            &"RTSparq499CmtyLINESNDWORK.ASSIGNENGINEER1 = RTEmployee.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>