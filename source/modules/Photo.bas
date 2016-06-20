Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Compare Database
Option Explicit

' =================================
' CLASS:        Photo
' Level:        Framework class
' Version:      1.02
'
' Description:  Photo object related properties, events, functions & procedures
'
' Source/date:  Bonnie Campbell, 10/28/2015
' References:   -
' Revisions:    BLC - 10/28/2015 - 1.00 - initial version
'               BLC - 4/7/2016   - 1.01 - added events & properties, updated schema documentation
'               BLC - 4/19/2016  - 1.02 - adjusted to mirror data sheets
' =================================

'    [ID] [smallint] IDENTITY(1,1) NOT NULL,
'    [PhotographerID] [int] NULL,
'    [DownloadByID] [int] NULL,
'    [EntryByID] [int] NOT NULL,
'    [VerifyByID] [int] NULL,
'    [LastUpdateByID] [int] NOT NULL,
'    [PhotoType] [nvarchar](2) NOT NULL,
'    [PhotographerFacing] [nvarchar](2) NOT NULL,
'    [PhotographerLocation] [nvarchar](15) NOT NULL,
'    [SubjectLocation] [nvarchar](10) NULL,
'    [PhotoLabel] [nvarchar](8) NOT NULL,
'    [DigitalFilename] [nvarchar](15) NOT NULL,
'    [NCPNImageName] [nvarchar](15) NOT NULL,
'    [IsReplacement] [bit] NOT NULL,
'    [IsCloseup] [bit] NOT NULL,
'    [InActive] [bit] NOT NULL,
'    [TakenDate] [datetime] NOT NULL,
'    [DownloadDate] [datetime] NOT NULL,
'    [EntryDate] [timestamp] NOT NULL,
'    [VerifyDate] [datetime] NOT NULL,
'    [LastUpdate] [datetime] NOT NULL,

'---------------------
' Declarations
'---------------------
Private m_ID As Long
Private m_PhotoDate As Date
Private m_PhotoType As String '2
Private m_PhotographerID As Long
Private m_Filename As String '10
Private m_NCPNImageID As Long '50
Private m_DirectionFacing As String '4
Private m_PhotogLocation As String '10
'Private m_PhotogLocationDescr As String '255
'Private m_PhotogOrientation As String '4
'Private m_SurveyPtID As Long
Private m_SubjectLocation As String '10
Private m_IsCloseup As Boolean
Private m_IsInActive As Boolean
Private m_IsSkipped As Boolean
Private m_IsReplacement As Boolean
Private m_LastPhotoUpdate As Date
Private m_CreateDate As Date
Private m_CreatedByID As Long
Private m_LastModified As Date
Private m_LastModifiedByID As Long

Private m_Comments As Comment

'Private m_PhotoType As String
'Private m_Filename As String
'Private m_PhotographerLocation As Location
'Private m_Photographer As Person
'Private m_Downloader As Person
'Private m_Enterer As Person
'Private m_Verifier As Person

'---------------------
' Events
'---------------------
Public Event InvalidPhotoType(value As String)
Public Event InvalidPhotoNumber(value As String)
Public Event InvalidFilename(value As String)
Public Event InvalidDirectionFacing(value As String)
Public Event InvalidPhotographerID(value As Long)
Public Event Invalid(value)

'---------------------
' Properties
'---------------------
Public Property Let ID(value As Long)
    m_ID = value
End Property

Public Property Get ID() As Long
    ID = m_ID
End Property

Public Property Let PhotoDate(value As Date)
    m_PhotoDate = value
End Property

Public Property Get PhotoDate() As Date
    PhotoDate = m_PhotoDate
End Property

Public Property Let PhotoType(value As String)
    Dim aryTypes() As String
    aryTypes = Split(PHOTO_TYPES, ",")
    If IsInArray(value, aryTypes) Then
        m_PhotoType = value
    Else
        RaiseEvent InvalidPhotoType(value)
    End If
End Property

Public Property Get PhotoType() As String
    PhotoType = m_PhotoType
End Property

Public Property Let PhotographerID(value As Long)
    m_PhotographerID = value
End Property

Public Property Get PhotographerID() As Long
    PhotographerID = m_PhotographerID
End Property
    
Public Property Let FileName(value As String)
    m_Filename = value
End Property

Public Property Get FileName() As String
    FileName = m_Filename
End Property

Public Property Let NCPNImageID(value As Long)
    m_NCPNImageID = value
End Property

Public Property Get NCPNImageID() As Long
    NCPNImageID = m_NCPNImageID
End Property

Public Property Let DirectionFacing(value As String)
    m_DirectionFacing = value
End Property

Public Property Get DirectionFacing() As String
    DirectionFacing = m_DirectionFacing
End Property

Public Property Let PhotogLocation(value As String)
    m_PhotogLocation = value
End Property

Public Property Get PhotogLocation() As String
    PhotogLocation = m_PhotogLocation
End Property

'Public Property Let PhotogLocationDescr(Value As String)
'    m_PhotogLocationDescr = Value
'End Property
'
'Public Property Get PhotogLocationDescr() As String
'    PhotogLocationDescr = m_PhotogLocationDescr
'End Property

'Public Property Let PhotogOrientation(Value As String)
'    m_PhotogOrientation = Value
'End Property
'
'Public Property Get PhotogOrientation() As String
'    PhotogOrientation = m_PhotogOrientation
'End Property
'
'Public Property Let SurveyPtID(Value As Long)
'    m_SurveyPtID = Value
'End Property
'
'Public Property Get SurveyPtID() As Long
'    SurveyPtID = m_SurveyPtID
'End Property

Public Property Let SubjectLocation(value As String)
    m_SubjectLocation = value
End Property

Public Property Get SubjectLocation() As String
    SubjectLocation = m_SubjectLocation
End Property

Public Property Let IsCloseup(value As Boolean)
    m_IsCloseup = value
End Property

Public Property Get IsCloseup() As Boolean
    IsCloseup = m_IsCloseup
End Property

Public Property Let IsInActive(value As Boolean)
    m_IsInActive = value
End Property

Public Property Get IsInActive() As Boolean
    IsInActive = m_IsInActive
End Property

Public Property Let IsSkipped(value As Boolean)
    m_IsSkipped = value
End Property

Public Property Get IsSkipped() As Boolean
    IsSkipped = m_IsSkipped
End Property

Public Property Let IsReplacement(value As Boolean)
    m_IsReplacement = value
End Property

Public Property Get IsReplacement() As Boolean
    IsReplacement = m_IsReplacement
End Property

Public Property Let LastPhotoUpdate(value As Date)
    m_LastPhotoUpdate = value
End Property

Public Property Get LastPhotoUpdate() As Date
    LastPhotoUpdate = m_LastPhotoUpdate
End Property

Public Property Let CreatedByID(value As Integer)
    m_CreatedByID = value
End Property

Public Property Get CreatedByID() As Integer
    CreatedByID = m_CreatedByID
End Property

Public Property Let CreateDate(value As Date)
    m_CreateDate = value
End Property

Public Property Get CreateDate() As Date
    CreateDate = m_CreateDate
End Property

Public Property Let LastModifiedByID(value As Integer)
    m_LastModifiedByID = value
End Property

Public Property Get LastModifiedByID() As Integer
    LastModifiedByID = m_LastModifiedByID
End Property



    
'Public Property Let Comment(Value As Comment)
'    m_Comment = Value
'End Property
'
'Public Property Get Comment() As Comment
'    Comment = m_Comment
'End Property



'Public Property Let Filename(Value As String)
'    m_Filename = Value
'End Property
'
'Public Property Get Filename() As String
'    Filename = m_Filename
'End Property
'
'Public Property Let PhotographerLocation(Value As Location)
'    m_PhotographerLocation = Value
'End Property
'
'Public Property Get PhotographerLocation() As Location
'    PhotographerLocation = m_PhotographerLocation
'End Property
'
'Public Property Let SubjectLocation(Value As Location)
'    m_SubjectLocation = Value
'End Property
'
'Public Property Get SubjectLocation() As Location
'    SubjectLocation = m_SubjectLocation
'End Property


'---------------------
' Methods
'---------------------

'======== Standard Methods ===========

' ---------------------------------
' SUB:          Class_Initialize
' Description:  Initialize the class
' Assumptions:  -
' Parameters:   -
' Returns:      -
' Throws:       none
' References:   -
' Source/date:  -
' Adapted:      Bonnie Campbell, April 4, 2016 - for NCPN tools
' Revisions:
'   BLC - 4/4/2016 - initial version
' ---------------------------------
Private Sub Class_Initialize()
On Error GoTo Err_Handler

Exit_Handler:
    Exit Sub

Err_Handler:
    Select Case Err.Number
        Case Else
            MsgBox "Error #" & Err.Description, vbCritical, _
                "Error encounter (#" & Err.Number & " - Class_Initialize[cls_Photo])"
    End Select
    Resume Exit_Handler
End Sub

'---------------------------------------------------------------------------------------
' SUB:          Class_Terminate
' Description:  -
' Parameters:   -
' Returns:      -
' Throws:       -
' References:   -
' Source/Date:  Bonnie Campbell
' Adapted:      Bonnie Campbell, 4/4/2016 - for NCPN tools
' Revisions:
'   BLC, 4/4/2016 - initial version
'---------------------------------------------------------------------------------------
Private Sub Class_Terminate()
On Error GoTo Err_Handler

    'Set m_ID = 0

Exit_Handler:
    Exit Sub

Err_Handler:
    Select Case Err.Number
        Case Else
            MsgBox "Error #" & Err.Description, vbCritical, _
                "Error encounter (#" & Err.Number & " - Class_Terminate[cls_Photo])"
    End Select
    Resume Exit_Handler
End Sub

'======== Custom Methods ===========
'---------------------------------------------------------------------------------------
' SUB:          SaveToDb
' Description:  -
' Parameters:   -
' Returns:      -
' Throws:       -
' References:
'   Fionnuala, February 2, 2009
'   David W. Fenton, October 27, 2009
'   http://stackoverflow.com/questions/595132/how-to-get-id-of-newly-inserted-record-using-excel-vba
' Source/Date:  Bonnie Campbell
' Adapted:      Bonnie Campbell, 4/4/2016 - for NCPN tools
' Revisions:
'   BLC, 4/4/2016 - initial version
'---------------------------------------------------------------------------------------
Public Sub SaveToDb()
On Error GoTo Err_Handler
    
    Dim strSQL As String
    Dim db As DAO.Database
    Dim rs As DAO.Recordset
    
    Set db = CurrentDb
    
    '& "PhotogLocationDesc, PhotogOrientation, SurveyPoint_ID, " _
    '& Me.PhotogLocationDescr & "','" _

    'photos must have:
'    strSQL = "INSERT INTO Photo(PhotoDate, PhotoType, Photographer_ID, " _
'                & "DigitalFilename, NCPNImageID, PhotogFacing, PhotogLocation, " _
'                & "PhotogOrientation, SurveyPoint_ID, " _
'                & "IsCloseup, InActive, IsSkipped, IsReplacement, " _
'                & "LastPhotoUpdate, CreateDate, CreatedBy_ID, " _
'                & "LastModified, LastModifiedBy_ID) VALUES " _
'                & "(#" & Me.PhotoDate & "#,'" & Me.PhotoType & "'," _
'                & Me.PhotographerID & ",'" & Me.Filename & "','" _
'                & Me.NCPNImageID & "','" & Me.DirectionFacing & "','" _
'                & Me.PhotogLocation & "','" _
'                & Me.PhotogOrientation & "'," & Me.SurveyPtID & "," _
'                & Me.IsCloseup & "," & Me.IsInActive & "," & Me.IsSkipped & "," _
'                & Me.IsReplacement & ",#" & Me.LastPhotoUpdate & "#,# Now()#," _
'                & Me.CreatedByID & ",# Now()#, " & Me.LastModifiedByID & ");"
    
    strSQL = "INSERT INTO Photo(PhotoDate, PhotoType, Photographer_ID, " _
                & "DigitalFilename, NCPNImageID, PhotogFacing, PhotogLocation, " _
                & "" _
                & "IsCloseup, InActive, IsSkipped, IsReplacement, " _
                & "LastPhotoUpdate, CreateDate, CreatedBy_ID, " _
                & "LastModified, LastModifiedBy_ID) VALUES " _
                & "(#" & Me.PhotoDate & "#,'" & Me.PhotoType & "'," _
                & Me.PhotographerID & ",'" & Me.FileName & "','" _
                & Me.NCPNImageID & "','" & Me.DirectionFacing & "','" _
                & Me.PhotogLocation & "','" _
                & Me.IsCloseup & "," & Me.IsInActive & "," & Me.IsSkipped & "," _
                & Me.IsReplacement & ",#" & Me.LastPhotoUpdate & "#,# Now()#," _
                & Me.CreatedByID & ",# Now()#, " & Me.LastModifiedByID & ");"

    db.Execute strSQL, dbFailOnError
    Me.ID = db.OpenRecordset("SELECT @@IDENTITY")(0)

Exit_Handler:
    Exit Sub

Err_Handler:
    Select Case Err.Number
        Case Else
            MsgBox "Error #" & Err.Description, vbCritical, _
                "Error encounter (#" & Err.Number & " - Class_Terminate[cls_Photo])"
    End Select
    Resume Exit_Handler
End Sub