<!-- #include virtual="/WebUtilityV3/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserEmply.inc" -->
<%
Sub SrEnvironment()
  company="���T�e�W�����ѥ��������q"
  system="HI-Building �޲z�t��"
  title="���T�Τ�^�Q�a�������(�ĤG��--�ʶRPS2)���Ӹ�Ƭd��"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;" & V(3)
  'buttonEnable="Y;Y;Y;Y;Y;N"
  functionOptName="�@�o;�@�o�^��;�C�L�X�f��"
  functionOptProgram="HB2002ACT222DROP.ASP;HB2002ACT222DROPBACK.ASP;HB2002ACT21P.ASP"
  functionOptPrompt="Y;Y;N"
  functionoptopen  ="1;1;1"    
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLib"
  formatName="none;���~�N��;���~�W��;�q�ʼƶq;�w��;���;���B;�q�ʤ�;�@�o��;�X�f��;�X�f�渹"
 ' sqlDelete="SELECT RTCust.COMQ1,RTCust.CUSID, RTCust.ENTRYNO, RTObj.shortnc, RTCust.CUSTYPE, " _
 '          &"RTCust.LINETYPE, RTCust.RCVD, RTCust.HOME," _
 '          &"RTCust.OFFICE + ' ' + RTCust.EXTENSION  AS Office,RTCust.SNDINFODAT ,rtcust.reqdat " _
 '          &"FROM RTCust INNER JOIN RTObj ON RTCust.CUSID = RTObj.CUSID " _
 '          &"WHERE RTCust.COMQ1=0 " _
 '          &"ORDER BY RTCust.CUSID, RTCust.ENTRYNO "
   sqlDelete="SELECT HB2002ACT222.SERNO AS Expr1, HB2002ACT222.PRODUCTID AS Expr2,  " _
         &"RTProduct.PNAME,HB2002ACT222.QTY AS Expr3, HB2002ACT222.LISTPRICE AS Expr4, " _
         &"HB2002ACT222.SALEPRICE AS Expr5, HB2002ACT222.AMT AS Expr6, " _
         &"CONVERT(varchar(10), HB2002ACT222.EDAT, 111) AS EDAT, " _
         &"HB2002ACT222.DROPDAT AS Expr13, HB2002ACT222.HAULDAT, HB2002ACT222.HAULNO " _
         &"FROM HB2002ACT221 INNER JOIN " _
         &"RTCounty ON HB2002ACT221.CUTID1 = RTCounty.CUTID INNER JOIN " _
         &"HB2002ACT222 ON HB2002ACT221.SERNO = HB2002ACT222.SERNO INNER JOIN " _
         &"RTProduct ON HB2002ACT222.PRODUCTID = RTProduct.PID " _
         &"ORDER BY  HB2002ACT222.EDAT " 
  dataTable="HB2002ACT222"
  userDefineDelete="Yes"
  extTable=""
  numberOfKey=2
  dataProg="/webap/rtap/ACT2002/ACT22/RTCustd.asp"
  datawindowFeature=""
  searchWindowFeature="width=700,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature=""
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=FALSE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="rtcusts.asp"
  searchFirst=FALSE
  If searchQry="" Then
     searchQry=" HB2002ACT221.SERNO<>0 "
     searchShow="����"
  ELSE
     searchFirst=False
  End If
  sqllist="SELECT HB2002ACT222.SERNO AS Expr1, HB2002ACT222.PRODUCTID AS Expr2,  " _
         &"RTProduct.PNAME,HB2002ACT222.QTY AS Expr3, HB2002ACT222.LISTPRICE AS Expr4, " _
         &"HB2002ACT222.SALEPRICE AS Expr5, HB2002ACT222.AMT AS Expr6, " _
         &"CONVERT(varchar(10), HB2002ACT222.EDAT, 111) AS EDAT, " _
         &"HB2002ACT222.DROPDAT AS Expr13, HB2002ACT222.HAULDAT,HB2002ACT222.HAULNO " _
         &"FROM HB2002ACT221 INNER JOIN " _
         &"RTCounty ON HB2002ACT221.CUTID1 = RTCounty.CUTID INNER JOIN " _
         &"HB2002ACT222 ON HB2002ACT221.SERNO = HB2002ACT222.SERNO INNER JOIN " _
         &"RTProduct ON HB2002ACT222.PRODUCTID = RTProduct.PID " _
         &"ORDER BY  HB2002ACT222.EDAT " 
 'Response.Write "sql=" & SQLLIST
End Sub
%>
