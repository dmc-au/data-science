Attribute VB_Name = "QLDGlass"
Sub QLDChangeGeneric()
    Dim i, firstCol As Integer
    Dim cell As Range
    Dim col As Variant
    
    On Error Resume Next

    firstCol = InputBox("Generic: What column?")
    
        
    For Each cell In Selection
        If IsNumeric(cell.Value) Or cell.HasFormula Then
            If Not IsEmpty(cell.Value) Then
                'col = cell.Column
                Select Case firstCol
                    Case 3
                        cell.Formula = "=VLOOKUP(E" & cell.Row _
                        & ",'PB_MAJORFAB'!$A:$E,5,0)"
                    Case 2
                        cell.Formula = "=VLOOKUP(C" & cell.Row _
                        & ",'PB_MAJORFAB'!$A:$E,5,0)"
                    Case 1
                        cell.Formula = "=VLOOKUP(A" & cell.Row _
                        & ",'PB_MAJORFAB'!$A:$E,5,0)"
                    Case Else
                        Exit Sub
                End Select
            End If
        End If
    Next cell
End Sub

Sub QLDChangeSpecific()
    Dim i, firstCol As Integer
    Dim cell As Range
    Dim col As Variant
    
    On Error Resume Next

    firstCol = InputBox("Specific: What column?")
    
        
    For Each cell In Selection
        If IsNumeric(cell.Value) Or cell.HasFormula Then
            If Not IsEmpty(cell.Value) Then
                'col = cell.Column
                Select Case firstCol
                    Case 3
                        cell.Formula = "=VLOOKUP(E" & cell.Row _
                        & ",'PB_" & Mid(ActiveSheet.Name, 4, Len(ActiveSheet.Name)) & "'!$A:$E,5,0)"
                    Case 2
                        cell.Formula = "=VLOOKUP(C" & cell.Row _
                        & ",'PB_" & Mid(ActiveSheet.Name, 4, Len(ActiveSheet.Name)) & "'!$A:$E,5,0)"
                    Case 1
                        cell.Formula = "=VLOOKUP(A" & cell.Row _
                        & ",'PB_" & Mid(ActiveSheet.Name, 4, Len(ActiveSheet.Name)) & "'!$A:$E,5,0)"
                    Case Else
                        Exit Sub
                End Select
            End If
        End If
    Next cell
End Sub
Sub AAQLDPriceList()
    Dim sheet As Worksheet
    Dim CellCount As Integer
    
    CellCount = 18
    
    On Error Resume Next
    
    For i = 1 To CellCount
        Worksheets("Sheet1").Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PS " & Worksheets("Sheet1").Range("A" & i).Value
        Worksheets("Sheet1").Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PS " & Worksheets("Sheet1").Range("A" & i).Value & " int"
        Worksheets("Sheet1").Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PB_" & Worksheets("Sheet1").Range("A" & i).Value
    Next i
End Sub
Sub AACopyPriceList()
    Dim sheet As Worksheet
    Dim CellCount As Integer
    
    CellCount = 11
    
    On Error Resume Next
    
    For i = 1 To CellCount
        'For PS sheet
        Worksheets(Worksheets.count).Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PS " & Worksheets("Sheet1").Range("A" & i).Value
        
        'For int sheet
        Worksheets(Worksheets.count).Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PS " & Worksheets("Sheet1").Range("A" & i).Value & " int"
        
        'For PB sheet
        Worksheets(Worksheets.count).Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PB_" & Worksheets("Sheet1").Range("A" & i).Value
    Next i
End Sub
Sub ReturnToA1()
    Dim sheet As Worksheet
    
    For Each sheet In ActiveWorkbook.Worksheets
        If sheet.Visible Then
            sheet.Activate
            sheet.Range("A1").Select
        End If
    Next sheet
    ActiveWorkbook.Worksheets(1).Activate
End Sub
Function checkName(n As String) As Boolean
  For Each ws In Worksheets
    If ws.Name = n Then
      checkName = True
      Exit Function
    End If
  Next ws
End Function
Sub QLDChangeDescript()
    Dim i, x, SheetCount, token, RowCount As Integer
    Dim StartSheet As Long
    
    SheetCount = ActiveWorkbook.Sheets.count
    RowCount = 250
    StartSheet = 5
    
    'For all worksheets: If the worksheet name not contain PB or int, set the vlookup formulas based on if sheet has its own PB
    For x = StartSheet To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            If InStr(Worksheets(x).Name, " int") = False Then
            
                'Does the worksheet have its own PB?
                Select Case checkName("PB_" & Mid(Worksheets(x).Name, 4, Len(Worksheets(x).Name)))
                    Case True
                        token = x
                    Case False
                        token = 1
                End Select
                
                'Write in the vlookups
                For i = 20 To RowCount
                    Worksheets(x).Range("B" & i).Formula = "=VLOOKUP(A" & i & ",'PB_" & Mid(Worksheets(token).Name, 4, Len(Worksheets(token).Name)) & "'!$A:$B,2,FALSE)"
                    Worksheets(x).Range("D" & i).Formula = "=VLOOKUP(C" & i & ",'PB_" & Mid(Worksheets(token).Name, 4, Len(Worksheets(token).Name)) & "'!$A:$B,2,FALSE)"
                    Worksheets(x).Range("F" & i).Formula = "=VLOOKUP(E" & i & ",'PB_" & Mid(Worksheets(token).Name, 4, Len(Worksheets(token).Name)) & "'!$A:$B,2,FALSE)"
                Next i
            End If
        End If
    Next x
    
    Call QLDCleanItems(SheetCount, RowCount)
End Sub
Sub QLDCleanItems(ByVal SheetCount As Integer, ByVal RowCount As Integer)
    Dim i, x, y As Integer
    Dim cell As Range
    
    On Error Resume Next
    
    For x = 1 To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            If InStr(Worksheets(x).Name, "int") = False Then
                For i = 20 To RowCount
                    For y = 1 To 6
                        Set cell = ActiveWorkbook.Worksheets(x).Cells(i, y)
                        If WorksheetFunction.IsNA(cell) Then
                            cell.ClearContents
                        End If
                    Next y
                Next i
            End If
        End If
    Next x
    
End Sub
Sub MakeInt()
    Dim i As Long
    
    For i = 1 To 10
        If InStr(Worksheets(i).Name, "PB_") = False Then
            Worksheets(i).Copy after:=Worksheets(i)
            ActiveSheet.Name = Worksheets(i).Name & " int"
        End If
    Next i
End Sub

Sub CopyPbNames()
    Dim i, x, SheetCount As Long
    
    x = 1
    SheetCount = Worksheets.count
    
    For i = 1 To SheetCount
       If InStr(Worksheets(i).Name, "PB_") Then
           Worksheets(1).Range("A" & x).Value = Worksheets(i).Name
           x = x + 1
       End If
    Next i
End Sub

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
        If .SelectedItems.count = 0 Then
            MsgBox ("Operation cancelled")
        Else
            FolderLocation = .SelectedItems(1) & "\"
        End If
    End With
    
    CurrentBook = Application.ActiveWorkbook.Name
    SheetCount = Worksheets.count
    
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
