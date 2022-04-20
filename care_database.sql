-- Sample database taken from current schema
-- Obviously, database needs to be re-designed

DROP DATABASE IF EXISTS care_database;
CREATE DATABASE IF NOT EXISTS care_database; 
USE care_database;

SELECT 'CREATING DRAFT DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS TargetFeedbackData,
                     TaskModel,
                     GameData,
                     GameSession,
                     UserExtended,
                     OrgDevice,
                     GlacierArchivesLog;
                     
CREATE TABLE TargetFeedbackData (
    ID INT AUTO_INCREMENT NOT NULL,
    AffectedSide VARCHAR(10),
    PatientID VARCHAR(20),
    TargetIndex INT,
    Sparc FLOAT,
    VisualTargetXCoord FLOAT,
    VisualTargetYCoord FLOAT,
    TargetXCoord FLOAT,
    TargetYCoord FLOAT,
    EnableHaptic INT,
    EnableHapticMain INT,
    KxGain FLOAT,
    KyGain FLOAT,
    KxyGain FLOAT,
    KyxGain FLOAT,
    BxGain FLOAT,
    ByGain FLOAT,
    BxyGain FLOAT,
    ByxGain FLOAT,
    OverallForceGain FLOAT,
    RotationMatrixAngle FLOAT,
    XCoordinate FLOAT,
    YCoordinate FLOAT,
    LeftQEI INT,
    RightQEI INT,
    VelocityX FLOAT,
    VelocityY FLOAT,
    TorqueLeft FLOAT,
    TorqueRight FLOAT,
    CurrentSenseLeft FLOAT,
    CurrentSenseRight FLOAT,
    TotalForce FLOAT,
    OutputA0 INT,
    OutputA1 INT,
    EmergencyState INT,
    TimeStamp VARCHAR(20),
    TimeStampMS BIGINT,
    TimeStampDate DATETIME,
    GameID INTEGER,
    SessionID VARCHAR(20),
    DeviceID VARCHAR(20),
    IsSynced INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (GameID)
        REFERENCES GameData (GameID),
	FOREIGN KEY (SessionID)
        REFERENCES GameSession (SessionID)
);

CREATE TABLE TaskModel (
    ID INTEGER AUTO_INCREMENT NOT NULL,
    PatientID VARCHAR(20),
    VisualTargetXCoord FLOAT,
    VisualTargetYCoord FLOAT,
    TargetXCoord FLOAT,
    TargetYCoord FLOAT,
    EnableHaptic INT,
    EnableHapticMain INT,
    KxGain FLOAT,
    KyGain FLOAT,
    KxyGain FLOAT,
    KyxGain FLOAT,
    BxGain FLOAT,
    ByGain FLOAT,
    BxyGain FLOAT,
    ByxGain FLOAT,
    OverallForceGain FLOAT,
    RotationMatrixAngle FLOAT,
    TargetRadius FLOAT,
    Duration FLOAT,
    Sparc FLOAT,
    GameID INT,
    SessionID VARCHAR(20),
    DeviceID VARCHAR(20),
    IsSynced INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (GameID)
        REFERENCES GameData (GameID),
	FOREIGN KEY (SessionID)
        REFERENCES GameSession (SessionID)
);

CREATE TABLE GameData (
    GameID INT AUTO_INCREMENT NOT NULL,
    UserExtendedID INTEGER,
    Score INT,
    Duration FLOAT,
    PRIMARY KEY (GameID),
    FOREIGN KEY (GameID)
        REFERENCES GameSession (GameID),
	FOREIGN KEY (GameID)
        REFERENCES TargetFeedbackData (GameID),
	FOREIGN KEY (GameID)
        REFERENCES TargetFeedbackData (GameID)
);

CREATE TABLE GameSession (
    SessionID INT AUTO_INCREMENT NOT NULL,
    PatientID VARCHAR(20),
    AffectedSide VARCHAR(20),
    Score FLOAT,
    Strength FLOAT,
    Coordination FLOAT,
    Agility FLOAT,
    GameID VARCHAR(20),
    SessionTime FLOAT,
    NumberOfTargets INT,
    CreatedDate DATETIME,
    GripForceMax VARCHAR(20),
    GripForceMin VARCHAR(20),
    GripForceVariability VARCHAR(20),
    IsSynced INT,
    PRIMARY KEY (SessionID),
    FOREIGN KEY (SessionID)
        REFERENCES TaskModel (SessionID),
    FOREIGN KEY (SessionID)
        REFERENCES TargetFeedbackData (SessionID),
	FOREIGN KEY (SessionID)
        REFERENCES GlacierArchivesLog (SessionID)
);

CREATE TABLE GlacierArchivesLog (
    ArchiveID INT NOT NULL,
    PatientID VARCHAR(20),
    SessionID VARCHAR(20),
    ModelType VARCHAR(20),
    FileName VARCHAR(20),
    UploadDateTime DATETIME,
    PRIMARY KEY (ArchiveID)
);

CREATE TABLE OrgDevice (
    DeviceID INT NOT NULL,
    OrgID INT,
    CreatedDate DATETIME,
    ModifiedDate DATETIME,
    LastModifiedBy INT,
    PRIMARY KEY (DeviceID),
    FOREIGN KEY (DeviceID)
        REFERENCES TargetFeedbackData (DeviceID),
    FOREIGN KEY (DeviceID)
        REFERENCES TaskModel (DeviceID)
);

CREATE TABLE UserExtended (
    PatientID VARCHAR(20),
    Age INT,
    Gender ENUM('M', 'F', 'O'),
    AffectedSide VARCHAR(20),
    DominantSide VARCHAR(20),
    AssignedTherapist INT,
    Height FLOAT,
    Weight FLOAT,
    ArmLength FLOAT,
    Notes VARCHAR(50),
    ClinicalScale INT,
    TrainingStartDate DATETIME,
    ConventionalTrainingStartDate DATETIME,
    ScaleType VARCHAR(20),
    Language VARCHAR(20),
    DateOfInjury VARCHAR(20),
    TypeOfInjury VARCHAR(20),
    LocationOfInjury VARCHAR(20),
    HasNoInjury VARCHAR(20),
    UserMasterID INT,
    DeviceID INT,
    CreatedDate DATETIME,
    ModifiedDate DATETIME,
    LastModifiedBy INT,
    PRIMARY KEY (PatientID),
	FOREIGN KEY (PatientID)
        REFERENCES TargetFeedbackData (PatientID),
	FOREIGN KEY (PatientID)
        REFERENCES TaskModel (PatientID),
    FOREIGN KEY (PatientID)
        REFERENCES GlacierArchivesLog (PatientID),
	FOREIGN KEY (PatientID)
        REFERENCES GameSession (PatientID)
);