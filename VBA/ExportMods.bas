Attribute VB_Name = "ExportMods"
Sub ExportMods()
    Dim i As Integer
    Dim ModCount As Long
    
    ModCount = Application.Workbooks("PERSONAL.XLSB").VBProject.VBComponents.count
    With Application.Workbooks("PERSONAL.XLSB").VBProject.VBComponents
        For i = 1 To ModCount
            .Item(i).Export "U:\Documents\Scripts\JuneBackup\" & .Item(i).Name & ".bas"
        Next i
    End With
End Sub
