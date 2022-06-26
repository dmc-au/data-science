Attribute VB_Name = "SendEmails"
Sub SendUserEmail2()
    Dim OutlookApp As Object
    Dim MItem As Object
    Dim cell As Range
    Dim subject_ As String
    Dim body_ As String
    Dim LinkList As String
    Dim greeting_ As String
    Dim count_ As Integer
    
     'Create Outlook object
    Set OutlookApp = CreateObject("Outlook.Application")
    
    'Set greeting based on time of day
    If Time < 0.5 Then
        greeting_ = "Good Morning "
    Else
        greeting_ = "Good Afternoon "
    End If

    count_ = Application.Selection.count
    
    'Sets subject_ and LinkList as default for many items
    subject_ = "Computer Access Forms "
    LinkList = "The Computer Access Forms below are awaiting your action:" & Chr(10) & Chr(10)
     
    'Changes subject and body modes based on singular or plural
    If count_ < 2 Then
        For Each cell In Application.Selection
            subject_ = "Computer Access Form " & cell.Value
            LinkList = "The Computer Access Form below is awaiting your action:" _
            & Chr(10) & Chr(10) _
            & cell.Offset(0, 7).Text & Chr(10)
        Next
    Else
        For Each cell In Application.Selection
            subject_ = subject_ & cell.Value & ", "
            LinkList = LinkList & cell.Offset(0, 7).Text & Chr(10)
        Next
    End If
     
     'For each Form # selected, draft up e-mail
    body_ = greeting_ & "Graeme," _
            & Chr(10) & Chr(10) & _
            LinkList _
            & Chr(10) _
            & "Thanks," _
            & Chr(10) & Chr(10) _
            & "Dave Cole"
    
     'Create Mail Item and send it
    Set MItem = OutlookApp.CreateItem(0)
    With MItem
        .To = ""
        .CC = ""
        .Subject = subject_
        .Body = body_
        .display
    End With
End Sub
Sub SendUserEmail()
    Dim OutlookApp As Object
    Dim MItem As Object
    Dim cell As Range
    Dim subject_ As String
    Dim body_ As String
    Dim link_ As String
    Dim greeting_ As String
    
    'Set greeting based on time of day
    If Time < 0.5 Then
        greeting_ = "Good Morning "
    Else
        greeting_ = "Good Afternoon "
    End If
        
     'Create Outlook object
    Set OutlookApp = CreateObject("Outlook.Application")
     
     'For each Form # selected, draft up e-mail
    For Each cell In Application.Selection
        link_ = cell.Offset(0, 7).Text
        subject_ = cell.Value
        body_ = greeting_ & "Graeme," & Chr(10) & Chr(10) & "The Computer Access Form below is awaiting your action:" _
                & Chr(10) & Chr(10) & link_ & Chr(10) & Chr(10) & "Thanks," & Chr(10) & Chr(10) & "Dave Cole"
        
        
         'Create Mail Item and send it
        Set MItem = OutlookApp.CreateItem(0)
        With MItem
            .To = ""
            .CC = ""
            .Subject = "Computer Access Form " & subject_
            .Body = body_
            .display
        End With
    Next
End Sub
Sub SendChangeEmail()
    Dim OutlookApp As Object
    Dim MItem As Object
    Dim cell As Range
    Dim subject_ As String
    Dim body_ As String
    Dim link_ As String
    Dim greeting_ As String
    
    'Set greeting based on time of day
    If Time < 0.5 Then
        greeting_ = "Good Morning "
    Else
        greeting_ = "Good Afternoon "
    End If
    
     'Create Outlook object
    Set OutlookApp = CreateObject("Outlook.Application")
     
     'Loop through the rows
    For Each cell In Application.Selection
    
        link_ = cell.Offset(0, 7).Value
        subject_ = cell.Value
        body_ = greeting_ & "Graeme," & Chr(10) & Chr(10) & "The Change Request Form below is awaiting your action:" _
                & Chr(10) & Chr(10) & link_ & Chr(10) & Chr(10) & "Thanks," & Chr(10) & Chr(10) & "Dave Cole"
        
        
         'Create Mail Item and send it
        Set MItem = OutlookApp.CreateItem(0)
        With MItem
            .To = ""
            .CC = ""
            .Subject = "Change Request Form " & subject_
            .Body = body_
            .display
        End With
    Next
End Sub
Sub SendCapex()
    Dim OutlookApp As Object
    Dim MItem As Object
    Dim cell As Range
    Dim subject_ As String
    Dim body_ As String
    Dim link_ As String
    Dim greeting_ As String
    Dim names_ As String
    Dim addr_ As String
    Dim nick_ As String
    Dim EmailCount As Integer
    Dim cc_ As String
    Dim x As Long
    
    'Set how many emails there are in the list
    EmailCount = Worksheets("Emails").Range("A2", Worksheets("Emails").Range("A2").End(xlDown)).Rows.count
    
    'Set greeting based on time of day
    If Time < 0.5 Then
        greeting_ = "Good Morning "
    Else
        greeting_ = "Good Afternoon "
    End If
    
    'Create Outlook object
    Set OutlookApp = CreateObject("Outlook.Application")
     
    'Sets up email for each capex # selected
    For Each cell In Application.Selection
        names_ = cell.Offset(0, 7).Value
        nick_ = names_
            
        'Sets email addresses and who the letter is addressed to
        For x = 2 To EmailCount
            If x = 2 Then
                nick_ = ""
            End If
            
            If InStr(1, names_, Worksheets("Emails").Range("A" & x).Value) > 0 Then
                addr_ = addr_ & Worksheets("Emails").Range("F" & x).Value & "; "
                nick_ = nick_ & Worksheets("Emails").Range("B" & x).Value & ", "
            End If
        Next x
        
        'Sets CC
        For y = 2 To 7
            If y = 2 Then
                cc_ = ""
            End If
            
            If InStr(1, Worksheets("Emails").Range("I" & y).Value, cell.Offset(0, 2).Value) > 0 Then
                cc_ = cc_ & Worksheets("Emails").Range("J" & y).Value
            End If
        Next y
        
        
        'Sets document details to send in email
        link_ = cell.Offset(0, 10).Value
        subject_ = cell.Value
        body_ = greeting_ & nick_ & Chr(10) & Chr(10) & "The Capex below is awaiting your action:" _
                & Chr(10) & Chr(10) & link_ & Chr(10) & Chr(10) & "Thanks," & Chr(10) & Chr(10) & "Dave Cole"
        
        'Create Mail Item and send it
        Set MItem = OutlookApp.CreateItem(0)
        With MItem
            .To = addr_
            .CC = cc_
            .Subject = "Capex " & cell.Value & " has been approved"
            .Body = body_
            .display
        End With
    Next
End Sub
