USE SharedWorkspace
GO


/*** INSERTING DATA at the entities***/

--Inserting data at entity ROLE
SET IDENTITY_INSERT Role ON
INSERT INTO Role(RoleID, RoleType) VALUES(1,'Owner')
INSERT INTO Role(RoleID, RoleType) VALUES(2, 'Coworker')
SET IDENTITY_INSERT Role OFF
GO

-- Inserting data at entity USER
INSERT INTO Users(Name,Phone,Email,Password,RoleID) VALUES
('Samantha Chen', '(416) 555-1234', 'samantha.chen@example.com', 'p@ssw0rd123', 1),
('Daniel Lee', '(647) 555-5678', 'daniel.lee@example.com', 's3cureP@ss', 1),
('Emily Brown', '(604) 555-9101', 'emily.brown@example.com', 'B1gSeCr3t', 1),
('Michael Nguyen', '(905) 555-4321', 'michael.nguyen@example.com', 'Passw0rd!', 1),
('Olivia Patel', '(519) 555-2468', 'olivia.patel@example.com', 'SuperS3cur3', 1),
('Ethan Johnson', '(613) 555-7890', 'ethan.johnson@example.com', '2saf3t0w3', 2),
('Ava Thompson', '(905) 555-7777', 'ava.thompson@example.com', 'MyP@ssIsS3cur3', 2),
('Benjamin Kim', '(416) 555-3456', 'benjamin.kim@example.com', 'Str0ngP@ssw0rd', 2),
('Sophia Singh', '(604) 555-9876', 'sophia.singh@example.com', 'P@ssw0rd1234', 2),
('William Chen', '(647) 555-2222', 'william.chen@example.com', 'S3cur3P@ssw0rd', 2),
('Rachel Wilson', '(416) 555-1234', 'rachel.wilson@example.com', 'Pa$$w0rd123', 2),
('Jason Lee', '(647) 555-5678', 'jason.lee@example.com', 'S3cur3P@ss', 2),
('Julia Brown', '(604) 555-9101', 'julia.brown@example.com', 'Str0ngP@ss', 2),
('Andrew Nguyen', '(905) 555-4321', 'andrew.nguyen@example.com', 's3cur3P@ssw0rd', 2),
('Samantha Patel', '(519) 555-2468', 'samantha.patel@example.com', 'B1gSeCr3t!', 2)
GO

--Inserting data at entity NEIGHBORHOOD
INSERT INTO Neighborhood(NeighborhoodName) VALUES
('Brentwood'),
('Bridgeland'),
('Beltline'),
('Hillhurst'),
('Mount Pleasant')
GO

--Inserting data at entity TRANSPORTATIONTYPE
INSERT INTO TransportationType(TransportationTypeName) VALUES
('Ctrain'),
('Bus')
GO

--Inserting data at entity TRANSPORTATIONLINE
INSERT INTO TransportationLine(TransportationLineName) VALUES
('201 - Red'),
('Line 09'),
('202 - Blue'),
('Line 405'),
('Line 02')
GO

--Inserting data at entity TRANSPORTATIONTYPELINE
INSERT INTO TransportationTypeLine(TransportationTypeID, TransportationLineID) VALUES
(1,1),
(2,2),
(1,3),
(2,4),
(2,5)
GO

--Inserting data at entity TRANSPORTATIONSTATION
INSERT INTO TransportationStation(TransportationStationName) VALUES
('Brentwood Station'),
('1 St NE at 7A St NE'),
('Victoria Park/Stampede Station'),
('5 Ave NW at Kensington Rd NW'),
('10 St NW at 24 Ave NW')
GO

--Inserting data at entity PUBLICTRANSPORTATION
INSERT INTO PublicTransportation(TransportationTypeLineID, TransportationStationID) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5)
GO

--Inserting data at entity WORKSPACETYPE
INSERT INTO WorkspaceType(TypeOfWorkspace) VALUES
('Meeting Room'),
('Private Office Room'),
('Desk')
GO

--Inserting data at entity LEASETERM
INSERT INTO LeaseTerm(LeasePeriod) VALUES
('Day'),
('Week'),
('Month')
GO

--Inserting data at entity PROPERTY
INSERT INTO Property(
	PropertyName,
	AddressStreet,
	AddressNumber,
	NeighborhoodID,
	PublicTransportationID,
	ParkingGarage,
	FoodCourt
	) VALUES
('Alberta Commerce Center', '19 St NW','3203',1,1,'Yes','Yes'),
('Calgary Executive Tower', 'Charleswood Dr NW','4708',1,1,'Yes','Yes'),
('Alberta Business Plaza', '11A St NE','102',2,2,'Yes','Yes'),
('Calgary Summit Offices', 'Drury Ave NE','1004',2,2,'Yes','Yes'),
('Alberta Corporate Palace', '17 Ave SW','1202',3,3,'Yes','Yes'),
('Calgary Commerce Court', '1 St SE','1320',3,3,'Yes','Yes'),
('Alberta Trade Center', 'Memorial Dr NW','1112',4,3,'No','No'),
('Calgary Elite Plaza', '11 St NW','416',4,3,'No','No'),
('Alberta Prime Office Suites', '22 Ave NW','617',5,3,'No','No'),
('Calgary Professional Hub', '28 Ave NW','511',5,3,'No','No')
GO

--UPDATE the PUBLICTRANSPORTATIONID in the PROPERTY entity
UPDATE Property SET PublicTransportationID = 4 WHERE NeighborhoodID = 4;
UPDATE Property SET PublicTransportationID = 5 WHERE NeighborhoodID = 5;


--Inserting data at entity PROPERTYOWNERS
INSERT INTO PropertyOwners(UserID, PropertyID) VALUES
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,9),
(5,10)
GO

--Inserting data at entity WORKSPACE
INSERT INTO Workspace(
	WorkspaceName,
	PropertyID,
	WorkspaceTypeID,
	Seats,
	Smoking,
	LeaseTermID,
	Price,
	Size
	) VALUES
('Ocean Meeting Room', 1,1,20,'No',1,800,30),
('Forest Meeting Room', 2,1,50,'No',3,1500,70),
('Montain Meeting Room', 3,1,30,'No',2,1000,40),
('Grizzly Bear Office Room', 4,2,5,'No',1,200,10),
('Elk Office Room', 5,2,5,'No',2,150,10),
('Moose Office Room', 6,2,5,'No',3,300,15),
('T-001', 7,3,1,'No',1,50,5),
('T-002', 8,3,1,'Yes',1,50,5),
('T-003', 9,3,1,'Yes',2,80,5),
('T-004', 10,3,1,'Yes',3,60,5)
GO

--Inserting data at entity WORKSPACEUSAGETYPE
INSERT INTO WorkspaceUsageType (UsageTypeName) VALUES
('Reserved'),
('Used')
GO

--Inserting data at entity WORKSPACEUSAGE
INSERT INTO WorkspaceUsage(WorkspaceID, UserID, UsageDateInitial, UsageDateFinal, NumberOfUsers) VALUES
(1, 6, '2023-03-11', '2023-03-13', 20),
(1, 6, '2023-03-13', '2023-03-15', 15),
(1, 7, '2023-03-15', '2023-03-17', 10),
(2, 8, '2023-03-17', '2023-03-19', 50),
(2, 9, '2023-03-19', '2023-03-21', 30),
(3, 10, '2023-03-21', '2023-03-23', 30),
(3, 11, '2023-03-23', '2023-03-25', 15),
(4, 12, '2023-03-25', '2023-03-27', 5),
(4, 13, '2023-03-27', '2023-03-29', 2),
(5, 14, '2023-03-29', '2023-03-31', 5),
(5, 15, '2023-03-31', '2023-04-02', 3),
(6, 7, '2023-04-02', '2023-04-04', 5),
(7, 8, '2023-04-04', '2023-04-06', 1),
(8, 10, '2023-04-06', '2023-04-08', 1),
(9, 9, '2023-04-08', '2023-04-25', 1),
(10, 10, '2023-04-25', '2023-04-27', 1),
(3, 6, '2023-04-27', '2023-04-29', 10),
(3, 8, '2023-04-29','2023-05-01', 5)
GO

UPDATE WorkspaceUsage
SET WorkspaceUsageTypeID = 2
WHERE UsageDateInitial < GETDATE()
GO