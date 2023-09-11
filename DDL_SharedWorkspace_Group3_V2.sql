USE [master]
GO

/*** Check IF the database exists, delete it and create a new one ***/
IF DB_ID('SharedWorkspace') IS NOT NULL
DROP DATABASE SharedWorkspace
GO

CREATE DATABASE SharedWorkspace
GO

USE SharedWorkspace
GO

/*** CREATING THE ENTITIES***/

--Creating the entity ROLE and give it some rules

CREATE TABLE Role (
	RoleID		INT IDENTITY(1,1) UNIQUE NOT NULL,
	RoleType	VARCHAR(50) NOT NULL,
	PRIMARY KEY (RoleID)
);
GO

--Creating the entity USERS and give it some rules
CREATE TABLE Users(
UserID		INT IDENTITY(1,1) UNIQUE NOT NULL,
Name		VARCHAR(250) NOT NULL,
Phone		VARCHAR(20) NOT NULL,
Email		VARCHAR(100) NOT NULL,
Password	VARCHAR(20) NOT NULL,
RoleID		INT NOT NULL,
PRIMARY KEY (UserID),
FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);
GO

--Creating the entity NEIGHBORHOOD and give it some rules
CREATE TABLE Neighborhood(
NeighborhoodID		INT IDENTITY(1,1) UNIQUE NOT NULL,
NeighborhoodName	VARCHAR(250) NOT NULL,
PRIMARY KEY (NeighborhoodID)
);
GO

--Creating the entity TRANSPORTATIONTYPE and give it some rules
CREATE TABLE TransportationType(
TransportationTypeID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TransportationTypeName		VARCHAR(250) NOT NULL,
PRIMARY KEY (TransportationTypeID)
);
GO

--Creating the entity TRANSPORTATIONLINE and give it some rules
CREATE TABLE TransportationLine(
TransportationLineID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TransportationLineName		VARCHAR(250) NOT NULL,
PRIMARY KEY (TransportationLineID)
);
GO

--Creating the entity TRANSPORTATIONTYPELINE and give it some rules
CREATE TABLE TransportationTypeLine(
TransportationTypeLineID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TransportationTypeID			INT NOT NULL,
TransportationLineID			INT NOT NULL,
PRIMARY KEY (TransportationLineID),
FOREIGN KEY (TransportationTypeID) REFERENCES TransportationType(TransportationTypeID),
FOREIGN KEY (TransportationLineID) REFERENCES TransportationLine(TransportationLineID)
);
GO

--Creating the entity TRANSPORTATIONSTATION and give it some rules
CREATE TABLE TransportationStation(
TransportationStationID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TransportationStationName	VARCHAR(250) NOT NULL,
PRIMARY KEY (TransportationStationID)
);
GO

--Creating the entity PUBLICTRANSPORTATION and give it some rules
CREATE TABLE PublicTransportation(
PublicTransportationID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TransportationTypeLineID	INT NOT NULL,
TransportationStationID		INT NOT NULL,
PRIMARY KEY (PublicTransportationID),
FOREIGN KEY (TransportationTypeLineID) REFERENCES TransportationTypeLine(TransportationTypeLineID),
FOREIGN KEY (TransportationStationID) REFERENCES TransportationStation(TransportationStationID)
);
GO

--Creating the entity WORKSPACETYPE and give it some rules
CREATE TABLE WorkspaceType(
WorkspaceTypeID		INT IDENTITY(1,1) UNIQUE NOT NULL,
TypeOfWorkspace		VARCHAR(250) NOT NULL,
PRIMARY KEY (WorkspaceTypeID)
);
GO

--Creating the entity LEASETERM and give it some rules
CREATE TABLE LeaseTerm(
LeaseTermID			INT IDENTITY(1,1) UNIQUE NOT NULL,
LeasePeriod			VARCHAR(250) NOT NULL,
PRIMARY KEY (LeaseTermID)
);
GO

--Creating the entity PROPERTY and give it some rules
CREATE TABLE Property(
PropertyID				INT IDENTITY(1,1) UNIQUE NOT NULL,
PropertyName			VARCHAR(250),
AddressStreet			VARCHAR(250) NOT NULL,
AddressNumber			VARCHAR(15),
NeighborhoodID			INT NOT NULL,
PublicTransportationID	INT,
ParkingGarage			VARCHAR(3) NOT NULL, 
FoodCourt				VARCHAR(3) NOT NULL,
PRIMARY KEY (PropertyID),
FOREIGN KEY (NeighborhoodID) REFERENCES Neighborhood(NeighborhoodID),
FOREIGN KEY (PublicTransportationID) REFERENCES PublicTransportation(PublicTransportationID)
);
GO

--Creating the entity PROPERTYOWNERS and give it some rules
CREATE TABLE PropertyOwners(
PropertyOwnersID	INT IDENTITY(1,1) UNIQUE NOT NULL,
UserID				INT NOT NULL,
PropertyID			INT NOT NULL,
PRIMARY KEY (PropertyOwnersID),
FOREIGN KEY (UserID) REFERENCES Users(UserID),
FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
);
GO

--Creating the entity WORKSPACE and give it some rules
CREATE TABLE Workspace(
WorkspaceID				INT IDENTITY(1,1) UNIQUE NOT NULL,
WorkspaceName			VARCHAR(250),
PropertyID				INT NOT NULL,
WorkspaceTypeID			INT NOT NULL,
Seats					INT,
Smoking					VARCHAR(3) NOT NULL,
LeaseTermID				INT NOT NULL,
Price					SMALLMONEY,
Size					DECIMAL(5,2)NOT NULL,
PRIMARY KEY (WorkspaceID),
FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID),
FOREIGN KEY (WorkspaceTypeID) REFERENCES WorkspaceType(WorkspaceTypeID),
FOREIGN KEY (LeaseTermID) REFERENCES LeaseTerm(LeaseTermID)
);
GO

--Creating the entity WORKSPACEUSAGETYPE and give it some rules
CREATE TABLE WorkspaceUsageType(
WorkspaceUsageTypeID	INT IDENTITY(1,1) UNIQUE NOT NULL,
UsageTypeName			VARCHAR(250),
PRIMARY KEY (WorkspaceUsageTypeID)
);
GO

--Creating the entity WORKSPACEUSAGE and give it some rules
CREATE TABLE WorkspaceUsage (
WorkspaceUsageID		INT IDENTITY(1,1) UNIQUE NOT NULL,
WorkspaceID				INT NOT NULL,
UserID					INT NOT NULL,
UsageDateInitial		DATE NOT NULL,
UsageDateFinal			DATE NOT NULL,
NumberOfUsers			INT NOT NULL,
WorkspaceUsageTypeID	INT DEFAULT 1
PRIMARY KEY (WorkspaceUsageID),
FOREIGN KEY (WorkspaceID) REFERENCES Workspace(WorkspaceID),
FOREIGN KEY (UserID) REFERENCES Users(UserID),
FOREIGN KEY (WorkspaceUsageTypeID) REFERENCES WorkspaceUsageType(WorkspaceUsageTypeID)
);
GO
