<!-- #include virtual="/WebUtilityV4/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���Ϻ����]�ƺ޲z"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable=v(0) & ";" & v(1) & ";" & v(2) & ";Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName=" �@  �o ;�@�o����"
  functionOptProgram="RTEquipmentdrop.ASP;RTEquipmentdropC.ASP"
   functionOptPrompt="Y;Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;none;none;�Ǹ�;���~���O;���~�s��;�ƶq;���;�겣�s��;�@�o��"
 ' sqlDelete="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.shortnc, RTCust.CUSTYPE, " _
 '          &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME," _
 '          &"RTCust.OFFICE + ' ' + RTCust.EXTENSION  AS Office,RTCust.SNDINFODAT ,rtcust.reqdat " _
 '          &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
 '          &"WHERE RTCust.COMQ1=0 " _
 '          &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
   sqlDelete="SELECT HBCmtyEquipment.COMQ1,HBCmtyEquipment.lineQ1, HBCmtyEquipment.CONNECTTYPE, HBCmtyEquipment.SEQ, HBCmtyEquipment.PRODNO, "  _
            &"HBCmtyEquipment.ITEMNO, HBCmtyEquipment.QTY, RTCode.CODENC, HBCmtyEquipment.ASSETNO, HBCmtyEquipment.cancelDAT " _
            &"from HBCmtyEquipment INNER JOIN RTCode ON HBCmtyEquipment.UNIT = RTCode.CODE AND " _
            &"RTCode.KIND = 'B5' LEFT OUTER JOIN RTProdD1 ON HBCmtyEquipment.PRODNO = RTProdD1.PRODNO AND " _
            &"HBCmtyEquipment.ITEMNO = RTProdD1.ITEMNO where HBCmtyEquipment.COMQ1 <> 0 " 
  dataTable="HBcmtyEquipment"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=4
  dataProg="RTCMTYEQUIPMENTD.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=false
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTCMTYEQUIPMENTs.asp"
  searchFirst=false
  If searchQry="" Then
     searchQry=" HBCmtyEquipment.COMQ1= " & aryparmkey(0) 
     searchShow="" 
  ELSE
     searchFirst=False
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
            DareaID="='*'"
  end select
  '�����D�ޥiŪ���������
  if UCASE(emply)="T89001" or Ucase(emply)="T89002" or  Ucase(emply)="T89020" or Ucase(emply)="T89018" or Ucase(emply)="T90076" OR _
     Ucase(emply)="T89003" or Ucase(emply)="T89005" or Ucase(emply)="T89025" or Ucase(emply)="T89008" then
     DAreaID="<>'*'"
  end if
  '��T���޲z���iŪ���������
  if userlevel=31 then DAreaID="<>'*'"  
  '���T&�F�T599
  if aryparmkey(2)="1" or aryparmkey(2)="4" then
  sqllist="SELECT         HBCmtyEquipment.COMQ1,HBCmtyEquipment.lineQ1, HBCmtyEquipment.CONNECTTYPE, " _
         &"               HBCmtyEquipment.SEQ, HBCmtyEquipment.PRODNO, "  _
         &"               HBCmtyEquipment.ITEMNO, HBCmtyEquipment.QTY, RTCode.CODENC, " _
         &"               HBCmtyEquipment.ASSETNO, HBCmtyEquipment.canceldat " _
         &"FROM           HBCmtyEquipment INNER JOIN " _
         &"               RTCode ON HBCmtyEquipment.UNIT = RTCode.CODE AND " _
         &"               RTCode.KIND = 'B5' INNER JOIN " _
         &"               RTCmty ON HBCmtyEquipment.COMQ1 = RTCmty.COMQ1 LEFT OUTER JOIN " _
         &"               RTProdD1 ON HBCmtyEquipment.PRODNO = RTProdD1.PRODNO AND " _
         &"               HBCmtyEquipment.ITEMNO = RTProdD1.ITEMNO where " & searchqry
   '����399
   elseif  aryparmkey(2)="2" then
   sqllist="SELECT        HBCmtyEquipment.COMQ1,HBCmtyEquipment.lineQ1, HBCmtyEquipment.CONNECTTYPE, " _
         &"               HBCmtyEquipment.SEQ, HBCmtyEquipment.PRODNO, "  _
         &"               HBCmtyEquipment.ITEMNO, HBCmtyEquipment.QTY, RTCode.CODENC, " _
         &"               HBCmtyEquipment.ASSETNO, HBCmtyEquipment.canceldat " _
         &"FROM           HBCmtyEquipment INNER JOIN " _
         &"               RTCode ON HBCmtyEquipment.UNIT = RTCode.CODE AND " _
         &"               RTCode.KIND = 'B5' INNER JOIN " _
         &"               RTcustadslCmty ON HBCmtyEquipment.COMQ1 = RTcustadslCmty.cutyid LEFT OUTER JOIN " _
         &"               RTProdD1 ON HBCmtyEquipment.PRODNO = RTProdD1.PRODNO AND " _
         &"               HBCmtyEquipment.ITEMNO = RTProdD1.ITEMNO where " & searchqry   
   '�t��399
   elseif  aryparmkey(2)="3" then
   sqllist="SELECT         HBCmtyEquipment.COMQ1,HBCmtyEquipment.lineQ1, HBCmtyEquipment.CONNECTTYPE, " _
         &"               HBCmtyEquipment.SEQ, HBCmtyEquipment.PRODNO, "  _
         &"               HBCmtyEquipment.ITEMNO, HBCmtyEquipment.QTY, RTCode.CODENC, " _
         &"               HBCmtyEquipment.ASSETNO, HBCmtyEquipment.canceldat " _
         &"FROM           HBCmtyEquipment INNER JOIN " _
         &"               RTCode ON HBCmtyEquipment.UNIT = RTCode.CODE AND " _
         &"               RTCode.KIND = 'B5' INNER JOIN " _
         &"               RTsparqadslCmty ON HBCmtyEquipment.COMQ1 = RTsparqadslCmty.cutyid LEFT OUTER JOIN " _
         &"               RTProdD1 ON HBCmtyEquipment.PRODNO = RTProdD1.PRODNO AND " _
         &"               HBCmtyEquipment.ITEMNO = RTProdD1.ITEMNO where " & searchqry      
   '�F��499
   elseif  aryparmkey(2)="5" then
   end if 
       
  'Response.Write "sql=" & SQLLIST
End Sub
%>
