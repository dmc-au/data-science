Attribute VB_Name = "CheckForSuspects"
Sub CheckForSuspects()
    Dim SusSheet As Worksheet
    Dim cell As Range
    Dim i As Long
    Dim x As Long
    Dim SuspectCount As Long
    Dim SupplierCount As Long

    'Worksheet variable for brevity
    Set SusSheet = Worksheets("UsualSuspects")
    
    'Sets how many rows in current sheet there are to check
    SupplierCount = ActiveSheet.Range("A4", ActiveSheet.Range("A4").End(xlDown)).Rows.count
    MsgBox (SupplierCount)
    
    'Sets how many suspects there are
    SuspectCount = SusSheet.Range("A2", SusSheet.Range("A2").End(xlDown)).Rows.count
    
    'For each cell selected, check if it's a suspect; if it is, colour it's row yellow
    For x = 4 To SupplierCount
        For i = 2 To SuspectCount
            If cell("I" & x).Value = SusSheet.Range("A" & i).Value Then
                cell("I" & x).EntireRow.Select
                Selection.Style = "Neutral"
            End If
        Next i
    Next cell
End Sub
