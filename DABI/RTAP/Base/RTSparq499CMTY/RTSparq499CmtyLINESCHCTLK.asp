<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�t��499�޲z�t��"
  title="�t��499�D�u���u�@�~"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�]�Ƭd��;�Τ�d��;�إ߬��u��"
  functionOptProgram="RTSparq499CmtyHARDWAREK2.asp;RTSparq499CustK.asp;RTSparq499CmtylineSNDWORKk.asp"
  functionOptPrompt="N;N;N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;���ϦW��;�D�u;�u��IP;�����q��;�p�渹�X;none;�i�ظm;�ӽФ�;���u�渹;���q��;none;none;none"
  sqlDelete="SELECT RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(convert(char(6),RTSparq499Cmtyline.COMQ1)) +'-'+ rtrim(convert(char(6),RTSparq499Cmtyline.lineQ1))  as comqline, " _
           &"RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno, " _
           &"RTSparq499CmtyLINE.ADSLopenDAT, " _
           &"SUM(CASE WHEN RTSparq499Cust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN RTSparq499Cust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN  " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINE ON RTSalesGroup.AREAID = RTSparq499CmtyLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTSparq499CmtyLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTSparq499CmtyLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTSparq499CmtyLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTSparq499Cust ON RTSparq499CmtyLINE.COMQ1 = RTSparq499Cust.COMQ1 AND " _
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499CmtyLINESNDWORK.LINEQ1 AND " _           
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499Cust.LINEQ1  inner join RTSparq499Cmtyh on RTSparq499Cmtyline.comq1=RTSparq499Cmtyh.comq1 " _
           &"WHERE RTSparq499CmtyLINE.COMQ1= 0 " _                
           &"GROUP BY RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(convert(varchar(10),RTSparq499Cmtyline.COMQ1)) +'-'+ rtrim(convert(varchar(10),RTSparq499Cmtyline.lineQ1)), " _
           &"RTSalesGroup.GROUPNC, RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno,  " _
           &"RTSparq499CmtyLINE.ADSLopenDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END " 

  dataTable="RTSparq499Cmtyline"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg="RTSparq499CmtylineD.asp"
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=true
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=25
  searchProg="RTSparq499CmtyLINESCHCTLS.ASP"
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
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" RTSparq499Cmtyline.LINEIPSTR1 <> '' and RTSparq499Cmtyline.adslopendat is null  "
     searchShow="�w���X�u���ӽ�(��IP)�A�B�u���|���}�q���D�u�M�� "
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
         case "C"
            DAreaID="='A2'"         
         case "P"
            DAreaID="='A1'"                        
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
         sqlList="SELECT RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(convert(varchar(10),RTSparq499Cmtyline.COMQ1)) +'-'+ rtrim(convert(varchar(10),RTSparq499Cmtyline.lineQ1))  as comqline, " _
           &"RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno, " _
           &"RTSparq499CmtyLINE.ADSLopenDAT, " _
           &"SUM(CASE WHEN RTSparq499Cust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN RTSparq499Cust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINE ON RTSalesGroup.AREAID = RTSparq499CmtyLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTSparq499CmtyLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTSparq499CmtyLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTSparq499CmtyLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTSparq499Cust ON RTSparq499CmtyLINE.COMQ1 = RTSparq499Cust.COMQ1 AND " _
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499Cust.LINEQ1  inner join RTSparq499Cmtyh on RTSparq499Cmtyline.comq1=RTSparq499Cmtyh.comq1 " _
           &"LEFT OUTER JOIN RTSparq499CmtyLINESNDWORK ON RTSparq499CmtyLINE.COMQ1 = RTSparq499CmtyLINESNDWORK.COMQ1 AND " _
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499CmtyLINESNDWORK.LINEQ1 AND " _           
           &"RTSparq499CmtyLINESNDWORK.DROPDAT IS NULL  AND RTSparq499CmtyLINESNDWORK.UNCLOSEDAT IS NULL " _
           &"WHERE RTSparq499CmtyLINE.COMQ1<> 0 AND " & SEARCHQRY & " " _
           &"GROUP BY RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(convert(varchar(10),RTSparq499Cmtyline.COMQ1)) +'-'+ rtrim(convert(varchar(10),RTSparq499Cmtyline.lineQ1)), " _
           &"RTSalesGroup.GROUPNC, RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno, " _
           &"RTSparq499CmtyLINE.ADSLopenDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END "
                       
    Else
         sqlList="SELECT RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(ltrim(convert(varchar(10),RTSparq499Cmtyline.COMQ1))) +'-'+ rtrim(ltrim(convert(varchar(10),RTSparq499Cmtyline.lineQ1)))  as comqline, " _
           &"RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno, " _
           &"RTSparq499CmtyLINE.ADSLopenDAT, " _
           &"SUM(CASE WHEN RTSparq499Cust.cusid IS NOT NULL THEN 1 ELSE 0 END) AS CUSCNT, " _
           &"SUM(CASE WHEN RTSparq499Cust.transdat IS NOT NULL THEN 1 ELSE 0 END) AS APPLYCNT, " _
           &"case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END AS DEVPMAN " _
           &"FROM RTSalesGroup RIGHT OUTER JOIN " _
           &"RTSparq499CmtyLINE ON RTSalesGroup.AREAID = RTSparq499CmtyLINE.AREAID AND " _
           &"RTSalesGroup.GROUPID = RTSparq499CmtyLINE.GROUPID AND " _
           &"RTSalesGroup.EDATE IS NULL LEFT OUTER JOIN " _
           &"RTCounty ON RTSparq499CmtyLINE.CUTID = RTCounty.CUTID LEFT OUTER JOIN " _
           &"RTObj ON RTSparq499CmtyLINE.CONSIGNEE = RTObj.CUSID LEFT OUTER JOIN " _
           &"RTSparq499Cust ON RTSparq499CmtyLINE.COMQ1 = RTSparq499Cust.COMQ1 AND " _
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499Cust.LINEQ1  inner join RTSparq499Cmtyh on RTSparq499Cmtyline.comq1=RTSparq499Cmtyh.comq1 " _
           &"LEFT OUTER JOIN RTSparq499CmtyLINESNDWORK ON RTSparq499CmtyLINE.COMQ1 = RTSparq499CmtyLINESNDWORK.COMQ1 AND " _
           &"RTSparq499CmtyLINE.LINEQ1 = RTSparq499CmtyLINESNDWORK.LINEQ1 AND " _
           &"RTSparq499CmtyLINESNDWORK.DROPDAT IS NULL AND RTSparq499CmtyLINESNDWORK.UNCLOSEDAT IS NULL " _
           &"WHERE RTSparq499CmtyLINE.COMQ1<> 0 AND " & SEARCHQRY & " " _
           &"GROUP BY RTSparq499CmtyLINE.COMQ1, RTSparq499CmtyLINE.LINEQ1,RTSparq499CmtyH.COMN, rtrim(ltrim(convert(varchar(10),RTSparq499Cmtyline.COMQ1))) +'-'+ rtrim(ltrim(convert(varchar(10),RTSparq499Cmtyline.lineQ1))), " _
           &"RTSalesGroup.GROUPNC, RTSparq499cmtyLINE.LINEIPSTR1+'.'+RTSparq499cmtyLINE.LINEIPSTR2+'.'+RTSparq499cmtyLINE.LINEIPSTR3+'.'+RTSparq499cmtyLINE.LINEIPSTR4+'-'+RTSparq499cmtyLINE.LINEIPEND,RTSparq499CmtyLINE.LINETEL,RTSparq499CmtyLINE.CHTWORKINGNO, " _
           &"RTSparq499CmtyLINE.RCVDAT," _
           &"RTSparq499CmtyLINE.AGREE, " _
           &"RTSparq499CmtyLINE.ADSLAPPLYDAT,RTSparq499CmtyLINESNDWORK.prtno, " _
           &"RTSparq499CmtyLINE.ADSLopenDAT,case when RTObj.SHORTNC is NULL then RTSalesGroup.GROUPNC ELSE RTObj.SHORTNC END " 
                      
    End If  
  'end if
  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>