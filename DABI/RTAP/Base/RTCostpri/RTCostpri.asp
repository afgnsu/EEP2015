 <%
  Dim search1,parm,vk
  parm=request("Key")
  vk=split(parm,";")
  if ubound(vk) > 0 then  searchX=vK(0)
%>
<!-- #include virtual="/WebUtility/DBAUDI/zzKeyList.inc" -->
<!-- #include virtual="/webap/include/accesspermit.inc" -->
<!-- #include virtual="/webap/include/lockright.inc" -->
<%
Sub SrEnvironment()
  company=application("company")
  system="HI-Building�޲z�t��"
  title="COT�ظm�ۥI�B�f�ֺM�P"
  buttonName=" �s�W ; �R�� ; ���� ;���s��z;����;�\��ﶵ"
  V=split(SrAccessPermit,";")
  AllowA=V(0):AllowU=V(1):AllowD=V(2):AllowP=V(3)
  ButtonEnable="N;N;Y;Y;Y;Y"
  'buttonEnable="Y;Y;Y;Y;Y;Y"
  functionOptName="�ۥI�B�f�ֽT�{"
  functionOptProgram="Verify.asp"
  If V(1)="Y" then
     accessMode="U"
  Else
     accessMode="I"
  End IF
  DSN="DSN=RTLIb"
  formatName="���ϦW��;�������B;�P�N�w��;T1�����;T1�}�q���;�C�L���;�C�L�H��;�f�֤��;�f�֤H��"
  sqlDelete="SELECT COMN,ASSESS,AGREE,T1ARRIVE,T1APPLY,PAYPRTD,PAYPRTUSR,ACCOUNTCFM,accountusr From RTCmty " _
             &  "where COMN='*' " 
  dataTable="rtCMTY"
  numberOfKey=1
  dataProg=""
  datawindowFeature=""
  searchWindowFeature="width=640,height=460,scrollbars=yes"
  optionWindowFeature=""
  detailWindowFeature="width=640,height=460,scrollbars=yes"
  diaWidth=""
  diaHeight=""
  diaTitle="�U�C��ƱN�Q�R���A�Ы��T�{�R�����A�Ϋ������C"
  diaButtonName=" �T�{�R�� ; ���� "
  goodMorning=TRUE
  goodMorningImage="cbbn.jpg"
  colSplit=1
  keyListPageSize=20
  searchProg="RTCOTpaysearch.asp"
  search1=Request("search1")
  if search1="" then search1=searchx
  'search2=Request("search2")
  If search1="" Then
     searchFirst=true
     where="ACCOUNTCFM IS not NULL and " 
  Else
     searchFirst=False
     where= "PAYPRTUSR='" & request("search1") & "' and "
  End If
  sqlList="SELECT COMN,ASSESS,AGREE,T1ARRIVE,T1APPLY,PAYPRTD,PAYPRTUSR,ACCOUNTCFM,accountusr From RTCmty WHERE  "  &where
End Sub
Sub SrSearch()
%>
  <table>
    <tr>
     <td><input name="search1" type="text" value="<%=search1%>" readonly></td>
     <td><%=keyname%></td>
    </tr>
  </table>
<%
End Sub
%>