<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���T�Τ�^�Q�a�������(�ĤG��--�ӽ�ADSL)�����Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�@�o;�@�o�^��;�p���T�{"
  functionOptProgram="HB2002ACT21DROP.ASP;HB2002ACT21DROPback.ASP;HB2002ACT21CFM.ASP"
  functionOptPrompt="Y"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;�Τ�W��;���q�q��;����;��a�q��;��ʹq��;�����m��;�ӽФ�;�t�v;IP;�T�{��;�@�o��"
 ' sqlDelete="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.shortnc, RTCust.CUSTYPE, " _
 '          &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME," _
 '          &"RTCust.OFFICE + ' ' + RTCust.EXTENSION  AS Office,RTCust.SNDINFODAT ,rtcust.reqdat " _
 '          &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
 '          &"WHERE RTCust.COMQ1=0 " _
 '          &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
   sqlDelete="SELECT HB2002ACT21.SERNO AS Expr1, HB2002ACT21.NAME AS Expr2, " _
            &"HB2002ACT21.TELC AS Expr3, HB2002ACT21.EXT AS Expr4, " _
            &"HB2002ACT21.TELH AS Expr5, HB2002ACT21.CONMOBILE AS Expr6, " _
            &"RTCounty.CUTNC + HB2002ACT21.TOWNSHIP + HB2002ACT21.RADDR AS Expr8, " _
            &"CONVERT(varchar(10), HB2002ACT21.EDAT, 111) AS EDAT, RTCode.CODENC AS Expr10, " _
            &"RTCode_1.CODENC AS Expr11, HB2002ACT21.cfmDAT AS Expr12, " _
            &"HB2002ACT21.DROPDAT AS Expr13 " _
            &"FROM HB2002ACT21 INNER JOIN " _
            &"RTCode ON HB2002ACT21.CASETYPE = RTCode.CODE AND " _
            &"RTCode.KIND = 'D3' INNER JOIN " _
            &"RTCode RTCode_1 ON HB2002ACT21.IPTYPE = RTCode_1.CODE AND " _
            &"RTCode_1.KIND = 'D4' INNER JOIN " _
            &"RTCounty ON HB2002ACT21.CUTID = RTCounty.CUTID order by hb2002act21.EDAT " 
  dataTable="HB2002ACT1"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=1
  dataProg="/webap/rtap/ACT2002/ACT1/RTCustd.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=True
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="rtcusts.asp"
  searchFirst=TRUE
  If searchQry="" Then
     searchQry=" HB2002ACT221.SERNO<>0 "
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT HB2002ACT21.SERNO AS Expr1, HB2002ACT21.NAME AS Expr2, " _
            &"HB2002ACT21.TELC AS Expr3, HB2002ACT21.EXT AS Expr4, " _
            &"HB2002ACT21.TELH AS Expr5, HB2002ACT21.CONMOBILE AS Expr6, " _
            &"RTCounty.CUTNC + HB2002ACT21.TOWNSHIP + HB2002ACT21.RADDR AS Expr8, " _
            &"CONVERT(varchar(10), HB2002ACT21.EDAT, 111) AS EDAT, RTCode.CODENC AS Expr10, " _
            &"RTCode_1.CODENC AS Expr11, HB2002ACT21.cfmDAT AS Expr12, " _
            &"HB2002ACT21.DROPDAT AS Expr13 " _
            &"FROM HB2002ACT21 INNER JOIN " _
            &"RTCode ON HB2002ACT21.CASETYPE = RTCode.CODE AND " _
            &"RTCode.KIND = 'D3' INNER JOIN " _
            &"RTCode RTCode_1 ON HB2002ACT21.IPTYPE = RTCode_1.CODE AND " _
            &"RTCode_1.KIND = 'D4' INNER JOIN " _
            &"RTCounty ON HB2002ACT21.CUTID = RTCounty.CUTID order by hb2002act21.EDAT " 
 ' Response.Write "sql=" & SQLLIST
End Sub
%>
