<%
key=split(request("key"),";")
opt=key(2)
comq1=key(0)
lineq1=key(1)
'call SrGetCMTYLINERef (rtnvalue,opt,comq1,lineq1)
'Function SrGetCMTYLINERef(RTNValue,OPT,COMQ1,LINEQ1)
'-----------------------------------------------------------------
'    RTNValue=�^�ǭ�
'      OPT   =���涵��
'      COMQ1 =�ǤJ�Ѽ�1(���ϧǸ�)
'      LINEQ1=�ǤJ�Ѽ�2(�D�u�Ǹ�) 
'-----------------------------------------------------------------
'      OPT=1:�����s���ϤΥD�u����
'            (A)���ϤΥD�u�O�_�s�b ==> ���s�b�����ϤΥD�u���i�Q���J�u��
'            (B)���ϥD�u�O�_�w���q ==> �Y�����q�D�u�h�����\�A�Q���J�u��
'-----------------------------------------------------------------------
'      rtnvalue=�������ҥ��ѮɡA�^��
'            (A)���ϸ�Ƥ��s�b
'            (B)�D�u��Ƥ��s�b
'            (C)���ϤΥD�u��ƬҤ��s�b
'            (D)���ϥD�u�w���q�A���i�A�Q���J�u��
'            (E)�s���ϥD�u�w�Q�䥦�u�����J�A���i���ƦA�Q���J�u��
'            (F)�s���ϥD�u�w�@�o�A���i���J�u��
'            (G)�s���ϥD�u�w�M�u�A���i���J�u��
'            (H)�s���ϥD�u�w�ӽСA���i���J�u��
'            (�䥦)�^�Ƿs�D�u������� 
'           
'-----------------------------------------------------------------
 rtnvalue=""
 IF OPT = 1 THEN
      set conn=server.CreateObject("ADODB.Connection")
      set rs=server.CreateObject("ADODB.recordset")
      DSN="DSN=RTlib"
      Conn.Open DSN
      '�ˬd�s����
      SQL="SELECT * from rtebtcmtyh where comq1=" & comq1 
      Rs.Open SQL,DSN,1,1
      if rs.eof then
         RTNVALUE= "A"
      ELSE
         COMN=RS("COMN")
      end if
      Rs.Close
      '�ˬd�s�D�u
      SQL="SELECT * from rtebtcmtyLINE where comq1=" & comq1 & " AND LINEQ1=" & LINEQ1
      Rs.Open SQL,DSN,1,1
      if rs.eof then
         '�s���Ϥηs�D�u���s�b��
         IF RTNVALUE="A" THEN
            RTNVALUE= "C"
         '�s���Ϧs�b���s�D�u���s�b��
         ELSE
            RTNVALUE= "B"
         END IF
      ELSE
         '�ˬd�s���ϥD�u�O�_�w���q ==> ���q���D�u���i�A�Q���J�u��
         IF NOT ISNULL(RS("ADSLAPPLYDAT")) THEN
            RTNVALUE="D"
         '�ˬd�s���ϥD�u�O�_�w���q ==> ���q���D�u���i�A�Q���J�u��
         ELSEIF NOT ISNULL(RS("UPDEBTCHKDAT")) THEN
            RTNVALUE="H"            
         '�ˬd�s���ϥD�u�O�_���w�M�u����
         ELSEIF NOT ISNULL(RS("DROPDAT")) THEN
            RTNVALUE="G"
         '�ˬd�s���ϥD�u�O�_���w�@�o����
         ELSEIF NOT ISNULL(RS("CANCELDAT")) THEN   
            RTNVALUE="F"
         '�ˬd�s���ϥD�u�O�_�w�Q�䥦�u�����J���|�����q
         ELSEIF RS("MOVEFROMCOMQ1") > 0 OR RS("MOVEFROMLINEQ1") > 0 THEN
            RTNVALUE="E" & ";" & RS("MOVEFROMCOMQ1") & ";" & RS("MOVEFROMLINEQ1")
         END IF
      end if
     
      '��RTNVALUE="" ��ܱ���ŦX�A�i�i�沾�J�@�~
      IF RTNVALUE="" THEN
         RTNVALUE=COMN & ";" & rs("COBOSS") & ";" & rs("COid") & ";" & rs("COBOSSENG") & ";" & rs("COBOSSID") & ";" _
                 & rs("APPLYNAMEC") & ";" & rs("APPLYNAMEe") & ";" & RS("CUTID") & ";" & rs("TOWNSHIP") & ";" & rs("VILLAGE") & ";" _
                 & RS("COD1") & ";" & rs("NEIGHBOR") & ";" & RS("COD2")  & ";" & rs("STREET") & ";" & RS("COD3") & ";" & rs("SEC") & ";" _
                 & RS("COD4") & ";" & rs("LANE") & ";" & RS("COD5") & ";" & rs("RZONE") & ";" & rs("ALLEYWAY") & ";" & RS("COD7") & ";" _
                 & rs("NUM") & ";" & RS("COD8") & ";" & rs("floor") & ";" & RS("COD9") & ";" & rs("room") & ";" & RS("COD10") & ";" _
                 & rs("ADDROTHER") & ";" & rs("TELCOMROOM") & ";" & rs("SUPPLYRANGE") & ";" & RS("CUTID1") & ";" & rs("TOWNSHIP1") & ";" _
                 & rs("RADDR1") & ";" & rs("rzone1") & ";" & rs("ENGADDR") & ";" & RS("CUTID2") & ";" & rs("TOWNSHIP2") & ";" _
                 & rs("RADDR2") & ";" & rs("rzone2") & ";" & rs("contact1") & ";" & rs("contact2") & ";" & rs("CONTACTTEL") & ";" _
                 & rs("CONTACTMOBILE") & ";" & rs("CONTACTEMAIL") & ";" & rs("TECHCONTACT") & ";" & rs("CONTACTTIME1") & ";" _
                 & rs("TECHENGNAME") & ";" & rs("CONTACTSTRTIME") & ";" & rs("CONTACTENDTIME") & ";" & rs("CONTACTTIME2") & ";" _
                 & rs("linerate") & ";" & rs("LINETEL") 
      END IF
      Rs.Close
      Conn.Close
      Set Rs=Nothing
      Set Conn=Nothing

 
 End IF
'End Function
%>
<HTML>
<HEAD>
<META name=VI60_DTCScriptingPlatform content="Server (ASP)">
<META name=VI60_defaultClientScript content=VBScript>
<meta http-equiv=Content-Type content="text/html; charset=Big5">
</HEAD>
<BODY style="BACKGROUND: lightblue">
<SCRIPT LANGUAGE="VBScript">
  Sub window_onload()
      returnvalue=document.all("KEYXX").value 
      window.close 
  End Sub
</SCRIPT>
<form>
<input type="text" name="KEYXX" style=display:none value="<%=RTNVALUE%>" ID="Text1">
</form>
</BODY>

</HTML>
