Sub UpdatePricebooks()
    Dim file As Variant
    Dim FromBook As Variant
    Dim CurrentBook As Variant
    Dim FolderLocation As String
    Dim i As Long
    Dim y As Long
    Dim SheetCount As Long
    Dim PBCount As Long
    Dim PBCountUpdate As Long
    Dim Msg As String
    
    'Stops screen flickering while updating
    Application.ScreenUpdating = False
    
    'Filepath set to user's choice
    With Application.FileDialog(msoFileDialogFolderPicker)
        .Title = "Please select the folder that contains the pricebooks"
        .AllowMultiSelect = False
        .Show
        If .SelectedItems.Count = 0 Then
            MsgBox ("Update cancelled")
        Else
            FolderLocation = .SelectedItems(1) & "\"
                        
            'Initialisation of variables
            CurrentBook = ActiveWorkbook.Name
            SheetCount = Worksheets.Count
            PBCount = 0
            PBCountUpdate = 0
            y = 3
            
            'Clear PB_Update tab
            Worksheets(1).Cells.ClearContents
            
            'Checks each tab to determine if it's a PB. If it is, it updates the PB if it can find
            'an Excel workbook with the same name (as the PB tab) in the specified folder.
            For i = 1 To SheetCount
                If InStr(Worksheets(i).Name, "PB_") > 0 Then
                
                    'Enter summary header
                    Worksheets(1).Range("A1").Value = "PBs Updated: " & Date & " " & Time
                    Worksheets(1).Range("A2").Value = "Pricebooks"
                    Worksheets(1).Range("B2").Value = "Updated Pricebooks"
                    Worksheets(1).Range("C2").Value = "Files from: " & FolderLocation
                    
                    If i <> 1 Then
                        ActiveWorkbook.Worksheets(1).Range("A" & y).Value = Worksheets(i).Name
                        y = y + 1
                        PBCount = PBCount + 1
                    End If
                    
                    file = Dir(FolderLocation)
                    Do While file <> ""
                        If InStr(file, Worksheets(i).Name) > 0 Then
                            Workbooks(CurrentBook).Worksheets(i).Cells.ClearContents
                            Set FromBook = Workbooks.Open(FolderLocation & file, ReadOnly:=True, CorruptLoad:=xlNormalLoad)
                            ActiveWorkbook.Worksheets(1).Cells.Copy Destination:=Workbooks(CurrentBook).Worksheets(i).Cells
                            Workbooks(FromBook.Name).Close
                            PBCountUpdate = PBCountUpdate + 1
                            
                            'Enter update info
                            ActiveWorkbook.Worksheets(1).Range("B" & (y - 1)).Value = Worksheets(i).Name
                            ActiveWorkbook.Worksheets(1).Range("C" & (y - 1)).Value = file
                            Exit Do
                        End If
                        file = Dir
                    Loop
                End If
            Next i
            
            'Returns screen updating after procedure is complete
            Application.ScreenUpdating = True
            
            'Returns a message box containing how many PB tabs were found, and how many were updated
            Msg = "Number of PB tabs: " & PBCount & vbNewLine
            Msg = Msg & "Number of updated PB tabs: " & PBCountUpdate
            MsgBox (Msg)
            
            'Displays summary sheet
            Worksheets(1).Visible = xlSheetVisible
            Worksheets(1).Activate
        End If
    End With
End Sub


