<%
  Dim fieldRole,fieldPa,fieldPb,fieldpc,fieldpe
  fieldRole=Split(FrGetUserRight("RTCustD",Request.ServerVariables("LOGON_USER")),";")
  userlevel=FrGetUserlevel(Request.ServerVariables("LOGON_USER"))
  
%>
<!-- #include virtual="/WebUtilityV4/DBAUDI/zzDataList.inc" -->
<%
' -------------------------------------------------------------------------------------------- 
Sub SrEnvironment()
  DSN="DSN=RTLib"
  numberOfKey=3
  title="�t��ADSL�Ȥ�򥻸�ƺ��@"
  formatName=";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  'sqlFormatDB="SELECT * FROM RTCust WHERE Comq1=0 "
  sqlFormatDB="SELECT comq1,CUSID, ENTRYNO,STOCKID,BRANCH,BUSSMAN,BUSSID,SEX,BIRTHDAY, cutid1, "_
			 &"township1,raddr1,rzone1,cutid2,township2,raddr2,rzone2, cutid3,township3,raddr3, "_
			 &"rzone3,SPEED,LINETYPE,USEKIND, HOUSETYPE,HOUSENAME,HOUSEQTY,exttel,HOME,FAX, "_
			 &"CONTACT,OFFICE, EXTENSION, MOBILE, EMAIL, VOUCHER, EUSR,EDAT,UUSR,UDAT, "_
			 &"PROFAC,SNDINFODAT, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR, FINISHDAT, DOCKETDAT, INCOMEDAT, AR, "_
			 &"ACTRCVAMT,DROPDAT,RCVDTLNO,RCVDTLPRT,SCHDAT,FINRDFMDAT,FINCFMUSR,BONUSCAL,DROPDESC,UNFINISHDESC, "_
			 &"PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, ACCCFMUSR, ENDCOD, NOTE,OPERENVID, SETTYPE, SETSALES, "_
			 &"PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, SETFEEDESC,orderno,Lookdat,formaldat,deliverdat, "_
			 &"socialid,agree,haveroom,homestat, LOOKDESC,CHTSIGNDAT,SENDWORKING,WORKINGREPLY,cusno,transdat, "_
			 &"holdemail,proposer,SPHNNO,ip,cotport,paytype,freecode,CONSIGNEE,overdue,TNSCUSTCASE, " _
			 &"COMPANYBOSS,COMPANYKIND,BOSSSOCIAL,IDNUMBERTYPE,TCOMQ1,secondidtype,secondno, GTMONEY, " _
			 &"GTVALID, GTSERIAL,ANO,BNO, DEVELOPERID, APPLYNO, GTEQUIP,GTPRTDAT, GTPRTUSR "_
			 &"FROM rtsparqADSLcust where cusid='*'"
  sqllist    ="SELECT COMQ1,CUSID, ENTRYNO,STOCKID,BRANCH,BUSSMAN,BUSSID,SEX,BIRTHDAY, " _
             &"cutid1,township1,raddr1,rzone1,cutid2,township2,raddr2,rzone2, " _
             &"cutid3,township3,raddr3,rzone3,SPEED,LINETYPE,USEKIND, " _
             &"HOUSETYPE,HOUSENAME,HOUSEQTY,exttel,HOME,FAX,CONTACT,OFFICE, EXTENSION, MOBILE, EMAIL, " _
             &"VOUCHER, EUSR,EDAT,UUSR,UDAT,PROFAC,SNDINFODAT, REQDAT, INSPRTNO, INSPRTDAT, INSPRTUSR,  " _
             &"FINISHDAT, DOCKETDAT, INCOMEDAT, AR, ACTRCVAMT, DROPDAT, RCVDTLNO,  " _
             &"RCVDTLPRT, SCHDAT, FINRDFMDAT, FINCFMUSR, BONUSCAL, DROPDESC, " _
             &"UNFINISHDESC, PAYDTLPRTNO, PAYDTLDAT, PAYDTLUSR, ACCCFMDAT, " _
             &"ACCCFMUSR, ENDCOD, NOTE,OPERENVID, SETTYPE, " _
             &"SETSALES, PRESETDATE, PRESETHOUR, PRESETMIN, SETFEE, SETFEEDIFF, " _
             &"SETFEEDESC,orderno,Lookdat,formaldat,deliverdat,socialid,agree,haveroom,homestat, " _
             &"LOOKDESC,CHTSIGNDAT,SENDWORKING,WORKINGREPLY,cusno,transdat, " _
			 &"holdemail,proposer,SPHNNO,ip,cotport,paytype,freecode,CONSIGNEE,overdue,TNSCUSTCASE, " _
			 &"COMPANYBOSS,COMPANYKIND,BOSSSOCIAL,IDNUMBERTYPE,TCOMQ1,secondidtype,secondno, GTMONEY, " _
			 &"GTVALID, GTSERIAL,ANO,BNO, DEVELOPERID, APPLYNO, GTEQUIP,GTPRTDAT, GTPRTUSR "_
             &"FROM rtsparqADSLcust where "
 ' Response.write "SQL=" & SQLlist
 ' Response.end            
  userDefineKey="Yes"
  userDefineData="Yes"
  extDBField=1
  userDefineRead="Yes"
  userDefineSave="Yes"
  userdefineactivex="Yes"  
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrCheckData(message,formValid)
'------���ϧǸ�---�T�w(�ѤW�h�{���ǤJ) 
   ' dspkey(90)=SESSION("comq1")
'------���ϦW��---�T�w(�Ѫ��ϧǸ�Ū��)
    Set connxx=Server.CreateObject("ADODB.Connection")  
    Set rsxx=Server.CreateObject("ADODB.Recordset")
    DSNXX="DSN=RTLIB"
    connxx.Open DSNxx
    sqlXX="SELECT * FROM RTsparqAdslCmty where cutyid=" & dspkey(0)
    rsxx.Open sqlxx,connxx
    s=""
    ADSLAPPLY=""
    If rsxx.Eof Then
       message="���ϥN��:" &dspkey(0) &"�b���ϰ򥻸�Ƥ��䤣��"
       formvalud=false
       'consigneeXX=""       
       adslapply="N"
    Else 
       'dspkey(25)=rsxx("ComN") 
       'consigneeXX=rsXX("consignee")    
       'if len(trim(dspkey(24)))=0 then  
       '   dspkey(24)=rsxx("housetype")
       'END IF       
       IF ISNULL(RSXX("ADSLAPPLY")) THEN
          adslapply="N"
       ELSE
          adslapply="Y"
       END IF
    End If
    rsxx.Close
    Set rsxx=Nothing
    connxx.Close
    Set connxx=Nothing    
    if len(trim(dspkey(3))) = 0 then dspkey(3)=""	'STOCKID
    if len(trim(dspkey(4))) = 0 then dspkey(4)=""	'BRANCH
    if len(trim(dspkey(5))) = 0 then dspkey(5)=""	'BUSSMAN
    if len(trim(dspkey(6))) = 0 then dspkey(6)=""	'BUSSID
    if len(trim(dspkey(7))) = 0 then dspkey(7)=""	'SEX
    if len(trim(dspkey(9))) = 0 then dspkey(9)=""	'�b��a�} �L����(Ex:�x���l�F)
    if len(trim(dspkey(24))) = 0 then dspkey(24)=""	'HOUSETYPE
    if len(trim(dspkey(25))) = 0 then dspkey(25)=""	'HOUSENAME
    if len(trim(dspkey(40))) = 0 then dspkey(40)=""
    if len(trim(dspkey(81))) = 0 then dspkey(81)=""	'AGREE
    if len(trim(dspkey(82))) = 0 then dspkey(82)=""	'haveroom ���L�q�H��
    if len(trim(dspkey(83))) = 0 then dspkey(83)=""	'homestat �W��, ����?
    if len(trim(dspkey(97))) = 0 then dspkey(97)="" 'consignee
    if len(trim(dspkey(99))) = 0 then dspkey(99)=""
    If len(trim(dspkey(26))) = 0 Then dspKey(26)=0	'HOUSEQTY ���
    if len(trim(dspkey(68))) = 0 then dspkey(68)="0"'�w�����O
    if len(trim(dspkey(71))) = 0 then dspkey(71)=0	'�˾�(��)
    if len(trim(dspkey(72))) = 0 then dspkey(72)=0	'�˾�(��)
    if len(trim(dspkey(104))) = 0 then dspkey(104)=0

    if dspkey(96) <> "Y" and dspkey(96) <>"N" then dspkey(96)=""   
    if dspkey(95) <> "Y" and dspkey(95) <>"M" and dspkey(95) <> "H" then dspkey(95)=""            
'-------�榸------------------------------
    If Not IsNumeric(dspKey(2)) Then dspKey(2)=0
    If Not IsNumeric(dspKey(49)) Then dspKey(49)=0   '�������B
    If Not IsNumeric(dspKey(50)) Then dspKey(50)=0   '�ꦬ���B 
    If Not IsNumeric(dspKey(73)) Then dspKey(73)=0   '�зǬI�u�O
    If Not IsNumeric(dspKey(74)) Then dspKey(74)=0   '�I�u�ɧU�O   
    If Not IsNumeric(dspKey(107)) Then dspKey(107)=0 '�O�Ҫ�
 '   If len(trim(dspkey(1))) < 1 then
 '      message="�ФJ�Ȥ�N�X"
 '      formValid=False
    If len(trim(extdb(0))) < 1 then
       message="�п�J�Ȥ�W��"
       formValid=False    
    'elseif len(trim(dspkey(6)))=0 and len(trim(Consigneexx)) = 0 then
    '   message="�����ɤ��g�P�����P�~�ȭ����i�P�ɪť�!"
    '   formValid=False
    elseif not Isdate(dspkey(8)) and len(dspkey(8)) > 0 then
       message="�X�ͤ�����~"
       formValid=False            
    elseif not Isdate(dspkey(41)) and len(dspkey(41))  > 0 then
       message="�q���o�]������~"
       formValid=False     
    elseif not Isdate(dspkey(42)) and len(dspkey(42))  > 0 then
       message="�o�]������~"
       formValid=False            
    elseif not Isdate(dspkey(46)) and len(dspkey(46))  > 0 then
       message="���u������~"
       formValid=False     
    elseif not Isdate(dspkey(47)) and len(dspkey(47))  > 0 then
       message="����������~"
       formValid=False             
    elseif not IsNumeric(dspkey(49)) and len(dspkey(49))  > 0 then
       message="�������B���~"
       formValid=False           
    elseif not IsNumeric(dspkey(50)) and len(dspkey(50))  > 0 then
       message="�ꦬ���B���~"
       formValid=False             
    elseif not Isdate(dspkey(51)) and len(dspkey(51))  > 0 then
       message="�h��������~"
       formValid=False             
    elseif not Isdate(dspkey(54)) and len(dspkey(54))  > 0 then
       message="���ڤ�����~"
       formValid=False          
    elseif not Isdate(dspkey(70)) and len(dspkey(70))  > 0 then
       message="�w�w�˾�������~"
       formValid=False          
    elseif not IsNumeric(dspkey(74)) and len(dspkey(74))  > 0 then
       message="�I�u�ɧU���B���~"
       formValid=False
	elseif len(trim(dspkey(40)))>0 and len(trim(dspkey(69)))>0 then
       formValid=False
       message="[�I�u�H��or�I�u�t��]���i�P�ɿ�J"
                           
    'elseif (dspkey(68)="1" or dspkey(68)="2" ) and dspkey(40) <> "" then
    '   message="�w�ˤH����(�~��)��(�޳N��)��,�I�u�t�ӥ����ť�"
    '   formvalid=false
    'elseif (dspkey(68)="3" ) and dspkey(40) = "" then
    '   message="�w�ˤH����(�t��)��,�I�u�t�Ӥ��o�ť�"
    '   formvalid=false       
    'elseif (dspkey(68)="3" ) and dspkey(40) = "" then
    '   message="�w�ˤH����(�t��)��,�I�u�t�Ӥ��o�ť�"
    '   formvalid=false              
    elseif LEN(TRIM(dspkey(105))) = 0 and dspkey(103)<>"02" and accessMode ="A" and dspKey(96)<>"Y" then
       message="�ĤG�ҷ����O���i�ť�"
       formvalid=false                 
    elseif LEN(TRIM(dspkey(106))) = 0 and dspkey(103)<>"02" and accessMode ="A" and dspKey(96)<>"Y" then
       message="�ĤG�ҷӸ��X���i�ť�"
       formvalid=false                       
    elseif (dspkey(103)="01" or dspkey(103)="02") and dspkey(80) <> "" and accessMode ="A" then
       idno=dspkey(80)
       if UCASE(left(idno,1)) >="A" AND UCASE(left(idno,1)) <="Z" THEN
          AAA=CheckID(idno)
          SELECT CASE AAA
             CASE "True"
             case "False"
                   message="�ӽХΤᨭ���Ҧr�����X�k"
                   formvalid=false 
             case "ERR-1"
                   message="�ӽХΤᨭ���Ҹ����i�d�ťթο�J��ƿ��~"
                   formvalid=false       
             case "ERR-2"
                   message="�ӽХΤᨭ���Ҧr�����Ĥ@�X���ݬO�X�k���^��r��"
                   formvalid=false    
             case "ERR-3"
                   message="�ӽХΤᨭ���Ҧr�����ĤG�X���ݬO�Ʀr 1 �� 2"
                   formvalid=false   
             case "ERR-4"
                   message="�ӽХΤᨭ���Ҧr������E�X���ݬO�Ʀr"
                   formvalid=false              
             case else
          end select  
       ELSE
          AAA=ValidBID(idno)
          if aaa = false then
              message="�ӽХΤᤣ�X�k���Τ@�s��"
              formvalid=false   
          end if
       END IF
       IF UCASE(left(DSPKEY(80),1)) >="A" AND UCASE(left(DSPKEY(80),1)) <="Z" AND ( DSPKEY(100) <> "" OR DSPKEY(102) <> "" ) THEN
          message="�ӤH�Τ�ӽСA���~�t�d�H�B�t�d�H�����Ҹ������ť�"
          formvalid=false  
       END IF       
       IF left(DSPKEY(80),1) >="0" AND left(DSPKEY(80),1) <="9" AND ( DSPKEY(100) = "" OR  DSPKEY(102) = ""  ) THEN
          message="���~�Τ�ӽСA���~�t�d�H�B�t�d�H�����Ҹ����i�ť�"
          formvalid=false  
       END IF              
    elseif dspkey(102) <> "" then    
          idno=dspkey(102)
          BBB=CheckID(idno)
          SELECT CASE BBB
             CASE "True"
             case "False"
                   message="���~�t�d�H�����Ҧr�����X�k"
                   formvalid=false 
             case "ERR-1"
                   message="���~�t�d�H���i�d�ťթο�J��ƿ��~"
                   formvalid=false       
             case "ERR-2"
                   message="���~�t�d�H�����Ҧr�����Ĥ@�X���ݬO�X�k���^��r��"
                   formvalid=false    
             case "ERR-3"
                   message="���~�t�d�H�����Ҧr�����ĤG�X���ݬO�Ʀr 1 �� 2"
                   formvalid=false   
             case "ERR-4"
                   message="���~�t�d�H�����Ҧr������E�X���ݬO�Ʀr"
                   formvalid=false              
             case else
          end select  
    elseif LEN(TRIM(dspkey(47)))<>0 and ADSLAPPLY <> "Y" then
       message="�D�u�|�����q�A���o��J�������"
       formvalid=false     
    elseif LEN(TRIM(dspkey(46)))<>0 and ADSLAPPLY <> "Y" then
       message="�D�u�|�����q�A���o��J���u���"
       formvalid=false                     
    elseif dspkey(95)="" and LEN(TRIM(dspkey(46)))<>0 and dspkey(96)<>"Y" then
       message="���u���u�f�N�X(ú�O�覡)���i�ť�"
       formvalid=false                            
    End If
 
'�t�ӼзǬI�u�O(�I�u�t�Ӥ����ťաA�B�L�I�ڦC�L�帹�ɡA�l�i�ܧ�^
    if len(trim(dspkey(40))) > 0 and len(trim(dspkey(60))) = 0 then
       Dim Connsupp,Rssupp,sqlsupp,dsn
       Set connsupp=server.CreateObject("ADODB.Connection")
       Set rssupp=Server.CreateObject("ADODB.RecordSet")
       DSN="DSN=RTLIB"
       Sqlsupp="select * from RtSupp where cusid='" & dspkey(40) & "'"
       connsupp.open DSN
       rssupp.open sqlsupp,connsupp,1,1
       if rssupp.eof then
          dspkey(73) = 0
       else
          dspkey(73) = rssupp("STDFee")
       end if
    end if
 '���ڦW�٬��ťծɡA
   IF len(trim(dspkey(35))) = 0 then
      dspkey(35)=extdb(0)
   end if
 '�ӽХN��H���ťծɡA�w�]��"N"
   IF len(trim(dspkey(91))) = 0 then
      dspkey(91)="N"
   end if   
'---�ˬd HN���X�O�_������ dspkey(89)---------
   IF LEN(TRIM(dspkey(88))) > 0 THEN
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx
      
	  if LEN(TRIM(DSPKEY(2))) =0 then
		 DSPKEY(2) =1
	  end if   
      sqlXX="SELECT count(*) AS CNT FROM RTsparqAdslcust where cusno='" & trim(dspkey(88)) & "' and not (cusid='" & dspkey(1) & "' and entryno=" & dspkey(2) & ")"
      rsxx.Open sqlxx,connxx
      s=""
      If RSXX("CNT") > 0 Then
         message="HN���X�w�s�bADSL�Ȥ�A���i���ƿ�J!"
         formvalid=false
      End If
      rsxx.Close
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing    
   end IF
'---�ˬd ����J���ϧǸ��O�_�s�b dspkey(104)---------
   IF LEN(TRIM(dspkey(104))) > 0 AND DSPKEY(104) > 0 AND ISNUMERIC(DSPKEY(104)) THEN   
      Set connxx=Server.CreateObject("ADODB.Connection")  
      Set rsxx=Server.CreateObject("ADODB.Recordset")
      DSNXX="DSN=RTLIB"
      connxx.Open DSNxx
      sqlXX="SELECT * FROM RTsparqAdslcmty where cutyid=" & dspkey(104) 
      rsxx.Open sqlxx,connxx
      s=""
      If RSXX.eof Then
         message="����J���ϧǸ����s�b�A�Э��s��J!"
         formvalid=false
      ELSEIF NOT ISNULL(RSXX("ADSLAPPLY")) THEN
         message="����J���ϧǸ��w���q�A�Ъ�����Ӫ��ϫإߥΤ�!"
         formvalid=false
      ELSEIF NOT ISNULL(RSXX("RCOMDROP")) THEN
         message="����J���ϧǸ��w�M�P�A�Э��s��J!"
         formvalid=false
      End If
      rsxx.Close
      Set rsxx=Nothing
      connxx.Close
      Set connxx=Nothing    
   END IF
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�ק�" then
        Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(38)=V(0)
    end if   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveXScript()%>
   <SCRIPT Language="VBScript">
   Sub Srbtnonclick()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="KEY" & clickid
	   if isdate(document.all(clickkey).value) then
	      objEF2KDT.varDefaultDateTime=document.all(clickkey).value
       end if
       call objEF2KDT.show(1)
       if objEF2KDT.strDateTime <> "" then
          document.all(clickkey).value = objEF2KDT.strDateTime
       end if
   End Sub 
   
   'Sub SrSelonclick()
   '    Dim ClickID
   '    ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
   '    clickkey="KEY" & clickid
   '    prog="RTFaQFinishUsrx.asp"
   '    CUTID=document.all("key13").value
   '    town=document.all("key14").value
   '    'showopt="Y;Y;Y;Y"��ܹ�ܤ�����n��ܪ�����(�~�Ȥu�{�v;�ȪA�H��;�޳N��;�t��)
   '    if clickkey="KEY6" then
   '       showopt="Y;N;N;N" & ";" & cutid & ";" & town
   '    else
   '       showopt="N;N;N;N;;"
   '    end if
   '    prog=prog & "?showopt=" & showopt
   '    FUsr=Window.showModalDialog(prog,"Dialog","dialogWidth:640px;dialogHeight:480px;")  
   '   'Fusrid(0)=���פH���u���μt�ӥN��  fusrid(1)=�u����W�@�e�����q�X����W��(�L�䥦�@��) fusrid(2)="1"���~��"2"���޳N"3"���t��"4"���ȪA(�@����Ʀs������줧�̾�)
   '    IF FUSR <> "" THEN
   '    FUsrID=Split(Fusr,";")    
   '    if Fusrid(3) ="Y" then
   '      '�t�Ө�8��,��l��6��   
   '      if Fusrid(2)="3"  then 
   '         document.all(clickkey).value =  left(Fusrid(0),8)
   '      else
   '         document.all(clickkey).value =  left(Fusrid(0),6)
   '      end if 
   '    End if
   '    END IF
   'End Sub    
   'Sub Srbranchonclick()
   '    prog="RTGetBRANCHD.asp"
   '    prog=prog & "?KEY=" & document.all("KEY3").VALUE 
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key4").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub      
   'Sub SrbranchMANonclick()	
   '    prog="RTGetBRANCHMAND.asp"
   '    prog=prog & "?KEY=" & document.all("KEY3").VALUE & ";" & document.all("KEY4").VALUE
   '    FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
   '    if fusr <> "" then
   '    FUsrID=Split(Fusr,";")   
   '    if Fusrid(2) ="Y" then
   '       document.all("key5").value =  trim(Fusrid(0))
   '    End if       
   '    end if
   'End Sub
   Sub SrSetEmplyonclick()
       prog="RTGetSetEmplyD.asp"
       prog=prog & "?KEY=" & document.all("KEY69").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key69").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub      
   Sub Srcounty10onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY9").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key10").value =  trim(Fusrid(0))
          document.all("key12").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub    
   Sub Srcounty14onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY13").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key14").value =  trim(Fusrid(0))
          document.all("key16").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub   
   Sub Srcounty18onclick()
       prog="RTGetcountyD.asp"
       prog=prog & "?KEY=" & document.all("KEY17").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(3) ="Y" then
          document.all("key18").value =  trim(Fusrid(0))
          document.all("key20").value =  trim(Fusrid(1))
       End if       
       end if
   End Sub             
   Sub SrDeveloperonclick()
       prog="RTGetDeveloperD.asp"
       prog=prog & "?KEY=" & document.all("KEY112").VALUE
       FUsr=Window.showModalDialog(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       if fusr <> "" then
       FUsrID=Split(Fusr,";")   
       if Fusrid(2) ="Y" then
          document.all("key112").value =  trim(Fusrid(0))
       End if       
       end if
   End Sub      
   Sub SrBUSonclick()
       prog="RTOBJSTOCKBRANCHBUSSD.asp"
       prog=prog & "?KEY=" & document.all("KEY3").VALUE & ";" & document.all("KEY4").VALUE
       FUsr=Window.open(prog,"d2","dialogWidth:590px;dialogHeight:480px;")  
       Window.form.Submit
   End Sub    
   
   Sub SrClear()
       Dim ClickID
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid       
       if len(trim(document.all(clearkey).value)) <> 0 then
          document.all(clearkey).value =  ""
       end if
   End Sub    
   
   Sub ImageIconOver()
       self.event.srcElement.style.borderBottom = "black 1px solid"
       self.event.srcElement.style.borderLeft="white 1px solid"
       self.event.srcElement.style.borderRight="black 1px solid"
       self.event.srcElement.style.borderTop="white 1px solid"   
   End Sub
   
   Sub ImageIconOut()
       self.event.srcElement.style.borderBottom = ""
       self.event.srcElement.style.borderLeft=""
       self.event.srcElement.style.borderRight=""
       self.event.srcElement.style.borderTop=""
   End Sub      
   
   Sub SrCmtysel()
       Dim ClickID,prog
       prog="RTCmtySelK.asp"
       ClickID=mid(window.event.srcElement.id,2,len(window.event.srcElement.id)-1)
       clickkey="C" & clickid
       clearkey="key" & clickid
       CuTID2=document.all("key13").value
       township2=document.all("key14").value
       prog=prog & "?PARM=" & CutID2 & ";" & township2
       Fcmty=window.showModalDialog(prog,"Dialog","dialogWidth:590px;dialogHeight:480px;scroll:Yes")  
       document.all("key25").value=Fcmty
   End Sub    
   </Script>
<%   
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrActiveX() %>
    <OBJECT classid="CLSID:B8C54992-B7BF-11D3-AACE-0080C8BA466E"    codebase="/webap/activex/EF2KDT.CAB#version=9,0,0,3" 
	        height=60 id=objEF2KDT style="DISPLAY: none; HEIGHT: 0px; LEFT: 0px; TOP: 0px; WIDTH: 0px" 
	        width=60 VIEWASTEXT>
	<PARAM NAME="_ExtentX" VALUE="1270">
	<PARAM NAME="_ExtentY" VALUE="1270">
	</OBJECT>
<%	
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineKey()
On error resume next
s=FrGetCmtyDesc(SESSION("comq1"))
%>
<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr><td width="20%" class=dataListSearch>��ƽd��</td>
    <td width="80%" class=dataListSearch2><%=s%></td></tr>
</table>
<p>
</table>

<table width="100%" border=1 cellPadding=0 cellSpacing=0>
<tr>
    <td width="10%" class=dataListHead>���ϧǸ�</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key0" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="6"
               value="<%=dspKey(0)%>" readonly class=dataListdata></td>
    <td width="10%" class=dataListHead>�Ȥ�N��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key1" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(1)%>" class=dataListdata readonly></td>
    <td width="10%" class=dataListHead>�Ȥ�榸</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key2" readonly
               style="text-align:left;" maxlength="6" size="5"
               value="<%=dspKey(2)%>" class=dataListdata></td>
    <td width="10%" bgcolor="orange" >����s��</td>
    <td width="10%" bgcolor="silver">
        <input type="text" name="key76" readonly
               style="text-align:left;" maxlength="6" size="10"
               value="<%=dspKey(76)%>" class=dataListdata style="color:red"></td>
 <td width="10%" BGCOLOR=#BDB76B>���ɳ������</td>
    <td width="10%" colspan="7" bgcolor=#DCDCDC>
        <input type="text" name="key89" <%=fieldRole(1)%><%=keyProtect%>
               style="text-align:left;color:red" maxlength="10" size="10"
               value="<%=dspKey(89)%>" readonly  class=dataListData></td>               
    </tr>
</table>
<%
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrGetUserDefineData()
'-------UserInformation----------------------       
    logonid=session("userid")
    if dspmode="�s�W" then
        if len(trim(dspkey(36))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                EUsrNc=V(1) 
                dspkey(36)=V(0)
      '          extdb(46)=v(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(36))
                V=split(rtnvalue,";")      
                EUsrNc=V(1)
        End if  
       dspkey(37)=now()
    else
        if len(trim(dspkey(38))) < 1 then
           Call SrGetEmployeeRef(Rtnvalue,1,logonid)
                V=split(rtnvalue,";")  
                UUsrNc=V(1)
                DSpkey(38)=V(0)
        else
           Call SrGetEmployeeRef(rtnvalue,2,dspkey(38))
                V=split(rtnvalue,";")      
                UUsrNc=V(1)
        End if         
        Call SrGetEmployeeRef(rtnvalue,2,dspkey(36))
             V=split(rtnvalue,";")      
             EUsrNc=V(1)
        dspkey(39)=now()
    end if  
' -------------------------------------------------------------------------------------------- 
    IF len(trim(dspkey(35))) = 0 then
      dspkey(35)=extdb(0)
    end if
    Dim conn,rs,s,sx,sql,t
    
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN

    '�~�U
	sql ="SELECT * FROM XXLib..UserGroup WHERE [GROUP] in('RTADMIN','�~�U') and userid ='" &logonid&"' "
    rs.Open sql,conn
    If rs.Eof Then
		basedata=False
    Else
		basedata=true
    End If
    rs.Close

    '�Τ������,���~�U�~��� protect
	If len(trim(dspKey(89))) > 0 and basedata=false Then
       fieldPm=" class=""dataListData"" readonly "
       fieldpn=""
    Else
       fieldPm=""
       fieldpn=" onclick=""SrClear"" "
    End If

    
    '���׽X(�������줣�i�ק�)
    If dspKey(65)="Y" or  len(trim(dspkey(89))) > 0 Then
       fieldPa=" class=""dataListData"" readonly "
       fieldPc=""
       fieldpe=""      
       fieldpf=""              
    Else
       fieldPa=""
       fieldPc=" Onclick=""Srbtnonclick"" "
       fieldpe=" onclick=""SrClear"" "     
       fieldpf=" onclick=""Srcmtysel"" "           
    End If    
    '�w��t�ճ�����==>�������protect(�������)  
    if len(trim(dspkey(89))) > 0 then
	   fieldpb=" disabled "
       fieldPc=""
       fieldpe=""      
       fieldpf=""         
       fieldPg=" class=""dataListData"" readonly "
    else
       fieldPb=""
       fieldPc=" Onclick=""Srbtnonclick"" "
       fieldpe=" onclick=""SrClear"" "     
       fieldpf=" onclick=""Srcmtysel"" " 
       fieldPg=""               
    end if
    '���ڪ�w�C�L�Φw�˭����O���o�](�Ϊť�)�ɡA���i���w�˭��u�s�A���i���w�ˤH����ơ]�Y�w�˭��u�sdisable)
  ' If Len(Trim(dspKey(50))) > 0  Then
  '    fieldPb=" class=""dataListData"" readonly "
  ' Else
  '    fieldPb=""
  ' End If
    if dspkey(65)="Y" or Len(Trim(dspKey(50))) > 0  then
       fieldPbx=""       
    else
       fieldPbx="SrAddusr()"
    end if
    '�O�Ҫ��C�L��, �O�Ҫ�������� protect
    If len(trim(dspKey(115))) > 0  Then
		fieldPh=" class=""dataListData"" readonly "
	Else
		fieldPh=""
	END IF

    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.Recordset")
    conn.open DSN%>
  <span id="tags1" class="dataListTagsOn"
        onClick="vbscript:tag1.style.display=''    :tags1.classname='dataListTagsOn':
                          tag2.style.display='none':tags2.classname='dataListTagsOf'"><font size=2>�򥻸��</span>
  <span id="tags2" class="dataListTagsOf"
        onClick="vbscript:tag1.style.display='none':tags1.classname='dataListTagsOf':
                          tag2.style.display=''    :tags2.classname='dataListTagsOn'"><font size=2>�o�]�w��</span>                                      
  <div class=dataListTagOn> 
<table width="100%" ><tr><td width="100%">&nbsp;</td></tr>                                                      
    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag1" height="354">  
    <tr><td bgcolor="BDB76B" align="CENTER" colspan=6>�򥻸��</td></tr>

<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='J5' "
       If len(trim(dspkey(103))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='J5' AND CODE='" & dspkey(103) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    's=s &"<option value=""" &"""" &sx &">(�ҷӧO)</option>"
    s=""
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(103) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>    
    <tr>
        <td  class="dataListHead" height="25">�Ĥ@�ҷӸ��X</td>
        <td  height="25" bgcolor="silver"> 
			<select size="1" name="key103"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>	
			<input type="text" name="key80" size="11" maxlength="10" value="<%=dspkey(80)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
		</td>

<%
    s=""
    sx=" selected "
    If sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false) Then 
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L3' " 
       If len(trim(dspkey(105))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
    Else
       sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L3' AND CODE='" & dspkey(105) &"' " 
       'SXX60=""
    End If
    rs.Open sql,conn
    s=""
    s=s &"<option value=""" &"""" &sx &">(�ĤG�ҷӧO)</option>"
    sx=""
    Do While Not rs.Eof
       If rs("CODE")=dspkey(105) Then sx=" selected "
       s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <td  class="dataListHead" height="25">�ĤG�ҷӸ��X</td>
        <td  height="25" bgcolor="silver"> 
		<select size="1" name="key105"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry" ID="Select2"><%=s%></select>	
        <input type="text" name="key106" size="15" maxlength="15" value="<%=dspkey(106)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text7"></td> 
    </tr>

     <tr>                                      
        <td  class="dataListHead" height="25">�Ȥ�W��</td>                                      
        <td  height="25" bgcolor="silver">
          <input type="text" name="ext0" size="28" maxlength="50" value="<%=extdb(0)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
		</td>                              
        
        <td  class="dataListHead" height="25">�X�ͤ��</td>                              
        <td  height="25" bgcolor="silver">
          <input type="text" name="key8" size="10" value="<%=dspkey(8)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class=dataListEntry>
          <input type="button" id="B8"  name="B8" height="70%" width="70%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>
        </td>
        <td  class="dataListHead" height="23">���ڦW��</td>                                 
        <td colspan="3" height="23" bgcolor="silver">
			<input type="text" name="key35" size="15" value="<%=dspkey(35)%>" maxlength="50" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text34">
			<font size=2>(�ťզP�Ȥ�W��)</font>
        </td>
      </tr>                              
      <tr>                                      
        <td  class="dataListHead" height="25">���~�t�d�H</td>                                      
        <td  height="25" bgcolor="silver">
          <input type="text" name="KEY100" size="15" maxlength="12" value="<%=DSPKEY(100)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text2">
		</td>
        <td  class="dataListHead" height="25">�t�d�H�����Ҹ�</td>                              
        <td  height="25" bgcolor="silver">
          <input type="text" name="key102" size="12" value="<%=dspkey(102)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class=dataListEntry ID="Text3">
		</td>
        <td  class="dataListHead" height="25">��~�O</td>
        <td  height="25" bgcolor="silver">
			<input type="text" name="KEY101" size="28" maxlength="15" value="<%=DSPKEY(101)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text4">
		</td>
      </tr>

      <tr>
        <td  class="dataListHead" height="23">�p���H</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key30" size="10" value="<%=dspkey(30)%>" maxlength="20" class="dataListEntry" ID="Text29"></td>                                 
        <td  class="dataListHead" height="23">�p���q��</td>                                 
        <td  height="23"><input type="text" name="key28" size="15" value="<%=dspkey(28)%>" maxlength="15"  class="dataListEntry" ID="Text25"></td>                                 
        <td  class="dataListHead" height="23" bgcolor="silver">���q�q��</td>                                 
        <td  height="23"><input type="text" name="key31" size="15" value="<%=dspkey(31)%>" maxlength="15" class="dataListEntry" ID="Text30">
        <font size=2>����<input type="text" name="key32" size="5" value="<%=dspkey(32)%>" maxlength="5" class="dataListEntry" ID="Text31"></td>
      </tr>                                 
      <tr>
        <td  class="dataListHead" height="23">�ǯu�q��</td>                                 
        <td  height="23" bgcolor="silver"><input type="text" name="key29" size="15" value="<%=dspkey(29)%>" maxlength="15" class="dataListEntry" ID="Text28"></td>                                 
        <td  class="dataListHead" height="23">��ʹq��</td>                                 
        <td   height="23" bgcolor="silver"><input type="text" name="key33" size="15" value="<%=dspkey(33)%>" maxlength="15" class="dataListEntry" ID="Text32"></td> 
        <td  class="dataListHead" height="25">�q�l�l��H�c</td>                                 
        <td  height="25" bgcolor="silver">
			<input type="text" name="key34" size="30" value="<%=dspkey(34)%>" maxlength="30" <%=dataProtect%> class="dataListEntry" ID="Text33">
        </td>                                 
      </tr>                                

      <tr>                              
        <td  class="dataListHead" height="25">�b��(�q�T)�a�}</td>                              
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(9))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX10=" onclick=""Srcounty10onclick()""  "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(9) & "' " 
       SXX10=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(9) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>
         <select size="1" name="key9"<%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> size="1" class="dataListEntry"><%=s%></select>
        <input type="text" name="key10" size="8" value="<%=dspkey(10)%>" maxlength="10" readonly <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B10"  name="B10"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX10%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C10"  name="C10"   style="Z-INDEX: 1" <%=fieldpn%> border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >
        <input type="text" name="key11" size="32" value="<%=dspkey(11)%>" maxlength="60" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                 
        <td  class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td  height="25" bgcolor="silver"><input type="text" name="key12" size="10" value="<%=dspkey(12)%>" maxlength="5" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>

<script language="vbscript">
Sub SrAddrEqual()
  Dim i,objOpt
  document.All("key13").value=document.All("key9").value
  document.All("key14").value=document.All("key10").value
  document.All("key15").value=document.All("key11").value
  document.All("key16").value=document.All("key12").value
End Sub 
Sub SrAddrEqual2()
  document.All("key17").value=document.All("key9").value
  document.All("key18").value=document.All("key10").value
  document.All("key19").value=document.All("key11").value
  document.All("key20").value=document.All("key12").value
End Sub 
Sub SrAddUsr()
  ExistUsr=document.all("key69").value
  InsType=cstr(document.all("key68").value)
  UsrStr=Window.showModalDialog("RTCustAddUsr.asp?parm=" & existusr & "@" & instype   ,"Dialog","dialogWidth:410px;dialogHeight:400px;")
  if UsrStr<>False then
     UsrStrAry=split(UsrStr,"@")
     document.all("key69").value=UsrStrAry(0)
     document.all("REF01").value=UsrStrAry(1)     
  end if
End Sub

Sub Srpay()
  if document.all("key68").value = "1" then
     document.all("key73").value = 200
  else
     document.all("key73").value = 0
  end if
end sub
</script>                       
<%
	dim seld1
	if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
	If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
		seld1=""
	Else
		seld1=" disabled "
	End If
	else
		seld1=" disabled "
	end if
%>
      <tr>                                 
        <td width="10%" class="dataListHead" height="25">�˾��a�}<br>
			<input type="radio" name="rdo1" value="1"<%=seld1%><%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual()" ID="Radio8">�P�b��
        </td>                                 
        <td width="60%" colspan="3" height="25" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(13))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if     
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"       
       SXX14=" onclick=""Srcounty14onclick()"" "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(13) & "' " 
       sXX14=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(13) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key13" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> size="1"  style="text-align:left;" maxlength="8" class="dataListEntry">
        <%=s%></select>
        <input type="text" name="key14" size="8" value="<%=dspkey(14)%>" maxlength="10" readonly <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B14"  name="B14"   width="100%" style="Z-INDEX: 1"  value="...." <%=SXX14%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C14"  name="C14"   style="Z-INDEX: 1" <%=fieldpn%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >    
        <input type="text" name="key15" size="32" value="<%=dspkey(15)%>" maxlength="60" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                                
        <td  class="dataListHead" height="25">�l���ϸ�</td>                                 
        <td  height="25" bgcolor="silver"><input type="text" name="key16" size="10" value="<%=dspkey(16)%>" maxlength="5"<%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>

      <tr>                                 
        <td width="10%" class="dataListHead">���y�a�}<br>
            <input type="radio" name="rdo2" value="1"<%=seld1%><%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> 
                   onClick="SrAddrEqual2()" ID="Radio9">�P�b��</td>                                 
        </td>                                 
        <td width="60%" colspan="3" bgcolor="silver">
  <%s=""
    sx=" selected "
    If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) and basedata=true Then 
       sql="SELECT Cutid,Cutnc FROM RTCounty " 
       If len(trim(dspkey(17))) < 1 Then
          sx=" selected " 
       else
          sx=""
       end if    
       s=s &"<option value=""" &"""" &sx &">(�����O)</option>"        
       sxx18=" onclick=""Srcounty18onclick()"" "
    Else
       sql="SELECT Cutid,Cutnc FROM RTCounty where cutid='" & dspkey(17) & "' " 
       sxx18=""
    End If
    sx=""    
    rs.Open sql,conn
    Do While Not rs.Eof
       If rs("cutid")=dspkey(17) Then sx=" selected "
       s=s &"<option value=""" &rs("Cutid") &"""" &sx &">" &rs("Cutnc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
   %>        
        <select name="key17" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> size="1" style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>
        <input type="text" name="key18" size="8" value="<%=dspkey(18)%>" maxlength="10" readonly <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"><font size=2>(�m����)                 
         <input type="button" id="B18"  name="B18"   width="100%" style="Z-INDEX: 1"  value="...." <%=sxx18%>  >        
          <IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" alt="�M��" id="C18"  name="C18"   style="Z-INDEX: 1" <%=fieldpn%>  border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut" >     
        <input type="text" name="key19" size="32" value="<%=dspkey(19)%>" maxlength="60" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry"></td>                     
        <td  class="dataListHead" >�l���ϸ�</td>                                 
        <td  bgcolor="silver"><input type="text" name="key20" size="10" value="<%=dspkey(20)%>" maxlength="5" <%=fieldpm%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" readonly></td>                                 
      </tr>                                

      <tr>
        <td class="dataListHead" height="34">�Ƶ�</td>  
        <td colspan="5" bgcolor="silver">
			<TEXTAREA cols="100%" name="key84" rows=5 MAXLENGTH=300 style="color:red" <%=FIELDROLE(3)%> value="<%=dspkey(84)%>" class="dataListEntry" ID="Textarea1"><%=dspkey(84)%> </TEXTAREA>
        </td>
      </tr>            

      <tr style="display:none">
        <td   bgcolor="ORANGE"  height="34">CHTñ�֤��</td>  
        <td   height="21" bgcolor="silver">
        <input type="text" name="key85" style="text-align:left;" maxlength="10" size="10"
               value="<%=dspKey(85)%>" class=dataListentry >
          <input type="button" id="B85"  name="B85" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=fieldpc%>>               
        </td>
        <td    bgcolor="ORANGE" height="34">�e��B�B���</td>                                 
        <td   height="34" bgcolor="silver">
          <input type="text" name="key86" size="10" value="<%=dspKey(86)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <input type="button" id="B86"  name="B86" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpc%>></td>       
        <td    bgcolor="ORANGE" height="34">���o�����q�ܤ�</td>                                 
        <td   height="34" bgcolor="silver">
          <input type="text" name="key87" size="10" value="<%=dspKey(87)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <input type="button" id="B87"  name="B87" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpc%>></td>                 
      </tr>                                            

    <tr><td bgcolor="BDB76B" align="CENTER" colspan=6>�Z���k��</td></tr>
    <tr>
        <td class="dataListHead">�I�u�H��</td>
        <td  bgcolor="silver">
			<input type="text" name="key69" size="7" readonly value="<%=dspKey(69)%>" <%=fieldPg%> class="dataListEntry" ID="Text38">
			<input type="BUTTON" id="B69" name="B69" <%=fieldpb%> style="Z-INDEX: 1"  value="...." onclick="SrSetEmplyonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C69" name="C69" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=SrGetEmployeeName(dspKey(69))%></font>
		</td>                   
    
        <td  class="dataListHead">�I�u�t��</td>                     
        <td  bgcolor="silver">
		<%    s=""
			If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa &fieldPb &fieldRole(1) &dataProtect))<1 and  len(trim(dspkey(89)))=0 Then 
				sql="select c.cusid, c.shortnc " &_
					"from RTConsignee a " &_
					"inner join RTConsigneeCASE b on a.CUSID = b.CUSID " &_
					"inner join RTObj c on c.cusid = a.cusid " &_
					"where	b.caseid ='00' " &_
					"order by c.shortnc " 
 		
				s="<option value="""" selected>&nbsp;</option>"

			Else
				sql="select c.cusid, c.shortnc " &_
					"from RTConsignee a " &_
					"inner join RTConsigneeCASE b on a.CUSID = b.CUSID " &_
					"inner join RTObj c on c.cusid = a.cusid " &_
					"where	b.caseid ='00' " &_
					"and c.CUSID='" &dspKey(40) &"' " &_
					"order by c.shortnc " 
			End If
		'  Response.Write "SQL=" & SQL & "<BR>"
			rs.Open sql,conn
			If rs.Eof Then 
			else
			sx=""
			Do While Not rs.Eof
				If rs("CusID")=dspKey(40) Then sx=" selected "
				s=s &"<option value=""" &rs("CusID") &"""" &sx &">" &rs("SHORTNC") &"</option>" & vbcrlf
				rs.MoveNext
				sx=""
			Loop
			end if
			rs.Close
		%>
        <select name="key40" <%=fieldRole(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%><%=fieldPb%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry" ID="Select7"><%=s%></select>
		</td> 

        <td class="dataListHead">�ꦬ���B</td>                     
        <td  bgcolor="silver">
			<input type="text" name="key50" size="10" value="<%=dspKey(50)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" ID="Text37">
        </td>
   
	</tr>    

    <tr>                       
		<td  class="dataListHead">�I�u�Ƶ�����</td>                    
		<td  colspan="5" bgcolor="silver">
			<input type="text" name="key66" size="70" value="<%=dspKey(66)%>" <%=fieldPg%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="50" ID="Text40"></td>
    </tr>                                     

    <tr><td bgcolor="BDB76B" align="CENTER" colspan=6>�O�Ҫ����</td></tr>

	<tr><td class="dataListHead">�O�Ҫ�</td>                    
        <td bgcolor="silver">
			<input type="text" name="key107" maxlength="10" size="10" value="<%=dspKey(107)%>" <%=fieldPh%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Text11">
		</td>

        <td width="10%" class="dataListHead">�Τ�O�޳]��</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='P2' " 
			If len(trim(dspkey(114))) < 1 Then
				sx=" selected " 
			else
				sx=""
			end if     
			Else
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='P2' AND CODE='" & dspkey(114) &"' " 
			End If
			rs.Open sql,conn
			s=""
			s=s &"<option value=""" &"""" &sx &"></option>"
			sx=""
			Do While Not rs.Eof
			If rs("CODE")=dspkey(114) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
        <td width="23%" bgcolor="silver">
			<select name="key114" size="1" <%=fieldPh%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" ID="Select5">
				<%=s%>
			</select>
		</td>

        <td  class="dataListHead">�O�Ҫ��~��</td>
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) Then     
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND ='L6' " 
			If len(trim(dspkey(108))) < 1 Then
				sx=" selected " 
			else
				sx=""
			end if     
			Else
			sql="SELECT Code,CodeNC FROM RTCode WHERE KIND='L6' AND CODE='" & dspkey(108) &"' " 
			End If
			rs.Open sql,conn
			s=""
			s=s &"<option value=""" &"""" &sx &"></option>"
			sx=""
			Do While Not rs.Eof
			If rs("CODE")=dspkey(108) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>
        <td  bgcolor="silver">
			<select size="1" name="key108" <%=fieldPh%> <%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry" ID="Select6">
				<%=s%>
			</select>
		</td>
	</tr>
	
	<tr><td class="dataListHead">�O�Ҫ��Ǹ�</td>
        <td bgcolor="silver">
			<input type="text" name="key109" size="13" readonly value="<%=dspKey(109)%>" class="dataListData" ID="Text24">
		</td>

		<td class="dataListHEAD" height="23">���ڦC�L�H</td>                                 
		<td height="23" bgcolor="silver">
			<input type="text" name="key116" size="10" readonly value="<%=dspKey(116)%>" class="dataListData" ID="Text26">
			<font size=2>
			<%
				if trim(len(dspKey(116))) =6 then
					response.Write SrGetEmployeeName(dspKey(116))
				else 
					sql="SELECT shortnc FROM RTObj where cusid ='" &dspKey(116)&"' "
					rs.Open sql,conn
					Do While Not rs.Eof
						response.Write rs("shortnc")
						rs.MoveNext
					Loop
					rs.Close
				end if
			%>
			</font>
		</td>       

		<td class="dataListHEAD" height="23">�O�Ҫ����ڦC�L��</td>                                 
		<td height="23" bgcolor="silver">
			<input type="text" name="key115" size="25" readonly value="<%=dspKey(115)%>" class="dataListDATA" ID="Text27">
		</td>       
	</tr>


    <tr><td bgcolor="BDB76B" align="CENTER" colspan=6>�e�W�A��</td></tr>

      <tr>                            
        <td  class="dataListHead" height="25">�ӽФ��</td>
 <td  height="25" bgcolor="silver">
<% aryOption=Array("�g�٫�","�����","�ӷ~��")
   s=""
   If Len(Trim(fieldRole(1) &dataProtect)) < 1 and len(trim(dspkey(89)))=0 Then 
      For i = 0 To Ubound(aryOption)
          If dspKey(23)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(23) &""">" &dspKey(23) &"</option>"
   End If%>               
   <select size="1" name="key23" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select1">                                            
        <%=s%>
   </select>
   </td>    
        <td  class="dataListHead" height="23">�ӽгt��</td>
<% aryOption=Array("512/64Kbps","768/128Kbps","1.5M/384Kbps")
   s=""
   If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 and  len(trim(dspkey(89)))=0 Then 
      For i = 0 To Ubound(aryOption)
          If dspKey(21)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(21) &""">" &dspKey(21) &"</option>"
   End If%>                                      
        <td  height="23" bgcolor="silver"><select size="1" name="key21" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select3">                                                             
        <%=s%></select></td>      
        <td  class="dataListHead" height="25">�u������</td>
<% aryOption=Array("ADSL")
   s=""
   If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 and  len(trim(dspkey(89)))=0 Then   
      For i = 0 To Ubound(aryOption)
          If dspKey(22)=aryOption(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOption(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
   Else
      s="<option value=""" &dspKey(22) &""">" &dspKey(22) &"</option>"
   End If%>                                  
        <td  height="25" bgcolor="silver"><select size="1" name="key22" style="font-family: �s�ө���; font-size: 10pt"<%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select4">                                                                  
        <%=s%></select></td>                                                                         
     </tr>
     
	<tr><td  class="dataListHEAD" height="25">������</td>       
		<%
			dim freecode1, freecode2
			if len(trim(dspkey(96))) =0 and dspkey(67) <> "Y" then
			If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
				freecode1=""
				freecode2=""
			Else
				freecode1=" disabled "
				freecode2=" disabled "
			end if
			else
		'       freecode1=" disabled "
		'       freecode2=" disabled "
			End If
			If dspKey(96)="Y" Then freecode1=" checked "    
			If dspKey(96)="N" or dspKey(96)="" Then freecode2=" checked " 
		%>                          
        <td  height="25" bgcolor="silver" >
			<input type="radio" value="Y"  name="key96" <%=FREECODE1%><%=FIELDROLE(1)%> ID="Radio4"><font size=2>�O</font>
			<input type="radio" name="key96" value="N" <%=FREECODE2%><%=FIELDROLE(1)%> ID="Radio5"><font size=2>�_</font>
		</td>

        <td  class="dataListHEAD" height="25">ú�O�覡</td>       
		<%  dim PAYTYPE1, PAYTYPE2
		if len(trim(dspkey(89))) =0 and dspkey(67) <> "Y" then
		If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
			PAYTYPE1=""
			PAYTYPE2=""
			PAYTYPE3=""
		Else
			PAYTYPE1=" disabled "
			PAYTYPE2=" disabled "
			PAYTYPE3=" disabled "
		end if
		else
	'       freecode1=" disabled "
	'       freecode2=" disabled "
		End If
		If dspKey(95)="M" Then PAYTYPE1=" checked "    
		If dspKey(95)="Y" Then PAYTYPE2=" checked " 
		If dspKey(95)="H" Then PAYTYPE3=" checked " 
		%>                          
        <td  height="25" bgcolor="silver" >
        <input type="radio" name="key95" value="M" <%=PAYTYPE1%><%=fieldpg%><%=FIELDROLE(1)%><%=dataProtec%> ID="Radio1"><font size=2>��ú</font>
        <input type="radio" name="key95" value="Y" <%=PAYTYPE2%><%=fieldpg%><%=FIELDROLE(1)%><%=dataProtec%> ID="Radio2"><font size=2>�~���~ú</font>
        <input type="radio" name="key95" value="H" <%=PAYTYPE3%><%=fieldpg%><%=FIELDROLE(1)%><%=dataProtec%> ID="Radio3"><font size=2>�~����ú</font>
          </td>
        
        <td  height="23" class="dataListHead" >�ӽХN��H</td>                     
        <td  height="23" bgcolor="silver">
        <%  dim OPT1, OPT2
            if len(trim(dspkey(89))) =0 and dspkey(65) <> "Y" then
               If Len(Trim(FIELDROLE(1) &dataProtect)) < 1 Then
                  OPT1=""
                  OPT2=""
               Else
                  OPT1=" disabled "
                  OPT2=" disabled "
               end if
            else
               OPT1=" disabled "
               OPT2=" disabled "
            End If
            If dspKey(91)="Y" Then OPT1=" checked "    
            If dspKey(91)="N" Then OPT2=" checked " %>                          
        
        <input type="radio" value="Y" <%=OPT1%> name="key91" <%=fieldpg%><%=fieldpa%><%=dataProtec%> ID="Radio6"><font size=2>�O</font>
        <input type="radio" value="N" <%=OPT2%> name="key91" <%=fieldpg%><%=fieldpa%><%=dataProtect%> ID="Radio7"><font size=2>�_</font>
        </td>
            
     </tr>

	<tr>
        <td class="dataListHead" height="25">�t�իȤ�N�X</td>       
        <td height="25" bgcolor="silver"> 
	        <input type="text" name="key88" size="10" maxlength="10" value="<%=dspkey(88)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text19">
		</td> 
        <td class="dataListHead" height="25" >����HN���X</td>       
        <td height="25" bgcolor="silver"> 
		    <input type="text" name="key90" size="8" maxlength="8" value="<%=dspkey(90)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" style="color:red" ID="Text20">
			<FONT SIZE=2>&nbsp;for �O�d����E-Mail</FONT>
		</td>
		<td  class="dataListHEAD" height="23">�G�u�}�o�H��</td>
	<%
	name=""
	if dspkey(112) <> "" then
		sqlxx=" select cusnc from rtemployee inner join rtobj on rtemployee.cusid=rtobj.cusid " _
			 &"where rtemployee.emply='" & dspkey(112) & "' "
		rs.Open sqlxx,conn
		if rs.eof then
			name="(��H�ɧ䤣�ӭ��u)"
		else
			name=rs("cusnc")
		end if
		rs.close
	end if
	%>
		<td><input type="text" name="key112"value="<%=dspKey(112)%>" <%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" size="8" maxlength="6" readonly class="dataListDATA" ID="Text8">
			<input type="BUTTON" id="B112" name="B112" style="Z-INDEX: 1"  value="...." onclick="Srdeveloperonclick()">
			<IMG SRC="/WEBAP/IMAGE/IMGDELETE.GIF" <%=fieldpb%> alt="�M��" id="C112" name="C112" style="Z-INDEX: 1" border=0 onmouseover="ImageIconOver" onmouseout="ImageIconOut"  onclick="SrClear">
			<font size=2><%=name%></font>
		</td>

	</tr>
    <tr><td width="10%" class="dataListSEARCH" height="25">��b�N��</td>
        <td width="18%" height="25" bgcolor="silver"> 
        <input type="text" name="key27" size="10" maxlength="10" readonly value="<%=dspkey(27)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" ID="Text13">
        #<input type="text" name="key92" size="3" maxlength="3" readonly value="<%=dspkey(92)%>" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" ID="Text14"></td> 
        <td width="10%" class="dataListSEARCH" height="25">�Τ�IP</td>
        <td width="18%"  height="25" bgcolor="silver"> 
        <input type="text" name="key93" size="20" maxlength="19"  value="<%=dspkey(93)%>"<%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListentry" ID="Text15"></td>
		<%
		If accessMode="A" Then
			Set rsc=Server.CreateObject("ADODB.Recordset")
			cusidxx="E" & right("00" & trim(datePART("yyyy",NOW())),2) & right("00" & trim(datePART("m",NOW())),2)& right("00" & trim(datePART("d",NOW())),2)
			rsc.open "select max(applyno) AS applyno from RTSparqAdslCust where cusid <>'' " ,conn
			if len(rsc("applyno")) > 0 then
				dspkey(113)=cusidxx & right("0000" & cstr(cint(right(rsc("applyno"),4)) + 1),4)
			else
				dspkey(113)=cusidxx & "0001"
			end if
			rsc.close
		End if
		%>
		<td width="15%" class=dataListHEAD>�ӽЮѽs��</td>
    	<td width="35%"  bgcolor="silver" >
        <input type="text" name="key113" <%=fieldpa%><%=fieldRole(1)%><%=dataProtect%> style="text-align:left;" maxlength="11"
               value="<%=dspKey(113)%>" readonly size="15" class=dataListdata ID="Text22">
		</td>
	</TR>

    <tr>
        <td width="10%" class="dataListHead" height="25">HomePNA Port</td>       
        <td width="18%" height="25" bgcolor="silver"><input type="text" name="key94" size="15" maxlength="15" value="<%=dspkey(94)%>" <%=dataProtect%> class="dataListentry" ID="Text9"></td>
        <td width="10%" class="dataListHead" height="25">MDF���X1</td>       
        <td width="17%" height="25" bgcolor="silver"><input type="text" name="key110" size="10" maxlength="10" value="<%=dspkey(110)%>" <%=dataProtect%> class="dataListentry" ID="Text10"></td>
        <td width="10%" class="dataListHead" height="25">MDF���X2</td>       
        <td width="18%" height="25" bgcolor="silver"><input type="text" name="key111" size="10" maxlength="10" value="<%=dspkey(111)%>" <%=dataProtect%> class="dataListentry" ID="Text12"></td>
	</tr>

	<tr><td class="dataListHead">�����ӽФ�</td>                     
		<td bgcolor="silver">
			<input type="text" name="key78" size="10" value="<%=dspKey(78)%>"  <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%> class="dataListEntry" maxlength="10" ID="Text16">
			<input type="button" id="B78"  name="B78" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpc%>>
		</td> 
        <td class="dataListHead"  height="34"><FONT size=2>�e����</FONT></td>                                 
        <td height="34" bgcolor="silver">
			<input type="text" name="key79" size="10" value="<%=dspKey(79)%>" maxlength="10" <%=fieldpg%><%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Text17">
			<input type="button" id="B79"  name="B79" height="100%" width="100%" style="Z-INDEX: 1" value="...."  <%=fieldpc%>>
		</td>
	</tr>

      <tr>                       
        <td  class="dataListHead">���u���</td>                    
        <td  bgcolor="silver">
          <input type="text" name="key46" size="10" value="<%=dspKey(46)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" ID="Text1"></td>                     
        <td  class="dataListHead">�������</td>   
        <td  bgcolor="silver">                  
         <input type="text" name="key47" size="10" readonly value="<%=dspKey(47)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListdata" maxlength="10" ID="Text5">
        <td  class="dataListHead">�h�����</td>                     
        <td  bgcolor="silver">
        <input type="text" name="key51" size="10" value="<%=dspKey(51)%>"  <%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10" ID="Text35">
          <input type="button" id="B51"  name="B51" height="100%" width="100%" style="Z-INDEX: 1" value="...." ONCLICK="SRBTNONCLICK">
           ���J<input type="text" name="key98" size="1" maxlength="1" value="<%=dspkey(98)%>" <%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry" ID="Text36">
        <!-- ���}��,10�멳�ɦA��
          <input type="text" name="key51" size="10" value="<%=dspKey(51)%>" <%=fieldPa%><%=fieldPb%> <%=fieldRole(1)%><%=dataProtect%> class="dataListentry" maxlength="10" >
          <input type="button" id="B51"  name="B51" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>
           ���J<input type="text" name="key98" size="1" maxlength="1" value="<%=dspkey(98)%>" <%=fieldPa%><%=fieldPb%><%=fieldRole(1)%> <%=dataProtect%> class="dataListEntry" ID="Text1">
           --></td>                   
      </tr>                                     

	<tr><td class="dataListHEAD" height="23">�䥦��ײ�����O</td>               
		<%
			s=""
			sx=" selected "
			If (sw="E" Or (accessMode="A" And sw="") or (sw="S" and formvalid=false)) And protect<1  AND len(trim(DSPKEY(89))) = 0  Then  
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H8' " 
			If len(trim(dspkey(99))) < 1 Then
				sx=" selected " 
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			else
				s=s & "<option value=""""" & sx & "></option>"  
				sx=""
			end if     
			Else
			sql="SELECT CODE,CODENC FROM RTCODE WHERE KIND='H8' AND CODE='" & dspkey(99) & "'"
			End If
			rs.Open sql,conn
			Do While Not rs.Eof
			If rs("CODE")=dspkey(99) Then sx=" selected "
			s=s &"<option value=""" &rs("CODE") &"""" &sx &">" &rs("CODENC") &"</option>"
			rs.MoveNext
			sx=""
			Loop
			rs.Close
		%>         
		<td height="23" bgcolor="silver" >
			<select size="1" name="key99" <%=fieldpa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" ID="Select14">                                                                  
					<%=s%>
			</select>
        </td>     

		<td WIDTH="10%"  class="dataListHEAD" height="23">�ݲ��J�D�u�Ǹ�</td>               
        <% 
			TCOMN=""
            IF LEN(TRIM(DSPKEY(104))) > 0 AND ISNUMERIC(DSPKEY(104)) THEN
              SQLXX="SELECT COMN FROM RTSPARQADSLCMTY WHERE CUTYID=" & DSPKEY(104)
              RS.OPEN SQLXX,CONN
              IF RS.EOF THEN
                 TCOMN=""
              ELSE
                 TCOMN=RS("COMN")
              END IF
              RS.CLOSE
           END IF
        %>
        <td height="23" bgcolor="silver" COLSPAN=3>
             <input type="text" name="key104" size="5" class="dataListENTRY" value="<%=dspKey(104)%>" ID="Text6"><%=TCOMN%>
        </td>                       
      </tr>
               
      <tr>                                 
        <td  class="dataListHead" height="23">��J�H��</td>                                 
        <td  height="23" bgcolor="silver" >
			<input type="text" name="key36" size="10" class="dataListData" value="<%=dspKey(36)%>" readonly ID="Text21"><%=EusrNc%></td>
        <td  class="dataListHead" height="23">��J���</td>                                 
        <td  colspan="3" height="23" bgcolor="silver"><input type="text" name="key37" size="25" class="dataListData" value="<%=dspKey(37)%>" readonly ID="Text23"></td>
      </tr>                                 
      <tr>                                 
        <td  class="dataListHead" height="23">���ʤH��</td>                                 
        <td  height="23" bgcolor="silver" >
			<input type="text" name="key38" size="10" class="dataListData" value="<%=dspKey(38)%>" readonly ><%=UUsrNc%></td>                                 
        <td  class="dataListHead" height="23">���ʤ��</td>                                 
        <td  colspan="3" height="23" bgcolor="silver"><input type="text" name="key39" size="25" class="dataListData" value="<%=dspKey(39)%>" readonly ></td>                                
      </tr>



    <table border="1" width="100%" cellpadding="0" cellspacing="0" id="tag2" style="display: none">                           
      <tr>                         
        <td  class="dataListHead">�q���o�]���</td>                     
        <td  colspan="1" bgcolor="silver">
          <input type="text" name="key41" size="10" value="<%=dspKey(41)%>" readonly <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%> class="dataListdata" maxlength="10"></td>                                               
        <td  class="dataListHead">�o�]���</td>                     
        <td  colspan="1" bgcolor="silver" colspan=3>
          <input type="text" name="key42" size="10" value="<%=dspKey(42)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%> class="dataListEntry" maxlength="10">
          <input type="button" id="B42"  name="B42" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>          </td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�w�˪�帹</td>                    
        <td  bgcolor="silver"><input type="text" name="key43" size="10" class="dataListData" value="<%=dspKey(43)%>" readonly></td>                     
        <td  class="dataListHead">�w�˪�C�L��</td>                     
        <td  bgcolor="silver"><input type="text" name="key44" size="10" class="dataListData" value="<%=dspKey(44)%>" readonly></td>                     
        <td  class="dataListHead">�C�L�H��</td>                     
        <td  bgcolor="silver"><input type="text" name="key45" size="10" class="dataListData" value="<%=dspKey(45)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�������B</td>                    
        <td  bgcolor="silver">
          <input type="text" name="key49" size="10" value="<%=dspKey(49)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10"></td>                     
        <td  class="dataListHead">�J�b���</td>                     
        <td colspan=3>
          <input type="text" name="key48" size="10" value="<%=dspKey(48)%>"   class="dataListdata" readonly maxlength="10" ID="Text18">
          <input type="button" id="B48"  name="B48" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>

      <tr>                       
        <td  class="dataListHead">���ڪ�帹</td>                    
        <td  bgcolor="silver"><input type="text" name="key52" size="10" class="dataListData" value="<%=dspKey(52)%>" readonly></td>                     
        <td  class="dataListHead">�C�L�H��</td>                     
        <td  bgcolor="silver"><input type="text" name="key53" size="10" class="dataListData" value="<%=dspKey(53)%>" readonly></td>                     
        <td  class="dataListHead">���ڤ��</td>                     
        <td  bgcolor="silver">
         <input type="text" name="key54" size="10" value="<%=dspKey(54)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%>  class="dataListEntry" maxlength="10">
          <input type="button" id="B54"  name="B54" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>></td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�]�Ȧ��ڽT�{��</td>                    
        <td  bgcolor="silver"><input type="text" name="key55" size="10" class="dataListData" value="<%=dspKey(55)%>" readonly></td>                     
        <td  class="dataListHead">�]�ȽT�{�H��</td>                     
        <td  bgcolor="silver"><input type="text" name="key56" size="10" class="dataListData" value="<%=dspKey(56)%>" readonly></td>                     
        <td  class="dataListHead">�����p����</td>                     
        <td  bgcolor="silver">
          <input type="text" name="key57" size="10" value="<%=dspKey(57)%>" readonly  class="dataListdata" maxlength="10"></td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�M�P��]����</td>                    
        <td  colspan="5" bgcolor="silver">
          <input type="text" name="key58" size="70" value="<%=dspKey(58)%>" <%=dataProtect%> class="dataListEntry" maxlength="50"></td>
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�����u��]</td>                    
        <td  colspan="5" bgcolor="silver">
          <input type="text" name="key59" size="70" value="<%=dspKey(59)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="50"></td>                     
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�I�ڪ�帹</td>                    
        <td  bgcolor="silver"><input type="text" name="key60" size="10" class="dataListData" value="<%=dspKey(60)%>" readonly></td>                     
        <td  class="dataListHead">�I�ڪ���</td>                     
        <td  bgcolor="silver"><input type="text" name="key61" size="10" class="dataListData" value="<%=dspKey(61)%>" readonly></td>                     
        <td  class="dataListHead">�C�L�H��</td>                     
        <td  bgcolor="silver"><input type="text" name="key62" size="10" class="dataListData" value="<%=dspKey(62)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�I�ڷ|�p�f�ֽT�{��</td>                    
        <td  bgcolor="silver"><input type="text" name="key63" size="10" class="dataListData" value="<%=dspKey(63)%>" readonly></td>                     
        <td  class="dataListHead">�|�p�f�֤H��</td>                     
        <td  bgcolor="silver"><input type="text" name="key64" size="10" class="dataListData" value="<%=dspKey(64)%>" readonly></td>                     
        <td  class="dataListHead">���׽X</td>                     
        <td  bgcolor="silver"><input type="text" name="key65" size="10" class="dataListData" value="<%=dspKey(65)%>" readonly></td>                   
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�I�u���ҥN�X</td>                    
        <td  bgcolor="silver">
        <%
    If (sw="E" Or (accessMode="A" And sw="")) And Len(Trim(fieldPa  &FIELDROLE(1) &dataProtect))<1 and len(trim(dspkey(89)))=0 Then 
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='C4' " 
    Else
       sql="SELECT code, codenc " _
          &"FROM RTcode where kind='C4' and code='" &dspKey(67) &"' "
    End If
    rs.Open sql,conn
    s=""
    If rs.Eof Then s="<option value="""" selected>&nbsp;</option>"
    sx=""
    Do While Not rs.Eof
       If rs("code")=dspKey(67) Then sx=" selected "
       s=s &"<option value=""" &rs("code") &"""" &sx &">" &rs("codenc") &"</option>"
       rs.MoveNext
       sx=""
    Loop
    rs.Close
%>
        <select name="key67" <%=FIELDROLE(1)%><%=dataProtect%><%=fieldpg%><%=fieldPa%> size="1"    
               style="text-align:left;" maxlength="8" class="dataListEntry"><%=s%></select>

        <td  class="dataListHead">�w�˭����O</td>
<%' if userlevel=1 then
  '    aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��")      
  '    aryOptionV=Array("0","1","2")
  ' elseif userlevel=4 then
  '    aryOption=Array("","�޳N���w��","�o�]")
  '    aryOptionV=Array("0","2","3")
  ' elseif userlevel=31 then
      aryOption=Array("","�~�Ȧۦ�w��","�޳N���w��","�o�]")
      aryOptionV=Array("0","1","2","3")   
  ' end if
   s=""
   If Len(Trim(fieldPa &fieldRole(1) &dataProtect)) > 0 or len(trim(dspkey(89)))> 0 Then
      s="<option value=""" &dspKey(68) &""">" &aryOption(dspKey(68)) &"</option>"
      SXX=""
   Else
      For i = 0 To Ubound(aryOption)
          If dspKey(68)=aryOptionV(i) Then
             sx=" selected "
          Else
             sx=""
          End If
          s=s &"<option value=""" &aryOptionV(i) &"""" &sx &">" &aryOption(i) &"</option>"
      Next
      sxx=" onclick=""SrAddUsr()"" "
   End If%>                    
        <td  bgcolor="silver" colspan=3><select size="1" onChange="Srpay()" name="key68" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry">
          <%=s%></select></td>                     

      </tr>                                     
      <tr>            
        <td  class="dataListHead">�w�w�˾����</td>                    
        <td  bgcolor="silver">
          <input type="text" name="key70" size="10" value="<%=dspKey(70)%>" <%=fieldpg%><%=fieldPa%><%=fieldRole(1)%><%=dataProtect%> class="dataListEntry" maxlength="10">
          <input type="button" id="B70"  name="B70" height="100%" width="100%" style="Z-INDEX: 1" value="...." <%=fieldpc%>>
		</td>
      </tr>

      <tr>                       
        <td  class="dataListHead">�зǬI�u�O</td>                    
        <td  bgcolor="silver">
        <input type="text" name="key73" size="10" class="dataListData" value="<%=dspKey(73)%>" readonly ></td>                     
        <td  class="dataListHead">�I�u�ɧU�O</td>                     
        <td  bgcolor="silver">
        <input type="text" name="key74" size="10" value="<%=dspKey(74)%>" <%=fieldpg%><%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="15"></td>                     
        <td  colspan="2">�@</td>                     
      </tr>                                     
      <tr>                       
        <td  class="dataListHead">�I�u�ɧU�O����</td>                    
        <td  colspan="5" bgcolor="silver">
          <input type="text" name="key75" size="70" value="<%=dspKey(75)%>" <%=fieldPa%><%=FIELDROLE(1)%><%=dataProtect%> class="dataListEntry" maxlength="25"></td>                     
      </tr>                                     
    </table>
<table width="100%"><tr><td width="100%">&nbsp;</td></tr>                                                                                                   
  </div>                               
<%
	conn.Close   
	set rs=Nothing   
	set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrReadExtDB()
    Dim conn,rs
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn
    extDB(0)=rs("CusNC")
   ' extDB(1)=rs("CutID1")
   ' extDB(2)=rs("TownShip1")
   ' extDB(3)=rs("RAddr1")
   ' extDB(4)=rs("RZone1")
   ' extDB(5)=rs("CutID2")
   ' extDB(6)=rs("TownShip2")
   ' extDB(7)=rs("RAddr2")
   ' extDB(8)=rs("RZone2")
    rs.Close
    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
Sub SrSaveExtDB(Smode)
    Dim conn,rs
' Smode A:add U:update
' extDBField = n
' use extDB(i) for Screen ,and map it to DataBase
'
    Set conn=Server.CreateObject("ADODB.Connection")
    conn.open DSN
    Set rs=Server.CreateObject("ADODB.Recordset")
'------ RTObj ---------------------------------------------------
    rs.Open "SELECT * FROM RTObj WHERE CusID='" &dspKey(1) &"' ",conn,3,3
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
       End If
    End If

    rs("CusNC")=extDB(0)
    rs("ShortNC")=Left(extDB(0),5)
   ' rs("CutID1")=extDB(1)
   ' rs("TownShip1")=extDB(2)
   ' rs("RAddr1")=extDB(3)
   ' rs("RZone1")=extDB(4)
   ' rs("CutID2")=extDB(5)
   ' rs("TownShip2")=extDB(6)
   ' rs("RAddr2")=extDB(7)
   ' rs("RZone2")=extDB(8)
    rs("Eusr")=""
    rs("Edat")=now()
    rs("Uusr")=""
    rs("Udat")=now()
    rs.Update
    rs.Close
'------ RTObjLink -----------------------------------------------
    rs.Open "SELECT * FROM RTObjLink WHERE CustYID='05' AND CusID='" &dspKey(1) &"' ",conn,3,3
    'Response.Write RS.EOF
    If rs.Eof Or rs.Bof Then
       If Smode="A" Then
          rs.AddNew
          rs("CusID")=dspKey(1)
          rs("CustYID")="05"
       End If
    End If
    rs("Eusr")=""
    rs("Edat")=now()
    rs("Uusr")=""
    rs("Udat")=now()
    rs.Update
    rs.Close

    conn.Close
    Set rs=Nothing
    Set conn=Nothing
End Sub
' -------------------------------------------------------------------------------------------- 
%>
<!-- #include virtual="/Webap/include/checkid.inc" -->
<!-- #include virtual="/Webap/include/companyid.inc" -->
<!-- #include virtual="/Webap/include/employeeref.inc" -->
<!-- #include file="RTGetUserRight.inc" -->
<!-- #include virtual="/Webap/include/RTGetUserLevel.inc" -->
<!-- #include file="RTGetCmtyDesc.inc" -->
