Attribute VB_Name = "FilterUnwanted"
Sub FilterAP()
    Dim SusSheet As Worksheet
    Dim cell As Range
    Dim x As Long
    Dim i As Long
    Dim SuspectCount As Long
    Dim SupplierCount As Long
    
    'Sum of rows with values on sheet of interest
    SupplierCount = ActiveSheet.UsedRange.Rows.count
    MsgBox ("Supplier count: " & SupplierCount)

    'Worksheet variable for brevity
    
    Set SusSheet = Worksheets("AP")
    
    'Sets how many suspects there are
    SuspectCount = 104
    MsgBox ("Supplier count: " & SupplierCount)
    
    'For each cell selected, check if it's a suspect; if it is, colour it's row yellow
    For x = 2 To SupplierCount
        For i = 2 To SuspectCount
            Set cell = Range("I" & x)
            If cell.Value = (SusSheet.Range("A" & i).Value & " ") Then
                cell.EntireRow.Hidden = True
            End If
        Next i
    Next x
End Sub
