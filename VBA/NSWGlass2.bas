Attribute VB_Name = "NSWGlass2"
Sub RemoveProtections()
    Dim count As Integer
    Dim i As Integer
    
    passbox = InputBox("password")
    
    count = ActiveWorkbook.Sheets.count
    
    For i = 1 To count
        ActiveWorkbook.Sheets(i).Unprotect Password:=passbox
    Next i
End Sub
Sub ChangeReference()
    Dim sheet As Worksheet
    Dim SheetCount As Integer
    Dim i As Integer
    Dim x As Long
    
    'Screen flicker off
    'Application.ScreenUpdating = False
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    'MsgBox (SheetCount)
        
    For i = 100 To 125
        'MsgBox (Sheets(i).Name)
        Application.Wait Now + TimeSerial(0, 0, 1)
        ActiveWorkbook.Worksheets(i).Activate
        For x = 2 To 244
            'If x = 2 Then
            '    Range("A1").Activate
            'End If
            Range("D" & x).Formula = "=VLOOKUP(A" & x & "," & "'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
            Range("E" & x).Formula = "=VLOOKUP(B" & x & "," & "'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
            Range("F" & x).Formula = "=VLOOKUP(C" & x & "," & "'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
        Next x
    Next i
End Sub
Sub ChangeRef2()
    Dim sheet As Worksheet
    Dim SheetCount As Integer
    Dim i As Integer
    
    'Screen flicker off
    'Application.ScreenUpdating = False
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    'MsgBox (SheetCount)
        
    For i = 5 To SheetCount
        'MsgBox (Sheets(i).Name)
        Application.Wait Now + TimeSerial(0, 0, 1)
        ActiveWorkbook.Worksheets(i).Activate
        
        'If x = 2 Then
        '    Range("A1").Activate
        'End If
        If InStr(Worksheets(i).Name, "PB_") = False Then
            For x = 2 To 244
                Range("D" & x).Formula = "=VLOOKUP(A" & x & ",'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
                Range("E" & x).Formula = "=VLOOKUP(B" & x & ",'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
                Range("F" & x).Formula = "=VLOOKUP(C" & x & ",'PB_" & ActiveWorkbook.Sheets(i).Name & "'!$B:$E,4,FALSE)"
            Next x
        End If
    Next i
End Sub
Sub ChangeRefPriceSheet()
    Dim sheet As Worksheet
    Dim i As Integer
    
    
    For i = 6 To 208
        ActiveSheet.Range("D" & i).Formula = "=VLOOKUP(D5,'PB_" & ActiveSheet.Range("C" & i).Value & "'!$B:$E,4,FALSE)"
    Next i
End Sub
Sub AACopyPriceList()
    Dim sheet As Worksheet
    Dim CellCount As Integer
    
    CellCount = 195
    
    On Error Resume Next
    
    For i = 1 To CellCount
        Worksheets(1).Copy after:=Worksheets(Worksheets.count)
        ActiveSheet.Name = "PB_" & Worksheets("TabName").Range("A" & i).Value
    Next i
End Sub
Sub MergeAndAlign()
    Selection.Merge
    Selection.HorizontalAlignment = xlLeft
End Sub
Sub UnhideSheets()
    Dim sheet As Worksheet
    
    For Each sheet In ActiveWorkbook.Worksheets
        sheet.Visible = xlSheetVisible
    Next sheet
End Sub
Sub SwitchHide()
    Dim sheet As Worksheet
    Dim switch As Boolean
    Dim response As Variant
    Dim Msg As String
    Dim Ans As Variant
    
Redo:
    On Error GoTo ErrResponse
    
    response = InputBox("'yes' to unhide, 'no' to hide PBs")
    
    Select Case response
        Case "yes"
            For Each sheet In ActiveWorkbook.Worksheets
                If InStr(sheet.Name, "PB_") Then
                    sheet.Visible = xlSheetVisible
                End If
            Next sheet
            Worksheets("INDEX").Activate
        Case "no"
            For Each sheet In ActiveWorkbook.Worksheets
                If InStr(sheet.Name, "PB_") Then
                    sheet.Visible = xlSheetHidden
                    Worksheets("INDEX").Select
                End If
            Next sheet
        Case Else
            Msg = "Please type 'yes' or 'no' into input box" & vbNewLine
            Msg = Msg & "Do you want to try again?"
            Ans = MsgBox(Msg, vbYesNo)
            
            If Ans = vbYes Then
                GoTo Redo
            End If
    End Select
    Exit Sub
    
ErrResponse:
    Msg = Err.Number & ": " & Err.Description & vbNewLine
    Msg = Msg & "Do you want to try again?"
    Ans = MsgBox(Msg, vbYesNo)
    
    If Ans = vbYes Then
        Resume Redo
    End If
End Sub
Sub GetTabName()
    Dim i As Integer
    Dim SheetCount As Integer
    
    SheetCount = ActiveWorkbook.Worksheets.count
    
    For i = 6 To (SheetCount)
        If InStr(Worksheets(i).Name, "PB") = False Then
            Worksheets("TabName").Range("C" & i).Value = Worksheets(i).Name
        End If
    Next i
End Sub
Sub RemoveApos()
    Dim i As Integer
    Dim sheet As Worksheet
    Dim SheetCount As Integer
    Dim TabName As String
    Dim token As String
    
    SheetCount = ActiveWorkbook.Sheets.count
    MsgBox (SheetCount)
    
    For i = 6 To SheetCount
        If InStr(Worksheets(i).Name, "'") > 0 Then
            Worksheets(i).Name = Replace(Worksheets(i).Name, "'", "")
        End If
    Next i
    
End Sub
Sub ChangePrice()
    Dim i, x, SheetCount As Integer
    Dim sheet As Worksheet
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    For x = 4 To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            For i = 6 To 200
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = "=VLOOKUP(A" & i & ",'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
            For i = 201 To 300
                If Worksheets(x).Range("N" & i).HasFormula Then
                    Worksheets(x).Range("N" & i).Formula = "=VLOOKUP(A" & i & ",'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = "=VLOOKUP(B" & i & ",'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("P" & i).HasFormula Then
                    Worksheets(x).Range("P" & i).Formula = "=VLOOKUP(C" & i & ",'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
        End If
    Next x
End Sub
Sub ChangePriceComplex()
    Dim i, x, SheetCount As Integer
    Dim sheet As Worksheet
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    For x = 4 To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            For i = 6 To 200
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = _
                    "=VLOOKUP((VLOOKUP(H" & i & ",'H:\projects\common\oracle\NSW Glass Project\Pricing\Split\[CTSPL_INDEX.xlsx]Correl'!$A:$D,2,0)),'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
            For i = 201 To 300
                If Worksheets(x).Range("N" & i).HasFormula Then
                    Worksheets(x).Range("N" & i).Formula = _
                    "=VLOOKUP((VLOOKUP(H" & i & ",'H:\projects\common\oracle\NSW Glass Project\Pricing\Split\[CTSPL_INDEX.xlsx]Correl'!$A:$D,2,0)),'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = _
                    "=VLOOKUP((VLOOKUP(H" & i & ",'H:\projects\common\oracle\NSW Glass Project\Pricing\Split\[CTSPL_INDEX.xlsx]Correl'!$A:$D,3,0)),'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("P" & i).HasFormula Then
                    Worksheets(x).Range("P" & i).Formula = _
                    "=VLOOKUP((VLOOKUP(H" & i & ",'H:\projects\common\oracle\NSW Glass Project\Pricing\Split\[CTSPL_INDEX.xlsx]Correl'!$A:$D,4,0)),'PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
        End If
    Next x
End Sub
Sub ChangePriceComplex2()
    Dim i, x, SheetCount As Integer
    Dim sheet As Worksheet
    
    SheetCount = ActiveWorkbook.Sheets.count
    
    Application.Calculation = xlCalculationManual
    
    For x = 4 To (SheetCount / 2)
        If InStr(Worksheets(x).Name, "PB_") = False Then
            For i = 6 To 200
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = _
                    "=VLOOKUP(VLOOKUP(H" & i & ",Correl!$A:$D,2,0),'[CTS Price List_AllPB.xlsx]PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
            For i = 201 To 300
                If Worksheets(x).Range("N" & i).HasFormula Then
                    Worksheets(x).Range("N" & i).Formula = _
                    "=VLOOKUP(VLOOKUP(H" & i & ",Correl!$A:$D,2,0),'[CTS Price List_AllPB.xlsx]PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("O" & i).HasFormula Then
                    Worksheets(x).Range("O" & i).Formula = _
                    "=VLOOKUP(VLOOKUP(H" & i & ",Correl!$A:$D,3,0),'[CTS Price List_AllPB.xlsx]PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
                If Worksheets(x).Range("P" & i).HasFormula Then
                    Worksheets(x).Range("P" & i).Formula = _
                    "=VLOOKUP(VLOOKUP(H" & i & ",Correl!$A:$D,4,0),'[CTS Price List_AllPB.xlsx]PB_" & Worksheets(x).Name & "'!$B:$E,4,FALSE)"
                End If
            Next i
        End If
    Next x
    
    Application.Calculation = xlCalculationAutomatic
End Sub
Sub ChangePrice2()
    Dim i, x, SheetCount, NACount As Integer
    Dim sheet As Worksheet
    Dim LookText As String
    
    SheetCount = ActiveWorkbook.Sheets.count
    NACount = 0
    LookText = "N/A"
    
    On Error Resume Next
    
    For x = 4 To SheetCount
        If InStr(Worksheets(x).Name, "PB_") = False Then
            For i = 201 To 300
                If Worksheets(x).Range("N" & i).Value = LookText Then
                    Worksheets(x).Range("N" & i).Formula = "=D" & i
                    NACount = NACount + 1
                End If
                If Worksheets(x).Range("O" & i).Value = LookText Then
                    Worksheets(x).Range("O" & i).Formula = "=E" & i
                    NACount = NACount + 1
                End If
                If Worksheets(x).Range("P" & i).Value = LookText Then
                    Worksheets(x).Range("P" & i).Formula = "=F" & i
                    NACount = NACount + 1
                End If
            Next i
        End If
    Next x
    MsgBox (NACount)
End Sub
Sub DeleteSheets()
    Dim i, x, SheetCount, IndexMax As Integer
    Dim RowRange, RowIndex As Range
    Dim switch As Boolean
    
    On Error Resume Next
    Application.DisplayAlerts = False
    
    IndexMax = 474
    SheetCount = ActiveWorkbook.Worksheets.count
    MsgBox (SheetCount)
    
    Set RowRange = Worksheets("INDEX").Range("B2:B" & IndexMax)
    
    For i = 15 To (SheetCount)
        For Each RowIndex In RowRange.SpecialCells(xlCellTypeVisible)
            'MsgBox (Worksheets("INDEX").Range("B" & RowIndex.Row).Value)
            If InStr(Worksheets("INDEX").Range("B" & RowIndex.Row).Value, Worksheets(i).Name) Then
                switch = True
                Exit For
            Else
                switch = False
            End If
        Next RowIndex
        If switch = False Then
            Worksheets(i).Delete
            i = i - 1
        End If
    Next i
    
    Application.DisplayAlerts = True
End Sub
Sub DeleteSheets2()
    Dim i, SheetCount As Integer
    
    SheetCount = ActiveWorkbook.Worksheets.count
    Application.DisplayAlerts = False
    
    For i = 2 To SheetCount
        If InStr(Worksheets(i).Name, "PB_") Then
            Worksheets(i).Delete
        End If
    Next i
    Application.DisplayAlerts = True
End Sub
Sub ReplaceAll()
    'PURPOSE: Find & Replace text/values throughout entire workbook
    'SOURCE: www.TheSpreadsheetGuru.com
    On Error Resume Next
    
    Application.DisplayAlerts = False
    
    Dim sht As Worksheet
    Dim fnd As Variant
    Dim rplc As Variant
    
    fnd = "Correl"
    rplc = "[CTSPL_INDEX.xlsx]Correl"
    
    For Each sht In ActiveWorkbook.Worksheets
      sht.Cells.Replace what:=fnd, Replacement:=rplc, _
        LookAt:=xlPart, SearchOrder:=xlByRows, MatchCase:=False, _
        SearchFormat:=False, ReplaceFormat:=False
    Next sht
    
    Application.DisplayAlerts = True

End Sub
