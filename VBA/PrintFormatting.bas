Attribute VB_Name = "PrintFormatting"
Sub NSWFormatting()
    'Snippet: http://www.mrexcel.com/forum/excel-questions/83903-inserting-pictures-header.html
    'General: https://msdn.microsoft.com/en-us/library/office/ff196103.aspx
    '         https://msdn.microsoft.com/en-us/library/office/ff822794.aspx
    
    Dim SheetCount As Long
    Dim i As Long
    
    SheetCount = ActiveWorkbook.Worksheets.count
    
    For i = 5 To SheetCount
        If InStr(Worksheets(i).Name, "PB_") = False Then
            'Other formatting
            Worksheets(i).Range("O4").Value = "06/01/2016"
            Worksheets(i).Range("O5").Value = "05/01/2015"
            Worksheets(i).Rows("2:5").RowHeight = 15
            Worksheets(i).Rows("6:7").EntireRow.Hidden = True
            
            'Print properties
            With Worksheets(i).PageSetup
                With Worksheets(i).PageSetup.LeftHeaderPicture
                    .Filename = "U:\Documents\Pricelists\Logo.jpg"
                    .Height = 100
                    .Width = 150
                    '.Brightness = 0.36
                    .ColorType = msoPictureAutomatic
                    '.Contrast = 0.39
                    .CropBottom = 0
                    .CropLeft = 0
                    .CropRight = 0
                    .CropTop = 0
                End With
                .LeftHeader = "&G"
                
                .TopMargin = Application.InchesToPoints(1.25)
                .LeftMargin = Application.InchesToPoints(0.71)
                .RightMargin = Application.InchesToPoints(0.4) '(0.71)
                .BottomMargin = Application.InchesToPoints(0.55)
                .HeaderMargin = Application.InchesToPoints(0.51)
                .FooterMargin = Application.InchesToPoints(0.31)
                .FitToPagesTall = False
                .FitToPagesWide = False
            End With
        End If
    Next i
End Sub
Sub NSWFormattingColWidth()
    Dim SheetCount As Long
    Dim i As Long
    
    SheetCount = ActiveWorkbook.Worksheets.count
    
    For i = 5 To SheetCount
        If InStr(Worksheets(i).Name, "PB_") = False Then
            'Change column widths
            Worksheets(i).Columns("H:P").ColumnWidth = 9
            'Change print area
            Worksheets(i).PageSetup.PrintArea = "$H$1:$P$250"
        End If
    Next i
End Sub
Sub NSWPageBreak()
    Dim SheetCount As Long
    Dim i As Long
    Dim y As Long
    
    SheetCount = ActiveWorkbook.Worksheets.count
    
    For i = 5 To SheetCount
        If InStr(Worksheets(i).Name, "PB_") = False Then
            Worksheets(i).ResetAllPageBreaks
            For y = 10 To 250
'                If InStr(Worksheets(i).Range("H" & y).Value, "SILVERED FLOAT") > 0 Then
'                    Worksheets(i).Rows(y).PageBreak = xlPageBreakManual
'                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "Cont…") > 0 Then
                    Worksheets(i).Rows(y).PageBreak = xlPageBreakManual
                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "PATTERNLITE & ETCHED TOUGHENED") > 0 Then
                    Worksheets(i).Rows(y).PageBreak = xlPageBreakManual
                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "PATTERNLITE & ETCHLITE TOUGHENED") > 0 Then
                    Worksheets(i).Rows(y).PageBreak = xlPageBreakManual
                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "*NOTE : SPECIAL COLOURLITE") > 0 Then
                    Worksheets(i).Rows(y - 1).EntireRow.Hidden = True
                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "3. COLOUR MATCH FEE FOR NON") > 0 Then
                    Worksheets(i).Rows(y + 1).EntireRow.Hidden = True
                End If
                If InStr(Worksheets(i).Range("H" & y).Value, "*NOTE : MINIMUM CHARGE") > 0 Then
                    Worksheets(i).Rows(y + 1).PageBreak = xlPageBreakManual
                End If
            Next y
        End If
    Next i
End Sub
Sub NSWRemoveOldItemsComplex()
    'Method to remove unwanted lines from the pricesheets
    '1) User selects files
    '2) Workbooks are opened; rows are deleted from sheets if condition satisfied
    '3) Workbook copies are saved with new names
    '4) Workbook copies are closed
    '
    Application.ScreenUpdate = False
    Option Explicit
    
    Dim SheetCount As Long
    Dim x As Long
    Dim i As Long
    Dim y As Long
    Dim NumPLs As Long
    Dim cell As Range
    Dim UpdateBook As Workbook
    Dim StrLen As Long
    
    With Application.FileDialog(msoFileDialogFilePicker)
        .Title = "Please select the workbooks to update"
        .AllowMultiSelect = True
        .Show
        If .SelectedItems.count = 0 Then
            MsgBox ("Update cancelled")
        Else
            NumPLs = .SelectedItems.count
            
            For x = 1 To NumPLs
                Set UpdateBook = Workbooks.Open(.SelectedItems(x), _
                                    CorruptLoad:=xlNormalLoad, _
                                    UpdateLinks:=False)
        
                SheetCount = UpdateBook.Worksheets.count
                
                For i = 5 To SheetCount
                    If InStr(UpdateBook.Worksheets(i).Name, "PB_") = False Then
                        For y = 100 To 240
                            Set cell = UpdateBook.Worksheets(i).Range("H" & y)
                            If InStr(cell.Value, "TINTED GLASS PAINTED") > 0 _
                            Or InStr(cell.Value, "HOLES OVER 85MM DIA") > 0 Then
                               cell.EntireRow.Delete
                               y = y - 1
                            End If
                        Next y
                    End If
                Next i
                
                'Save copy and close workbook
                StrLen = Len(.SelectedItems(x))
                UpdateBook.SaveCopyAs (Mid(.SelectedItems(x), 1, StrLen - 5) _
                                    & "_updated.xlsb")
                UpdateBook.Close SaveChanges:=False
            Next x
        End If
    End With
    
    Application.ScreenUpdate = True
End Sub
