Attribute VB_Name = "CheckSus2"
Sub CheckSus2()
    Dim SusSheet As Worksheet
    Dim cell As Range
    Dim x As Long
    Dim i As Long
    Dim SuspectCount As Long
    Dim SupplierCount As Long
    
    'Sum of rows with values on sheet of interest
    SupplierCount = ActiveSheet.UsedRange.Rows.count
    MsgBox (SupplierCount)

    'Worksheet variable for brevity
    Set SusSheet = Worksheets("UsualSuspects")
    
    'Sets how many suspects there are
    SuspectCount = SusSheet.Range("A2", SusSheet.Range("A2").End(xlDown)).Rows.count
    MsgBox (SuspectCount)
    
    'For each cell selected, check if it's a suspect; if it is, colour it's row yellow
    For x = 4 To SupplierCount
        For i = 2 To SuspectCount
            Set cell = Range("I" & x)
            If cell.Value = SusSheet.Range("A" & i).Value Then
                cell.EntireRow.Select
                Selection.Style = "Neutral"
            End If
        Next i
    Next x
End Sub
Sub CheckAPSus()
    Dim SusSheet As Worksheet
    Dim cell As Range
    Dim x As Long
    Dim i As Long
    Dim SuspectCount As Long
    Dim SupplierCount As Long
    
    'Sum of rows with values on sheet of interest
    SupplierCount = ActiveSheet.UsedRange.Rows.count
    MsgBox (SupplierCount)

    'Worksheet variable for brevity
    Set SusSheet = Worksheets("UsualSuspects")
    
    'Sets how many suspects there are
    SuspectCount = SusSheet.Range("A2", SusSheet.Range("A2").End(xlDown)).Rows.count
    MsgBox (SuspectCount)
    
    'For each cell selected, check if it's a suspect; if it is, colour it's row yellow
    For x = 2 To SupplierCount
        For i = 2 To SuspectCount
            Set cell = Range("A" & x)
            If (cell.Value & " ") = SusSheet.Range("A" & i).Value Then
                cell.EntireRow.Select
                Selection.Style = "Neutral"
            End If
        Next i
    Next x
End Sub
