VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CEmployee"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private pName As String
Private pAddress As String
Private pSalary As Double
'Name let and get
Public Property Get Name() As String
    Name = pName
End Property

Public Property Let Name(Value As String)
    pName = Value
End Property
'Address let and get
Public Property Get Address() As String
    Address = pAddress
End Property
Public Property Let Address(Value As String)
    pAddress = Value
End Property
'Salary let and get
Public Property Get Salary() As String
    Salary = pSalary
End Property
Public Property Let Salary(Value As String)
    If Value > 0 Then
        pSalary = Value
    Else
        MsgBox ("Please enter a salary figure greater than 0")
    End If
End Property

