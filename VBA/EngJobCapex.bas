Attribute VB_Name = "EngJobCapex"
Sub GetCapex()
    Dim x As Integer
    Dim i As Integer
    Dim y As Integer
    Dim SusSheet As Worksheet
    Dim SusBook As Workbook
    Dim cell As Range
    Dim cell2 As Range
    Dim JobCount As Double
    Dim CapexCount As Double
    Dim Cap14 As Workbook
    Dim Cap15 As Workbook
    Dim Cap16 As Workbook
    Dim NumBooks As Double
    Dim token As String
    Dim Token2 As String
    
    'For each Range value in column I of active worksheet:
    'Check if that value exists in Column B of every sheet in capex14,15,16
    'If it does, set Range value to Hyperlink column value
    'Move to next range value
    
    'Activates current worksheet
    
    
    'Set up current sheet variables
    JobCount = Worksheets("Current Jobs 2016").UsedRange.Rows.count
    
    'Set up workbooks
    Set Cap14 = Workbooks.Open(Filename:="H:\fa\10\capexpapp14.xlsx", ReadOnly:="TRUE")
    Set Cap15 = Workbooks.Open(Filename:="H:\fa\10\capexpapp15.xlsx", ReadOnly:="TRUE")
    Set Cap16 = Workbooks.Open(Filename:="H:\fa\10\capexpapp16.xlsx", ReadOnly:="TRUE")
    
    NumBooks = 3
    
    For x = 2 To JobCount
        'For i = 1 To NumBooks
            CapexCount = Cap14.Worksheets("FY14").UsedRange.Rows.count
            For y = 2 To CapexCount
                Set cell = Workbooks("invwipadj16_TEST").Worksheets("Current Jobs 2016").Range("I" & x)
                Set cell2 = Cap14.Worksheets("FY14").Range("B" & y)
                If cell.Value = cell2.Value Then
                    cell.Range("J" & x).Value = "bla" 'cell2.Offset(0, 10).Value
                End If
            Next y
       ' Next i
    Next x
    
End Sub

Sub GetCapex2()

End Sub
