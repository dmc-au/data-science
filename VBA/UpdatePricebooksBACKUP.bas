Sub UpdatePricebooks()
    Dim file As Variant
    Dim FromBook As Variant
    Dim CurrentBook As Variant
    Dim FolderLocation As String
    Dim i As Long
    Dim SheetCount As Long
    
    Application.ScreenUpdating = False
    
    With Application.FileDialog(msoFileDialogFolderPicker)
        .Title = "Please select the folder that contains the pricebooks"
        .AllowMultiSelect = False
        .Show
        If .SelectedItems.Count = 0 Then
            MsgBox ("Operation cancelled")
        Else
            FolderLocation = .SelectedItems(1) & "\"
        End If
    End With
    
    CurrentBook = Application.ActiveWorkbook.Name
    SheetCount = Worksheets.Count
    
    For i = 1 To SheetCount
        If InStr(Worksheets(i).Name, "PB_") > 0 Then
            Debug.Print Worksheets(i).Name
            file = Dir(FolderLocation)
            Do While file <> ""
                If InStr(file, Worksheets(i).Name) > 0 Then
                    Debug.Print (FolderLocation & file)
                    Workbooks(CurrentBook).Worksheets(i).Cells.ClearContents
                    Set FromBook = Workbooks.Open(FolderLocation & file, ReadOnly:=True, CorruptLoad:=xlNormalLoad)
                    ActiveWorkbook.Worksheets(1).Cells.Copy Destination:=Workbooks(CurrentBook).Worksheets(i).Cells
                    Debug.Print "WORKBOOK: " & Workbooks(CurrentBook).Worksheets(i).Name & " updated"
                    Workbooks(FromBook.Name).Close
                    Exit Do
                End If
                file = Dir
            Loop
        End If
    Next i
    
    Application.ScreenUpdating = True
End Sub