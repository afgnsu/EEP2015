<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="����RT�o�]�@�~(�ȪA��)"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"  
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�Ȥ����"
  functionOptProgram="RTSendWorkk.asp"
  functionOptPrompt="N"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�Ǹ�;���ϦW��;T1�}�q��;����"
  sqlDelete="SELECT b.COMQ1,b.comq2, b.COMN, b.t1apply, COUNT(a.cusid) AS custcnt " _
           &"FROM RTCust a, RTCmty b " _
           &"WHERE a.COMQ1 = b.COMQ1 AND b.t1apply IS NOT NULL  AND " _
           &"a.sndinfodat IS NOT NULL and a.settype not in ('2','3') " _
           &"and RTCmty.COMQ1=0 " _          
           &"GROUP BY b.comq1,b.comq2, b.comn, b.t1apply " 
  
  dataTable=""
  userDefineDelete="Yes"
  numberOfKey=1
  dataProg="None"
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
  colSplit=2
  keyListPageSize=40
  searchProg="RTSENDWORKS1.ASP"
  searchFirst=False
  If searchQry="" Then
     searchQry=" and b.ComQ1<>0 AND A.SNDINFODAT IS NOT NULL AND A.REQDAT IS NULL and a.dropdat is null "
     searchShow="�o�]�O�G���o�]  �M�P�O�G���M�P"
  End If
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  Emply=FrGetUserEmply(Request.ServerVariables("LOGON_USER"))  
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
            DareaID=""
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or Ucase(emply)="T90076" or _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"  
  
  If searchShow="����" Then
  sqlList="SELECT b.COMQ1,b.comq2, b.COMN, b.t1apply, COUNT(a.cusid) AS custcnt " _
           &"FROM RTCust a, RTCmty b, RTAREACTY C, RTAREA D " _
           &"WHERE d.areaid " & DareaId & " and a.COMQ1 = b.COMQ1 AND b.t1apply IS NOT NULL AND a.sndinfodat IS NOT NULL " _
           &"AND a.settype Not IN ('2','3') AND b.ComQ1 <> 0 AND A.SNDINFODAT IS NOT NULL " _
           &"AND  b.cutid = c.cutid AND  " _
           &"c.areaid = d.areaid AND d.areatype = '1' " _
           &" " & searchqry  _           
           &" GROUP BY b.comq1,b.comq2, b.comn, b.t1apply "
  Else
  sqlList="SELECT b.COMQ1,b.comq2, b.COMN, b.t1apply, COUNT(a.cusid) AS custcnt " _
           &"FROM RTCust a, RTCmty b, RTAREACTY C, RTAREA D " _
           &"WHERE d.areaid " & Dareaid & " and a.COMQ1 = b.COMQ1 AND b.t1apply IS NOT NULL AND a.sndinfodat IS NOT NULL " _
           &"AND a.settype Not IN ('2','3') AND b.ComQ1 <> 0 AND A.SNDINFODAT IS NOT NULL " _
           &"AND  b.cutid = c.cutid AND  " _
           &"c.areaid = d.areaid AND d.areatype = '1' " _
           &" " & searchqry  _           
           &" GROUP BY b.comq1,b.comq2, b.comn, b.t1apply " 
  End if
  searchqry=replace(searchqry,"b.ComQ1","a.comq1")
 ' searchqry=replace(searchqry,"c.CutID","e.cutid")  
  searchqryDTL=replace(searchqry,"c.CutID","e.cutid")  
  Session("DSQL")=" a.sndinfodat IS NOT NULL and a.settype not in ('2','3')  " & searchqryDTL         
  'Response.Write "SQL=" & SQLlist & "<BR>"
 ' Response.Write "DSQL=" & SESSION("DSQL")& "<BR>"
End Sub
%>