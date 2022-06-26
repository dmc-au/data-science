Attribute VB_Name = "ClassPlay"
Sub CreateEmployee()
    Dim anEmployee As CEmployee
    
    Set anEmployee = New CEmployee
    
    With anEmployee
        .Name = "John"
        .Address = "123 whatever"
        .Salary = 15000
    End With
    
    MsgBox (anEmployee.Name & " " & anEmployee.Address & " " & anEmployee.Salary)
End Sub
