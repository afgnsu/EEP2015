<%@ Transaction = required %>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->

<%
Dim debug36
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="�ܮw�򥻸�ƺ��@"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=V(0) & ";" & V(2) & ";Y;Y;Y;Y"
 ' buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="���~�s�q;�i����u"
  functionOptProgram="hbwarehouseprodK.asp;hbwarehousesalesk.asp"
  functionOptPrompt="N;N"  
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  debug36=false
  formatName="�w�O;�ܮw�W��;�a�};���@�H��"
  sqlDelete="SELECT hbwarehouse.warehouse,hbwarehouse.warename,rtcounty.cutnc+ " _
          &"hbwarehouse.township+hbwarehouse.address,rtobj.cusnc " _
          &"from rtobj inner join rtemployee on rtobj.cusid=rtemployee.cusid right outer join " _
          &"hbwarehouse inner join rtcounty on hbwarehouse.cutid=rtcounty.cutid on " _
          &"rtemployee.emply=hbwarehouse.maintainusr " _
          &"where hbwarehouse.warehouse='*' order by hbwarehouse.warehouse "

  dataTable="hbwarehouse"
  userDefineDelete="Yes"  
  extTable=""
  numberOfKey=1
  dataProg="HBwarehouseD.asp"
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
  keyListPageSize=20
  searchProg="hbwarehouseS.asp"
' Open search program when first entry this keylist
'  If searchQry="" Then
'     searchFirst=True
'     searchQry=" RTCmty.ComQ1=0 "
'     searchShow=""
'  Else
'     searchFirst=False
'  End If
' When first time enter this keylist default query string to RTcmty.ComQ1 <> 0
  searchFirst=false
  If searchQry="" Then
     searchQry=" HBWAREHOUSE.WAREHOUSE <>'*' "
     searchShow="����"
  End If
  sqlList="SELECT hbwarehouse.warehouse,hbwarehouse.warename,rtcounty.cutnc+ " _
          &"hbwarehouse.township+hbwarehouse.address,rtobj.cusnc " _
          &"from rtobj inner join rtemployee on rtobj.cusid=rtemployee.cusid right outer join " _
          &"hbwarehouse inner join rtcounty on hbwarehouse.cutid=rtcounty.cutid on " _
          &"rtemployee.emply=hbwarehouse.maintainusr " _
          &"where hbwarehouse.warehouse<>'*' and " & searchqry & " order by hbwarehouse.warehouse "
'Response.Write "SQL=" &sqllist           
End Sub
Sub SrRunUserDefineDelete()

End Sub
%>