<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="Hi-Building�޲z�t��"
  title="���Ͼ�u���u�沧�ʸ�Ƭd��"
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
  formatName="none;none;none;none;��u���u�渹;����;���ʤ��;�������O;���ʤH��;���u��;�@�o��;�@�o�H��;��u���u��;��u�H��"
  sqlDelete="SELECT HBCmtyarrangeSNDWORKLOG.COMQ1,HBCmtyarrangeSNDWORKLOG.COMTYPE, HBCmtyarrangeSNDWORKLOG.PRTNO, " _
           &"HBCmtyarrangeSNDWORKLOG.ENTRYNO, HBCmtyarrangeSNDWORKLOG.PRTNO AS Expr1, HBCmtyarrangeSNDWORKLOG.ENTRYNO AS Expr2, " _
           &"HBCmtyarrangeSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, HBCmtyarrangeSNDWORKLOG.SNDDAT, " _
           &"HBCmtyarrangeSNDWORKLOG.DROPDAT, RTObj_1.CUSNC AS Expr3,HBCmtyarrangeSNDWORKLOG.closeDAT, RTObj_2.CUSNC AS Expr4 " _
           &"FROM RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID RIGHT OUTER JOIN " _
           &"HBCmtyarrangeSNDWORKLOG INNER JOIN RTCode ON HBCmtyarrangeSNDWORKLOG.CHGCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON RTEmployee_2.EMPLY = HBCmtyarrangeSNDWORKLOG.CLOSEUSR LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
           &"HBCmtyarrangeSNDWORKLOG.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCmtyarrangeSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where HBCmtyarrangeSNDWORKLOG.COMQ1=0"
  dataTable="HBCmtyarrangeSNDWORKLOG"
  userDefineDelete="Yes"
  numberOfKey=4
  dataProg="none"
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
  connYY.Open dsnYY
  set connYY=server.CreateObject("ADODB.connection")
  set rsYY=server.CreateObject("ADODB.recordset")
  dsnYY="DSN=RTLIB"
  connYY.Open dsnYY
  if aryparmkey(1)="01" then
     comtype="Hi-Buildinf"
     sqlYY="select * from RTCMTY LEFT OUTER JOIN RTCOUNTY ON RTCMTY.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
     rsYY.Open sqlYY,connYY
     if not rsYY.EOF then
        COMN=rsYY("COMN")
     else
        COMN=""
     end if
     rsYY.Close
  elseif  aryparmkey(1)="02" then
     comtype="����399"
     sqlYY="select * from RTcustadslCMTY LEFT OUTER JOIN RTCOUNTY ON RTcustadslCMTY.CUTID=RTCOUNTY.CUTID where cutyid=" & ARYPARMKEY(0)
     rsYY.Open sqlYY,connYY
     if not rsYY.EOF then
        COMN=rsYY("COMN")
     else
        COMN=""
     end if
     rsYY.Close
  elseif  aryparmkey(1)="03" then
     comtype="�t��399"
     sqlYY="select * from RTsparqadslCMTY LEFT OUTER JOIN RTCOUNTY ON RTsparqadslCMTY.CUTID=RTCOUNTY.CUTID where cutyid=" & ARYPARMKEY(0)
     rsYY.Open sqlYY,connYY
     if not rsYY.EOF then
        COMN=rsYY("COMN")
     else
        COMN=""
     end if
     rsYY.Close
  end if
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" HBCmtyarrangeSNDWORKLOG.ComQ1=" & aryparmkey(0) & " and HBCmtyarrangeSNDWORKLOG.COMTYPE=" & aryparmkey(1) & " and HBCmtyarrangeSNDWORKLOG.prtno='" & aryparmkey(2) & "' "
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",�������O�J" & COMtype & ",��u���u�渹�J" & aryparmkey(2)
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
            DAreaID="='A1'"
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
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT HBCmtyarrangeSNDWORKLOG.COMQ1,HBCmtyarrangeSNDWORKLOG.COMTYPE, HBCmtyarrangeSNDWORKLOG.PRTNO, " _
           &"HBCmtyarrangeSNDWORKLOG.ENTRYNO, HBCmtyarrangeSNDWORKLOG.PRTNO AS Expr1, HBCmtyarrangeSNDWORKLOG.ENTRYNO AS Expr2, " _
           &"HBCmtyarrangeSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, HBCmtyarrangeSNDWORKLOG.SNDDAT, " _
           &"HBCmtyarrangeSNDWORKLOG.DROPDAT, RTObj_1.CUSNC AS Expr3,HBCmtyarrangeSNDWORKLOG.closeDAT, RTObj_2.CUSNC AS Expr4 " _
           &"FROM RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID RIGHT OUTER JOIN " _
           &"HBCmtyarrangeSNDWORKLOG INNER JOIN RTCode ON HBCmtyarrangeSNDWORKLOG.CHGCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON RTEmployee_2.EMPLY = HBCmtyarrangeSNDWORKLOG.CLOSEUSR LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
           &"HBCmtyarrangeSNDWORKLOG.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCmtyarrangeSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    Else
         sqlList="SELECT HBCmtyarrangeSNDWORKLOG.COMQ1,HBCmtyarrangeSNDWORKLOG.COMTYPE, HBCmtyarrangeSNDWORKLOG.PRTNO, " _
           &"HBCmtyarrangeSNDWORKLOG.ENTRYNO, HBCmtyarrangeSNDWORKLOG.PRTNO AS Expr1, HBCmtyarrangeSNDWORKLOG.ENTRYNO AS Expr2, " _
           &"HBCmtyarrangeSNDWORKLOG.CHGDAT, RTCode.CODENC, RTObj.CUSNC, HBCmtyarrangeSNDWORKLOG.SNDDAT, " _
           &"HBCmtyarrangeSNDWORKLOG.DROPDAT, RTObj_1.CUSNC AS Expr3,HBCmtyarrangeSNDWORKLOG.closeDAT, RTObj_2.CUSNC AS Expr4 " _
           &"FROM RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = RTObj_2.CUSID RIGHT OUTER JOIN " _
           &"HBCmtyarrangeSNDWORKLOG INNER JOIN RTCode ON HBCmtyarrangeSNDWORKLOG.CHGCODE = RTCode.CODE AND " _
           &"RTCode.KIND = 'G2' ON RTEmployee_2.EMPLY = HBCmtyarrangeSNDWORKLOG.CLOSEUSR LEFT OUTER JOIN " _
           &"RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = RTObj_1.CUSID ON " _
           &"HBCmtyarrangeSNDWORKLOG.DROPUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON HBCmtyarrangeSNDWORKLOG.CHGUSR = RTEmployee.EMPLY " _
           &"where " & searchqry
    End If  
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>