Attribute VB_Name = "PDF"
Sub myGoto(ByVal where As Integer)
    Dim app As Object, avdoc As Object, pageview As Object
    Set app = CreateObject("AcroExch.App")
    Set avdoc = app.GetActiveDoc
    Set pageview = avdoc.GetAVPageView
    pageview.Goto (where)
End Sub

