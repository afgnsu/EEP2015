<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�t��499�Τ��ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�ȶD�B�z"
  functionOptProgram="RTFaqK.asp"
  functionOptPrompt="N"
  'functionoptopen="1;1;1;1"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�D�u;�D�u�W��;�Τ�;none;�Τ�IP;�˾��a�};�s���q��;ú�ڤ覡;�ӽФ�;���u��;������;���ɤ�;�h����;�@�o��;���J;���X"
  sqlDelete="SELECT RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,RTSparq499Cust.CUSID,rtrim(ltrim(convert(char(6),RTSparq499Cust.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTSparq499Cust.lineQ1))) as comqline,RTSparq499Cmtyh.comn,LEFT(RTSparq499Cust.CUSnc,4),RTCODE_3.CODENC,  " _
           &"RTSparq499Cust.CUSTIP1+'.'+RTSparq499Cust.CUSTIP2+'.'+RTSparq499Cust.CUSTIP3+'.'+RTSparq499Cust.CUSTIP4,(RTCounty.CUTNC + RTSparq499Cust.TOWNSHIP2 + RTSparq499Cust.RADDR2 ) AS raddr, " _
           &"RTSparq499Cust.CONTACTTEL+','+RTSparq499Cust.MOBILE, RTCode_2.CODENC, " _
           &"RTSparq499Cust.APPLYDAT, " _
           &"RTSparq499Cust.FINISHDAT, RTSparq499Cust.DOCKETDAT, RTSparq499Cust.TRANSDAT, RTSparq499Cust.DROPDAT, RTSparq499Cust.CANCELDAT, " _
           &"case when RTSparq499Cust.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTSparq499Cust.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOlineQ1))) else '' end " _
           &"FROM RTSparq499Cust LEFT OUTER JOIN RTCode RTCode_2 ON RTSparq499Cust.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'M1' LEFT OUTER JOIN RTCounty ON RTSparq499Cust.CUTID2 = RTCounty.CUTID  inner join RTSparq499Cmtyh on " _
           &"RTSparq499Cust.comq1=RTSparq499Cmtyh.comq1 inner join RTSparq499Cmtyline on RTSparq499Cust.comq1=RTSparq499Cmtyline.comq1 and " _
           &"RTSparq499Cust.lineq1=RTSparq499Cmtyline.lineq1 INNER JOIN RTAREATOWNSHIP ON RTSparq499CmtyLINE.CUTID=RTAREATOWNSHIP.CUTID AND " _
           &"RTSparq499CmtyLINE.TOWNSHIP=RTAREATOWNSHiP.TOWNSHIP " _ 
           &"LEFT OUTER JOIN RTCODE RTCODE_3 ON RTSparq499Cust.CASETYPE = RTCODE_3.CODE AND RTCODE_3.KIND='L9' " _
           &"where " & searchqry & " AND RTAREATOWNSHIP.AREAID " & DAREAID & " " _
           &"GROUP BY  RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,RTSparq499Cust.CUSID,rtrim(ltrim(convert(char(6),RTSparq499Cust.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTSparq499Cust.lineQ1))),RTSparq499Cmtyh.comn,LEFT(RTSparq499Cust.CUSnc,4),RTCODE_3.CODENC,  " _
           &"RTSparq499Cust.CUSTIP1+'.'+RTSparq499Cust.CUSTIP2+'.'+RTSparq499Cust.CUSTIP3+'.'+RTSparq499Cust.CUSTIP4,RTCounty.CUTNC + RTSparq499Cust.TOWNSHIP2 + RTSparq499Cust.RADDR2 , " _
           &"RTSparq499Cust.CONTACTTEL+','+RTSparq499Cust.MOBILE, RTCode_2.CODENC, " _
           &"RTSparq499Cust.APPLYDAT, " _
           &"RTSparq499Cust.FINISHDAT, RTSparq499Cust.DOCKETDAT, RTSparq499Cust.TRANSDAT, RTSparq499Cust.DROPDAT, RTSparq499Cust.CANCELDAT, " _
           &"case when RTSparq499Cust.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTSparq499Cust.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTSparq499Cust.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTSparq499Cust.MOVETOlineQ1))) else '' end " _
           &"ORDER BY RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,LEFT(RTSparq499Cust.CUSnc,4) " 

  dataTable="RTSparq499Cust"
  userDefineDelete="Yes"
  numberOfKey=3
  dataProg="RTSparq499CustD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth="600"
  diaHeight="400"
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
     COMaddr=rsYY("cutnc") & rsyy("township") & RSYY("RADDR")
   else
     COMaddr=""
  end if
  rsYY.Close
  connYY.Close
  set rsYY=nothing
  set connYY=nothing
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSparq499Cust.COMQ1=" & ARYPARMKEY(0) & " AND RTSparq499Cust.LINEQ1=" & ARYPARMKEY(1)
     searchShow="����"
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
  '   Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89076" then
  '   DAreaID="<>'*'"
  'end if
  '��T���޲z���iŪ���������
  'if userlevel=31 then DAreaID="<>'*'"
  
  '�ѩ�����q�h�a�|���ӽШ�u���A�G�ȪA���}��Ҧ��ϰ��v���A�@�����x�_�ȪA�B�z
  if userlevel=31 or userlevel =1  or userlevel =5 or userlevel =9 then DAreaID="<>'*'"
  
         sqlList="SELECT RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,RTSparq499Cust.CUSID,rtrim(ltrim(convert(char(6),RTSparq499Cust.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTSparq499Cust.lineQ1))) as comqline,RTSparq499Cmtyh.comn,LEFT(RTSparq499Cust.CUSnc,4),RTCODE_3.CODENC,  " _
           &"RTSparq499Cust.CUSTIP1+'.'+RTSparq499Cust.CUSTIP2+'.'+RTSparq499Cust.CUSTIP3+'.'+RTSparq499Cust.CUSTIP4,(RTCounty.CUTNC + RTSparq499Cust.TOWNSHIP2 + RTSparq499Cust.RADDR2 ) AS raddr, " _
           &"RTSparq499Cust.CONTACTTEL+','+RTSparq499Cust.MOBILE, RTCode_2.CODENC, " _
           &"RTSparq499Cust.APPLYDAT, " _
           &"RTSparq499Cust.FINISHDAT, RTSparq499Cust.DOCKETDAT, RTSparq499Cust.TRANSDAT, RTSparq499Cust.DROPDAT, RTSparq499Cust.CANCELDAT, " _
           &"case when RTSparq499Cust.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTSparq499Cust.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOlineQ1))) else '' end " _
           &"FROM RTSparq499Cust  LEFT OUTER JOIN RTCode RTCode_2 ON RTSparq499Cust.PAYTYPE = RTCode_2.CODE " _
           &"AND RTCode_2.KIND = 'M1' LEFT OUTER JOIN RTCounty ON RTSparq499Cust.CUTID2 = RTCounty.CUTID  inner join RTSparq499Cmtyh on " _
           &"RTSparq499Cust.comq1=RTSparq499Cmtyh.comq1 inner join RTSparq499Cmtyline on RTSparq499Cust.comq1=RTSparq499Cmtyline.comq1 and " _
           &"RTSparq499Cust.lineq1=RTSparq499Cmtyline.lineq1 INNER JOIN RTAREATOWNSHIP ON RTSparq499CmtyLINE.CUTID=RTAREATOWNSHIP.CUTID AND " _
           &"RTSparq499CmtyLINE.TOWNSHIP=RTAREATOWNSHiP.TOWNSHIP " _ 
           &"LEFT OUTER JOIN RTCODE RTCODE_3 ON RTSparq499Cust.CASETYPE = RTCODE_3.CODE AND RTCODE_3.KIND='L9' " _
           &"where " & searchqry & " AND RTAREATOWNSHIP.AREAID " & DAREAID & " " _
           &"GROUP BY  RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,RTSparq499Cust.CUSID,rtrim(ltrim(convert(char(6),RTSparq499Cust.COMQ1))) +'-'+ rtrim(ltrim(convert(char(6),RTSparq499Cust.lineQ1))),RTSparq499Cmtyh.comn,LEFT(RTSparq499Cust.CUSnc,4),RTCODE_3.CODENC,  " _
           &"RTSparq499Cust.CUSTIP1+'.'+RTSparq499Cust.CUSTIP2+'.'+RTSparq499Cust.CUSTIP3+'.'+RTSparq499Cust.CUSTIP4,RTCounty.CUTNC + RTSparq499Cust.TOWNSHIP2 + RTSparq499Cust.RADDR2 , " _
           &"RTSparq499Cust.CONTACTTEL+','+RTSparq499Cust.MOBILE, RTCode_2.CODENC, " _
           &"RTSparq499Cust.APPLYDAT, " _
           &"RTSparq499Cust.FINISHDAT, RTSparq499Cust.DOCKETDAT, RTSparq499Cust.TRANSDAT, RTSparq499Cust.DROPDAT, RTSparq499Cust.CANCELDAT, " _
           &"case when RTSparq499Cust.MOVEFROMCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVEFROMCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTSparq499Cust.MOVEFROMlineQ1))) else '' end, " _
           &"case when RTSparq499Cust.MOVETOCOMQ1 > 0 then rtrim(ltrim(CONVERT(char(6), RTSparq499Cust.MOVETOCOMQ1))) + '-' + rtrim(ltrim(CONVERT(char(6),RTSparq499Cust.MOVETOlineQ1))) else '' end " _
           &"ORDER BY RTSparq499Cust.COMQ1, RTSparq499Cust.LINEQ1,LEFT(RTSparq499Cust.CUSnc,4) " 
  'end if
 ' Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>