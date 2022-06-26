Attribute VB_Name = "ColourModule"
Dim cell As Range
Sub Normalise()
'
' Normalise Macro
' Returns formatting to normal
'
' Keyboard Shortcut: Ctrl+Shift+Z
    For Each cell In Application.Selection
        cell.EntireRow.Select
        With Selection.Interior
            .Pattern = xlNone
            .TintAndShade = 0
            .PatternTintAndShade = 0
        End With
        With Selection.Font
            .Name = "Arial"
            .Size = 10
            .ColorIndex = xlAutomatic
            .TintAndShade = 0
        End With
        ActiveCell.Select
    Next
End Sub
Sub Good()
'
' Good Macro
' Goodifies the whole thing
'
' Keyboard Shortcut: Ctrl+Shift+A
'
    For Each cell In Application.Selection
        cell.EntireRow.Select
        Selection.Style = "Good"
        ActiveCell.Select
    Next
End Sub
Sub Hmmm()
'
' Hmmm Macro
' Call in Sartre
'
' Keyboard Shortcut: Ctrl+Shift+S
'
    For Each cell In Application.Selection
        cell.EntireRow.Select
        Selection.Style = "Neutral"
        ActiveCell.Select
    Next
End Sub
Sub Nope()
'
' Nope Macro
' Get it out
'
' Keyboard Shortcut: Ctrl+Shift+D
'
    For Each cell In Application.Selection
        cell.EntireRow.Select
        Selection.Style = "Bad"
        ActiveCell.Select
    Next
End Sub
Sub Outsource()
    For Each cell In Application.Selection
        cell.Value = "R&M Outsourced"
        'ActiveCell.Select
    Next
End Sub
Sub Parts()
    For Each cell In Application.Selection
        cell.Value = "R&M Parts"
        'ActiveCell.Select
    Next
End Sub
Sub Expendables()
    For Each cell In Application.Selection
        cell.Value = "Expendables"
        'ActiveCell.Select
    Next
End Sub

