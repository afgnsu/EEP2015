<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�F��AVS�޲z�t��"
  title="AVS�D�u�ӽаO����Ƭd��"
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
  formatName="none;none;none;�D�u;����;���ʺ���;���ʤ�;���ʭ�;IP;�p��;�����q��;�C�L�渹;��ĳ�e��覡;���s�e���]"
  sqlDelete="SELECT RTEBTCMTYLINEAPPLYLOG.COMQ1, RTEBTCMTYLINEAPPLYLOG.LINEQ1, " _
           &"RTEBTCMTYLINEAPPLYLOG.ENTRYNO,rtrim(convert(char(6),RTEBTcmtylineapplylog.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtylineapplylog.lineQ1))  as comqline,RTEBTCMTYLINEAPPLYLOG.ENTRYNO, RTEBTCMTYLINEAPPLYLOG.CHGDAT, " _
           &"RTObj.CUSNC, RTEBTCMTYLINEAPPLYLOG.IP, RTEBTCMTYLINEAPPLYLOG.APPLYNO, RTEBTCMTYLINEAPPLYLOG.LINETEL,RTEBTCMTYLINEAPPLYLOG.APPLYPRTNO, RTCode.CODENC, " _
           &"RTEBTCMTYLINEAPPLYLOG.REPEATREASON fROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINEAPPLYLOG ON RTCode.CODE = RTEBTCMTYLINEAPPLYLOG.SUGGESTTYPE AND " _
           &"RTCode.KIND = 'H1' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCMTYLINEAPPLYLOG.CHGUSR = RTEmployee.EMPLY where RTEBTCMTYLINEAPPLYLOG.COMQ1=0" 

  dataTable="rtebtcmtylineapplylog"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTEBTCMTYLINELOGD.ASP"
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
  sqlYY="select * from RTEBTCMTYH LEFT OUTER JOIN RTCOUNTY ON RTEBTCMTYH.CUTID=RTCOUNTY.CUTID where COMQ1=" & ARYPARMKEY(0)
  connYY.Open dsnYY
  rsYY.Open sqlYY,connYY
  if not rsYY.EOF then
     COMN=rsYY("COMN")
     COMADDR=RSYY("CUTNC") & RSYY("TOWNSHIP") & RSYY("RADDR")
  else
     COMN=""
     COMADDR=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTEBTCmtylineapplylog.ComQ1=" & aryparmkey(0) & " and lineq1=" & aryparmkey(1)
     searchShow="���ϧǸ��J"& aryparmkey(0) & ",���ϦW�١J" & COMN & ",���Ϧa�}�J" & COMADDR
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
  'if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T93168" OR _
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076"then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 then DAreaID="<>'*'"
  
    If searchShow="����" Then
         sqlList="SELECT RTEBTCMTYLINEAPPLYLOG.COMQ1, RTEBTCMTYLINEAPPLYLOG.LINEQ1, " _
           &"RTEBTCMTYLINEAPPLYLOG.ENTRYNO,rtrim(convert(char(6),RTEBTcmtylineapplylog.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtylineapplylog.lineQ1))  as comqline,RTEBTCMTYLINEAPPLYLOG.ENTRYNO, RTCODE_1.CODENC,RTEBTCMTYLINEAPPLYLOG.CHGDAT, " _
           &"RTObj.CUSNC, RTEBTCMTYLINEAPPLYLOG.LINEIP, RTEBTCMTYLINEAPPLYLOG.APPLYNO, RTEBTCMTYLINEAPPLYLOG.LINETEL, RTEBTCMTYLINEAPPLYLOG.APPLYPRTNO, RTCode.CODENC, " _
           &"RTEBTCMTYLINEAPPLYLOG.REPEATREASON fROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINEAPPLYLOG ON RTCode.CODE = RTEBTCMTYLINEAPPLYLOG.SUGGESTTYPE AND " _
           &"RTCode.KIND = 'H1' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCMTYLINEAPPLYLOG.CHGUSR = RTEmployee.EMPLY  LEFT OUTER JOIN " _
           &"RTCode RTCODE_1 ON RTEBTCMTYLINEAPPLYLOG.CHGCODE = RTCODE_1.CODE AND " _
           &"RTCODE_1.KIND = 'H4' where " & searchqry & " order by RTEBTCMTYLINEAPPLYLOG.COMQ1, RTEBTCMTYLINEAPPLYLOG.LINEQ1,RTEBTCMTYLINEAPPLYLOG.ENTRYNO "

    Else
         sqlList="SELECT RTEBTCMTYLINEAPPLYLOG.COMQ1, RTEBTCMTYLINEAPPLYLOG.LINEQ1, " _
           &"RTEBTCMTYLINEAPPLYLOG.ENTRYNO,rtrim(convert(char(6),RTEBTcmtylineapplylog.COMQ1)) +'-'+ rtrim(convert(char(6),RTEBTcmtylineapplylog.lineQ1))  as comqline,RTEBTCMTYLINEAPPLYLOG.ENTRYNO, RTCODE_1.CODENC, RTEBTCMTYLINEAPPLYLOG.CHGDAT, " _
           &"RTObj.CUSNC, RTEBTCMTYLINEAPPLYLOG.LINEIP, RTEBTCMTYLINEAPPLYLOG.APPLYNO, RTEBTCMTYLINEAPPLYLOG.LINETEL, RTEBTCMTYLINEAPPLYLOG.APPLYPRTNO, RTCode.CODENC, " _
           &"RTEBTCMTYLINEAPPLYLOG.REPEATREASON fROM RTCode RIGHT OUTER JOIN " _
           &"RTEBTCMTYLINEAPPLYLOG ON RTCode.CODE = RTEBTCMTYLINEAPPLYLOG.SUGGESTTYPE AND " _
           &"RTCode.KIND = 'H1' LEFT OUTER JOIN RTObj INNER JOIN " _
           &"RTEmployee ON RTObj.CUSID = RTEmployee.CUSID ON " _
           &"RTEBTCMTYLINEAPPLYLOG.CHGUSR = RTEmployee.EMPLY  LEFT OUTER JOIN " _
           &"RTCode RTCODE_1 ON RTEBTCMTYLINEAPPLYLOG.CHGCODE = RTCODE_1.CODE AND " _
           &"RTCODE_1.KIND = 'H4' where " & searchqry & " order by RTEBTCMTYLINEAPPLYLOG.COMQ1, RTEBTCMTYLINEAPPLYLOG.LINEQ1,RTEBTCMTYLINEAPPLYLOG.ENTRYNO "

    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>