Option Compare Database
Option Explicit

' =================================
' MODULE:       mod_Enums
' Level:        Application module
' Version:      1.03
' Description:  enum functions & procedures specific to this application
'
' Source/date:  Bonnie Campbell, 11/5/2015
' Revisions:    BLC - 11/5/2015  - 1.00 - initial version
'               BLC - 6/24/2016  - 1.01 - replaced Exit_Function > Exit_Handler
'               BLC - 7/6/2016   - 1.02 - added OpenAndHideVBE() and ShowAndCloseVBE() to
'                                         CreateEnums()
'               BLC - 8/4/2016   - 1.03 - revised table name to AppEnum to avoid reserved word
' =================================

'-----------------------------
'  Functions
'-----------------------------

' ---------------------------------
' FUNCTION:     CreateEnums
' Description:  Create application specific enums based on Enum table
' Notes:
' you can combine enums for combo types as in direction facing
'    Dim df As DirectionFacing
'    df = DS + RL
'
'    PhotoType.Feature
'    PhotoType.Overview
'
' for more information see the following reference
'   Chip Pearson, March 12, 2008
'   http://www.cpearson.com/excel/Enums.aspx
' Parameters:
' Returns:      -
' Throws:       none
' References:   none
' Source/date:
' Ashareef, August 22, 2014
' http://stackoverflow.com/questions/25445422/array-in-an-enumeration
' Adapted:      Bonnie Campbell, November 5, 2015 - for NCPN tools
' Revisions:
'   BLC - 11/5/2015  - initial version
'   BLC - 4/12/2016  - revised to use vs. Modules("mod_App_Enum") which didn't find enum module
'   BLC - 7/6/2016   - added calls to OpenAndHideVBE() and ShowAndCloseVBE()
'                      before & after (respectively) modifying enums to prevent
'                      VBE from displaying when enums are recreated
'   BLC - 8/4/2016   - revised table name to AppEnum to avoid reserved word
' ---------------------------------
Public Function CreateEnums(Optional EnumType As String)
On Error GoTo Err_Handler
        
    Dim db As DAO.Database
    Dim rs As DAO.Recordset

    Set db = CurrentDb
    'Set rs = db.OpenRecordset("Enum", dbOpenSnapshot) <-- replace w/ SQL to get sort by enumtype
    Set rs = db.OpenRecordset("SELECT * FROM AppEnum ORDER BY EnumType, ID, Label", dbOpenSnapshot)

    Dim m As Module
    Dim s As String, PrevEnumType As String, strEnumType As String
    Dim lastID As Long
    
    'call OpenAndHideVBE before modifying enums
    'OpenAndHideVBE
    
    'module must be open to reference
    DoCmd.OpenModule ("mod_App_Enum")
    
    Set m = Modules("mod_App_Enum")

    'clear current enums
    Call m.DeleteLines(1, m.CountOfLines)

    PrevEnumType = ""
    
    s = "Option Compare Database"
    s = s & vbNewLine & "Option Explicit"
    s = s & vbNewLine
    
    s = s & vbNewLine & "' ================================="
    s = s & vbNewLine & "' MODULE:       mod_App_Enum"
    s = s & vbNewLine & "' Level:        Application module"
    s = s & vbNewLine & "' Version:      1.02"
    s = s & vbNewLine & "' Description:  enum functions & procedures specific to this application"
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "' Note:  This module is re-generated by the application from"
    s = s & vbNewLine & "'        the Enum table when the application is initialized."
    s = s & vbNewLine & "'        The framework module mod_Enums & Enum table are used"
    s = s & vbNewLine & "'        when the CreateEnums() call is made during app initialization."
    s = s & vbNewLine & "'        This allows enums to be changed via table vs. hardcoded."
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "'        [_First] & [_Last] enum values are hidden values"
    s = s & vbNewLine & "'        that allow for iteration w/in the enum"
    s = s & vbNewLine & "'        (any bracketed string begun with an underscore is hidden)"
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "' *************************************************************"
    s = s & vbNewLine & "' *  IMPORTANT!                                               *"
    s = s & vbNewLine & "' *                                                           *"
    s = s & vbNewLine & "' *        DO NOT EDIT this module!                           *"
    s = s & vbNewLine & "' *        ALL changes WILL be LOST when it is regenerated!   *"
    s = s & vbNewLine & "' *                                                           *"
    s = s & vbNewLine & "' *************************************************************"
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "' Source/date:  Bonnie Campbell, 11/5/2015"
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "' References:  Chip Pearson, November 6, 2013"
    s = s & vbNewLine & "'              http://www.cpearson.com/excel/Enums.aspx"
    s = s & vbNewLine & "'"
    s = s & vbNewLine & "' Revisions:    BLC - 11/5/2015  - 1.00 - initial version"
    s = s & vbNewLine & "' Revisions:    BLC - 4/12/2015  - 1.01 - revised rs to use SQL to retrieve"
    s = s & vbNewLine & "'                                         sorted results, .Sort doesn't apply to table recordsets"
    s = s & vbNewLine & "'                                         added hidden _First & _Last values for @ enum"
    s = s & vbNewLine & "'               app - " & Date & "  - 1.02 - latest enum update from db"
    s = s & vbNewLine & "'                                         last updated: " & Date & " " & Time
    s = s & vbNewLine & "' =================================" & vbNewLine
    
    With rs
    
        'sort doesn't apply to table recordsets --> use query instead
        '.Sort = "[EnumType], [Label]"
        
        Do Until .EOF
            
            'handle first enum
            If .Fields("EnumType") <> PrevEnumType Then
                
                'handle plurals
                If Right(.Fields("EnumType"), 1) = "s" Or Right(.Fields("EnumType"), 1) = "y" Then
                    strEnumType = .Fields("EnumType")
                Else
                    strEnumType = .Fields("EnumType") & "s"
                End If
            
                s = s & vbNewLine & "'-----------------------------"
                s = s & vbNewLine & "'  " & strEnumType
                s = s & vbNewLine & "'-----------------------------"
                
                s = s & vbNewLine & "Public Enum " & .Fields("EnumType")
                If PrevEnumType = "" Then PrevEnumType = .Fields("EnumType")
                            
                'add the _First item
                s = s & vbNewLine & vbTab & "[_First]" & " = " & .Fields("ID")
            End If
            
            s = s & vbNewLine & vbTab & .Fields("Label") & " = " & .Fields("ID")
            
            'capture last ID
            lastID = .Fields("ID")
            
            .MoveNext
            
            If Not .EOF Then
                If .Fields("EnumType") <> PrevEnumType Then
                    'add the _Last item
                    s = s & vbNewLine & vbTab & "[_Last]" & " = " & lastID
                    
                    s = s & vbNewLine & "End Enum" & vbNewLine
                    PrevEnumType = .Fields("EnumType")
                                        
                    'handle plurals
                    If Right(.Fields("EnumType"), 1) = "s" Or Right(.Fields("EnumType"), 1) = "y" Then
                        strEnumType = .Fields("EnumType")
                    Else
                        strEnumType = .Fields("EnumType") & "s"
                    End If
                    
                    'handle remaining enums
                    s = s & vbNewLine & "'-----------------------------"
                    s = s & vbNewLine & "'  " & strEnumType
                    s = s & vbNewLine & "'-----------------------------"
                    
                    s = s & vbNewLine & "Public Enum " & .Fields("EnumType")
                    
                    'add the _First item
                    s = s & vbNewLine & vbTab & "[_First]" & " = " & .Fields("ID")
                    
                    'capture last ID
                    lastID = .Fields("ID")
                End If
            End If
        
        Loop
        
        'add the _Last item
        s = s & vbNewLine & vbTab & "[_Last]" & " = " & lastID

        s = s & vbNewLine & "End Enum"
    End With
    
    'Call m.DeleteLines(1, m.CountOfLines)
    Call m.AddFromString(s)
    
    'save & close module
    DoCmd.Close acModule, "mod_App_Enum", acSaveYes
    
    'call to close the VBE after modifications
    'ShowAndCloseVBE
    
    'hide the vbe
    Application.VBE.MainWindow.Visible = False
    
Exit_Handler:
    Exit Function
    
Err_Handler:
    Select Case Err.Number
      Case Else
        MsgBox "Error #" & Err.Number & ": " & Err.Description, vbCritical, _
            "Error encountered (#" & Err.Number & " - CreateEnums[mod_Enums])"
    End Select
    Resume Exit_Handler
End Function