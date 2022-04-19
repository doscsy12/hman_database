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
                     GlacierArchivesLog;
                     
CREATE TABLE TargetFeedbackData (
    ID INT AUTO_INCREMENT NOT NULL,
    AffectedSide VARCHAR(10),
    PatientID VARCHAR(10),
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
        REFERENCES GameData (GameID)
);

CREATE TABLE TaskModel (
    ID INTEGER AUTO_INCREMENT NOT NULL,
    PatientID VARCHAR(10),
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
        REFERENCES GameData (GameID)
);

CREATE TABLE GameData (
    ID INT AUTO_INCREMENT NOT NULL,
    GameID VARCHAR(20),
    UserExtendedID INTEGER,
    Score INT,
    Duration FLOAT,
    PRIMARY KEY (ID)
);

CREATE TABLE GameSession (
    ID INT AUTO_INCREMENT NOT NULL,
    PatientID VARCHAR(20),
    AffectedSide VARCHAR(20),
    Score FLOAT,
    Strength FLOAT,
    Coordination FLOAT,
    Agility FLOAT,
    SessionTime FLOAT,
    SessionID VARCHAR(20),
    NumberOfTargets INT,
    CreatedDate DATETIME,
    GripForceMax VARCHAR(20),
    GripForceMin VARCHAR(20),
    GripForceVariability VARCHAR(20),
    IsSynced INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (SessionID)
        REFERENCES TaskModel (SessionID),
    FOREIGN KEY (SessionID)
        REFERENCES TargetFeedbackData (SessionID)
);

CREATE TABLE GlacierArchivesLog (
    ArchiveID VARCHAR(20),
    PatientID VARCHAR(20),
    SessionID VARCHAR(20),
    ModelType VARCHAR(20),
    FileName VARCHAR(20),
    UploadDateTime DATETIME,
    PRIMARY KEY (ArchiveID),
    FOREIGN KEY (PatientID)
        REFERENCES TargetFeedbackData (PatientID),
    FOREIGN KEY (SessionID)
        REFERENCES TargetFeedbackData (SessionID)
);