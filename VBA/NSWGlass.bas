Attribute VB_Name = "NSWGlass"
Sub NSWChangeDescript()
    Dim i, x, SheetCount, token, RowCount As Integer
    Dim StartSheet As Long
    Dim StartRow As Long
    
    SheetCount = ActiveWorkbook.Sheets.count
    RowCount = 250
    StartSheet = 5
    StartRow = 10
    
    'For all worksheets: If the worksheet name not contain PB or int, set the vlookup formulas based on if sheet has its own PB
    For x = StartSheet To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            If InStr(Worksheets(x).Name, " int") = False Then
                
                'Write in the vlookups for Annealed
                For i = StartRow To 120
                    Worksheets(x).Range("E" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A:$E,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D:$D,0),1)"
                    Worksheets(x).Range("F" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A:$E,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D:$D,0),2)"
                    Worksheets(x).Range("G" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A:$E,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D:$D,0),3)"
                Next i
                'Write in the vlookups from Toughened down
                For i = 121 To RowCount
                    Worksheets(x).Range("E" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A81:$E200,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D81:$D200,0),1)"
                    Worksheets(x).Range("F" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A81:$E200,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D81:$D200,0),2)"
                    Worksheets(x).Range("G" & i).Formula = "=INDEX([CTSPL_INDEX.xlsx]Correl!$A81:$E200,MATCH(H" & i & ",[CTSPL_INDEX.xlsx]Correl!$D81:$D200,0),3)"
                Next i
            End If
        End If
    Next x
    
    Call NSWCleanItems(StartSheet, SheetCount, StartRow, RowCount)
End Sub
Sub NSWCleanItems(ByVal StartSheet As Long, ByVal SheetCount As Long _
                , ByVal StartRow As Long, ByVal RowCount As Long)
    Dim i, x, y As Integer
    Dim cell As Range
    
    On Error Resume Next
    
    For x = StartSheet To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            If InStr(Worksheets(x).Name, "int") = False Then
                For i = StartRow To RowCount
                    For y = 5 To 7
                        Set cell = ActiveWorkbook.Worksheets(x).Cells(i, y)
                        
                        'Conditions for final update of cells
                        If WorksheetFunction.IsNA(cell) Then
                            cell.ClearContents
                        End If
                        If cell.Value = 0 Then
                            cell.ClearContents
                        End If
                        If WorksheetFunction.IsNumber(cell.Value) Then
                            cell.Value = cell.Value
                        End If
                    Next y
                Next i
            End If
        End If
    Next x
End Sub
Sub NSWChangePrice()
    Dim i, x, SheetCount As Integer
    Dim sheet As Worksheet
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    For x = 5 To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            For i = 6 To 200
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = "=VLOOKUP(E" & i & ",'PB_" & Worksheets(x).Name & "'!$A:$E,5,FALSE)"
                End If
            Next i
            For i = 201 To 300
                If Worksheets(x).Range("N" & i).HasFormula Then
                    Worksheets(x).Range("N" & i).Formula = "=VLOOKUP(E" & i & ",'PB_" & Worksheets(x).Name & "'!$A:$E,5,FALSE)"
                End If
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = "=VLOOKUP(F" & i & ",'PB_" & Worksheets(x).Name & "'!$A:$E,5,FALSE)"
                End If
                If Worksheets(x).Range("P" & i).HasFormula Then
                    Worksheets(x).Range("P" & i).Formula = "=VLOOKUP(G" & i & ",'PB_" & Worksheets(x).Name & "'!$A:$E,5,FALSE)"
                End If
            Next i
        End If
    Next x
End Sub
Sub NSWMatchPBList()
    Dim i As Long
    Dim x As Long
    Dim y As Long
    Dim Coin As Long
    
    y = 2
    Coin = 0
    
    For i = 2 To 160
        For x = 2 To 127
            Debug.Print Range("A" & i).Value
            Debug.Print Range("B" & x).Value
            
            If Range("A" & i).Value = Range("B" & x).Value Then
                Coin = 1
                Exit For
            End If
        Next x
        If Coin < 1 Then
            Range("D" & y).Value = Range("A" & i).Value
            y = y + 1
        End If
    Next i
End Sub
Sub NSWFindUnique()
    Dim i As Long
    Dim x As Long
    Dim y As Long
    Dim Coin As Long
    Dim Column1 As Variant
    Dim Column2 As Variant
    
    y = 2
    Coin = 0
    
    For i = 2 To 193
        Coin = 0
        Column1 = Range("A" & i).Value
        
        For x = 2 To 172
            Column2 = Range("D" & x).Value
            
            Debug.Print Column1
            Debug.Print Column2
            
            If InStr(Column1, Column2) > 1 Then
                Coin = 1
                Exit For
            End If
        Next x
        
        If Coin <> 1 Then
            Range("F" & y).Value = Column1
            y = y + 1
        End If
    Next i
End Sub
