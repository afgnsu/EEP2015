<!-- #include virtual="/WebUtilityV4EBT/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="�M�ץΤ�޲z�t��"
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
  formatName="none;�b�ڽs��;����;�Ȥ�;AR/AP;����;���R<br>���B;�w�R<br>���B;���R<br>���B;�R�b��;�R�b��;�R�߶��@;�R�߶��G;none;���ͤ�;�@�o��;�@�o��;�@�o��];�h����"
  sqlDelete="SELECT  RTPrjCustAR.CUSID, RTPrjCustAR.BATCHNO, RTPrjCmtyH.COMN,RTPrjCust.CUSNC," _
                &" RTCode.CODENC, RTPrjCustAR.PERIOD,RTPrjCustAR.AMT,RTPrjCustAR.REALAMT," _
                &"RTPrjCustAR.AMT - RTPrjCustAR.REALAMT AS DIFFAMT, RTPrjCustAR.MDAT, RTObj_1.CUSNC AS MUSR, " _
                &"RTPrjCustAR.COD1, RTPrjCustAR.COD2,RTPrjCustAR.COD3, RTPrjCustAR.CDAT, " _
                &"RTPrjCustAR.CANCELDAT, RTObj_2.CUSNC AS CANCELUSR, " _
                &"RTPrjCustAR.CANCELMEMO, RTPrjCust.Dropdat " _
                &"FROM    RTPrjCmtyH RIGHT OUTER JOIN RTPrjCust ON RTPrjCmtyH.COMQ1 = RTPrjCust.COMQ1 " _
                &"RIGHT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = " _
                &"RTObj_2.CUSID RIGHT OUTER JOIN RTPrjCustAR ON RTEmployee_2.EMPLY = RTPrjCustAR.CANCELUSR " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                &"RTObj_1.CUSID ON RTPrjCustAR.MUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTCode ON RTPrjCustAR.ARTYPE = RTCode.CODE AND RTCode.KIND = 'N2' ON RTPrjCust.CUSID = " _
                &"RTPrjCustAR.CUSID " _
                &"WHERE RTPrjCustAR.cusid='' "
  dataTable="RTPrjCUSTLOG"
  userDefineDelete="Yes"
  numberOfKey=2
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=350,height=250,scrollbars=yes"
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
  searchProg="RTPrjcustARS1.ASP"
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
     searchQry="  (RTPrjCustAR.AMT <> RTPrjCustAR.REALAMT) and RTPrjCustAR.canceldat is null "
     searchShow="�������R�P�b��"
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
  
         sqlList="SELECT  RTPrjCustAR.CUSID, RTPrjCustAR.BATCHNO, RTPrjCmtyH.COMN,RTPrjCust.CUSNC," _
                &"RTCode.CODENC, RTPrjCustAR.PERIOD,RTPrjCustAR.AMT,RTPrjCustAR.REALAMT, " _
                &"RTPrjCustAR.AMT - RTPrjCustAR.REALAMT AS DIFFAMT, RTPrjCustAR.MDAT, RTObj_1.CUSNC AS MUSR," _
                &"RTPrjCustAR.COD1, " _
                &"case when RTPrjCustAR.COD2 like '�W��%' then '<font color =blue>'+RTPrjCustAR.COD2+'</font>' " _
				&"		when RTPrjCustAR.COD2 like '�h��%' then '<font color =red>'+RTPrjCustAR.COD2+'</font>' " _
				&"		when RTPrjCustAR.COD2 like '�H�Υd%' then '<font color =green>'+RTPrjCustAR.COD2+'</font>' " _
				&"else RTPrjCustAR.COD2 end, " _
				&"RTPrjCustAR.COD3, RTPrjCustAR.CDAT, " _
                &"RTPrjCustAR.CANCELDAT, RTObj_2.CUSNC AS CANCELUSR, RTPrjCustAR.CANCELMEMO, RTPrjCust.Dropdat " _
                &"FROM    RTPrjCmtyH RIGHT OUTER JOIN RTPrjCust ON RTPrjCmtyH.COMQ1 = RTPrjCust.COMQ1 " _
                &"RIGHT OUTER JOIN RTEmployee RTEmployee_2 INNER JOIN RTObj RTObj_2 ON RTEmployee_2.CUSID = " _
                &"RTObj_2.CUSID RIGHT OUTER JOIN RTPrjCustAR ON RTEmployee_2.EMPLY = RTPrjCustAR.CANCELUSR " _
                &"LEFT OUTER JOIN RTEmployee RTEmployee_1 INNER JOIN RTObj RTObj_1 ON RTEmployee_1.CUSID = " _
                &"RTObj_1.CUSID ON RTPrjCustAR.MUSR = RTEmployee_1.EMPLY LEFT OUTER JOIN " _
                &"RTCode ON RTPrjCustAR.ARTYPE = RTCode.CODE AND RTCode.KIND = 'N2' ON RTPrjCust.CUSID = " _
                &"RTPrjCustAR.CUSID " _
                &"WHERE " & searchqry & " " _ 
                &"ORDER BY  RTPrjCustAR.CDAT desc" 

  'Response.Write "SQL=" & SQLlist
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>