<%
'--------------------------------------------------
'���~�����J
'CheckID(Request("ID")) = "True"  �q�L�ˬd
'CheckID(Request("ID")) = "False" ���X�k���Τ@�s��
Function ValidBID(bid)
  dim n(8)

  If (Len(bid) <> 8) Then
     ValidBid = False
     Exit Function
  End If
  for i = 1 to 8
    ch = Mid(bid,i,1)
    If (ch<"0" or ch>"9") Then
       ValidBID = False
       Exit Function
    End If
  next
  for i = 1 to 8
    n(i) = ASC(Mid(bid,i,1))-48   '�N�r���ର�Ʀr
  next
 '�v�Ƭ�1�����������ۥ[
  wt = n(1) + n(3) + n(5) + n(8)
 '�p���v��
  n(2) = n(2) * 2
  n(2) = Int(n(2)/10) + n(2) Mod 10
  n(4) = n(4) * 2
  n(4) = Int(n(4)/10) + n(4) Mod 10
  n(6) = n(6) * 2
  n(6) = Int(n(6)/10) + n(6) Mod 10
  n(7) = n(7) * 4
  n(7) = Int(n(7)/10) + n(7) Mod 10
  wt = wt + n(2) + n(4) + n(6) + n(7)
 '��Q10�㰣�N�����T
  if wt Mod 10 = 0 Then
     ValidBID = True
  Else 
    '���p��Q�Ʒ~�Τ@�s����7�쬰"7"
     If Mid(bid,7,1)="7" Then
        wt = wt - n(7) + Int(n(7)/10)  '���s�p��[�v��
        if wt Mod 10 = 0 Then          '�Y��Q10�㰣�A�N�����T
           ValidBID = True
        Else
           ValidBID = False            '�_�h���~
        End If
     Else
        ValidBID = False
     End If
  End If 
End Function
%> 