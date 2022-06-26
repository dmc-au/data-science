Attribute VB_Name = "APFix"
Sub APFix()
Attribute APFix.VB_ProcData.VB_Invoke_Func = "O\n14"
'
' APFix Macro
'
' Keyboard Shortcut: Ctrl+Shift+O
'
    Sheets("AP Payables Documents").Select
    Sheets("AP Payables Documents").Copy before:=Sheets(1)
    ActiveSheet.Range("$A$3:$BM$2750").AutoFilter Field:=64, Criteria1:= _
        "Leanne"
    Sheets("AP Payables Documents (2)").Select
    Sheets("AP Payables Documents (2)").Name = "Leanne"
    Sheets("Leanne").Select
    Sheets("Leanne").Copy before:=Sheets(1)
    ActiveSheet.Range("$A$3:$BM$2750").AutoFilter Field:=64, Criteria1:="Kate"
    Sheets("Leanne (2)").Select
    Sheets("Leanne (2)").Name = "Kate"
    Sheets("Kate").Select
    Sheets("Kate").Copy before:=Sheets(1)
    ActiveSheet.Range("$A$3:$BM$2750").AutoFilter Field:=64, Criteria1:="David"
    Sheets("Kate (2)").Select
    Sheets("Kate (2)").Name = "David"
    Sheets("David").Select
    Sheets("David").Copy before:=Sheets(1)
    ActiveSheet.Range("$A$3:$BM$2750").AutoFilter Field:=64, Criteria1:="Brian"
    Sheets("David (2)").Select
    Sheets("David (2)").Name = "Brian"
    Sheets("AP Payables Documents").Select
    Sheets("AP Payables Documents").Move before:=Sheets(1)
    ActiveWindow.ScrollColumn = 1
    ActiveWorkbook.Save
    ActiveWorkbook.Close
End Sub
