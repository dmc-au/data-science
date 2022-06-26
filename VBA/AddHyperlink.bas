Attribute VB_Name = "AddHyperlink"
Sub AddHyperlink()
    For Each xCell In Application.Selection
        ActiveSheet.Hyperlinks.Add Anchor:=xCell, Address:=xCell.Text
    Next xCell
End Sub

