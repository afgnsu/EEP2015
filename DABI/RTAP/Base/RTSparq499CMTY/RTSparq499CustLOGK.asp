<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�ΤᲧ�ʸ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName=""
  functionOptProgram=""
  functionOptPrompt=""
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;����;�D�u;���ʤ��;�������O;���ʤH��;�Τ�ӽФ�;���u��;������;��������;�h����;������"
  sqlDelete="SELECT       RTSparq499CustLOG.COMQ1 AS Expr1, RTSparq499CustLOG.LINEQ1 AS Expr2, " _
                          &"RTSparq499CustLOG.CUSID AS Expr3, RTSparq499CustLOG.ENTRYNO AS Expr4, " _
                          &"RTRIM(CONVERT(char(6), RTSparq499CustLOG.COMQ1)) " _
                          &"+ '-' + RTRIM(CONVERT(char(6), RTSparq499CustLOG.LINEQ1)) AS comqline, " _
                          &"RTSparq499CustLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
                          &"RTSparq499CustLOG.APPLYDAT,RTSparq499CustLOG.FINISHDAT, RTSparq499CustLOG.DOCKETDAT, " _
                          &"RTSparq499CustLOG.TRANSDAT, " _
                          &"RTSparq499CustLOG.DROPDAT, RTSparq499CustLOG.FREECODE " _
             &"FROM          RTObj INNER JOIN " _
                          &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
                          &"RTSparq499CustLOG ON " _
                          &"RTEmployee.EMPLY = RTSparq499CustLOG.CHGUSR LEFT OUTER JOIN " _
                          &"RTCode ON RTSparq499CustLOG.CHGCODE = RTCode.CODE AND  " _
                          &"RTCode.KIND = 'G2' where RTSparq499CustLOG.COMQ1=0 "
  dataTable="RTSparq499CustLOG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg=""
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
  sqlYY="select * from RTSPARQ499CMTYH LEFT OUTER JOIN RTCOUNTY ON RTSPARQ499CMTYH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
  else
     COMN=""
  end if
  rsYY.Close
  sqlYY="select * from RTSPARQ499CMTYline LEFT OUTER JOIN RTCOUNTY ON RTSPARQ499CMTYline.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1)
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     comaddr=""
     COMaddr=rsYY("cutnc") & rsyy("township") & rsyy("RADDR") 
  else
     COMaddr=""
  end if
  RSYY.Close
  sqlYY="select * from RTSPARQ499CUST  where COMQ1=" & ARYPARMKEY(0) & " and lineq1=" & aryparmkey(1) & " AND CUSID='" & ARYPARMKEY(2) & "' "
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     CUSNC=rsYY("CUSNC")
  else
     CUSNC=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSPARQ499CUSTLOG.ComQ1=" & aryparmkey(0) & " and RTSPARQ499CUSTLOG.lineq1=" & aryparmkey(1) & " AND RTSPARQ499CUSTLOG.CUSID='" & ARYPARMKEY(2) & "' "
     searchShow="�D�u�J"& aryparmkey(0)& "-" & aryparmkey(1) & ",���ϡJ" & COMN & ",�D�u��}�J" & COMADDR & ",�Τ�Ǹ��J" & aryparmkey(2) & ",�Τ�W�١J" & CUSNC
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
  
    If searchShow="����" Then
         sqlList="SELECT       RTSparq499CustLOG.COMQ1 AS Expr1, RTSparq499CustLOG.LINEQ1 AS Expr2, " _
                          &"RTSparq499CustLOG.CUSID AS Expr3, RTSparq499CustLOG.ENTRYNO AS Expr4, " _
                          &"RTRIM(CONVERT(char(6), RTSparq499CustLOG.COMQ1)) " _
                          &"+ '-' + RTRIM(CONVERT(char(6), RTSparq499CustLOG.LINEQ1)) AS comqline, " _
                          &"RTSparq499CustLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
                          &"RTSparq499CustLOG.APPLYDAT,RTSparq499CustLOG.FINISHDAT, RTSparq499CustLOG.DOCKETDAT, " _
                          &"RTSparq499CustLOG.TRANSDAT, " _
                          &"RTSparq499CustLOG.DROPDAT, RTSparq499CustLOG.FREECODE " _
             &"FROM          RTObj INNER JOIN " _
                          &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
                          &"RTSparq499CustLOG ON " _
                          &"RTEmployee.EMPLY = RTSparq499CustLOG.CHGUSR LEFT OUTER JOIN " _
                          &"RTCode ON RTSparq499CustLOG.CHGCODE = RTCode.CODE AND  " _
                          &"RTCode.KIND = 'G2' " _
           &"where " & searchqry & " ORDER BY ENTRYNO "
    Else
         sqlList="SELECT       RTSparq499CustLOG.COMQ1 AS Expr1, RTSparq499CustLOG.LINEQ1 AS Expr2, " _
                          &"RTSparq499CustLOG.CUSID AS Expr3, RTSparq499CustLOG.ENTRYNO AS Expr4, " _
                          &"RTRIM(CONVERT(char(6), RTSparq499CustLOG.COMQ1)) " _
                          &"+ '-' + RTRIM(CONVERT(char(6), RTSparq499CustLOG.LINEQ1)) AS comqline, " _
                          &"RTSparq499CustLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, " _
                          &"RTSparq499CustLOG.APPLYDAT,RTSparq499CustLOG.FINISHDAT, RTSparq499CustLOG.DOCKETDAT, " _
                          &"RTSparq499CustLOG.TRANSDAT, " _
                          &"RTSparq499CustLOG.DROPDAT, RTSparq499CustLOG.FREECODE " _
             &"FROM          RTObj INNER JOIN " _
                          &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID RIGHT OUTER JOIN " _
                          &"RTSparq499CustLOG ON " _
                          &"RTEmployee.EMPLY = RTSparq499CustLOG.CHGUSR LEFT OUTER JOIN " _
                          &"RTCode ON RTSparq499CustLOG.CHGCODE = RTCode.CODE AND  " _
                          &"RTCode.KIND = 'G2' " _
           &"where " & searchqry & " ORDER BY ENTRYNO "
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>